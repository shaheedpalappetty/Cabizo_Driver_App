import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToplevelText extends StatelessWidget {
  const ToplevelText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to Aber ! We\'re thrilled to have you on board.',
      style: GoogleFonts.urbanist(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0)),
    );
  }
}
