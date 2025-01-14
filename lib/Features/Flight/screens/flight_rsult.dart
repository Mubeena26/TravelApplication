import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Flight/bloc/flight_bloc.dart';
import 'package:travelapp_project/Features/Flight/screens/flight_detail.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:flutter/scheduler.dart'; // Required for TickerProviderStateMixin

import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';

class FlightRsult extends StatefulWidget {
  const FlightRsult({super.key});

  @override
  State<FlightRsult> createState() => _FlightRsultState();
}

class _FlightRsultState extends State<FlightRsult>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Slide animation, starting from below (Offset(0.0, 1.0)) and ending at the normal position (Offset.zero)
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App2,
      appBar: CustomAppBar(
        title: "Flight Results",
        style: AppTextStyles.headline1,
        backgroundColor: App2,
        toolbarHeight: 60,
        titleSpacing: 30,
        iconTheme: IconThemeData(
          color: whitecolor, // Change this to the desired color
        ),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SlideTransition(
          position: _slideAnimation, // Apply the slide animation
          child: BlocBuilder<FlightBloc, FlightState>(
            builder: (context, state) {
              if (state is FlightLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FlightError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is FlightLoaded) {
                return ListView.builder(
                  itemCount: state.flightdetails.length,
                  itemBuilder: (context, index) {
                    final flight = state.flightdetails[index];
                    return FlightItem(flight: flight);
                  },
                );
              } else {
                return const Center(
                  child: Text('No flights found'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
