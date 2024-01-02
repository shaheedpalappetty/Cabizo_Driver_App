// ignore_for_file: unused_local_variable

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/model/driver_model.dart';

class Sharedpref {
  Sharedpref._();
  static final Sharedpref _instance = Sharedpref._();
  static Sharedpref get instance => _instance;

  static const String username = 'username';
  static const String password = 'password';
  static const String userid = 'userid';

  late SharedPreferences sharedpref;

  initStorage() async {
    sharedpref = await SharedPreferences.getInstance();
  }

  setAuthDetails(Driver driverInfo) async {
    await sharedpref.setString(username, driverInfo.username);
    await sharedpref.setString(password, driverInfo.password);
    await sharedpref.setInt(userid, driverInfo.id!);
  }

  signout() {
    sharedpref.remove(username);
    sharedpref.remove(password);
  }

  Map<String, dynamic>? getAuthDetails() {
    String? usernames = sharedpref.getString(username);
    String? passwords = sharedpref.getString(password);
    int? userids = sharedpref.getInt(userid);
    if (usernames == null || passwords == null) return null;
    Map<String, dynamic> authDetails = {
      'username': usernames,
      'password': passwords,
      'userid': userids
    };
    return authDetails;
  }

  int? getId() {
    final map = getAuthDetails();
    int? id = sharedpref.getInt(userid);
    if (id != null) {
      return id;
    }
    return null;
  }
}