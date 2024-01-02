import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/controller/sign_up_validation.dart';
import 'package:taxi_app/view/upload_adhar_screen.dart';
import 'package:taxi_app/view/upload_license_screen.dart';
import 'package:taxi_app/widgets/appbars/appbars.dart';
import 'package:taxi_app/widgets/buttons/autbutton.dart';
import 'package:taxi_app/widgets/documentation_table.dart/documet_table.dart';

class DocumentScreen extends StatelessWidget {
  final int? id;
  DocumentScreen({super.key,this.id});
  final SignupController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 229, 229),
      appBar: const PreferredSize(
          preferredSize: Size(double.maxFinite, 70),
          child: DeatialAppbar(text: 'Document Management')),
      body: Column(
        children: [
          DocumentTable(
            controller1: controller.licenseController,
            controller2: controller.expiereDateController,
            isUpload: controller.uploaded,
            onTap: () {
              Get.to(UploadLicesneScreen(), fullscreenDialog: true);
            },
            title1: 'Driving license no :',
            titel2: 'Expire date :',
            head: 'Driving license',
          ),
          DocumentTable(
            controller2: controller.adharNumberController,
            controller1: controller.adharAddressController,
            isUpload: controller.uploadedAdhr,
            onTap: () {
              Get.to(UploadAdharScreen(), fullscreenDialog: true);
            },
            title1: 'Adhar card no :',
            titel2: 'Address :',
            head: 'Adhar card',
          ),
          const SizedBox(
            height: 70,
          ),
          InkWell(
              onTap: () {
                controller.addDriverDocuments(id);
              },
              child: const AutButton(text: "Add and Save"))
        ],
      ),
    );
  }
}