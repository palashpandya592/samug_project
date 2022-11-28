import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samug_project/constant/app_colors.dart';
import 'package:samug_project/constant/app_images.dart';
import 'package:samug_project/utills/widget/space_divider.dart';

Widget imageWithText({String? text}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Column(
      children: [
        Image.asset(AppImages.doller, width: 20, height: 20),
        Text(text!,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: AppColors.purple)),
      ],
    ),
  );
}

List<Widget> slideShow(String prefix, List<String> images) {
  return List.generate(
      images.length ?? 0,
      (index) => Container(
            height: 288,
            child: Image.network('$prefix${images[index]}'),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('$prefix${images[index]}'),
                    fit: BoxFit.fill)),
          ));
}

Widget commentContainer(
    {String? image, Color? background, String? text, Color? textColor}) {
  return Container(
    height: 26,
    width: 70,
    decoration: BoxDecoration(
        color: background, borderRadius: BorderRadius.circular(35)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image!, width: 20, height: 20),
        horizontalSpace(width: 5),
        Text(text!,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.8,
                color: textColor ?? AppColors.white)),
      ],
    ),
  );
}

Widget profileListCommon({String? image, String? text, Color? color}) {
  return Column(
    children: [
      Container(
        height: 90,
        width: 70,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                  image!,
                ),
                fit: BoxFit.fill)),
      ),
      verticalSpace(height: 5),
      Text(
        text!,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400, fontSize: 10, color: AppColors.purple),
      )
    ],
  );
}
