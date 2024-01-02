import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/service/repo.dart';

class IndroController extends GetxController {
  final number = TextEditingController();
  RxBool status = false.obs;
  String? statusDriver;

  statusChecking() async {
    statusDriver = await Repo.checkStatus(number.text.trim());
    status.value = true;
  }
  
}
