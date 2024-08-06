import 'package:hive_flutter/adapters.dart';
import 'package:leezon/hive/profile_model.dart';


class ProfileService {
  Box<Profile>? _profileBox;

  Future<void> openBox() async {
    _profileBox = await Hive.openBox<Profile>('profiles');
  }

  Future<void> closeBox() async {
    await _profileBox!.close();
  }

  //add  data

  Future<void> addProfile(Profile profile) async {
    if (_profileBox == null) {
      await openBox();
    }
    await _profileBox!.add(profile);
  }

// get all data

  Future<List<Profile>> getProfile() async {
    if (_profileBox == null) {
      await openBox();
    }
    return _profileBox!.values.toList();
  }

  Future<void> updateprofile(int index, Profile profile) async {
    if (_profileBox == null) {
      await openBox();
    }
    await _profileBox!.putAt(index, profile);
  }

//delete

  Future<void> deleteprofile(int index) async {
    if (_profileBox == null) {
      await openBox();
    }
    await _profileBox!.clear();
  }
}
