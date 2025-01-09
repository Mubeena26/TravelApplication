import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Flight/bloc/flight_bloc.dart';
import 'package:travelapp_project/Features/Flight/screens/flight_detail.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';

class FlightRsult extends StatelessWidget {
  const FlightRsult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Flight Results",
        style: AppTextStyles.headline1,
        backgroundColor: lightPrimary,
        toolbarHeight: 60,
        titleSpacing: 30,
        automaticallyImplyLeading: true,
        // backgroundColor: const Color.fromARGB(255, 102, 163, 212)
      ),
      body: BlocBuilder<FlightBloc, FlightState>(
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
                final hotel = state.flightdetails[index];
                return FlightItem(flight: hotel);
              },
            );
          } else {
            return const Center(
              child: Text('No hotels found'),
            );
          }
        },
      ),
    );
  }
}
