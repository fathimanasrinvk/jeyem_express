import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_config.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class AppUtils {
  static Future<String?> getToken() async {
    log("AppUtils -> getToken()");
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get(AppConfig.token) != null) {
      final access =
      jsonDecode(sharedPreferences.get(AppConfig.token) as String);
      log("Token -> $access");
      return access;
    } else {
      return null;
    }
  }
  static oneTimeSnackBar(
      String? message, {
        int time = 2,
        Color? bgColor,
        TextStyle? textStyle,
        required BuildContext context,
        bool showOnTop = false,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
    // ScaffoldMessenger.of(context??Routes.router.routerDelegate.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        /*action:SnackBarAction(label: "Ok",
        onPressed: (){
          SystemSettings.internalStorage();
        },
        ) ,*/

        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.white60,
        content: Text(message!,
            style:
            textStyle ?? GLTextStyles.cabinStyle(color: ColorTheme.white)),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .size
                .height - 100,
            right: 20,
            left: 20)
            : null,
      ),
    );
  }
}