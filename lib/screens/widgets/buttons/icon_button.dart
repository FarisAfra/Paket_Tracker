import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';

class CustomIconButton extends StatelessWidget {
  final double size;
  final double padding;
  final double radius;
  final Color bgColor;
  final String icons;
  final VoidCallback handler; 

  const CustomIconButton({
    this.size = 36,
    this.radius = 10,
    this.padding = 6,
    this.bgColor = AppColors.BiruSecondary,
    required this.icons,
    required this.handler,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handler,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
            color: bgColor,
            height: size,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Image.asset(icons),
            )),
      ),
    );
  }
}
