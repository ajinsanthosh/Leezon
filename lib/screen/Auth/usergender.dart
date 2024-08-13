import 'package:flutter/material.dart';
import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/screen/Auth/profilepicture.dart';
import 'package:leezon/screen/Auth/useremailid.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/commen_widget/spacedivider.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class Usergender extends StatefulWidget {
  const Usergender({super.key});

  @override
  State<Usergender> createState() => _UsergenderState();
}

class _UsergenderState extends State<Usergender> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 100, right: 10, left: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Pallete.borderColor,
                      child: Icon(
                        Icons.person_2_outlined,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "How do you identify \nyourselves as?",
                      style: TextStyle(
                          color: Pallete.blackColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 70),
                    _buildGenderRow("Male", 'Male'),
                    const SpacedDivider(),
                    _buildGenderRow("Female", 'Female'),
                    const SpacedDivider(),
                    _buildGenderRow("Non-binary", 'Non binary'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderedIconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Useremailid()));
                    },
                  borderColor:Pallete.blackColor,
                      backgroundColor:Pallete.borderColor,
                    size: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      String gender = _selectedGender ?? 'not specified';

                      try {
                        await profileProvider.updateProfile(newGender: gender);
                        print(
                            'Updated profile name: ${profileProvider.profile!.gender}');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePicture()),
                        );
                      } catch (e) {
                        print('Error updating profile: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to update name')),
                        );
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Pallete.blackColor,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color:Pallete.whiteColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color:Pallete.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRow(String label, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _selectedGender == value
                  ? Pallete.blackColor
                  : Pallete.greycolor,
              fontWeight: _selectedGender == value
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 18.0,
            ),
          ),
          Row(
            children: [
              Radio<String>(
                activeColor: Pallete.blackColor,
                value: value,
                groupValue: _selectedGender,
                onChanged: (selectedValue) {
                  setState(() {
                    _selectedGender = selectedValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
