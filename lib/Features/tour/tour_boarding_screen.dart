import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/Flight/flight_boarding.dart';

class TourBoarding extends StatefulWidget {
  const TourBoarding({super.key});

  @override
  State<TourBoarding> createState() => _TourBoardingState();
}

class _TourBoardingState extends State<TourBoarding>
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
              'Tailored Travel ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const Text(
              'Packages',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const SizedBox(height: 70),
            const Text(
              'Discover exclusive travel packages that ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Color.fromARGB(255, 66, 88, 132),
              ),
            ),
            const Text(
              'include flights, hotels, and activities.',
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
                      builder: (context) =>
                          FlightBoarding(), // Replace with your home screen widget
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
