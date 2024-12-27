import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/Home/widgets/home_screen.dart';
import 'package:travelapp_project/Features/chat/chat_screen.dart';
import 'package:travelapp_project/Features/screens/hello.dart';
import 'package:travelapp_project/Features/screens/user_screen.dart';
import 'package:travelapp_project/Features/tour/booking_details.dart';
import 'package:travelapp_project/Features/tour/order_summary.dart';

class BottomNav extends StatefulWidget {
  final String bookingId; // Accept bookingId as a parameter

  const BottomNav({super.key, required this.bookingId});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Dynamically construct the `body` list with the correct bookingId
    final List<Widget> body = [
      const HomeScreen(),
      const ChatScreen(),
      widget.bookingId.isNotEmpty
          ? OrderSummaryScreen(
              bookingId: widget.bookingId) // Ensure bookingId is valid
          : const Center(child: Text("No booking details available")),
      UserScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: body[currentIndex], // Displays the current screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green, // Background color of the bar
        selectedItemColor: const Color.fromARGB(255, 41, 182, 246),
        unselectedItemColor: Colors.grey, // Color of unselected items
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: 'My Bookings',
            icon: Icon(Icons.list_alt_outlined),
          ),
          BottomNavigationBarItem(
            label: 'User',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
