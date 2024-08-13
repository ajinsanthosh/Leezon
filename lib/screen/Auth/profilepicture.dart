
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/screen/Auth/interestarea.dart';
import 'package:leezon/screen/Auth/usergender.dart';

import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 20, left: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 239, 238, 238),
                child: Icon(
                  Icons.photo,
                  size: 40,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Upload your profile picture?",
                style: TextStyle(
                    color: Pallete.blackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Pallete.borderColor),
                ),
                child: _image == null
                    ? const Center(
                        child: Text("No image selected"),
                      )
                    : Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () async {
                    await _pickImage();  
                  },
                  child: Container(
                    height: 45,
                    width: 180,
                    decoration: BoxDecoration(
                      color:Pallete.whiteColor,
                      border: Border.all(
                        color: Pallete.blackColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Upload your photo",
                        style: TextStyle(
                          color: Pallete.blackColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderedIconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Usergender()));
                    },
                   borderColor:Pallete.blackColor,
                      backgroundColor:Pallete.borderColor,
                    size: 50,
                  ),
                  InkWell(
                     onTap: () async {
                  
                    if (_image != null) {
                      try {
                        await profileProvider.updateProfile(
                            newImagePath: _image!.path);
                        print(
                            'Updated profile image path: ${profileProvider.profile!.imagePath}');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Interestarea()),
                        );
                      } catch (e) {
                        print('Error updating profile: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to update image')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No image selected')),
                      );
                    }
                  },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 25, 25),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
