
import 'package:flutter/material.dart';
import 'package:leezon/hive/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  Profile? get profile => _profile;

   void loadProfile(Profile profile) {
    _profile = profile;
    print("Profile loaded: ${_profile?.name}"); // Debug print
    notifyListeners();
  }

  Future<void> updateProfile({
  String? newName,
  String? newEmail,
  String? newPassword,
  String? newGender,
  String? newImagePath,
  List<String>? newInterestedAreas,
}) async {
  if (_profile == null) {
    throw Exception('Profile is not loaded. Please load a profile before updating.');
  }
  
  _profile!.updateProfile(
    newName: newName,
    newEmail: newEmail,
    newPassword: newPassword,
    newGender: newGender,
    newImagePath: newImagePath,
    newInterestedAreas: newInterestedAreas,
  );
  await _profile!.save();
  notifyListeners();
}
}