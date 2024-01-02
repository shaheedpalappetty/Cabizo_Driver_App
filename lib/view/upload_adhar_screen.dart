import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/widgets/appbars/appbars.dart';
import 'package:taxi_app/widgets/textfields/cupertino_textfield.dart';
import 'package:taxi_app/widgets/upload_image.dart';

import '../controller/sign_up_validation.dart';

class UploadAdharScreen extends StatelessWidget {
  UploadAdharScreen({super.key});
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 210, 210),
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: DeatialAppbar(text: "Add Adhar card"),
      ),
      body: Form(
        key: controller.uploadAdharkey,
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            CupertonTextfield(
              keyboardType: TextInputType.number,
              validator: (value) => controller.textFeildValidation(value),
              controller: controller.adharNumberController,
              title: "Adhar number",
            ),
            CupertonTextfield(
              validator: (value) => controller.textFeildValidation(value),
              title: "Address",
              controller: controller.adharAddressController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UploadImage(
                    text: "Adhar front side", controller: adharCardFront),
                UploadImage(text: "Adhar back side", controller: adharCardBack),
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
          controller.uploadAdhrvalidation();
        },
        label: const Text("Save Document"),
      ),
    );
  }
}
