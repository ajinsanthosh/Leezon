
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:leezon/provider/thought_provider.dart';
import 'package:leezon/screen/profile/edit_profile.dart';
import 'package:leezon/screen/profile/setteing.dart';
 // Ensure correct file name
import 'package:provider/provider.dart';
import 'package:leezon/provider/profileprovider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final thoughtProvider = Provider.of<ThoughtProvider>(context);
    final profile = profileProvider.profile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: profile != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: profile.imagePath.isNotEmpty
                                  ? FileImage(File(profile.imagePath))
                                  : const AssetImage('assets/img/ajin.jpg') as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: IconButton(
                              icon: const Icon(Icons.settings, size: 30, color: Colors.black),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Setteing(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        profile.name.toUpperCase(),
                        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        profile.email,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        '"${thoughtProvider.currentThought}"',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 15.0,
                        children: profile.interestedAreas.map((area) {
                          return ChoiceChip(
                            showCheckmark: false,
                            label: Text(area),
                            selected: true,
                            onSelected: (bool selected) {},
                            selectedColor: const Color.fromARGB(255, 240, 239, 239),
                            labelStyle: const TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: double.infinity, // Responsive width
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(color: Colors.black, width: 1),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Updateprofile(),
                              ),
                            );
                          },
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
