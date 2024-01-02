import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/controller/sign_up_validation.dart';
import 'package:taxi_app/widgets/appbars/appbars.dart';
import 'package:taxi_app/widgets/person_table.dart/detail_tile.dart';
import 'package:taxi_app/widgets/person_table.dart/person_table.dart';

class PersonalDetails extends StatelessWidget {
  PersonalDetails({super.key});

  final DateTime _selectedDate = DateTime.now();
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const PreferredSize(
          preferredSize: Size(double.maxFinite, 70),
          child: DeatialAppbar(text: 'Personal Details')),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          //personl table widget//
          PersonDetailTable(
            onTap: () {
              profilePic.imagepickerfun();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(255, 254, 254, 254),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(44, 112, 112, 112),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(5, 10),
                  ),
                ],
              ),
              width: double.maxFinite,
              child: Column(
                children: [
                  DetailTile(
                    keyboardType: TextInputType.number,
                    controllers: controller.phoneController,
                    sub: 'Phone number',
                    hittext: 'Enter your phone number',
                  ),
                  DetailTile(
                    keyboardType: TextInputType.emailAddress,
                    controllers: controller.emailContorllers,
                    sub: 'Email',
                    hittext: 'Enter your email address',
                  ),
                  DetailTile(
                    controllers: controller.genderController,
                    sub: 'Gender',
                    hittext: controller.selectRepeat.value,
                    suffixicon: DropdownButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      iconDisabledColor:
                          const Color.fromARGB(252, 103, 103, 103),
                      items: controller.selectRepeatList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        controller.selectGetnder(newValue);
                      },
                    ),
                  ),
                  DetailTile(
                    controllers: controller.birthController,
                    sub: 'Birthday',
                    hittext: DateFormat.yMd().format(_selectedDate).toString(),
                    suffixicon: IconButton(
                        onPressed: () {
                          controller.getTimeFromUser(context);
                        },
                        icon: const Icon(Icons.calendar_month)),
                  ),
                  DetailTile(
                    keyboardType: TextInputType.number,
                    controllers: controller.expController,
                    sub: 'Expirience',
                    hittext: 'Enter your Expirience',
                  ),
                  DetailTile(
                    controllers: controller.licenseController,
                    sub: 'License Number',
                    hittext: 'Enter your License No',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
        
          controller.personalScreenValidation();
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
