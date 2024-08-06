import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leezon/hive/profile_model.dart';
import 'package:leezon/screen/login/loginScreen.dart';
import 'package:leezon/model/profile_service.dart';
import 'package:leezon/screen/profile/setteing.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();
  Profile? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    var box = await Hive.openBox<Profile>('profiles');

    Profile? fetchedProfile = box.getAt(0);
    if (fetchedProfile != null) {
      setState(() {
        profile = fetchedProfile;
      });
    } else {
      print('Profile not found or box is empty');
    }

    // await box.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: profile != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: profile!.imagePath.isNotEmpty
                                  ? FileImage(File(profile!.imagePath))
                                  : const AssetImage(
                                          'assets/default_profile.png')
                                      as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: IconButton(
                              icon: const Icon(Icons.settings,
                                  size: 30, color: Colors.black),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Setteing(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        ' ${profile!.name.toUpperCase()}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        ' ${profile!.email}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 400,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            await _profileService.openBox();
                            // await _profileService.deleteprofile(
                            //     0); // This actually clears the whole box
                            await _profileService.closeBox();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loginscreen(),
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged out ')),
                            );
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              )
            : const Center(
                child:
                    CircularProgressIndicator(), // Show loading indicator while fetching profile
              ),
      ),
    );
  }
}
