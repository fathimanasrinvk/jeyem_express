import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/view/lr_search_screeen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../repository/api/employee_login_screen/service/emp_login_screen_service.dart';

class LoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(String email, String password, BuildContext context) async {
    log("loginController -> onLogin() started");
    LoginService.postLoginData(email, password).then((value) {
      log("postLoginData() -> ${value["status"]}");
      if (value["status"] == 200) {
        log("token -> ${value["token"]} ");
        storeLoginData(value);
        storeUserToken(value["token"]);
        storeUsername(value["user"]); // Store the username
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LrSearchScreen()),
                (route) => false);
      } else {
        log("Else Condition >> Api failed");
      }
    });
  }

  void onPressed() {
    visibility = !visibility;
    notifyListeners();
  }

  void storeLoginData(Map<String, dynamic> loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  void storeUserToken(String token) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConfig.token, token);
  }

  void storeUsername(String username) async {
    log("storeUsername");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConfig.username, username); // Store username
  }
}
