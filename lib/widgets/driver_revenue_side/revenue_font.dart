// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenuFont extends StatelessWidget {
  const RevenuFont({super.key, required this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color.fromARGB(255, 219, 163, 9)),
    );
  }
}

class RevenueAmountFont extends StatelessWidget {
  const RevenueAmountFont({super.key, required this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.urbanist(
          fontSize: 25, fontWeight: FontWeight.w800, color: Colors.amber),
    );
  }
}
