
import 'package:flutter/material.dart';
import 'package:leezon/screen/Auth/phonenumber_auth.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:leezon/screen/home/navigation_menu.dart';

import 'package:leezon/screen/Auth/username.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnUserState();
  }

  Future<void> _navigateBasedOnUserState() async {
    final prefs = await SharedPreferences.getInstance();

    // Check user state
    bool? isNewUser = prefs.getBool('isNewUser') ?? true;
    bool? hasAccount = prefs.getBool('hasAccount') ?? false;
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay for splash screen

    if (isNewUser) {
      // Navigate to Username page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Username()),
      );
    } else if (hasAccount && isLoggedIn) {
      // Navigate to Navigation Menu page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationMenu()),
      );
    } else {
      // Navigate to Login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhonenumberAuth()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.blackColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/splash.jpg"),
          ),
        ),
      ),
    );
  }
}

// after  account creation(New User)
// final prefs = await SharedPreferences.getInstance();
// prefs.setBool('isNewUser', false);
// prefs.setBool('hasAccount', true);
// prefs.setBool('isLoggedIn', true);

//after login
// final prefs = await SharedPreferences.getInstance();
// prefs.setBool('isLoggedIn', true);


//after logout
// final prefs = await SharedPreferences.getInstance();
// prefs.setBool('isLoggedIn', false);
