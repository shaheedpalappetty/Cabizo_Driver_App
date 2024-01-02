import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/controller/home_controller.dart';
import 'package:taxi_app/service/repo.dart';
import 'package:taxi_app/widgets/online_offline_bar.dart';
import 'package:taxi_app/widgets/ride_notificatiion.dart';
import '../widgets/appbar.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController(), permanent: true);
  DriverController driver = Get.find();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleNotification(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: ScreenDrawer()),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              if (controller.isReached.value == true &&
                  controller.showPop.value) {
                controller.showPop.value = false;
                showStartTripDialog();
                return const SizedBox();
              }
              return const SizedBox();
            }),
            GetBuilder<HomeController>(builder: (c) {
              LatLng currentlocation = LatLng(
                  controller.currentLocation.value.latitude,
                  controller.currentLocation.value.longitude);
              return controller.requestCome.value == true
                  ? driverToUserMap(controller.data)
                  : GoogleMap(
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentlocation.latitude,
                              currentlocation.longitude),
                          zoom: 12.5),
                      onMapCreated: (controller) {
                        controller.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(currentlocation.latitude,
                                    currentlocation.longitude),
                                zoom: 15)));
                        mapController.complete(controller);
                      },
                      onCameraMove: (CameraPosition position) {},
                      markers: {
                        Marker(
                          markerId: const MarkerId('_currentLocation'),
                          icon: BitmapDescriptor.defaultMarker,
                          position: currentlocation,
                        ),
                      },
                    );
            }),
            Obx(() => controller.onlineStatus.value == false
                ? const Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: OnlineOffBar(),
                  )
                : const SizedBox()),
            CustomAppbar(mapController: mapController),
          ],
        ),
      ),
    );
  }

  Widget driverToUserMap(data) {
    return GetBuilder<HomeController>(builder: (context) {
      LatLng currentlocation = LatLng(controller.currentLocation.value.latitude,
          controller.currentLocation.value.longitude);
      return GoogleMap(
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
            target: LatLng(controller.currentLocation.value.latitude,
                controller.currentLocation.value.longitude),
            zoom: 12.5),
        onMapCreated: (controller) {
          try {
            mapController.complete(controller);

            // ... rest of your code ...
          } catch (e, stackTrace) {
            Get.snackbar("Error", 'Error in onMapCreated: $e\n$stackTrace',
                backgroundColor: Colors.red);
          }
          controller.animateCamera(CameraUpdate.newLatLng(LatLng(
              double.parse(data['dropoffLat'] ?? "11.2588"),
              double.parse(data['dropoffLang'] ?? "75.7804"))));
          controller.animateCamera(CameraUpdate.newLatLng(
            LatLng(currentlocation.latitude, currentlocation.longitude),
          ));
          fetchRoute(
            LatLng(double.parse(data['dropoffLat'] ?? "11.2588"),
                double.parse(data['dropoffLang'] ?? "75.7804")),
            LatLng(currentlocation.latitude, currentlocation.longitude),
          );
        },
        markers: {
          Marker(
            markerId: const MarkerId('_currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(double.parse(data['dropoffLat'] ?? "11.2588"),
                double.parse(data['dropoffLang'] ?? "75.7804")),
          ),
          Marker(
            markerId: const MarkerId('_destinationLocation'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position:
                LatLng(currentlocation.latitude, currentlocation.longitude),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        },
      );
    });
  }

  void fetchRoute(LatLng pickUplocaiton, LatLng dropLocation) async {
    const apiKey = 'AIzaSyAWktkmf1xJM-2dQriSVBNm15Ai8XHweCo';
    final polylinePoints = PolylinePoints();
    final origin =
        PointLatLng(pickUplocaiton.latitude, pickUplocaiton.longitude);
    final destination =
        PointLatLng(dropLocation.latitude, dropLocation.longitude);

    final result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      origin,
      destination,
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  void _handleNotification(RemoteMessage message) {
    if (!mounted) {
      return;
    }

    try {
      Map<String, dynamic>? data = message.data;
      controller.requestCome.value = true;
      controller.data = data;

      if (data['status'] == "sucess") {
        Get.defaultDialog(
            title: "Payment Sucessfully Credited",
            content: const Icon(Icons.credit_score_outlined),
            onConfirm: () {
              Get.back();
              controller.requestCome.value = false;
              controller.hascallFunction = false;
            },
            textConfirm: "Ok");
      } else if (data["status"] == "failed") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopup(data: data);
            });
        true;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  showStartTripDialog() async {
    await Future.delayed(const Duration(seconds: 2));
    await Get.defaultDialog(
      title: "Start Trip",
      middleText: "Lets Start trip?",
      textConfirm: "Yes, ready",
      onConfirm: () async {
        //patch pickup in booking
        controller.driverIsReadyTrip(
          controller.data!["token"],
          "Go",
        );
        bool ready = await Repo.startTrip(
            controller.currentLocation.value.latitude,
            controller.currentLocation.value.longitude,
            int.parse(controller.data!['userid']));
        Get.back();
        if (ready) {
          Get.defaultDialog(
              title: "Reached Location",
              middleText: "User location Reached",
              textConfirm: "End Trip",
              onConfirm: () async {
                //===========================//
                controller.showPop.value = true;
                int? fare = await Repo.getridefare(
                    int.parse(controller.data!['userid']),
                    driver.driver.id!,
                    controller.currentLocation.value.latitude,
                    controller.currentLocation.value.longitude);
                if (fare != null) {
                  await controller.driverEndTrip(
                      controller.data!['token'], "End", fare);
                  Get.back();
                }
              });

          controller.isReached.value = false;
        }
      },
    );
  }

  Widget userMap(data) {
    return GetBuilder<HomeController>(builder: (context) {
      LatLng currentlocation = LatLng(controller.currentLocation.value.latitude,
          controller.currentLocation.value.longitude);
      return GoogleMap(
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
            target: LatLng(controller.currentLocation.value.latitude,
                controller.currentLocation.value.longitude),
            zoom: 12.5),
        onMapCreated: (controller) {
          try {
            mapController.complete(controller);

            // ... rest of your code ...
          } catch (e, stackTrace) {
            Get.snackbar("Error", 'Error in onMapCreated: $e\n$stackTrace');
          }
          controller.animateCamera(CameraUpdate.newLatLng(LatLng(
              double.parse(data['dropoffLat']),
              double.parse(data['dropoffLang']))));
          controller.animateCamera(CameraUpdate.newLatLng(LatLng(
              double.parse(data['pickupLat']),
              double.parse(data['pickupLang']))));
          fetchRoute(
            LatLng(double.parse(data['dropoffLat']),
                double.parse(data['dropoffLang'])),
            LatLng(double.parse(data['pickupLat']),
                double.parse(data['pickupLang'])),
          );
        },
        markers: {
          Marker(
            markerId: const MarkerId('_currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(double.parse(data['dropoffLat']),
                double.parse(data['dropoffLang'])),
          ),
          Marker(
            markerId: const MarkerId('_destinationLocation'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position:
                LatLng(currentlocation.latitude, currentlocation.longitude),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        },
      );
    });
  }
}
