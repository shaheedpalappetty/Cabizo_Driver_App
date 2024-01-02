import 'package:flutter/material.dart';
import 'package:taxi_app/widgets/texts/bullet_text.dart';
import 'package:taxi_app/widgets/texts/heading_text.dart';
import 'package:taxi_app/widgets/texts/subtitle_text.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Headline(text: "Terms & Conditions"),
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            color: Colors.amber,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const ToplevelText(),
              Text(
                "Welcome to ZippyRoutes, the taxi booking app for users in Kerala, India. Please carefully read and understand the following terms and conditions before using our services.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "urbanist",
                    fontSize: 16),
              ),
              SizedBox(height: 20),

              Headline(
                text: 'Acceptance of Terms:',
              ),
              BulletText(
                  text:
                      "By downloading, installing, or using the ZippyRoutes app, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use our services."),

              // Service Information
              SizedBox(height: 20),
              Headline(text: 'Eligibility:'),
              BulletText(
                  text:
                      "You must be at least 18 years old to use ZippyRoutes. By using the app, you confirm that you meet this eligibility requirement."),

              SizedBox(height: 20),
              Headline(text: 'Account Registration:'),

              BulletText(
                  text:
                      "To use our services, you must create an account by providing accurate and complete information during the signup process."),
              BulletText(
                  text:
                      ' You are responsible for maintaining the confidentiality of your account credentials. Any activity under your account is your responsibility.'),
              SizedBox(height: 20),
              Headline(text: 'User Conduct:'),
              BulletText(
                text:
                    "You agree to use ZippyRoutes solely for lawful purposes and in compliance with all applicable laws and regulations.",
              ),
              BulletText(
                  text:
                      "You will not engage in any behavior that could harm, disrupt, or interfere with the proper functioning of the ZippyRoutes app."),
              SizedBox(height: 20),
              Headline(text: ' Ride Booking and Payment:'),
              BulletText(
                  text:
                      "By booking a ride through ZippyRoutes, you agree to pay the fare as displayed in the app."),
              BulletText(
                  text:
                      "Payment is processed through the Razorpay gateway. ZippyRoutes does not store any financial information on its servers."),
              BulletText(
                  text:
                      "ZippyRoutes reserves the right to modify fares, promotions, or payment policies at any time."),
              SizedBox(height: 20),
              Headline(text: 'User Content:'),
              BulletText(
                  text:
                      "You retain ownership of any content you submit to ZippyRoutes, such as reviews and feedback."),
              BulletText(
                  text:
                      "By submitting content, you grant ZippyRoutes a non-exclusive, worldwide, royalty-free license to use, modify, and display the content for the purpose of providing and improving our services."),
              SizedBox(height: 20),

              Headline(text: 'Privacy:'),
              BulletText(
                  text:
                      "Your use of ZippyRoutes is subject to our Privacy Policy, which outlines how we collect, use, and protect your personal information"),
              SizedBox(height: 20),
              Headline(text: 'Termination:'),
              BulletText(
                  text:
                      "ZippyRoutes reserves the right to suspend or terminate your account and access to the app at its sole discretion, with or without cause."),
              SizedBox(height: 20),

              Headline(text: ' Changes to Terms and Conditions:'),
              BulletText(
                  text:
                      "ZippyRoutes may update these Terms and Conditions to reflect changes in our services or legal requirements. You will be notified of any significant changes"),
              SizedBox(height: 20),

              Headline(text: 'Disclaimer of Warranties:'),
              BulletText(
                  text:
                      "ZippyRoutes is provided 'as is and as available.' We make no warranties, expressed or implied, regarding the reliability, timeliness, or availability of our services."),
              SizedBox(height: 20),
              Headline(text: 'Limitation of Liability:'),
              BulletText(
                  text:
                      "In no event shall ZippyRoutes be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues."),
              SizedBox(height: 20),

              Headline(text: 'Governing Law:'),
              BulletText(
                  text:
                      "These Terms and Conditions are governed by the laws of the State of Kerala, India."),
              SizedBox(height: 20),

              Headline(text: 'Contact Information:'),
              BulletText(
                  text:
                      "If you have any questions or concerns about these Terms and Conditions, please contact us at [contact@zippyroutes.com]."),
              SizedBox(height: 20),
              SubtitleText(text: "Thank you for choosing ZippyRoutes!")
            ],
          ),
        ),
      ),
    );
  }
}
