import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';

class CustomNavButton extends StatelessWidget {
  final String icons;
  final double height;
  final VoidCallback handler;

  const CustomNavButton({
    this.height = 52,
    required this.icons,
    required this.handler,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: IconButton(
        onPressed: handler, 
        icon: Image.asset(icons)),
    );
  }
}