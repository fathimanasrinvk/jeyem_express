import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/order_tracking_screen/controller/details_controller.dart';
import 'package:jeyem_express_cargo/presentation/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [

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
