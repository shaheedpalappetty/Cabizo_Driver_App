// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BulletText extends StatelessWidget {
  const BulletText({super.key, this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: SizedBox(
              width: 8,
              height: 8,
              child: CircleAvatar(
                backgroundColor:
                    Colors.black, // Customize the bullet point style
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.urbanist(
                  fontSize: 16), // Customize the text style
            ),
          ),
        ],
      ),
    );
  }
}
