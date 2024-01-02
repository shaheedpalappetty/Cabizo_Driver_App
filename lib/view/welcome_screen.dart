import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/indro_controller.dart';
import 'package:taxi_app/service/repo.dart';
import 'package:taxi_app/view/login_screen.dart';
import 'package:taxi_app/view/signup_screen.dart';
import 'package:taxi_app/widgets/buttons/autbutton.dart';
import 'package:taxi_app/widgets/textfields/cupertino_textfield.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final Repo calling = Repo();
  final IndroController controller = Get.put(IndroController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/welcome3.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 223, 223, 223),
                          title: 'Status',
                          // middleText: '',
                          content: Obx(
                            () => controller.status.value
                                ? Text(
                                    'Your Status is ${controller.statusDriver}')
                                : CupertonTextfield(
                                    controller: controller.number,
                                    title: 'Enter Your Phone Number',
                                  ),
                          ),
                          onCancel: () {},
                          onConfirm: () {
                            controller.statusChecking();
                          },
                          cancelTextColor:
                              const Color.fromARGB(255, 78, 78, 78),
                          confirmTextColor:
                              const Color.fromARGB(255, 70, 70, 70),
                          buttonColor: Colors.amber);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(62, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.all(15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Check your Status',
                            style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(0, 255, 255, 255),
                    Color.fromARGB(125, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                ),
              ),
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topLeft,
                    child: Text("Welcome to the\n driver app",
                        style: GoogleFonts.urbanist(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 36,
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(SignInScreen());
                      },
                      child: const AutButton(text: 'Continue')),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 109, 109, 109),
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SignUp());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.topLeft,
                      child: Text("Join ride community",
                          style: GoogleFonts.urbanist(
                              color: const Color.fromARGB(255, 80, 80, 80),
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  loading() async {
    await Future.delayed(const Duration(seconds: 1));
    const Center(
      child: CircularProgressIndicator(),
    );

    const Text('Your Status is Pending wait few days');
  }
}
