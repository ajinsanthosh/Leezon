import 'package:flutter/material.dart';
import 'package:leezon/hive/profile_model.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/screen/login/loginScreen.dart';
import 'package:leezon/model/profile_service.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkProfileStatus();
  }

  void _checkProfileStatus() async {
    ProfileService _profileService = ProfileService();
    await _profileService.openBox();

    List<Profile> profiles = await _profileService.getProfile();

    await Future.delayed(const Duration(seconds:2));

    if (profiles.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginscreen()),
      );
    } else {
      Profile profile = profiles.first;
      if (profile.name.isNotEmpty &&
          profile.email.isNotEmpty &&
          profile.password.isNotEmpty &&
          profile.phonenumber.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  NavigationMenu()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Loginscreen()),
        );
      }
    }

    // Close the Hive box after checking the profile status
    await _profileService.closeBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
