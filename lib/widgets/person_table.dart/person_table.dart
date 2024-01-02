import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/sign_up_validation.dart';
import 'package:taxi_app/widgets/textfields/detail_textfield.dart';

class PersonDetailTable extends StatelessWidget {
  PersonDetailTable({super.key, required this.onTap});
  final SignupController controller = Get.put(SignupController());
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(44, 112, 112, 112),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        width: double.maxFinite,
        height: Get.height * .28,
        child: Row(
          children: [
            SizedBox(
              width: Get.height * .18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Stack(
                      alignment: const Alignment(1, 1),
                      children: [
                        Obx(
                          () => CircleAvatar(
                            backgroundImage: profilePic.isProfiepathSet.value ==
                                    false
                                ? const AssetImage('assets/unknow.png')
                                : FileImage(
                                        File(profilePic.profilepicPath.value))
                                    as ImageProvider,
                            radius: 55,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: onTap,
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Color.fromARGB(255, 229, 229, 229),
                              child: Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 217, 166, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add your profile',
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            Expanded(
                child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Form(
                  key: controller.personalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DetailTextfield(
                        text: "Full name",
                        controller: controller.nameController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      DetailTextfield(
                        text: "Last name",
                        controller: controller.lastnameController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
