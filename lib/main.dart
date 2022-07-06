import 'package:cabavenue/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:cabavenue/pages/home.dart';
import 'package:cabavenue/pages/auth.dart';
import 'package:cabavenue/pages/profile_edit.dart';
import 'package:cabavenue/pages/ride_history.dart';
import 'package:cabavenue/pages/emergency.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/ride-history': (context) => const RideHistory(),
        '/profile-edit': (context) => const EditProfilePage(),
        '/emergency': (context) => const EmergencyPage(),
        '/auth': (context) => const AuthPage(),
      },
      // home: const MyHomePage(),
    );
  }
}
