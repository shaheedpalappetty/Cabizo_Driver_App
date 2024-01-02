// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/sign_up_validation.dart';
import 'package:taxi_app/view/app_info.dart';
import 'package:taxi_app/view/login_screen.dart';
import 'package:taxi_app/view/personl_detail_screen.dart';
import '../widgets/buttons/autbutton.dart';
import '../widgets/texts/rich_text.dart';
import '../widgets/texts/short_text.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  SignupController controller = Get.put<SignupController>(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Flexible(
                  child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Drive when you want, make what you need",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                            color: const Color.fromARGB(255, 76, 76, 76),
                            fontSize: 30,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 15,
                    ),
                    const ShortText(
                        text: 'Earn on your own schedule.', otp: true),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(const AppInfo(),
                              transition: Transition.downToUp);
                        },
                        child: const ShortText(
                            text: "Why drive with us ?", otp: false))
                  ],
                ),
              )),
              SizedBox(
                width: double.infinity,
                height: Get.height * .25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(PersonalDetails());
                        },
                        child: const AutButton(text: 'Get start')),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(SignInScreen());
                      },
                      child: richText(
                          context: context,
                          firstTxt: "Don't have already account? ",
                          secondTxt: "SignIn"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
