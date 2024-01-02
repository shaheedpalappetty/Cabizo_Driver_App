import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/model/driver_model.dart';
import 'package:taxi_app/model/revenue.dart';
import 'package:taxi_app/service/repo.dart';

class DriverController extends GetxController {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final Rx<DateTime> selectedStartDate = DateTime.now().obs;
  final Rx<DateTime> selectedEndDate = DateTime.now().obs;
  late Driver driver;
  RxList<Revenue> revenue = <Revenue>[].obs;
  getRevenue() async {
    revenue.value = await Repo.getRevenueByDate(
        startDateController.text, endDateController.text, driver.id!);
    revenue.refresh();
  }

  getStartingDate(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2123));

    if (pickerDate != null) {
      selectedStartDate.value = pickerDate;
      String formattedDate =
          DateFormat('dd/MM/yyyy').format(selectedStartDate.value);
      startDateController.text = formattedDate;
    } else {}
  }

  getEndingDate(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2123));

    if (pickerDate != null) {
      selectedEndDate.value = pickerDate;
      String formattedDate =
          DateFormat('dd/MM/yyyy').format(selectedEndDate.value);
      endDateController.text = formattedDate;
     
    } else {}
  }
}
