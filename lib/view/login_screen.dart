// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/sign_in_controller.dart';
import 'package:taxi_app/widgets/textfields/signup_textfields.dart';
import 'package:taxi_app/widgets/buttons/autbutton.dart';
import 'package:taxi_app/widgets/texts/rich_text.dart';
import 'package:taxi_app/widgets/texts/short_text.dart';


class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  SignInController controller = Get.put(SignInController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Flexible(
                    child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome Have a nice day",
                          style: GoogleFonts.urbanist(
                              color: const Color.fromARGB(255, 76, 76, 76),
                              fontSize: 25,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 5,
                      ),
                      const ShortText(
                          text:
                              'Please login to your account, and start your Drive',
                          otp: true),
                      const SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        width: 350,
                        child: Form(
                          key: controller.signinsformKey,
                          child: Column(
                            children: [
                              CustomTextfield(
                                  controller: controller.usernameController,
                                  validation: (value) =>
                                      controller.textFeildValidation(value),
                                  hintText: 'Enter your username'),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextfield(
                                  controller: controller.passwordController,
                                  validation: (value) =>
                                      controller.textFeildValidation(value),
                                  hintText: 'Enter your password')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                          onTap: () {
                          
                            controller.loginDriver();
                          },
                          child: const AutButton(text: 'Continue')),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 70),
                        child: richText(
                            context: context,
                            firstTxt: "Don't have an account? ",
                            secondTxt:
                                "Uplod the information yours,and join the driver Community"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
