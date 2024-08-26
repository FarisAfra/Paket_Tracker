import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class PrimaryButton extends StatelessWidget {
  final double borderRadius;
  final double PaddingY;
  final double sizeIcons;
  final double width;
  final String Icons;
  final String HintText;
  final double fontSize;

  const PrimaryButton({
    this.borderRadius = 8,
    this.PaddingY = 6,
    this.sizeIcons = 20,
    this.fontSize = 12,
    this.width = 270,
    required this.Icons,
    required this.HintText,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: width,
          decoration: BoxDecoration(
              color: AppColors.BiruPrimary,
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
                  style: AppFonts.poppinsRegular(color: AppColors.Putih, fontSize: fontSize),
                )
              ],
            ),
          )),
    );
  }
}
