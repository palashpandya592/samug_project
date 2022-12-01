import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samug_project/constant/app_colors.dart';

class AppStyle {
  static TextStyle poppins400(
          {FontWeight? fontWeight, Color? color, double? size}) =>
      GoogleFonts.poppins(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: size ?? 10,
        color: color ?? AppColors.black,
      );
}
