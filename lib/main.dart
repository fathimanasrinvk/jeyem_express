import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/login_screeen/controller/login_controller.dart';
import 'package:jeyem_express_cargo/presentation/login_screeen/view/login_screen.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/view/lr_search_screeen.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/view/lr_details_screen.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/view/order_details_screen.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/view/track_order_screen.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import 'package:jeyem_express_cargo/presentation/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => LoginController(),)
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:  SplashScreen(),
      // home: TrackOrderScreen(),
      home:  LrSearchScreen(),
      // home:  LrSearchScreen(),
      // home:  LrSearchScreen(),
    );
  }
}
