import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/initial_name.dart';
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

    _navigateToNextScreen(); // Start the check process
  }

  // Function to check user data in the database
  Future<void> _navigateToNextScreen() async {
    bool hasUserData = await DBHelper().hasUserData(); // Check for user data

    // Wait for the splash screen to display for a short time
    Timer(const Duration(milliseconds: 3000), () {
      // Navigate based on the result of the check
      if (hasUserData) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const InitialName()),
        );
      }
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
