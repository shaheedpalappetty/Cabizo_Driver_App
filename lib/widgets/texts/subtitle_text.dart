// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({super.key, required this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Text(
        text,
        style: GoogleFonts.urbanist(
            color: const Color.fromARGB(255, 57, 57, 57), fontSize: 16),
      ),
    );
  }
}
