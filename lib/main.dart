import 'package:flutter/material.dart';
import 'package:travelapp_project/screens/hotel_boarding_screen.dart';
import 'package:travelapp_project/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/HotelBoarding': (context) => const HotelBoarding(),
      },
    );
  }
}
