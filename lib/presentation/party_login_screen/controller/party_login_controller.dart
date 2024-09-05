import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/view/lr_search_screeen.dart';
import 'package:jeyem_express_cargo/repository/api/party_login_screen/prty_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../party_view_screen/view/party_view_screen.dart';

class PartyLoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(String email, String password, BuildContext context) async {
    log("PartyLoginController -> onLogin() started");
    PartyLoginService.postLoginData(email, password).then((value) {
      log("postLoginData() -> ${value["status"]}");
      if (value["status"] == 200) {
        log("token -> ${value["token"]} ");
        storeLoginData(value);
        storeUserToken(value["token"]);

        // Extract digits from username
        String username = email; // Assuming email is the username
        final digits = RegExp(r'\d+').allMatches(username).map((match) => match.group(0)).join();

        // Pass digits to PartyViewController
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PartyViewScreen(digits: digits)),
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

  void storeLoginData(loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.ptyloggedIn, true);
  }

  void storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    sharedPreferences.setString(AppConfig.token, dataUser);
  }
}
