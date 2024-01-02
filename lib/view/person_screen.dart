import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/controller/driver_controller.dart';
import 'package:taxi_app/controller/home_controller.dart';
import 'package:taxi_app/model/revenue.dart';
import 'package:taxi_app/view/profit_screen.dart';
import 'package:taxi_app/widgets/driver_revenue_side/revenue_table.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final HomeController controller = Get.find();
  final DriverController driver = Get.find();
  @override
  void initState() {
    super.initState();
    controller.getRevenue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.amber,
        title: Text("Hi ${driver.driver.name}....."),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ProfitScreen());
              },
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: RevenueTable(
                      totaldrive: controller.revenueList!.length.toString(),
                      profit: controller.revenueTotal.toString(),
                    ))
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: controller.revenueList!.isEmpty
                  ? const Center(
                      child: Text("No Drives Today"),
                    )
                  : ListView.builder(
                      itemCount: controller.revenueList?.length,
                      itemBuilder: (context, index) {
                        Revenue detail = controller.revenueList![index];
                        DateTime parsedDate =
                            DateFormat('dd/MM/yyyy').parse(detail.date);

                        String formattedDate =
                            DateFormat('MMMM dd, yyyy').format(parsedDate);
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.date_range),
                            title: Text(formattedDate),
                            subtitle:
                                Text("RideId : ${detail.bookingId.toString()}"),
                            trailing: Text(
                              "₹ ${detail.fare.toString()}",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        );
                      },
                    ))
        ],
      ),
    );
  }
}
