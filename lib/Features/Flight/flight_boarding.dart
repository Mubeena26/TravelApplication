import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/hotel/hotel_boarding_screen.dart';

class FlightBoarding extends StatefulWidget {
  const FlightBoarding({super.key});

  @override
  State<FlightBoarding> createState() => _FlightBoardingState();
}

class _FlightBoardingState extends State<FlightBoarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 139, 216, 249),
              Color.fromARGB(255, 112, 197, 233),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.5,
              0.8,
              1
            ], // Control the points of the gradient transition
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let’s',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Color.fromARGB(255, 66, 88, 132),
                ),
              ),
              const Text(
                'Explore',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 48,
                  color: Color.fromARGB(255, 66, 88, 132),
                ),
              ),
              const Text(
                'The World',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Color.fromARGB(255, 66, 88, 132),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Journey beyond borders with our range of flight choices, ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: Color.fromARGB(255, 66, 88, 132),
                ),
              ),
              const Text(
                'offering you the freedom to explore the world like never before.',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: Color.fromARGB(255, 66, 88, 132),
                ),
              ),
              const SizedBox(height: 50),
              // Container with gradient background for button
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 41, 182, 246), // Start color
                      Color.fromARGB(255, 0, 122, 255), // End color
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            HotelBoarding(), // Replace with your home screen widget
                      ),
                    );
                    // Add login functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Make button background transparent
                    shadowColor: Colors.transparent, // No shadow
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child:
                        child, // Place the child here to ensure it's animated correctly
                  );
                },
                child: Image.asset(
                  'assets/10476-[Converted] 2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
