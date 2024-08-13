import 'package:hive_flutter/hive_flutter.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 0)
class Profile extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String password;

  @HiveField(3)
  late String gender;

  @HiveField(4)
  late String imagePath;

  @HiveField(5)
  late List<String> interestedAreas;

  Profile({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.imagePath,
    required this.interestedAreas,
  });

  // Method to update each field
  void updateProfile({
    String? newName,
    String? newEmail,
    String? newPassword,
    String? newGender,
    String? newImagePath,
    List<String>? newInterestedAreas,
  }) {
    if (newName != null) name = newName;
    if (newEmail != null) email = newEmail;
    if (newPassword != null) password = newPassword;
    if (newGender != null) gender = newGender;
    if (newImagePath != null) imagePath = newImagePath;
    if (newInterestedAreas != null) interestedAreas = newInterestedAreas;

     save();
   
  }
}