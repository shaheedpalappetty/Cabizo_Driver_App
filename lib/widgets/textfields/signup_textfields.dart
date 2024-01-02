// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield(
      {super.key,
      this.controller,
      required this.hintText,
      this.validation,
      this.suffixIcon});
  final controller;
  final hintText;
  FormFieldValidator? validation;
  Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: validation,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: GoogleFonts.urbanist(
              color: const Color.fromARGB(255, 157, 157, 157),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          fillColor: const Color.fromARGB(255, 232, 232, 232),
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 251, 251),
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 247, 0),
            ),
          ),
        ),
      ),
    );
  }
}
