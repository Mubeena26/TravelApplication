import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/Flight/bloc/flight_bloc.dart';
import 'package:travelapp_project/Features/Flight/flight_detail.dart';

class FlightRsult extends StatelessWidget {
  const FlightRsult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Hotel Results"),
          backgroundColor: const Color.fromARGB(255, 102, 163, 212)),
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
