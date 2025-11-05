// lib/main.dart
//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/splash_screen/splash_screen.dart';
import 'firebase_options.dart'; // ✅ Required for DefaultFirebaseOptions

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Proper Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class DefaultFirebaseOptions {
  static FirebaseOptions? get currentPlatform => null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: darkFontGrey),
          backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
