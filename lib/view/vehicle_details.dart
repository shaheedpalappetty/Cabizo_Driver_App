import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/controller/sign_up_validation.dart';
import 'package:taxi_app/widgets/appbars/appbars.dart';
import 'package:taxi_app/widgets/textfields/cupertino_textfield.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({super.key, this.userId});
  final int? userId;

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: const PreferredSize(
          preferredSize: Size(double.maxFinite, 70),
          child: DeatialAppbar(text: "Vehicle Detials")),
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(255, 222, 221, 221),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(65, 112, 112, 112),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(5, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(
                  key: controller.vehicleKey,
                  child: Column(
                    children: [
                      CupertonTextfield(
                        title: 'Vehicle brand',
                        controller: controller.carBrandController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      CupertonTextfield(
                        title: 'Model',
                        controller: controller.carModelController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      for (var vehicle in controller.vehicleOptions)
                        Obx(
                          () => RadioListTile<int>(
                            title: Text(vehicle.name),
                            value: vehicle.id,
                            groupValue: controller.selectedVehicle.value,
                            onChanged: (int? value) {
                              controller.selectingVehicle(value!);
                            },
                          ),
                        ),
                      CupertonTextfield(
                        title: 'Vehicle Number',
                        controller: controller.carNumberController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      CupertonTextfield(
                        title: 'Year',
                        controller: controller.carYearControllerl,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      CupertonTextfield(
                        title: 'Color',
                        controller: controller.carColorController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                      CupertonTextfield(
                        keyboardType: TextInputType.number,
                        title: 'Seats',
                        controller: controller.carSeatController,
                        validator: (value) =>
                            controller.textFeildValidation(value),
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
          controller.vehicleScreenValidation(widget.userId!);
        },
        label: const SizedBox(
          child: Row(
            children: [
              Text('Continue'),
              Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleSelection {
  final int id;
  final String name;

  VehicleSelection({required this.id, required this.name});
}
