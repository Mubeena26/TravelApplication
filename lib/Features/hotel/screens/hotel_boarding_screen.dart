import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/Authentication/screens/auth_three.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/elevated_button.dart';

class HotelBoarding extends StatelessWidget {
  const HotelBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Image.asset(
                'assets/download (2).jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Centered content
          Center(
            // child: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         'Let’s Explore The World',
            //         style: AppTextStyles.body1,
            //         textAlign: TextAlign.start,
            //       ),
            //       const SizedBox(height: 20),
            //       const Text(
            //         'Journey beyond borders with our range of flight choices,\noffering you the freedom to explore the world like never before.',
            //         style: AppTextStyles.body3,
            //         textAlign: TextAlign.center,
            //       ),
            //       const SizedBox(height: 40),
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
                    style: AppTextStyles.body1,
                  ),
                  const Text(
                    'The World',
                    style: AppTextStyles.body1,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                      'Journey beyond borders with our range of flight choices, ',
                      style: AppTextStyles.body3),
                  const Text(
                      'offering you the freedom to explore the world like never before.',
                      style: AppTextStyles.body3),
                  const SizedBox(height: 50),
                  // Next Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [App2, App2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomButton(
                      text: 'Next',
                      backgroundColor: App2,
                      textColor: whitecolor,
                      borderRadius: 30.0,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => AuthThreePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
