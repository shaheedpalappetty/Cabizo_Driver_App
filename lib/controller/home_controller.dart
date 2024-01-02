// ignore_for_file: empty_catches, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/model/revenue.dart';
import 'package:taxi_app/service/listen_location.dart';

import 'package:taxi_app/service/repo.dart';

class HomeController extends GetxController {
  static FirebaseMessaging fMessage = FirebaseMessaging.instance;
  DriverController controller = Get.find();
  RxBool onlineStatus = false.obs;
  RxBool requestCome = false.obs;
  Map<String, dynamic>? data;
  List<Revenue>? revenueList = [];
  Rx<Position> currentLocation = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    altitudeAccuracy: 0.0,
    heading: 0.0,
    headingAccuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  ).obs;
  late bool servicePermission;
  late LocationPermission permission;
  late StreamSubscription<Position> _locationSubscription;
  RxString currentAddress = ''.obs;
  RxBool isReached = false.obs;
  RxBool showPop = true.obs;
  bool hascallFunction = false;
  int revenueTotal = 0;
  @override
  void onInit() {
    super.onInit();
    _startLocationUpdates();
  }

  @override
  void onClose() {
    super.onClose();
    _locationSubscription.cancel();
  }

  getRevenue() async {
    List<Revenue>? revenue =
        await Repo.getRevenueDetails(controller.driver.id!);
    if (revenue != null) {
      revenueTotal = 0;
      revenueList = revenue;
      for (int i = 0; i < revenueList!.length; i++) {
        revenueTotal = revenueTotal + revenue[i].fare;
      }
    }
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.value.latitude,
        currentLocation.value.longitude,
      );
      Placemark place = placemarks.first;

      currentAddress.value =
          "${place.name}, ${place.locality}, ${place.street}, ${place.country}, ${place.postalCode}";
    } catch (e) {
    }
    update();
    currentLocation.refresh();
  }

  Future<void> _startLocationUpdates() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    _locationSubscription = Geolocator.getPositionStream(
      locationSettings:
          AndroidSettings(distanceFilter: 0, accuracy: LocationAccuracy.best),
    ).listen((Position position) async {
      currentLocation.value = position;
      if (onlineStatus.value) {
        updateToDB();
        _getAddressFromCoordinates();
        if (requestCome.value == true) {
          final driverLocation = Coordinates(
              latitude: currentLocation.value.latitude,
              longitude: currentLocation.value.longitude);
          final userLocation = Coordinates(
              latitude: double.parse(data!['dropoffLat'] ?? "11.2588"),
              longitude: double.parse(data!['dropoffLang'] ?? "75.7804"));
          bool isReacheds =
              Helper.hasDriverReachedCustomer(driverLocation, userLocation);
          if (isReacheds && hascallFunction == false) {
            await driverReachedNotification(
              data!['token'],
              "reached",
            );
            isReached.value = true;
            hascallFunction = true;
          }
        }

        update();
      } else {}
    });
  }

  updateToDB() async {
    await Repo.updateLocationCoordinates(
      currentLocation.value,
      controller.driver.id!,
    );
  }

  Future<void> sendPushNotification(
      String token, String status, LatLng driveLocation) async {
    final body = {
      "to": token,
      "notification": {"title": "Driver", "body": "Yes am ready, let's go!"},
      "data": {"status": status}
    };
    const url = 'https://fcm.googleapis.com/fcm/send';

    await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "key=AAAAOd8TloI:APA91bFR5DQqeZ4sK3pKmCDVG2gycpvL-0k3P37vFfc8dGGiBmTk6etbnucQJJZG2hfdYx_em93yVIcaJFeDWl2QxXYdJurwnE-YvIGmxp5K0Z7zbbYlmCdCsRpxdF0-Et5sHjkzhcjd",
    });
  }

  Future<void> driverReachedNotification(String token, String status) async {
    final body = {
      "to": token,
      "notification": {"title": "Driver", "body": "Hi am reached ,where you?"},
      "data": {"status": status}
    };
    const url = 'https://fcm.googleapis.com/fcm/send';

    final response =
        await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "key=AAAAOd8TloI:APA91bFR5DQqeZ4sK3pKmCDVG2gycpvL-0k3P37vFfc8dGGiBmTk6etbnucQJJZG2hfdYx_em93yVIcaJFeDWl2QxXYdJurwnE-YvIGmxp5K0Z7zbbYlmCdCsRpxdF0-Et5sHjkzhcjd",
    });
   
  }

  Future<void> driverIsReadyTrip(String token, String status) async {
    final body = {
      "to": token,
      "notification": {"title": "Driver", "body": "Okey lets Go!"},
      "data": {"status": status}
    };
    const url = 'https://fcm.googleapis.com/fcm/send';

    await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "key=AAAAOd8TloI:APA91bFR5DQqeZ4sK3pKmCDVG2gycpvL-0k3P37vFfc8dGGiBmTk6etbnucQJJZG2hfdYx_em93yVIcaJFeDWl2QxXYdJurwnE-YvIGmxp5K0Z7zbbYlmCdCsRpxdF0-Et5sHjkzhcjd",
    });
  }

  Future<void> driverEndTrip(String token, String status, int fare) async {
    final body = {
      "to": token,
      "notification": {"title": "Driver", "body": "Trip Completed!"},
      "data": {"status": status, "fare": fare}
    };
    const url = 'https://fcm.googleapis.com/fcm/send';

    await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "key=AAAAOd8TloI:APA91bFR5DQqeZ4sK3pKmCDVG2gycpvL-0k3P37vFfc8dGGiBmTk6etbnucQJJZG2hfdYx_em93yVIcaJFeDWl2QxXYdJurwnE-YvIGmxp5K0Z7zbbYlmCdCsRpxdF0-Et5sHjkzhcjd",
    });
  }
}
