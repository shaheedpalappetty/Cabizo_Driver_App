import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi_app/view/welcome_screen.dart';

class Lodingpage extends StatefulWidget {
  const Lodingpage({super.key});

  @override
  State<Lodingpage> createState() => _LodingpageState();
}

class _LodingpageState extends State<Lodingpage> {
  void _navigateToHomePage() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offAll( WelcomeScreen());
  }

  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 198, 26),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/loding.json',
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                animate: true,
              ),
            ),
            Text(
              'Welcome onboard',
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Congragulations, Happy have you board, we will get back to you soon',
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color.fromARGB(255, 89, 89, 89)),
            ),
          ],
        ),
      ),
    );
  }
}
