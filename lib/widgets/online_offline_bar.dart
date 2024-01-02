import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlineOffBar extends StatelessWidget {
  const OnlineOffBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: MediaQuery.sizeOf(context).height * .1,
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 25,
              child: Icon(
                Icons.person_off_outlined,
                color: Colors.amber,
              ),
            ),
            title: Text(
              'Your are offline',
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Go online a start accepting job',
              style: GoogleFonts.urbanist(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
