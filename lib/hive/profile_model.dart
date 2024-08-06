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
  late String phonenumber;

  @HiveField(4)
  late String imagePath;

  Profile({
    required this.name,
    required this.email,
    required this.password,
    required this.phonenumber,
    this.imagePath = 'assets/img/ajin.jpg',
  });
}
