import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
            color: AppColors.BiruSecondary,
            height: 36,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Image.asset('assets/icons/ic_edit_blue.png'),
            )),
      ),
    );
  }
}
