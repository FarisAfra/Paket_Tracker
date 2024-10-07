import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/cek_ongkir.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class ErrorNodataScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String IconButton;
  final String TextButton;
  final VoidCallback handler;

  const ErrorNodataScreen({
    required this.title,
    required this.desc,
    required this.IconButton,
    required this.TextButton,
    required this.handler,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/error_state.png', width: 175,),
          AppSpacer.VerticalSpacerSmall,
          Text(title,
          textAlign: TextAlign.center,
              style:
                  AppFonts.poppinsBold(fontSize: 16)),
          
          Text(
              desc,
              textAlign: TextAlign.center,
              style: AppFonts.poppinsRegular(
                  fontSize: 12, color: AppColors.AbuMuda)),
          AppSpacer.VerticalSpacerMedium,
          // PrimaryButton(
          //   Icons: IconButton,
          //   HintText: TextButton,
          //   bgColor: AppColors.BiruPrimary, 
          //   handler: handler,
          // )
        ],
      ),
    ));
  }
}
