import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Otpfield extends StatefulWidget {
  const Otpfield({super.key});

  @override
  State<Otpfield> createState() => _OtpfieldState();
}

class _OtpfieldState extends State<Otpfield> {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  OtpController controller = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          Container(
              width: 40,
              margin: const EdgeInsets.all(8),
              child: TextField(
                onChanged: (value) {
                  if (value.isNotEmpty && i <= 3) {
                    FocusScope.of(context).nextFocus();
                    controller.forOtp(value);
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                cursorColor: Colors.yellow,
                controller: controllers[i],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Color.fromARGB(255, 213, 213, 213),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 247, 0),
                    ),
                  ),
                ),
              )),
      ],
    );
  }
}

class OtpController extends GetxController {
  List<String> otp = [];
  forOtp(userotp) {
    otp.add(userotp);
    // print(otp);
  }
}
