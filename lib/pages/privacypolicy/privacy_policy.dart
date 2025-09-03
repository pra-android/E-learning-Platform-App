import 'package:e_learning_platform/utilities/constants/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  Widget sectionTitle(String text) => Padding(
    padding: EdgeInsets.only(left: 8.w, top: 12.h, bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget sectionText(String text) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 14.sp),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Introduction"),
            sectionText(
              "Welcome to Skill Booster! This privacy policy explains how we collect, use, "
              "and protect your personal information when you use our e-learning services.",
            ),

            sectionTitle("Information We Collect"),
            sectionText(
              "We collect information to provide better services to our users. This includes:\n"
              "1. Personal identification information (name, email, etc.)\n"
              "2. Usage data (app interactions, learning progress)\n"
              "3. Cookies and tracking technologies",
            ),

            sectionTitle("How We Use Your Information"),
            sectionText(
              "We use the collected information to:\n"
              "1. Improve our services\n"
              "2. Personalize your learning experience\n"
              "3. Communicate with you regarding updates or support",
            ),

            sectionTitle("Data Security"),
            sectionText(
              "We use industry-standard security measures, including encryption and secure servers, "
              "to protect your personal information from unauthorized access, alteration, or disclosure.",
            ),

            sectionTitle("Third-Party Services"),
            sectionText(
              "Our app may use third-party services such as Firebase Authentication, Google Analytics, "
              "or payment gateways, which may collect data as described in their respective privacy policies.",
            ),

            sectionTitle("Your Rights"),
            sectionText(
              "You have the right to access, update, or delete your personal information at any time. "
              "You can request these changes by contacting us directly.",
            ),

            sectionTitle("Data Retention"),
            sectionText(
              "We retain your personal data only as long as necessary to provide our services or as "
              "required by applicable laws.",
            ),

            sectionTitle("Changes to This Policy"),
            sectionText(
              "We may update this privacy policy from time to time. You will be notified of significant "
              "changes within the app or via email.",
            ),

            sectionTitle("Consent"),
            sectionText(
              "By using Skill Booster, you agree to the collection and use of your information as "
              "described in this privacy policy.",
            ),

            sectionTitle("Contact Us"),
            sectionText(
              "Email: bhattaraipravin123@gmail.com\n"
              "Address: Sankhamul, Kathmandu",
            ),
          ],
        ),
      ),
    );
  }
}
