import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/login_screeen/view/login_screen.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/view/lr_search_screeen.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/view/lr_details_screen.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/view/order_details_screen.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/view/track_order_screen.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import 'package:jeyem_express_cargo/presentation/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
      // home: TrackOrderScreen(),
      // home:  LoginScreen(),
      // home:  LrSearchScreen(),
      // home:  LrSearchScreen(),
    );
  }
}
