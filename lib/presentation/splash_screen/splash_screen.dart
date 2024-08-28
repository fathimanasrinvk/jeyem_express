import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/login_screeen/view/login_screen.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SelectionScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorTheme.black.withOpacity(0.8),
      body: Center(
        child: Image.asset(
          "assets/logo/jeyem_logo-removebg-preview.png",
          height: size.height *.35,
          width: size.width * .6,
        ),
      ),
    );
  }
}
