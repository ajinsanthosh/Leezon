import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:leezon/firebase_options.dart';
import 'package:leezon/model/profile_model.dart';
import 'package:leezon/pallete.dart';
import 'package:leezon/screen/splashScreen/splashScreen.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileAdapter());
  // await ProfileService().openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor
        ),
      ),
      home: const Splashscreen(),
    );
  }
}