import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waytoturf/dependency_injection.dart';
import 'package:waytoturf/Screens/onboarding.dart';
import 'package:waytoturf/firebase_options.dart';

// size 
//
late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
 await setup();
  runApp(splashScreen());
  await Future.delayed(
    Duration(seconds: 4),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}

class splashScreen extends StatelessWidget {
  splashScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white, // Set the background color to white
        body: Center(
          child:
              Image.asset("assets/splash.png"), // Replace with your image asset
        ),
      ),
    );
  }
}
