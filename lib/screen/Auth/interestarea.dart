import 'package:flutter/material.dart';
import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/screen/Auth/profilepicture.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interestarea extends StatefulWidget {
  const Interestarea({super.key});

  @override
  State<Interestarea> createState() => _InterestareaState();
}

class _InterestareaState extends State<Interestarea> {
  final List<String> hobbies = [
    '🧑‍💻PROGRAMMING LANGUAGE',
    '✨AI',
    '🧬BIOHACKING',
    '👩‍💼ENTREPRENEURSHIP',
    '🏋FITNESS',
    '🌍SOCIALSCIENCE',
    '🎯PRODUCT MANAGEMENT',
    '🎨ART',
    '🧑‍💻MACHINE LEARNING',
    '🤖ROBOTICS',
    '💻DATA SCIENCE',
    '🌍LIFE SCIENCES',
    '🤵VOLUNTEERING',
    '🥽AR/VR',
    '💻WEB DEVELOPMENT',
    '✒PRODUCT DESIGN',
    '‍♂SPORTS',
    '👩‍💻DEVOPS',
    '📱APP DEVELOPMENT',
    '🎤MUSIC'
  ];
  final Set<String> selectedHobbies = {};

  Future<void> _saveSelectedHobbies() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    try {
      await profileProvider.updateProfile(
          newInterestedAreas: selectedHobbies.toList());
      print(
          'Updated profile interested areas: ${profileProvider.profile!.interestedAreas}');
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update interests')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, right: 10, left: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Pallete.borderColor,
              child: Icon(
                Icons.photo,
                size: 40,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Tell us about your area of interest?",
              style: TextStyle(
                  color:Pallete.blackColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 7),
            const Text(
              "Pick up 5 things you like",
              style: TextStyle(color: Pallete.greycolor),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: hobbies.map((hobby) {
                    return ChoiceChip(
                      showCheckmark: false,
                      label: Text(hobby),
                      selected: selectedHobbies.contains(hobby),
                      selectedColor: Pallete.greycolor,
                      backgroundColor:  Pallete.borderColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(
                          color: selectedHobbies.contains(hobby)
                              ? Pallete.greycolor
                              : Pallete.borderColor,
                        ),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            if (selectedHobbies.length < 5) {
                              selectedHobbies.add(hobby);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "You can only select up to 5 hobbies."),
                                ),
                              );
                            }
                          } else {
                            selectedHobbies.remove(hobby);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BorderedIconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePicture()),
                    );
                  },
                  borderColor:Pallete.blackColor,
                      backgroundColor:Pallete.borderColor,
                  size: 50,
                ),
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isNewUser', false);
                    prefs.setBool('hasAccount', true);
                    prefs.setBool('isLoggedIn', true);
                    // Save the selected hobbies
                    await _saveSelectedHobbies();

                    // Print the selected hobbies
                    print('Selected hobbies: ${selectedHobbies.toList()}');

                    // Navigate to the next screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationMenu()),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color:  Pallete.blackColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Pallete.whiteColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Pallete.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
