import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Home/bloc/nav_bloc.dart';
import 'package:travelapp_project/Features/Home/bloc/nav_event.dart';
import 'package:travelapp_project/Features/Home/bloc/nav_state.dart';
import 'package:travelapp_project/Features/Home/screens/home_screen.dart';
import 'package:travelapp_project/Features/chat/screen/chat_screen.dart';
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
        backgroundColor: Colors.white,
        body: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return body[state.currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return BottomNavigationBar(
              backgroundColor: Colors.green,
              selectedItemColor: const Color.fromARGB(255, 41, 182, 246),
              unselectedItemColor: Colors.grey,
              currentIndex: state.currentIndex,
              onTap: (int newIndex) {
                context.read<NavBloc>().add(ChangeNav(newIndex));
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
            );
          },
        ),
      ),
    );
  }
}
