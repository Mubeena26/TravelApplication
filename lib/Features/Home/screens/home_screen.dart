import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Authentication/screens/auth_three.dart';

import 'package:travelapp_project/Features/Authentication/screens/login_screen.dart';
import 'package:travelapp_project/Features/Home/bloc/tab_bloc.dart';
import 'package:travelapp_project/Features/Home/bloc/tab_event.dart';
import 'package:travelapp_project/Features/Home/bloc/tab_state.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';

import 'package:travelapp_project/Features/hotel/screens/hotel.dart';
import 'package:travelapp_project/Features/Flight/screens/flight.dart';
import 'package:travelapp_project/Features/tour/screens/tour.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);

    return Scaffold(
      backgroundColor: App2,
      appBar: AppBar(
        title: Text("Le'xplore", style: AppTextStyles.headline1),
        backgroundColor: App2, // Check if App2 color works here
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: whitecolor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AuthThreePage(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logout successful')),
                      );
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TabBloc, TabState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButton(context, 0, 'Tour', state.selectedIndex),
                    const SizedBox(width: 20),
                    _buildTabButton(context, 1, 'Hotel', state.selectedIndex),
                    const SizedBox(width: 20),
                    _buildTabButton(context, 2, 'Flight', state.selectedIndex),
                  ],
                ),
                Expanded(
                  child: IndexedStack(
                    index: state.selectedIndex,
                    children: [
                      const TourScreen(),
                      Hotel(),
                      const FlightPage(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabButton(
      BuildContext context, int index, String title, int selectedIndex) {
    final isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<TabBloc>(context).add(ChangeTab(index));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? whitecolor : App2,
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.08, // 8% of screen width
            vertical: MediaQuery.of(context).size.height *
                0.01, // 1% of screen height
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? App2 : whitecolor, // Black for selected tab
          ),
        ),
      ),
    );
  }
}
