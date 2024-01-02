import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/sign_up_validation.dart';

import 'package:taxi_app/widgets/textfields/cupertino_textfield.dart';

class DocumentTable extends StatelessWidget {
  DocumentTable(
      {super.key,
      this.controller1,
      this.controller2,
      this.title1,
      this.titel2,
      this.head,
      required this.isUpload,
      required this.onTap});
  final TextEditingController? controller1;
  final TextEditingController? controller2;
  final void Function()? onTap;
  final String? title1;
  final String? titel2;
  final String? head;
  final RxBool isUpload;
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromARGB(255, 254, 254, 254),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(51, 95, 95, 95),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(10, 10),
            ),
          ],
        ),
        width: double.maxFinite,
        height: Get.height * .31,
        child: Column(
          children: [
            Flexible(
                child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('assets/unknow.png'),
                                  fit: BoxFit.cover),
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertonTextfield(
                              text: controller.licenseController.text,
                              controller: controller1,
                              grey: true,
                              title: title1!,
                            ),
                            CupertonTextfield(
                              controller: controller2,
                              grey: true,
                              title: titel2!,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            )),
            InkWell(
              onTap: onTap,
              child: Ink(
                height: 70,
                child: Column(
                  children: [
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Text(
                        isUpload.value
                            ? "Uploaded ${head!}"
                            : 'Upload ${head!}',
                        style: GoogleFonts.urbanist(
                            color: isUpload.value
                                ? const Color.fromARGB(255, 66, 182, 70)
                                : const Color.fromARGB(255, 136, 136, 136),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
