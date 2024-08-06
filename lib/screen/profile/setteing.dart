import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/screen/profile/resetpassword.dart';
import 'package:leezon/screen/profile/widget/CustomInkWell.dart';
import 'package:leezon/screen/profile/widget/SpacedDivider.dart';
import 'package:leezon/utility/commen_widget/iconbutton.dart';
import 'package:lottie/lottie.dart';

class Setteing extends StatelessWidget {
  const Setteing({super.key});

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  NavigationMenu(),
                ),
              );
            }, backgroundColor: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: BorderedIconButton(
              icon: const Icon(Icons.more_horiz),
              size: 40,
              borderColor: Colors.black,
              onPressed: () {
                // Action for the more options button
              }, backgroundColor: Colors.white,
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
              icon: Icons.security,
              text: "Reset password",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Resetpassword()),
                );
             }),
          const SpacedDivider(),
          CustomInkWell(
              icon: Icons.security,
              text: "Terms and condition",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const Updateprofile()),
                // );
              }),
          const SpacedDivider(),
          CustomInkWell(
              icon: Icons.security,
              text: "Privacy policy",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const Updateprofile()),
                // );
              }),
          const SpacedDivider(),
          CustomInkWell(
              icon: Icons.security,
              text: "Community guideline",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const Updateprofile()),
                // );
              }),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
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
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                          Text(
                            "Let's grow our community together",
                            style: TextStyle(color: Colors.white, fontSize: 13),
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
