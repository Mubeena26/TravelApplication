import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/elevated_button.dart';
import 'package:travelapp_project/Features/hotel/screens/hotel_boarding_screen.dart';

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
            colors: [board1, board2, board3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.8, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let’s',
                style: AppTextStyles.body1,
              ),
              const Text(
                'Explore',
                style: AppTextStyles.body2,
              ),
              const Text(
                'The World',
                style: AppTextStyles.body2,
              ),
              const SizedBox(height: 30),
              const Text(
                  'Journey beyond borders with our range of flight choices, ',
                  style: AppTextStyles.body3),
              const Text(
                  'offering you the freedom to explore the world like never before.',
                  style: AppTextStyles.body3),
              const SizedBox(height: 50),
              // Container with gradient background for button
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [button1, button2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomButton(
                  text: 'Next',
                  backgroundColor: tab1,
                  textColor: whitecolor,
                  borderRadius: 30.0,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            HotelBoarding(), // Replace with your home screen widget
                      ),
                    );
                    // Add login functionality here
                  },
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor:
                  //       blackcolor, // Make button background transparent
                  //   shadowColor: blackcolor, // No shadow
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                  // child: const Text(
                  //   'Next',
                  //   style: TextStyle(color: whitecolor, fontSize: 24),
                  // ),
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
