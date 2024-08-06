// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leezon/screen/login/forgotpassword.dart';
import 'package:leezon/screen/login/loginScreen.dart';
import 'package:leezon/screen/profile/resetpassword.dart';

class PhonenumberOtp extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  PhonenumberOtp({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<PhonenumberOtp> createState() => _PhonenumberOtpState();
}

class _PhonenumberOtpState extends State<PhonenumberOtp> {
  final otpController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

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
              MaterialPageRoute(builder: (context) => const Loginscreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text("Verify",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold))),
                Center(
                  child: Container(
                    height: 260,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/resetpassword.jpg"))),
                  ),
                ),
                const Center(
                  child: Text(
                    "Enter OTP",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    "A 6 digit OTP has been sent to",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    widget.phoneNumber,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Enter your OTP",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: otpController,
                  cursorColor: const Color.fromARGB(255, 61, 60, 60),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: errorMessage.isEmpty ? null : errorMessage,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 61, 60, 60),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 12, 3, 47),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                        errorMessage = '';
                      });

                      try {
                        final cred = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: otpController.text.trim());

                        await FirebaseAuth.instance.signInWithCredential(cred);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Forgotpasswordpage(),
                          ),
                        );
                      } catch (e) {
                        log(e.toString());
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
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          )
                        : const Text(
                            "Verify",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
