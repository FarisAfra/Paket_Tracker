import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';

class AppFonts {
  static TextStyle poppinsThin({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsExtraLight({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsLight({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsRegular({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsMedium({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsSemiBold({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsBold({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsExtraBold({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static TextStyle poppinsBlack({double fontSize = 12, Color color = AppColors.Hitam}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}