import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  UserInfoState createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo> {
  bool isExpanded = false;
  double containerHeight = 100.0;

  void toggleContainer() {
    setState(() {
      isExpanded = !isExpanded;
      containerHeight = isExpanded ? 200.0 : 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 227, 227, 227),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                duration: const Duration(milliseconds: 300),
                height: containerHeight,
                child: Column(
                  mainAxisAlignment: !isExpanded
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          const CircleAvatar(),
                          Expanded(
                              child: ListTile(
                            title: const Text('shahshad babu'),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 51, 211, 64),
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.sizeOf(context).width * .2,
                              height: 30,
                              child: Center(
                                  child: Text('Completed',
                                      style: GoogleFonts.urbanist(
                                          color: Colors.white))),
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                )),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 167, 167, 167),
            ),
            IconButton(
              icon: Icon(isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: toggleContainer,
            ),
          ],
        ),
      ),
    );
  }
}
