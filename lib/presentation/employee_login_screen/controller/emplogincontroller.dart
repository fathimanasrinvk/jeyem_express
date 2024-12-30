import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/employee_login_screen/service/emp_login_screen_service.dart';
import '../../lr_search_screen/view/lr_search_screen.dart';

class LoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(String email, String password, BuildContext context) async {
    log("loginController -> onLogin() started");


    // Check if email or password are empty
    if (email.isEmpty || password.isEmpty) {
      AppUtils.oneTimeSnackBar(
        "Username and Password are required",
        textStyle: GLTextStyles.snackbartxt(color: ColorTheme.lightcolor),
        context: context,
        bgColor: ColorTheme.black,
      );
      return; // Exit the function if either field is empty
    }

    LoginService.postLoginData(email, password).then((value) async {
      log("postLoginData() -> ${value["status"]}");
      if (value != null && value["status"] == 200) {
        log("token -> ${value["token"]} ");
        await storeLoginData(value);
        await storeUserToken(value["token"]);
        await storeUsername(value["user"]); // Store the username

        // Navigate
        AppUtils.oneTimeSnackBar("Logged In Successfully",
            context: context, bgColor: ColorTheme.lightcolor);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LrSearchScreen()),
            (route) => false);
      } else {
        AppUtils.showFlushbar(
          context: context,
          message: "Incorrect Password or Username",
          icon: Icons.cancel,
          iconColor: ColorTheme.red,
        );
      }
    });
  }

  void onPressed() {
    visibility = !visibility;
    notifyListeners();
  }

  Future<void> storeLoginData(loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    await sharedPreferences.setString(AppConfig.loginData, storeData);
    await sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  Future<void> storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    await sharedPreferences.setString(AppConfig.token, dataUser);
  }

  Future<void> storeUsername(String username) async {
    log("storeUsername");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConfig.username, username); // Store username
  }
}
