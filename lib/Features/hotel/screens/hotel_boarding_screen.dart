import 'package:flutter/material.dart';

import 'package:travelapp_project/Features/Authentication/screens/login_screen.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';

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
      backgroundColor: homebg,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hassle-Free Hotel', style: AppTextStyles.body1),
            const Text('Searching', style: AppTextStyles.body1),
            const SizedBox(height: 70),
            const Text('Search and compare thousands of hotels to',
                style: AppTextStyles.body3),
            const Text('find the best deal for your stay',
                style: AppTextStyles.body3),
            const SizedBox(height: 70),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    button1,
                    button2,
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
                  style: TextStyle(color: whitecolor, fontSize: 24),
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
