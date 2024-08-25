import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';

class CustomTextfieldsIcon extends StatelessWidget {
  const CustomTextfieldsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 262,
      height: 36,
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
            padding: EdgeInsets.only(top: 4),
            child: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/ic_package_search_grey.png',
                  fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 14, top: 0),
                  border: InputBorder.none,
                  hintText: 'Masukkan No. Resi',
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
