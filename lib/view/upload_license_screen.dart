import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/widgets/appbars/appbars.dart';
import 'package:taxi_app/widgets/textfields/cupertino_textfield.dart';
import 'package:taxi_app/widgets/upload_image.dart';

import '../controller/sign_up_validation.dart';

class UploadLicesneScreen extends StatelessWidget {
  UploadLicesneScreen({super.key});
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 210, 210),
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: DeatialAppbar(text: "Add License"),
      ),
      body: Form(
        key: controller.uploadformKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            CupertonTextfield(
              controller: controller.expiereDateController,
              title: "Expire date",
              validator: (value) => controller.textFeildValidation(value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UploadImage(
                    text: "License front sidr",
                    controller: licenseFrontController),
                UploadImage(
                    text: "License back side",
                    controller: licenseBackController),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
          controller.uploadButtonPressValidation();
        },
        label: const Text("Save Document"),
      ),
    );
  }
}
