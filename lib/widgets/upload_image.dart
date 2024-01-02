// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/widgets/texts/short_text.dart';
import '../controller/sign_up_validation.dart';

class UploadImage extends StatelessWidget {
  UploadImage({super.key, required this.text, required this.controller});

  final text;
  SignupController controller;
  SignupController signinController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          controller.imagepickerfun();
        },
        child: Obx(() => Container(
            width: Get.width * .4,
            height: 150,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 195, 195, 195),
                borderRadius: BorderRadius.circular(20)),
            child: controller.isProfiepathSet.value == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Icon(
                          Icons.cloud_upload,
                          size: 50,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ShortText(text: text, otp: true)
                      ])
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                                File(controller.profilepicPath.value)),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20)),
                  ))),
      ),
    );
  }
}
