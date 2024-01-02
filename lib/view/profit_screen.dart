import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/model/revenue.dart';
import 'package:taxi_app/widgets/textfields/signup_textfields.dart';

class ProfitScreen extends StatelessWidget {
  ProfitScreen({super.key});

  final DriverController contorller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              contorller.startDateController.clear();
              contorller.endDateController.clear();
              Get.back();
            },
            icon: const Icon(Icons.chevron_left_sharp)),
        title: const Text("Search your profit"),
      ),
      body: Column(
        children: [
          Card(
            color: const Color.fromARGB(255, 195, 195, 195),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextfield(
                    suffixIcon: IconButton(
                        onPressed: () {
                          contorller.getStartingDate(context);
                        },
                        icon: const Icon(Icons.date_range)),
                    controller: contorller.startDateController,
                    hintText: "Start Date",
                  ),
                  CustomTextfield(
                      suffixIcon: IconButton(
                          onPressed: () {
                            contorller.getEndingDate(context);
                          },
                          icon: const Icon(Icons.date_range)),
                      controller: contorller.endDateController,
                      hintText: "End Date"),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await contorller.getRevenue();
                      },
                      child: const Text("Search"))
                ],
              ),
            ),
          ),
          Expanded(
              child: SizedBox(
            child: contorller.revenue.isEmpty
                ? const Center(
                    child: Text("No datas, In this date "),
                  )
                : Obx(() => ListView.builder(
                    itemCount: contorller.revenue.length,
                    itemBuilder: (context, index) {
                      Revenue revenue = contorller.revenue[index];
                      DateTime parsedDate =
                          DateFormat('dd/MM/yyyy').parse(revenue.date);
                      String formattedDate =
                          DateFormat('MMMM dd, yyyy').format(parsedDate);
                      return ListTile(
                        title: Text(
                            "Booking id : ${revenue.bookingId.toString()}"),
                        subtitle: Text(formattedDate),
                        trailing: Text(
                          "₹ ${revenue.fare.toString()}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      );
                    })),
          ))
        ],
      ),
    );
  }
}
