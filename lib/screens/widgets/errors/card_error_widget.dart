import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class CardErrorWidget extends StatelessWidget {
  final double PaddingX;
  final double PaddingY;
  final double SizeIcons;
  final String TextTitle;
  final String TextDesc;

  const CardErrorWidget({
    this.PaddingX = 20,
    this.PaddingY = 16,
    this.SizeIcons = 62,
    required this.TextTitle,
    required this.TextDesc,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.Putih,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: PaddingY, horizontal: PaddingX),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error_state.png',
              height: SizeIcons,
            ),
            AppSpacer.HorizontalSpacerMedium,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TextTitle,
                    style: AppFonts.poppinsBold(),
                  ),
                  Text(
                    TextDesc,
                    style: AppFonts.poppinsLight(fontSize: 10),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
