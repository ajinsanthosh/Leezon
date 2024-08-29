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
   
Privacy Policy

Effective Date: 29-09-2024
1. Introduction

Welcome to Leezon! This Privacy Policy explains how we collect, use, and protect your personal information when you use our app, which includes features for text-to-image creation, voice interaction with Gemini, and starting conversations with Gemini. We are committed to safeguarding your personal data and ensuring it remains secure.
2. Information We Collect

We collect the following personal information from you:

    Full Name: To personalize your experience within the app.

    Email Address: For account-related notifications, communication, and support.

    Gender: To customize interactions, recommendations, and app experience.

    Interested Areas: To tailor content and services based on your preferences.

    Profile Photo: To personalize your profile and enhance user interaction.

    Phone Number: For account verification and essential communication.

    Search History: To improve our services and provide relevant content.

    Generated Images: To save, display, and manage images created through the text-to-image feature.

3. How We Collect Information

We collect information through:

    User Input: When you manually enter data through the app, such as during registration, profile updates, or while using app features.

    Local Storage: Information is stored locally on your device using Hive, which ensures data accessibility and security within the app.

4. How We Use Your Information

We use the collected information to:

    Provide and Improve Services: Enhance your experience with text-to-image creation, voice interaction, and other app features.

    Personalize Content: Offer tailored recommendations and interactions based on your preferences and search history.

    Communicate: Send essential notifications, updates, and support-related information.

    Manage and Display Generated Images: Save, organize, and present images you create through the app’s features.

5. Data Storage and Security

We are deeply committed to ensuring the security and protection of your personal information. Here are the measures we take:

    Data Encryption: All personal information, including email addresses and any sensitive data, is encrypted both during transmission and when stored. We use industry-standard encryption protocols (e.g., HTTPS/SSL) to protect your data.

    Local Storage: Your data is stored locally on your device using Hive, a secure data storage solution. Hive uses encryption to ensure your data is safe and only accessible through the app.

    Access Control: We implement strict access control mechanisms to ensure that only authorized personnel can access your personal information. These measures include authentication and authorization protocols.

    Secure Third-Party Services: If we use third-party services (e.g., cloud storage providers) to store or process personal data, we ensure that these partners are compliant with industry-standard security practices, such as GDPR or ISO 27001 certifications. These third-party services are contractually obligated to protect your data and use it solely for purposes specified by us.

6. Data Sharing

We do not share your personal information with third parties, except in the following cases:

    Legal Requirements: To comply with legal obligations or to protect our rights, we may disclose your information.

    Service Providers: We may work with trusted third-party service providers to support app functionality. These providers are required to protect your data and use it only for specific purposes as directed by us.

7. Your Rights

You have the following rights regarding your personal information:

    Access and Update: You can review and update your personal information through the app’s settings.

    Delete Your Data: You may request the deletion of your personal data by contacting us directly.

    Opt-Out: You can opt out of receiving non-essential communications by following the unsubscribe instructions in our emails.

8. Changes to This Privacy Policy

We may update this Privacy Policy from time to time. Any changes will be posted on our website and within the app. Your continued use of the app following any changes signifies your acceptance of the revised policy.
9. Contact Us

If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:

Email: ajinsanthosh0123@gmail.com
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
