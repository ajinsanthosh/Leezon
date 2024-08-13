import 'package:flutter/material.dart';
import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/screen/Auth/usergender.dart';
import 'package:leezon/screen/Auth/username.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class Useremailid extends StatefulWidget {
  const Useremailid({super.key});

  @override
  _UseremailidState createState() => _UseremailidState();
}

class _UseremailidState extends State<Useremailid> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
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
                    Icons.email,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "What's your email ID?",
                  style: TextStyle(
                      color:Pallete.blackColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Pallete.greycolor,
                      fontSize: 17,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Pallete.blackColor, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Pallete.greycolor, width: 1.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Pallete.redcolor, width: 2.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Pallete.redcolor, width: 2.0),
                    ),
                    errorStyle: TextStyle(color: Pallete.redcolor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                                builder: (context) => const Username()));
                      },
                      borderColor:Pallete.blackColor,
                      backgroundColor:Pallete.borderColor,
                      size: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          String email = _emailController.text;

                          try {
                            await profileProvider.updateProfile(
                                newEmail: email);
                            print(
                                'Updated profile email: ${profileProvider.profile!.email}');

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Name updated successfully')),
                            // );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Usergender()),
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
                          color:Pallete.blackColor,
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
      ),
    );
  }
}
