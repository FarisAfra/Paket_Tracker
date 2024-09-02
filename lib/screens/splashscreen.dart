import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BiruPrimary,
      body: Center(
        child: Image.asset(
          'assets/images/SplashScreen.gif',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
