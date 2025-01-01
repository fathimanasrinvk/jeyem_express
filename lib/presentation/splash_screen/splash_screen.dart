import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/party_view_screen/view/party_view_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import '../../app_config/app_config.dart';
import '../../core/constants/colors.dart';
import '../lr_search_screen/view/lr_search_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final bool isLoggedIn =
        sharedPreferences.getBool(AppConfig.loggedIn) ?? false;
    final bool isPartyLoggedIn =
        sharedPreferences.getBool(AppConfig.ptyloggedIn) ?? false;
    final String storedDigits =
        sharedPreferences.getString(AppConfig.partyDigits) ?? '';

    Timer(Duration(seconds: 3), () {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LrSearchScreen()));
      } else if (isPartyLoggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PartyViewScreen(digits: storedDigits)));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SelectionScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorTheme.white,
      body: Center(
        child: Image.asset(
          "assets/logo/jeyem_logo-removebg-preview.png",
          height: size.height * .35,
          width: size.width * .6,
        ),
      ),
    );
  }
}
