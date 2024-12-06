import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Authentication/firebase_options.dart';
import 'package:travelapp_project/Features/Flight/bloc/flight_bloc.dart';
import 'package:travelapp_project/Features/hotel/bloc/bloc/hotel_bloc.dart';
import 'package:travelapp_project/Features/screens/splash_screen.dart';
// Adjust the import as per your file structure.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HotelBloc(),
        ),
        BlocProvider(
          create: (context) => FlightBloc(),
        )
        // Add more providers if needed in the future
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Navigation Flow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Start with Splash Screen
    );
  }
}
