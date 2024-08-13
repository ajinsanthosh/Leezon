import 'package:flutter/material.dart';
import 'package:leezon/screen/profile/setteing.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40, // Diameter of the circle
            borderColor: Pallete.blackColor,
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
      body: TermsAndConditionsContent(),
    );
  }
}

class TermsAndConditionsContent extends StatelessWidget {
  final String termsText = """
  1. Introduction
  Welcome to our application. By accessing or using our app, you agree to be bound by these terms and conditions.

  2. User Obligations
  You agree to use the app in accordance with all applicable laws and regulations. You must not use the app for any unlawful or fraudulent purposes.

  3. Intellectual Property
  All content provided on the app, including text, graphics, logos, and software, is the property of the app owner and is protected by copyright laws.

  4. Limitation of Liability
  We will not be liable for any damages arising from the use of or inability to use the app, including any errors or omissions in the content.

  5. Changes to Terms
  We reserve the right to modify these terms at any time. Your continued use of the app following any changes indicates your acceptance of the new terms.

  6. Governing Law
  These terms and conditions are governed by and construed in accordance with the laws of [Your Country].

  7. Contact Us
  If you have any questions about these terms, please contact us at [Your Contact Information].



  """;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Terms and Conditions",
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
