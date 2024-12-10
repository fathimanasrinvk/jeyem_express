import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../bottom_navigation_screen/view/bottom_nav_screen.dart';
import '../order_tracking_screen/view/track_order_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToTrackOrder();
  }

  void navigateToTrackOrder() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
