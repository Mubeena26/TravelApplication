import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:travelapp_project/Features/screens/bottom_nav.dart';
import 'package:travelapp_project/Features/tour/tour_boarding_screen.dart';

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
      duration: const Duration(seconds: 3),
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
          MaterialPageRoute(builder: (context) => TourBoarding()),
        );
      }
    } catch (e) {
      // Handle errors (e.g., log them or show an error message)
      debugPrint('Error in _checkUserStatus: $e');
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TourBoarding()),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 192, 252, 252),
              Color.fromARGB(255, 139, 216, 249),
              Color.fromARGB(255, 132, 187, 209),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.8, 1.0],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: const Text(
                  "Le'xplore",
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 88, 132),
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
