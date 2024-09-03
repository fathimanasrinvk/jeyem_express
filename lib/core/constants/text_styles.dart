import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class GLTextStyles {
  static robotoStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 30,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static mainTittle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 26,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static mainColorTitle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 26,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static cabinStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.cabin(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static SubTitle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 23,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static poppins({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 15,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static poppins1({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static poppins3({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.green,
    );
  }

  static poppins2({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 16,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }
}
