import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leezon/hive/profile_model.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/screen/profile/profile.dart';
import 'package:leezon/model/profile_service.dart';
import 'package:leezon/utility/commen_widget/CustomElevatedButton.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _selectedImage;

  final ProfileService _profileService = ProfileService();
  List<Profile> _profile = [];
  late Profile user;

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

 Future<void> _loadProfile() async {
    _profile = await _profileService.getProfile();
    if (_profile.isNotEmpty) {
      user = _profile.first;
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneNumberController.text = user.phonenumber;
      if (user.imagePath != null) {
        _selectedImage = File(user.imagePath);
      }
      setState(() {}); 
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        user.name = _nameController.text;
        user.email = _emailController.text;
        user.phonenumber = _phoneNumberController.text;
        if (_selectedImage != null) {
          user. imagePath = _selectedImage!.path;
        }
      });
      // Save the updated user back to the service or database
      _profileService.updateprofile(0, user);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => NavigationMenu() ),
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25,right: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  // backgroundColor: Color.fromARGB(255, 32, 2, 2),
                  backgroundImage:
                      _selectedImage != null ? FileImage(_selectedImage!) : null,
                  child: Stack(children: [
                    Positioned(
                        left: 25,
                        top: 25,
                        child: _selectedImage == null
                            ? const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 81, 10, 10),
                                size: 70,
                              )
                            : const Icon(null)),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          File? pickedImage =
                              await SelectImageFromGallery(context);
                          setState(() {
                            _selectedImage = pickedImage;
                          });
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Enter your Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  // if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                  //   return 'Name must contain only letters';
                  // }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters long';
                  }
                  return null;
                },
                controller: _nameController,
                cursorColor: const Color.fromARGB(255, 61, 60, 60),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 12, 3, 47),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Enter your Email",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                controller: _emailController,
                cursorColor: const Color.fromARGB(255, 61, 60, 60),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 61, 60, 60),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 12, 3, 47),
                          width: 2,
                        ))),
              ),
              const SizedBox(height: 25),
              const Text(
                "Enter your phone Number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null; // Return null if validation succeeds
                },
                controller: _phoneNumberController,
                cursorColor: const Color.fromARGB(255, 61, 60, 60),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 12, 3, 47),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            CustomElevatedButton(
              onPressed:(){
                     
                      if (_formKey.currentState?.validate() == true) {
                     
                     _saveProfile();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    }
              } ,
              text:"Update" ,)
            ]),
          ),
        ),
      ),
    );
  }
}

Future<File?> SelectImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    __showSnackBar(context, e.toString());
  }
  return image;
}

void __showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
  