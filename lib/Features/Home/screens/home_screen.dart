import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      backgroundColor: homebg,
      appBar: CustomAppBar(
        title: "Le'xplore",
        style: AppTextStyles.home,
        backgroundColor: home,
        toolbarHeight: 60,
        titleSpacing: 10,
        automaticallyImplyLeading: false,
        leading: IconButton(
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
                          builder: (context) => LoginScreen(),
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
      body: BlocBuilder<TabBloc, TabState>(
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
          backgroundColor: isSelected ? tab1 : tab2,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: lightPrimary),
        ),
      ),
    );
  }
}
