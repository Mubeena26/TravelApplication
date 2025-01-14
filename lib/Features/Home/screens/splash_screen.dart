import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:travelapp_project/Features/Home/screens/bottom_nav.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/hotel/screens/hotel_boarding_screen.dart';
import 'package:travelapp_project/Features/tour/screens/tour_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    // Start checking user status after the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkUserStatus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkUserStatus() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch bookingId and navigate to BottomNav
        final String bookingId = await _getBookingIdForUser(user.uid);
        if (!mounted) return; // Ensure the widget is still in the widget tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BottomNav(bookingId: bookingId),
          ),
        );
      } else {
        // Navigate to TourBoarding screen
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HotelBoarding()),
        );
      }
    } catch (e) {
      // Handle errors (e.g., log them or show an error message)
      debugPrint('Error in _checkUserStatus: $e');
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HotelBoarding()),
      );
    }
  }

  Future<String> _getBookingIdForUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot['bookingId'] ?? '';
      } else {
        return ''; // Return a default value if bookingId is not available
      }
    } catch (e) {
      debugPrint('Failed to fetch bookingId: $e');
      return ''; // Return a default value on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/WhatsApp Image 2025-01-14 at 11.53.23_c4dbafc0.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          // Positioned.fill(
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [App6, App3, App2],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         stops: [0.5, 0.8, 1.0],
          //       ),
          //     ),
          //   ),
          // ),
          // Centered animated text
          // Center(
          //   child: AnimatedBuilder(
          //     animation: _animation,
          //     builder: (context, child) {
          //       return Opacity(
          //         opacity: _animation.value,
          //         child: const Text(
          //           "Le'xplore",
          //           style: TextStyle(
          //             color: App2,
          //             fontWeight: FontWeight.w800,
          //             fontSize: 40,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // Bottom text
          Positioned(
            bottom: 30.0,
            left: 130.0,
            right: 10.0,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: const Text(
                    "Le'xplore",
                    style: TextStyle(
                      color: whitecolor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "icomoon",
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
