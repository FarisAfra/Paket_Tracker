import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoSizeAnimation;
  late bool _showLogo1;

  @override
  void initState() {
    super.initState();
    _showLogo1 = true;

    _animationController = AnimationController(
      duration: const Duration(seconds: 3), // Total duration is 3 seconds for one logo
      vsync: this,
    );

    _logoSizeAnimation = Tween<double>(begin: 0, end: 157).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.166, curve: Curves.easeIn), // 0 to 0.5 seconds
        reverseCurve: const Interval(0.833, 1.0, curve: Curves.easeOut), // 2.5 to 3 seconds
      ),
    )..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          if (_showLogo1) {
            setState(() {
              _showLogo1 = false;
            });
            _animationController.forward();
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          }
        }
      });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BiruPrimary,
      body: Center(
        child: Image.asset(
          _showLogo1 ? 'assets/images/logo_app_1.png' : 'assets/images/logo_app_2.png',
          height: _logoSizeAnimation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
