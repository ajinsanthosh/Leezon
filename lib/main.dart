
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leezon/firebase_options.dart';
import 'package:leezon/hive/conversation.dart';
import 'package:leezon/hive/profile_model.dart';
import 'package:leezon/hive/image_data.dart';
import 'package:leezon/provider/ImageProvider.dart';
import 'package:leezon/provider/NavigationProvider.dart';
import 'package:leezon/provider/auth_provider.dart';
import 'package:leezon/provider/profileprovider.dart';
import 'package:leezon/provider/thought_provider.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:leezon/provider/chat_provider.dart';
import 'package:leezon/provider/voice_provider.dart';
import 'package:leezon/screen/Auth/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  _registerHiveAdapters();

   await ChatProvider.initHive();

     await Hive.openBox<ImageData>('images');

  await Hive.openBox('imageBox');
  await Hive.openBox('hobbiesBox');
  await Hive.openBox<Profile>('profileBox');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) {
        final profileBox = Hive.box<Profile>('profileBox');
        final profileProvider = ProfileProvider();
        if (profileBox.isNotEmpty) {
          final profile = profileBox.getAt(0);
          if (profile != null) {
            profileProvider.loadProfile(profile);
          }
        } else {
          final newProfile = Profile(
            name: '',
            email: '',
            password: '',
            gender: '',
            imagePath: '',
            interestedAreas: [],
          );
          profileBox.add(newProfile);
          profileProvider.loadProfile(newProfile);
        }
        return profileProvider;
      }),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
      ChangeNotifierProvider(create: (context) => VoiceChatProvider()),
      ChangeNotifierProvider(create: (_) => ImageGenerationProvider()),
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ChangeNotifierProvider(create: (context) => ThoughtProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
    ],
    child: const MyApp(),
  ));
}

void _registerHiveAdapters() {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ProfileAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(ConversationAdapter());
  }
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(ImageDataAdapter());
  }
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
          backgroundColor: Pallete.whiteColor,
        ),
      ),
      home: const Splashscreen(),
    );
  }
}
 