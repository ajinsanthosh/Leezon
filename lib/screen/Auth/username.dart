import 'package:flutter/material.dart';
import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/screen/Auth/useremailid.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    print("Current profile in Username widget: ${profileProvider.profile?.name}");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 10, left: 20, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Pallete.borderColor,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "What's your name?",
                  style: TextStyle(
                    color: Pallete.blackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                    hintStyle: TextStyle(
                      color: Pallete.greycolor,
                      fontSize: 17,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.blackColor, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.greycolor, width: 1.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.redcolor, width: 2.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.redcolor, width: 2.0),
                    ),
                    errorStyle: TextStyle(color: Pallete.redcolor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'First name must contain only letters';
                    }
                    if (value.length < 3) {
                      return 'First name must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.blackColor, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.redcolor, width: 2.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallete.redcolor, width: 2.0),
                    ),
                    errorStyle: TextStyle(color: Pallete.redcolor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Last name must contain only letters';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          String fullName =
                              '${_firstNameController.text} ${_lastNameController.text}';
                          try {
                            // Check if the profile is loaded before updating
                            if (profileProvider.profile == null) {
                              throw Exception(
                                  'Profile is not loaded. Please load a profile before updating.');
                            }

                            await profileProvider.updateProfile(
                                newName: fullName);

                            // Print the updated profile name safely
                            if (profileProvider.profile != null) {
                              print(
                                  'Updated profile name: ${profileProvider.profile!.name}');
                            } else {
                              print('Profile is still null after update');
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Useremailid()),
                            );
                          } catch (e) {
                            print('Error updating profile: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Failed to update name')),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Pallete.blackColor,
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
        ),
      ),
    );
  }
}
