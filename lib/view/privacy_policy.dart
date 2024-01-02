import 'package:flutter/material.dart';
import 'package:taxi_app/widgets/texts/bullet_text.dart';
import 'package:taxi_app/widgets/texts/heading_text.dart';
import 'package:taxi_app/widgets/texts/subtitle_text.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Headline(text: "Privacy Policy"),
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
                "Welcome to ZippyRoutes, a taxi booking app designed for users in Kerala, India. This Privacy Policy outlines how we collect, use, and safeguard your personal information. By using the ZippyRoutes app, you agree to the terms described in this policy.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "urbanist",
                    fontSize: 16),
              ),
              SizedBox(height: 20),

              Headline(
                text: 'Information We Collect:',
              ),
              BulletText(
                text:
                    "When a driver joins the Zippy Routes community, we collect personal details such as name, email, phone number, Aadhar card, driver's license, and other necessary information to verify identity and eligibility for the driver job.",
              ),
              BulletText(
                text:
                    "Location Information: ZippyRoutes requires access to your device's location to provide accurate taxi services. Your location data is used solely for the purpose of connecting you with nearby drivers.",
              ),
              BulletText(
                text:
                    "Push Notifications: We request permission to send push notifications to keep you informed about your ride status, promotions, and other relevant updates.",
              ),
              BulletText(
                text:
                    "Payment Information: When making payments through the Razorpay gateway, your payment details are securely processed, and we do not store any financial information on our servers.",
              ),
              // Service Information
              SizedBox(height: 20),
              Headline(text: 'How We Use Your Information:'),
              BulletText(
                text:
                    'Booking and Ride Management: Your user details are used to facilitate ride bookings and manage the ride lifecycle, including communication with drivers.',
              ),
              BulletText(
                text:
                    "Location Services: We use your location to connect you with nearby drivers and improve the accuracy of estimated arrival times.",
              ),
              BulletText(
                text:
                    "Push Notifications: To keep you informed about ride status, promotional offers, and important updates related to the ZippyRoutes service.",
              ),
              SizedBox(height: 20),
              Headline(text: 'Data Security:'),

              BulletText(
                  text:
                      'Encryption: We prioritize the security of your information and use encryption protocols to protect data during transmission.'),
              BulletText(
                  text:
                      'Access Controls: Access to user data is restricted to authorized personnel only, and we implement strict access controls to prevent unauthorized access.'),
              SizedBox(height: 20),
              Headline(text: 'Sharing of Information:'),
              BulletText(
                text:
                    "Third-Party Services: We do not share your personal information with third-party services. Your data is used solely for the purpose of providing the ZippyRoutes service.",
              ),
              SizedBox(height: 20),
              Headline(text: 'User Control:'),
              BulletText(
                text:
                    "Data Access and Correction: You have the right to access and correct your personal information. Contact us at [contact@zippyroutes.com] for assistance.",
              ),
              BulletText(
                  text:
                      "Opt-Out of Push Notifications: You can manage your push notification preferences in the app settings."),
              SizedBox(height: 20),
              Headline(text: 'Changes to the Privacy Policy:'),
              BulletText(
                  text:
                      " Updates: We may update this Privacy Policy to reflect changes in our practices. You will be notified of any significant changes."),
              SizedBox(height: 20),

              Headline(text: 'Contact Information:'),
              BulletText(
                  text:
                      "If you have any questions or concerns about this Privacy Policy, please contact us at [contact@zippyroutes.com]."),
              SizedBox(height: 30),
              SubtitleText(text: "Thank you for choosing ZippyRoutes!")
            ],
          ),
        ),
      ),
    );
  }
}
