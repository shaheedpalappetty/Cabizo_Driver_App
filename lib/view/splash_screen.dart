import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/service/repo.dart';
import 'package:taxi_app/service/shadepreferance.dart';
import 'package:taxi_app/view/signup_screen.dart';
import 'package:taxi_app/view/welcome_screen.dart';
import 'package:taxi_app/widgets/bottam_navigaton_bar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DriverController driver = Get.put(DriverController());
  @override
  void initState() {
    validatorDriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/zippy-routes-logo.png'))),
          width: MediaQuery.of(context).size.width * 2 / 3,
          height: MediaQuery.of(context).size.height * 1 / 4,
        ),
      ),
    );
  }

  void validatorDriver() async {
    final driverAuth = Sharedpref.instance.getAuthDetails();

    if (driverAuth != null) {
      final data = await Repo.loginDriver(
          driverAuth['username'], driverAuth['password']);

      if (data != null) {
        driver.driver = data;
        Get.offAll(const BottamNavBar());
      } else {
        Get.offAll(SignUp());
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      Get.off(WelcomeScreen());
    }
  }
}
