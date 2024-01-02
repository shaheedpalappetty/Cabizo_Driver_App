import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/model/driver_model.dart';
import 'package:taxi_app/service/repo.dart';
import 'package:taxi_app/service/shadepreferance.dart';
import 'package:taxi_app/widgets/bottam_navigaton_bar.dart';

class SignInController extends GetxController {
  static FirebaseMessaging fMessage = FirebaseMessaging.instance;
  GlobalKey<FormState> signinsformKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  DriverController controller = Get.put(DriverController());
  static bool added = false;
  static String token = '';
  loginDriver() async {
    if (signinsformKey.currentState!.validate()) {
      Driver? driverInfo = await checkUser();
      if (driverInfo != null) {
        controller.driver = driverInfo;
        await Sharedpref.instance.setAuthDetails(driverInfo);
        await getFirebaseMessagingToken();
        Get.offAll(const BottamNavBar());
      } else {
        Get.snackbar("Error Occured", 'Enter valid password and Email');
      }
    }
  }

  textFeildValidation(String value) {
    if (value.isEmpty) {
      return "Fill the field";
    } else {
      return null;
    }
  }

  checkUser() async {
    final driverInfo = await Repo.loginDriver(
        usernameController.text.trim(), passwordController.text.trim());
    return driverInfo;
  }

  static Future<void> getFirebaseMessagingToken() async {
    await fMessage.requestPermission();
    Map<String, dynamic>? user = Sharedpref.instance.getAuthDetails();
    int id = user!['userid'];
    await fMessage.getToken().then((t) async {
      if (t != null) {
        added = await Repo.addTokenToDB(id, t);
      }
    });
  }
}
