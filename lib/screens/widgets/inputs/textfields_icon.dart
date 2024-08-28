import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';

class CustomTextfieldsIcon extends StatelessWidget {
  final double width;
  final double height;
  final String icons;
  final double sizeicons;
  final String hintText;
  final TextEditingController controller;


  const CustomTextfieldsIcon({
    this.width = 262,
    this.height = 36,
    this.sizeicons = 24,
    required this.icons,
    required this.hintText,
    required this.controller,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.Putih,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: SizedBox(
              width: sizeicons,
              height: sizeicons,
              child: Image.asset(icons,
                  fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 14, top: 0),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: AppFonts.poppinsRegular(
                      fontSize: 12, color: AppColors.AbuMuda)),
              style:
                  AppFonts.poppinsRegular(fontSize: 12, color: AppColors.Hitam),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
