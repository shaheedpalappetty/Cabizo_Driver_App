// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortText extends StatelessWidget {
  const ShortText({super.key, required this.text, required this.otp});
  final text;
  final bool otp;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.urbanist(
            color: otp ? const Color.fromARGB(255, 134, 134, 134) : Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.w500));
  }
}
