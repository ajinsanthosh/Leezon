import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leezon/firebase_options.dart';
import 'package:leezon/hive/conversation.dart';
import 'package:leezon/hive/profile_model.dart';
import 'package:leezon/hive/image_data.dart'; // Import ImageData
import 'package:leezon/provider/ImageProvider.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:leezon/provider/chat_provider.dart';
import 'package:leezon/provider/voice_provider.dart';
import 'package:leezon/screen/splashScreen/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  _registerHiveAdapters();

  // Initialize Providers' Hive
  await ChatProvider.initHive();

  // Open Hive box for images
  await Hive.openBox<ImageData>('images');

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ChatProvider()),
      ChangeNotifierProvider(create: (context) => VoiceChatProvider()),
      ChangeNotifierProvider(create: (_) => ImageGenerationProvider()),
    ],
    child: const MyApp(),
  ));
}

void _registerHiveAdapters() {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ProfileAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    // Adjust typeId as needed
    Hive.registerAdapter(ConversationAdapter());
  }
  if (!Hive.isAdapterRegistered(4)) {
    // Register ImageData adapter
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
      home: const Splashscreen(), // Set the initial screen here
    );
  }
}
