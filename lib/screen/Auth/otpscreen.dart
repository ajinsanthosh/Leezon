import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/screen/Auth/phonenumber_auth.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otpscreen extends StatefulWidget {
  final String verificationId;

  const Otpscreen({super.key, required this.verificationId});

  @override
  _OtpscreenState createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  String? otpCode;
  bool isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 10, left: 20, bottom: 10),
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
                "Enter your verification code",
                style: TextStyle(
                  color:  Pallete.blackColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color.fromARGB(31, 50, 50, 50)),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });print("OTP:::$otpCode");
                },
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhonenumberAuth(),
                          ),
                        );
                      },
                      child: const Text(
                        "DID'T GET A CODE? RESEND?",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        print(otpCode);
                        setState(() {
                          isLoading = true;
                          errorMessage = '';
                        });

                        try {
                          // Log the values to debug
                          log('Verification ID: ${widget.verificationId}');
                          log('Entered OTP Code: $otpCode');

                          final cred = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: otpCode!,
                          );

                          await FirebaseAuth.instance
                              .signInWithCredential(cred);

                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', true);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationMenu(),
                            ),
                          );
                        } catch (e) {
                          log('Error during sign-in: $e');
                          setState(() {
                            errorMessage = 'Invalid OTP. Please try again.';
                          });
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>( Pallete.whiteColor,)
                            )
                          : Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 25, 25, 25),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      color:  Pallete.whiteColor,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
