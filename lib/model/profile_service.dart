
// import 'package:hive_flutter/adapters.dart';
// import 'package:leezon/hive/profile_model.dart';

// class ProfileService {
//   Box<Profile>? _profileBox;

//   Future<void> openBox() async {
//     if (_profileBox == null) {
//       try {
//         _profileBox = await Hive.openBox<Profile>('profiles');
//       } catch (e) {
//         // Handle error (e.g., log it)
//         print('Error opening box: $e');
//       }
//     }
//   }

//   Future<void> closeBox() async {
//     if (_profileBox != null) {
//       try {
//         await _profileBox!.close();
//         _profileBox = null; // Ensure the box is marked as closed
//       } catch (e) {
//         // Handle error (e.g., log it)
//         print('Error closing box: $e');
//       }
//     }
//   }




//   // Add data
//   Future<void> addProfile(Profile profile) async {
//     if (_profileBox == null) {
//       await openBox();
//     }
//     try {
//       await _profileBox!.add(profile);
//     } catch (e) {
//       // Handle error (e.g., log it)
//       print('Error adding profile: $e');
//     }
//   }

//   // Get all data
//   Future<List<Profile>> getProfile() async {
//     if (_profileBox == null) {
//       await openBox();
//     }
//     return _profileBox!.values.toList();
//   }

//   // Update profile
//   Future<void> updateProfile(int index, Profile profile) async {
//     if (_profileBox == null) {
//       await openBox();
//     }
//     try {
//       await _profileBox!.putAt(index, profile);
//     } catch (e) {
//       // Handle error (e.g., log it)
//       print('Error updating profile: $e');
//     }
//   }

//   // Delete profile
//   Future<void> deleteProfile(int index) async {
//     if (_profileBox == null) {
//       await openBox();
//     }
//     try {
//       await _profileBox!.deleteAt(index);
//     } catch (e) {
//       // Handle error (e.g., log it)
//       print('Error deleting profile: $e');
//     }
//   }

  
// }
