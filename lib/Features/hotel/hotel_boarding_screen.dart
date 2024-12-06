import 'package:flutter/material.dart';

import 'package:travelapp_project/Features/Authentication/login_screen.dart';

class HotelBoarding extends StatefulWidget {
  const HotelBoarding({super.key});

  @override
  State<HotelBoarding> createState() => _HotelBoardingState();
}

class _HotelBoardingState extends State<HotelBoarding>
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hassle-Free Hotel',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const Text(
              'Searching',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const SizedBox(height: 70),
            const Text(
              'Search and compare thousands of hotels to',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const Text(
              'find the best deal for your stay',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const SizedBox(height: 70),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 139, 216, 249),
                    Color.fromARGB(255, 84, 149, 255),
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
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
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
            const SizedBox(height: 110),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/Friends vacation_ Men woman with 1.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
