import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class CustomIconTextButton extends StatelessWidget {
  final String icons;
  final double radius;
  final VoidCallback handler; 
  final String text;

  const CustomIconTextButton({
    required this.icons,
    required this.text,
    required this.handler,
    this.radius =100,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          icons: icons,
          radius: radius,
          handler: handler,
        ),
        AppSpacer.VerticalSpacerExtraSmall,
        Text(
          text,
          style: AppFonts.poppinsRegular(fontSize: 10),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
