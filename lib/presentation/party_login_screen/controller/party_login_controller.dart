import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/party_login_screen/service/party_login_service.dart';
import '../../party_view_screen/view/party_view_screen.dart';

class PartyLoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(String email, String password, BuildContext context) async {
    log("PartyLoginController -> onLogin() started");

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

    PartyLoginService.postLoginData(email, password).then((value) async {
      log("postLoginData() -> ${value["status"]}");
      if (value != null && value["status"] == 200) {
        log("token -> ${value["token"]} ");
        await storeLoginData(value);
        await storeUserToken(value["token"]);
        storePrtyusername(value["user"]); // Store the username

        // Extract digits from username
        String username = email; // Assuming email is the username
        final digits = RegExp(r'\d+')
            .allMatches(username)
            .map((match) => match.group(0))
            .join();

        // Store digits in SharedPreferences
        await storeDigits(digits);

        // Navigate to PartyViewScreen with stored digits
        AppUtils.oneTimeSnackBar("Logged In Successfully",
            context: context, bgColor: ColorTheme.lightcolor);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => PartyViewScreen(digits: digits)),
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
    await sharedPreferences.setBool(AppConfig.ptyloggedIn, true);
  }

  Future<void> storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    await sharedPreferences.setString(AppConfig.token, dataUser);
  }

  void storePrtyusername(String prtyusername) async {
    log("storePrtyusername");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        AppConfig.prtyusername, prtyusername); // Store username
  }

  // New method to store extracted digits
  Future<void> storeDigits(String digits) async {
    log("storeDigits -> $digits");
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(AppConfig.partyDigits, digits);
  }
}
