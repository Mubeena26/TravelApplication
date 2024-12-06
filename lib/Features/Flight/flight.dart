import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc package
import 'package:travelapp_project/Features/Flight/bloc/flight_bloc.dart';
import 'package:travelapp_project/Features/Flight/flight_detail.dart';
import 'package:travelapp_project/Features/Flight/flight_rsult.dart';
// Import your FlightBloc

class FlightPage extends StatefulWidget {
  const FlightPage({super.key});

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  String _departureCity = 'NYCA';
  String? _arrivalCity;
  DateTime? _departureDate;
  final TextEditingController _departureDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlightBloc(), // Correctly initialize the FlightBloc here
      child: BlocBuilder<FlightBloc, FlightState>(
        builder: (context, state) {
          if (state is FlightLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FlightError) {
            return Center(child: Text(state.message));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/download__9_-removebg-preview 1.png',
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not found');
                  },
                ),
                const SizedBox(height: 30),
                buildTextField('Departure City', Icons.flight_takeoff_outlined,
                    (value) {
                  _departureCity = value;
                }),
                const SizedBox(height: 10),
                buildTextField('Arrival City', Icons.flight_land_outlined,
                    (value) {
                  _arrivalCity = value;
                }),
                const SizedBox(height: 10),
                buildDatePicker('Departure Date', _departureDateController,
                    (date) {
                  _departureDate = date;
                  _departureDateController.text = date != null
                      ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                      : '';
                }),
                const SizedBox(height: 40),
                BlocListener<FlightBloc, FlightState>(
                  listener: (context, state) {
                    if (state is FlightLoaded) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<FlightBloc>(context),
                            child: const FlightRsult(),
                          ),
                        ),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (_arrivalCity == null || _departureDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in all fields')),
                        );
                        return;
                      }

                      String departureCity = _departureCity.toUpperCase();
                      String arrivalCity = _arrivalCity!.toUpperCase();

                      if (!RegExp(r'^[A-Z]{3}$').hasMatch(departureCity) ||
                          !RegExp(r'^[A-Z]{3}$').hasMatch(arrivalCity)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please enter valid 3-letter IATA codes for cities')),
                        );
                        return;
                      }

                      final flightBloc = BlocProvider.of<FlightBloc>(context);
                      flightBloc.add(
                        SearchFlights(
                          departure: _departureCity,
                          arrival: arrivalCity,
                          date: _departureDate!,
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value:
                                flightBloc, // Pass the existing Bloc instance
                            child: const FlightRsult(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 41, 182, 246),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (state is FlightLoaded)
                  SizedBox(
                    height: 400, // Example fixed height
                    child: ListView.builder(
                      itemCount: state.flightdetails.length,
                      itemBuilder: (context, index) {
                        final hotel = state.flightdetails[index];
                        return FlightItem(flight: hotel);
                      },
                    ),
                  ),
                if (state is FlightError) Center(child: Text(state.message)),
                if (state is! FlightLoaded && state is! FlightError)
                  const Center(child: Text('No hotels found')),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(
      String label, IconData icon, Function(String) onChanged) {
    return SizedBox(
      width: 350,
      height: 45,
      child: TextFormField(
        cursorColor: Colors.teal,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.teal),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildDatePicker(String label, TextEditingController controller,
      Function(DateTime?) onChanged) {
    return SizedBox(
      width: 350,
      height: 45,
      child: TextFormField(
        cursorColor: Colors.teal,
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.teal),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
        ),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            onChanged(picked);
            setState(() {
              controller.text =
                  '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
            });
          }
        },
      ),
    );
  }
}
