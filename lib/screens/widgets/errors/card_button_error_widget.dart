import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class CardButtonErrorWidget extends StatelessWidget {
  final double PaddingX;
  final double PaddingY;
  final double SizeIcons;
  final String TextTitle;
  final String TextDesc;
  final String Icons;
  final String HintText;

  const CardButtonErrorWidget(
      {this.PaddingX = 20,
      this.PaddingY = 16,
      this.SizeIcons = 62,
      required this.TextTitle,
      required this.TextDesc,
      required this.Icons,
      required this.HintText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        color: AppColors.Putih,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: PaddingY, horizontal: PaddingX),
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
                  children: [
                    Text(
                      TextTitle,
                      style: AppFonts.poppinsBold(),
                    ),
                    Text(
                      TextDesc,
                      style: AppFonts.poppinsLight(fontSize: 10),
                    ),
                    AppSpacer.VerticalSpacerExtraSmall,
                    PrimaryButton(
                      Icons: Icons,
                      HintText: HintText,
                      sizeIcons: 16,
                      fontSize: 10,
                      borderRadius: 5,
                      width: 180,
                      PaddingY: 5,
                      handler: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
