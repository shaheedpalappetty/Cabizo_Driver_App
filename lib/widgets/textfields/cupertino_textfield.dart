import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CupertonTextfield extends StatelessWidget {
  const CupertonTextfield(
      {super.key,
      required this.title,
      this.grey,
      this.controller,
      this.validator,
      this.text,
      this.keyboardType});
  final TextEditingController? controller;
  final String title;
  final bool? grey;
  final FormFieldValidator? validator;
  final String? text;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              title,
              style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 137, 137, 137)),
            ),
          ),
          SizedBox(
            child: CupertinoTextFormFieldRow(
              keyboardType: keyboardType,
              placeholder: text ?? '',
              validator: validator,
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              readOnly: grey == null ? false : true,
              decoration: BoxDecoration(
                color: grey == true
                    ? const Color.fromARGB(255, 222, 222, 222)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 1.0,
                ),
              ),
              padding: const EdgeInsets.all(10.0),
            ),
          ),
        ],
      ),
    );
  }
}
