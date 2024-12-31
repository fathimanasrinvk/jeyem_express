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

  static search({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 30,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static date({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 30,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
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

  static mainColorTitle1({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 24,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static cabinStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.rakkas(
      fontSize: size ?? 20,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static snackbartxt({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.rakkas(
      fontSize: size ?? 16,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static cancel({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 20,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static selectionbuttontext({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.rakkas(
      fontSize: size ?? 20,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static SubTitle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 23,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static textformfieldhint({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 13,
      fontWeight: weight ?? FontWeight.normal,
      color: color ?? ColorTheme.black,
    );
  }

  static textformfieldhint1({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 13,
      fontWeight: weight ?? FontWeight.normal,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static poppins({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 15,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static poppins4({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 15,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static poppins1({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static logout({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.rakkas(
      fontSize: size ?? 16,
      fontWeight: weight ?? FontWeight.normal,
      color: color ?? ColorTheme.maincolor,
    );
  }

  static username({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static poppins3({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 24,
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
