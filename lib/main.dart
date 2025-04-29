import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/add_booking_count_screen/controller/add_booking_count_screen_controller.dart';
import 'package:jeyem_express_cargo/presentation/added_count_view_screen/controller/added_count_view_screen_controller.dart';
import 'package:jeyem_express_cargo/presentation/employee_login_screen/controller/emplogincontroller.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/controller/details_controller.dart';
import 'package:jeyem_express_cargo/presentation/party_login_screen/controller/party_login_controller.dart';
import 'package:jeyem_express_cargo/presentation/party_view_screen/controller/party-view_controller.dart';
import 'package:jeyem_express_cargo/presentation/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => PartyLoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => PartyViewController(),
    ),
    ChangeNotifierProvider(
      create: (_) => DetailsController(),
    ),ChangeNotifierProvider(
      create: (_) => ViewCountsController(),
    ),ChangeNotifierProvider(
      create: (_) => BookingCountProvider(),
    ),

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
