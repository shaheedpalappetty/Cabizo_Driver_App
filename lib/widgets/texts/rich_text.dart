import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget richText(
    {required BuildContext context,
    required String firstTxt,
    required String secondTxt}) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: firstTxt,
            style: GoogleFonts.urbanist(
                color: const Color.fromARGB(255, 134, 134, 134),
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: secondTxt,
            style: GoogleFonts.urbanist(
                color: const Color.fromARGB(255, 208, 181, 5),
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ],
    ),
  );
}
