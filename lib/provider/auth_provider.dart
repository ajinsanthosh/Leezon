
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leezon/screen/Auth/otpscreen.dart';
import 'package:leezon/utility/commen_widget/showsnackbar.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential PhoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(PhoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResedingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Otpscreen(
                  verificationId: verificationId,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // void verifyOtp({
  //   required BuildContext context,
  //   required String verificationId,
  //   required String userOtp,
    
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     PhoneAuthCredential creds = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: userOtp);
  //     await _firebaseAuth.signInWithCredential(creds);
     
  //     _isLoading=false;
  //     notifyListeners();
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message.toString());
  //      _isLoading=false;
  //     notifyListeners();
  //   }
  // }
}