// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:taxi_app/widgets/driver_revenue_side/revenue_font.dart';

class RevenueTable extends StatelessWidget {
  const RevenueTable({
    super.key,
    required this.totaldrive,
    required this.profit,
  });
  final totaldrive;
  final profit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 99, 95, 60),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(35)),
      height: 110,
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 232, 233, 234),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RevenuFont(text: "Total Drive"),
                const SizedBox(
                  height: 10,
                ),
                RevenueAmountFont(text: totaldrive)
              ],
            ),
          )),
          Expanded(
              child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RevenuFont(text: "Total Revenue"),
                const SizedBox(
                  height: 10,
                ),
                RevenueAmountFont(text: profit)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
