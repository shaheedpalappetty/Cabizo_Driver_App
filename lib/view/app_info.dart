// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/view/personl_detail_screen.dart';
import 'package:taxi_app/widgets/buttons/autbutton.dart';
import 'package:taxi_app/widgets/texts/bullet_text.dart';
import 'package:taxi_app/widgets/texts/heading_text.dart';
import 'package:taxi_app/widgets/texts/subtitle_text.dart';
import 'package:taxi_app/widgets/texts/top_level_text.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(
              color: Colors.amber,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [Shadow(color: Colors.black)],
                    size: 35,
                  )),
            )),
        body: const SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ToplevelText(),

                const SizedBox(height: 20),
                const Headline(
                  text: 'Benefits and Opportunities:',
                ),
                const SubtitleText(
                    text:
                        'Join us to enjoy flexible schedules, great earning potential, and the freedom to be your own boss.'),

                // Service Information
                const SizedBox(height: 20),
                const Headline(text: 'Service Information:'),
                const SubtitleText(
                  text:
                      'At [Your Taxi Service], we offer a variety of services, including standard rides, premium services, and more. We operate in [Service Area], and our platform connects you with riders from all walks of life.',
                ),

                const SizedBox(height: 20),
                const Headline(text: 'Earnings Potential:'),
                const SubtitleText(
                  text:
                      'As a driver, you have the opportunity to earn a competitive income. Our fare structures, surge pricing, and tips from passengers can boost your earnings. Plus, we offer special incentives and bonuses for outstanding performance.',
                ),
                const SizedBox(height: 20),
                const Headline(text: 'Driver Requirements:'),
                const SubtitleText(
                  text:
                      "To become a driver with us, you'll need to meet certain requirements:",
                ),
                SizedBox(
                  height: 15,
                ),
                BulletText(text: 'Possession of a valid driver\'s license'),
                BulletText(text: 'A vehicle that meets our specifications'),
                BulletText(text: 'Clean driving record'),
                BulletText(text: 'Successful background checks'),
                BulletText(text: 'Good and friendly communication'),
                const SizedBox(height: 20),
                const Headline(text: 'Safety and Support:'),
                const SubtitleText(
                  text:
                      'Your safety and well-being are our top priorities. Our platform includes safety features such as passenger ratings and in-app navigation. We provide 24/7 support to assist you with any concerns or questions.',
                ),
                const SizedBox(height: 20),
                const Headline(text: 'Insurance and Liability:'),
                const SubtitleText(
                  text:
                      'Our service offers insurance coverage to drivers and passengers. Our insurance policies provide protection under specific circumstances. Rest assured, we prioritize your safety and peace of mind.',
                ),
                const SizedBox(height: 20),
                const Headline(text: 'Terms and Conditions:'),
                const SubtitleText(
                  text:
                      'Before joining our community, please review and accept our full terms and conditions. They outline the rules and guidelines for using our platform.',
                ),
                const SizedBox(height: 20),
                const Headline(text: 'Ready to Get Started?'),
                const SubtitleText(
                  text:
                      "If you're excited about the opportunities we offer and want to become a part of our driver community, hit the 'Join Our Community' button to begin your registration.",
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        floatingActionButton: InkWell(
            onTap: () {
              Get.to(PersonalDetails());
            },
            child: const AutButton(text: 'Join Our Community')));
  }
}
