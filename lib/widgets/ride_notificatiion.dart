// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/controller/home_controller.dart';
import 'package:taxi_app/service/repo.dart';

class CustomPopup extends StatelessWidget {
  final Map<String, dynamic> data;
  CustomPopup({Key? key, required this.data}) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: EdgeInsets.zero,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-1024.png'),
            backgroundColor: Colors.amber,
            radius: 30,
          ),
          title: Text(data['username']),
          subtitle: Text('04:54 PM'),
          trailing: Text(
            "₹.239",
            style: TextStyle(fontSize: 17, color: Colors.green),
          ),
        ),
      ),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * .30,
        width: double.maxFinite,
        child: Column(
          children: [
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Pickup'),
              subtitle: Text(
                data['pickup'] ?? "its empty",
                overflow: null,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(child: Divider()),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("Destination"),
              subtitle: Text(
                data['dropOff'] ?? "is empty",
                overflow: null,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Change the button color here
          ),
          onPressed: () async {
            controller.requestCome.value = false;
            controller.update();
            final updated = await Repo.acceptOrRejectBooking(
                int.parse(data['userid']), "Reject");
            if (updated) {
              await controller.sendPushNotification(controller.data!['token'],
                  "Rejected", LatLng(541.46, 51154.8444));
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            "Reject",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, // Change the button color here
          ),
          onPressed: () async {
            // print(
            //     "======================${controller.data!['token']}=================");
            final updated = await Repo.acceptOrRejectBooking(
                int.parse(data['userid']), "Accepted");
            if (updated) {
              await controller.sendPushNotification(controller.data!['token'],
                  "Approve", LatLng(144988.94, 145151.511));
            }
            controller.requestCome.value = true;
            controller.update();
            Navigator.of(context).pop();
          },
          child: const Text('Accept',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
