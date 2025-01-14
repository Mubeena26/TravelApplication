import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Home/bloc/nav_bloc.dart';
import 'package:travelapp_project/Features/Home/bloc/nav_event.dart';
import 'package:travelapp_project/Features/Home/bloc/nav_state.dart';
import 'package:travelapp_project/Features/Home/screens/home_screen.dart';
import 'package:travelapp_project/Features/chat/screen/chat_screen.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/settings/screens/user_screen.dart';
import 'package:travelapp_project/Features/tour/screens/order_summary.dart';

class BottomNav extends StatelessWidget {
  final String bookingId;

  const BottomNav({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      HomeScreen(),
      const ChatScreen(),
      OrderSummaryScreen(),
      UserScreen(),
    ];

    return BlocProvider(
      create: (_) => NavBloc(),
      child: Scaffold(
        backgroundColor: App2, // Background for the whole Scaffold
        body: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return body[state.currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return BottomAppBar(
              elevation: 0, // Remove shadow
              color: App2, // Set the background color for the BottomAppBar
              child: SizedBox(
                height: 60.0, // Set the desired height for the BottomBar
                child: BottomNavigationBar(
                  backgroundColor:
                      App2, // This sets the color of the bottom nav bar
                  selectedItemColor: whitecolor,
                  unselectedItemColor: Colors.grey,
                  currentIndex: state.currentIndex,
                  onTap: (int newIndex) {
                    context.read<NavBloc>().add(ChangeNav(newIndex));
                  },
                  iconSize: 24.0, // Smaller icon size
                  selectedFontSize: 12.0, // Smaller label font size
                  unselectedFontSize:
                      12.0, // Smaller unselected label font size
                  items: const [
                    BottomNavigationBarItem(
                      backgroundColor: App2,
                      label: 'Home',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: App2,
                      label: 'Chat',
                      icon: Icon(Icons.chat),
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: App2,
                      label: 'My Bookings',
                      icon: Icon(Icons.list_alt_outlined),
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: App2,
                      label: 'User',
                      icon: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
