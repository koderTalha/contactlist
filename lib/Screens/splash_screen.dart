import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        "assets/images/logo.png",
      ),
      title: const Text(
        "Contact List App",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      loaderColor: Colors.red,
      showLoader: true,
      durationInSeconds: 5,
      navigator: const HomeScreen(),
    );
  }
}
