import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/service/shadepreferance.dart';
import 'package:taxi_app/view/privacy_policy.dart';
import 'package:taxi_app/view/terms_condition_screen.dart';
import 'package:taxi_app/view/welcome_screen.dart';

class ScreenDrawer extends StatelessWidget {
  ScreenDrawer({super.key});
  final driver = Get.find<DriverController>().driver;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(driver.driverImg),
              ),
              Text(driver.name,
                  style: GoogleFonts.urbanist(
                      fontSize: 22, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: Text(
            'Privacy & policy',
            style:
                GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onTap: () {
            Get.to(const PrivacyPolicy());
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
          ),
          title: Text(
            'Terms and Condition',
            style:
                GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onTap: () {
            Get.to(const TermsConditionScreen());
          },
        ),

        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: Text(
            'Sign Out',
            style:
                GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const LogoutDialog();
              },
            );
          },
        ), // ... Other list tiles ...
      ],
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Sign Out ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Do you want to sign out',
        style: TextStyle(color: Color(0xFF6D6D6D)),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color.fromARGB(255, 138, 135, 135),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Sharedpref.instance.signout();
            Get.offAll(WelcomeScreen());
          },
          child: const Text(
            'Sign out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }
}
