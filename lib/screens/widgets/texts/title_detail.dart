import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';

class TitleDetail extends StatelessWidget {
  final VoidCallback handler;
  final String textTitle;
  final String textDetail;

  const TitleDetail({
    super.key,
    required this.textTitle,
    required this.textDetail,
    required this.handler,
    });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(textTitle,
            style: AppFonts.poppinsSemiBold(fontSize: 14)),
        Spacer(),
        Row(
          children: [
            TextButton(
              onPressed: handler,
              child: Text(textDetail,
                  style: AppFonts.poppinsLight(fontSize: 12, color: AppColors.BiruPrimary)),
            ),
            InkWell(
              child: Image.asset(
                AppIcons.IcMoreBlue,
                height: 9,
              ),
              onTap: handler,
            ),
          ],
        )
      ],
    );
  }
}