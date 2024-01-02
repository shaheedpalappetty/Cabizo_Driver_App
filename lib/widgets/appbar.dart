import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/controller/home_controller.dart';
import 'package:taxi_app/service/repo.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({super.key, required this.mapController});
  final HomeController controller = Get.put(HomeController());
  final DriverController driverController = Get.find();
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.sizeOf(context).height * .1,
        color: const Color.fromARGB(78, 255, 189, 22),
        width: double.maxFinite,
        child: Center(
          child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(255, 255, 200, 0),
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    )),
              ),
              title: Obx(
                () => Text(
                    controller.onlineStatus.value == false
                        ? 'Offline'
                        : 'Online',
                    style: GoogleFonts.urbanist(
                        color: const Color.fromARGB(255, 65, 65, 65),
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              trailing: Obx(
                () => CupertinoSwitch(
                  thumbColor: Colors.amber,
                  trackColor: const Color.fromARGB(89, 93, 93, 93),
                  activeColor: const Color.fromARGB(130, 62, 136, 64),
                  value: controller.onlineStatus.value,
                  onChanged: (value) async {
                    mapController.future.then((con) {
                      con.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                  controller.currentLocation.value.latitude,
                                  controller.currentLocation.value.longitude),
                              zoom: 15)));
                    });

                    controller.onlineStatus.value = value;
                    if (value) {
                      await Repo.upadateDriverStatus(
                          "t", driverController.driver.id!);
                      controller.update();
                    } else {
                      await Repo.upadateDriverStatus(
                          "f", driverController.driver.id!);
                    }
                  },
                ),
                //           ) ,
              )),
        ));
  }
}
