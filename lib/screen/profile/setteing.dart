
import 'package:flutter/material.dart';
import 'package:leezon/screen/Auth/phonenumber_auth.dart';
import 'package:leezon/screen/Auth/username.dart';
import 'package:leezon/screen/profile/communityguidelines.dart';
import 'package:leezon/screen/profile/privacypolicy.dart';
import 'package:leezon/screen/profile/termsandcondition.dart';
import 'package:leezon/screen/profile/widget/custom_inkwell.dart';
import 'package:leezon/utility/commen_widget/spacedivider.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:leezon/utility/utilites.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setteing extends StatelessWidget {
  const Setteing({super.key});

  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isNewUser');
    prefs.remove('hasAccount');
    prefs.remove('isLoggedIn');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40,
            borderColor: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Pallete.borderColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0, top: 0),
            child: PopupMenuButton<String>(
              icon: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Pallete.borderColor,
                ),
                child: const Center(
                  child: Icon(Icons.more_horiz, size: 30),
                ),
              ),
              color: const Color.fromARGB(255, 240, 239, 239),
              onSelected: (value) async {
                if (value == 'delete_account') {
                  showMyAnimatedDialog(
                    context: context,
                    title: 'Delete Account',
                    content:
                        'Are you sure you want to delete your account? This action cannot be undone.',
                    actionText: 'Delete',
                    onActionPressed: (confirmed) async {
                      if (confirmed) {
                        await deleteAccount();
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Username(),
                          ),
                        );
                      }
                    },
                  );
                } else if (value == 'logout') {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLoggedIn', false);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhonenumberAuth(),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'delete_account',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Pallete.redcolor),
                        SizedBox(width: 8),
                        Text('Delete Account'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Pallete.bluecolor),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 30,
          right: 10,
          bottom: 20,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomInkWell(
            icon: Icons.sticky_note_2_outlined,
            text: "Terms and condition",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndConditionsPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const SpacedDivider(),
          const SizedBox(
            height: 15,
          ),
          CustomInkWell(
            icon: Icons.lock_clock_outlined,
            text: "Privacy policy",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Privacypolicy(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const SpacedDivider(),
          const SizedBox(
            height: 15,
          ),
          CustomInkWell(
            icon: Icons.security,
            text: "Community guideline",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Communityguidelines(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Pallete.blackColor,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Share your friends",
                            style: TextStyle(
                                color: Pallete.whiteColor, fontSize: 23),
                          ),
                          Text(
                            "Let's grow our community together",
                            style: TextStyle(
                                color: Pallete.whiteColor, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 110,
                    height: 110,
                    child: Lottie.asset(
                      'assets/lotti/clap.json', // replace with your lottie file path
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Made with ❤️ by ",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                "Ajin santhosh",
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          )
        ]),
      ),
    );
  }
}
