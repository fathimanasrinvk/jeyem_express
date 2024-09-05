import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/employee_login_screeen/controller/emp_login_controller.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/controller/details_controller.dart';
import 'package:jeyem_express_cargo/presentation/party_login_screen/controller/party_login_controller.dart';
import 'package:jeyem_express_cargo/presentation/party_view_screen/controller/partY_view_controller.dart';
import 'package:jeyem_express_cargo/presentation/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => PartyLoginController(),
    ),   ChangeNotifierProvider(
      create: (context) => PartyViewController(),
    ),
    ChangeNotifierProvider(create: (_) => DetailsController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
