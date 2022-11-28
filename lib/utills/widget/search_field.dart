import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samug_project/constant/app_colors.dart';

Widget searchField({
  double? height,
  String? hintText,
  EdgeInsetsGeometry? contentPadding,
  final ValueChanged<String>? onChanged,
}) {
  return SizedBox(
    height: height ?? 50,
    child: TextField(
      decoration: InputDecoration(
          contentPadding: contentPadding,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.lightGreen)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.lightGreen)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.lightGreen)),
          fillColor: AppColors.lightGreen,
          prefixIcon: const Icon(Icons.search,color: AppColors.black),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.black,
              letterSpacing: -0.3)),
      onChanged: onChanged,
    ),
  );
}
