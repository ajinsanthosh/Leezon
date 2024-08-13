import 'package:flutter/material.dart';
import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/screen/profile/widget/custom1_textformfild.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (profileProvider.profile != null) {
      _nameController.text = profileProvider.profile!.name;
      _emailController.text = profileProvider.profile!.email;
      selectedHobbies.addAll(profileProvider.profile!.interestedAreas);
    }
  }

  @override
  void dispose() {
    selectedHobbies
        .clear(); // Clear selected hobbies when the widget is disposed
    super.dispose();
  }

  Future<void> _saveSelectedHobbies() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    try {
      await profileProvider.updateProfile(
        newInterestedAreas: selectedHobbies.toList(),
      );
      print(
        'Updated profile interested areas: ${profileProvider.profile!.interestedAreas}',
      );
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update interests')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40, // Diameter of the circle
            borderColor:Pallete.blackColor,
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationMenu(
                    initialIndex: 2,
                  ),
                ),
              );
            },
            backgroundColor: Pallete.borderColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                color:Pallete.blackColor,
                borderRadius: BorderRadius.circular(20), // Oval shape
              ),
              child: Center(
                child: TextButton(
                   onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          await _saveSelectedHobbies();

                          try {
                            await profileProvider.updateProfile(
                              newName: _nameController.text,
                              newEmail: _emailController.text,
                              newInterestedAreas: selectedHobbies.toList(),
                            );
                           
                          } catch (e) {
                            print('Error updating profile: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Failed to update profile')),
                            );
                          }
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationMenu(),
                            ),
                          );
                        }
                      },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Pallete.whiteColor, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30), // Added top padding
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color:Pallete.blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlineTextformfild(
                      controller: _nameController,
                      hintText: 'Enter your name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    OutlineTextformfild(
                      controller: _emailController,
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(height: 7),
                    const Text(
                      "Pick up 5 things you like",
                      style:
                          TextStyle(color: Color.fromARGB(255, 134, 132, 132)),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: hobbies.map((hobby) {
                        return ChoiceChip(
                          showCheckmark: false,
                          label: Text(hobby),
                          selected: selectedHobbies.contains(hobby),
                          selectedColor:
                             Pallete.greycolor,
                          backgroundColor:
                              Pallete.borderColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: selectedHobbies.contains(hobby)
                                  ?  Pallete.greycolor
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
