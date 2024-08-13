import 'package:flutter/material.dart';
import 'package:leezon/screen/profile/setteing.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';

class Communityguidelines extends StatelessWidget {
  const Communityguidelines({super.key});

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
      body: CommunityGuidelinesContent(),
    );
  }
}

class CommunityGuidelinesContent extends StatelessWidget {
  final String termsText = """
  1. Respect and Kindness
  Treat everyone with respect and kindness. We do not tolerate harassment, discrimination, or hate speech of any kind.

  2. Authenticity
  Be authentic and genuine in your interactions. Do not impersonate others or provide false information.

  3. Privacy
  Respect the privacy of others. Do not share private information without consent.

  4. Safe Environment
  Create a safe environment by reporting any harmful or inappropriate content. We want our community to be welcoming and safe for everyone.

  5. No Spamming
  Avoid spamming or flooding the community with repetitive content. Keep discussions relevant and meaningful.

  6. Content Sharing
  Share content responsibly and give credit where it's due. Do not share content that violates copyright or intellectual property rights.

  7. Follow the Law
  Abide by all applicable laws and regulations. Illegal activities are not permitted within our community.

  8. Consequences
  Violating these guidelines may result in the suspension or termination of your account.

  9. Changes to Guidelines
  We reserve the right to update these guidelines at any time. Continued use of the app implies acceptance of the updated guidelines.

  10. Contact Us
  If you have any questions or concerns about these guidelines, please contact us at [Your Contact Information].



  """;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Community Guidelines",
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
