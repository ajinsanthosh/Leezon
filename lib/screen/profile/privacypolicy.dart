import 'package:flutter/material.dart';
import 'package:leezon/screen/profile/setteing.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';

class Privacypolicy extends StatelessWidget {
  const Privacypolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40, // Diameter of the circle
            borderColor: Colors.black,
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const Setteing (),
                ),
              );
            },
            backgroundColor: Pallete.borderColor,
          ),
        ),
      ),
      body: const PrivacypolicyContent  (),
    );
  }
}

class PrivacypolicyContent extends StatelessWidget {
  final String termsText = """
   1. Introduction
  This Privacy Policy outlines how we collect, use, and protect your personal information when you use our application.

  2. Information We Collect
  We may collect the following types of information:
  - Personal identification information (Name, email address, phone number, etc.)
  - Usage data and analytics

  3. How We Use Your Information
  We use the information we collect in the following ways:
  - To provide and maintain our service
  - To notify you about changes to our service
  - To improve the app and user experience
  - To provide customer support

  4. Data Security
  We are committed to ensuring that your information is secure. We have implemented appropriate physical, electronic, and managerial procedures to safeguard and secure the information we collect.

  5. Sharing Your Information
  We do not sell, trade, or otherwise transfer your personal information to outside parties except as required by law.

  6. Changes to This Privacy Policy
  We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.

  7. Contact Us
  If you have any questions about this Privacy Policy, please contact us at [Your Contact Information].

  """;

  const PrivacypolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Privacy Policy",
            style: TextStyle(
                color: Pallete.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                termsText,
                style: const TextStyle(fontSize: 16.0, height: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
