import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  Style._();

  //------------------------ BottomNavigationBar style -------------------------//

  static const selectedGradientBottomNav =
  LinearGradient(colors: [Color(0xff6499FF), Color(0xff2972FE)]);
  static const unselectedGradientBottomNav =
  LinearGradient(colors: [Color(0x102972FE), Color(0x102972FE)]);
  static const unselectedBottomIcon = Color(0xff2972FE);
  static const borderBottomNav = Color(0xffEBEEF2);

  //------------------------ MainStyle -----------------------------------------//

  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff09101D);
  static const primaryBlue = Color(0xff5163BF);
  static const transparentColor = Colors.transparent;
  static const greyColor = Color(0xff878787);
  static const redAccentColor = Colors.redAccent;
  static const redColor = Colors.red;


  //----------------------- CardStyle ------------------------------------------//

  static const blueColor = Color(0xff5366BE);
  static const lightBlueColor = Color(0xff8EDFEB);
  static const yellowColor = Color(0xffF59D31);

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
