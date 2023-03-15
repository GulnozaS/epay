import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  Style._();

  //------------------------ MainStyle -----------------------------------------//

  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff09101D);
  static const primaryBlue = Color(0xff5163BF);
  static const transparentColor = Colors.transparent;
  static const greyColor = Color(0xff878787);

  //----------------------- TextStyle ------------------------------------------//

  static textStyleThin({
    double size = 18,
    Color textColor = greyColor,
  }) {
    return GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w500, color: textColor, fontSize: size);
  }

  static textStyleRegular({
    double size = 20,
    Color textColor = blackColor,
  }) {
    return GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w600, color: textColor, fontSize: size);
  }

  static textStyleBold({
    double size = 35,
    Color textColor = primaryBlue,
  }) {
    return GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w700, color: textColor, fontSize: size);
  }
}
