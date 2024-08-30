import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class CustomOutlineButton extends StatelessWidget {
  final double borderRadius;
  final double PaddingY;
  final double sizeIcons;
  final double width;
  final String Icons;
  final String HintText;
  final double fontSize;
  final Color bgColor;
  final Color OutlineColor;
  final VoidCallback handler;

  const CustomOutlineButton({
    this.borderRadius = 8,
    this.PaddingY = 6,
    this.sizeIcons = 20,
    this.fontSize = 12,
    this.width = 270,
    this.bgColor = AppColors.BgPutih,
    required this.OutlineColor,
    required this.Icons,
    required this.HintText,
    required this.handler,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handler,
      child: Container(
          width: width,
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: OutlineColor),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: PaddingY),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Icons,
                  height: sizeIcons,
                ),
                AppSpacer.HorizontalSpacerSmall,
                Text(
                  HintText,
                  style: AppFonts.poppinsRegular(color: OutlineColor, fontSize: fontSize),
                )
              ],
            ),
          )),
    );
  }
}
