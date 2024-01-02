import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:taxi_app/model/document_model.dart';
import 'package:taxi_app/model/driver_model.dart';
import 'package:taxi_app/model/revenue.dart';
import 'package:taxi_app/model/vehicle_model.dart';
import 'package:taxi_app/utils/end_points.dart';

class Repo {
  static Future<int?> driverPost(Driver driver) async {
    var url = Url.baseUrl + Url.driver + Url.createDriver;
    final uri = Uri.parse(url);
    final body = driver.toJson();
    var response =
        await http.post(uri, body: jsonEncode(body), headers: Url.headers);
    if (response.statusCode == 200) {
      int id = jsonDecode(response.body);
      return id;
    }
    return null;
  }

  static Future driverGet(int id) async {
    var url = "${Url.baseUrl}${Url.driver}${Url.getDriverDetails}$id";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    Map<String, dynamic> driver = json['driver'];
    if (response.statusCode == 200) {
      return driver;
    } else {
      return null;
    }
  }

  static Future<bool> addVehicle(VehicleDetails vehicle) async {
    var url = Url.baseUrl + Url.driver + Url.vehicledetails;
    final uri = Uri.parse(url);
    final body = vehicle.toJson();
    var response =
        await http.post(uri, body: jsonEncode(body), headers: Url.headers);
    return response.statusCode == 200;
  }

  static Future<bool> addDocuments(Documents documents) async {
    var url = Url.baseUrl + Url.driver + Url.documents;
    final uri = Uri.parse(url);
    final body = documents.toJson();
    var response =
        await http.post(uri, body: jsonEncode(body), headers: Url.headers);
    return response.statusCode == 200;
  }

  static Future<Driver?> loginDriver(String username, String password) async {
    var url = Url.baseUrl + Url.driver + Url.login;
    final uri = Uri.parse(url);
    final body = {'username': username, 'password': password};

    var response =
        await http.post(uri, body: jsonEncode(body), headers: Url.headers);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Driver driverInfo = Driver.fromJson(responseData['driver']);
      return driverInfo;
    } else {
      return null;
    }
  }

  static Future<bool> updateLocationCoordinates(
      Position position, int id) async {
    var url = '${Url.baseUrl}${Url.driver}${Url.updateLocation}/$id';
    var uri = Uri.parse(url);
    final body = {
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString()
    };
      var response =
        await http.patch(uri, body: jsonEncode(body), headers: Url.headers);
    return response.statusCode == 200;
  }

  static Future<String?> checkStatus(String number) async {
    var url =
        Uri.parse("${Url.baseUrl}${Url.driver}${Url.checkStatus}/$number");
    final response = await http.post(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<bool> addTokenToDB(int userId, String token) async {
    var url = Uri.parse(Url.baseUrl + Url.firebase + Url.token);
    var body = {
      'user_id': userId,
      'token': token,
      'status': 'Active',
      'category': 'Driver'
    };
   
    var response =
        await http.post(url, body: jsonEncode(body), headers: Url.headers);
    return response.statusCode == 200;
  }

  static Future<bool> acceptOrRejectBooking(int userid, String status) async {
    
    var url =
        Uri.parse("${Url.baseUrl}${Url.booking}${Url.ridestatus}/$userid");
    final body = {"status": status};
    final response =
        await http.patch(url, body: jsonEncode(body), headers: Url.headers);
    
    return response.statusCode == 200;
  }

  static Future<bool> disablePushNotifications(int userId) async {
    var url = Uri.parse("${Url.baseUrl}${Url.firebase}${Url.disable}");
    var body = {'user_id': userId, 'status': 'InActive', 'category': 'Driver'};
    var response =
        await http.patch(url, body: jsonEncode(body), headers: Url.headers);
    return response.statusCode == 200;
  }

  static Future<bool> startTrip(
      double latitude, double longitude, int userId) async {
    final url = Uri.parse(Url.baseUrl + Url.driver + Url.starttrip);
    final body = {
      "slatitude": latitude,
      "slongitude": longitude,
      "userid": userId
    };
    final response =
        await http.patch(url, body: jsonEncode(body), headers: Url.headers);
    return response.statusCode == 200;
  }

  static Future<int?> getridefare(
      int userid, int driverid, double endLatitude, double endLongitude) async {
    var url = Uri.parse(Url.baseUrl + Url.booking + Url.ridefare);
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    final body = {
      "elatitude": endLatitude,
      "elongitude": endLongitude,
      "userid": userid,
      "driverid": driverid,
      "date": formattedDate
    };
    final response =
        await http.post(url, body: jsonEncode(body), headers: Url.headers);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['fare'];
    }
    return null;
  }

  static Future<List<Revenue>?> getRevenueDetails(int driverId) async {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    final url = Uri.parse(Url.baseUrl + Url.driver + Url.revenue);
    final body = {"driverid": driverId, "date": formattedDate};
    final response =
        await http.post(url, body: jsonEncode(body), headers: Url.headers);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<dynamic> payments = result["payments"];
      final List<Revenue> paymentsList =
          payments.map((e) => Revenue.fromJson(e)).toList();
      return paymentsList;
    }
    return null;
  }

  static Future<void> upadateDriverStatus(String status, int id) async {
    final url = Uri.parse(
        "${Url.baseUrl}${Url.driver}${Url.status}?id=$id&status=$status");
    await http.patch(url, headers: Url.headers);
  }

  static Future<List<Revenue>> getRevenueByDate(
      String startDate, String endDate, int userId) async {
    final url = Uri.parse("${Url.baseUrl}${Url.driver}${Url.getRevenue}");
    final body = {
      "driverid": userId,
      "start_date": startDate,
      "end_date": endDate
    };
    final response =
        await http.post(url, body: jsonEncode(body), headers: Url.headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body)['success'];
      List<Revenue> bookings =
          jsonResponse.map((data) => Revenue.fromJson(data)).toList();
      return bookings;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
