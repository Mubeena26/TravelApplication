import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/hotel/bloc/bloc/hotel_bloc.dart';

import 'package:travelapp_project/Features/hotel/screens/hotel_screen.dart';

class Hotel extends StatefulWidget {
  const Hotel({super.key});

  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  String? _hotelCity;
  DateTime? _checkin;
  DateTime? _checkout;
  final TextEditingController _checkinController = TextEditingController();
  final TextEditingController _checkoutController = TextEditingController();

  @override
  void dispose() {
    _checkinController.dispose();
    _checkoutController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HotelBloc(),
      child: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HotelError) {
            return Center(child: Text(state.message));
          }

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/Hotel-removebg-preview 1.png',
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Image not found');
                    },
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    'City, Hotel, Area',
                    Icons.local_hotel,
                    (value) => _hotelCity = value,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return 'City is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildDatePicker(
                    'Check in',
                    (date) {
                      setState(() {
                        _checkin = date;
                      });
                    },
                    _checkinController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Check-in date is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildDatePicker(
                    'Check out',
                    (date) {
                      setState(() {
                        _checkout = date;
                      });
                    },
                    _checkoutController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Check-out date is required';
                      }
                      if (_checkin != null && _checkout!.isBefore(_checkin!)) {
                        return 'Check-out must be after check-in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  BlocListener<HotelBloc, HotelState>(
                    listener: (context, state) {
                      if (state is HotelLoaded) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: BlocProvider.of<HotelBloc>(context),
                              child: const HotelResultsScreen(),
                            ),
                          ),
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final hotelBloc = BlocProvider.of<HotelBloc>(context);
                          hotelBloc.add(
                            SearchHotelsEvent(
                              hotelCity: _hotelCity!,
                              checkIn: _checkin!,
                              checkOut: _checkout!,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value:
                                    hotelBloc, // Pass the existing Bloc instance
                                child: const HotelResultsScreen(),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tab1,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text('Search', style: AppTextStyles.caption),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    Function(String) onChanged, {
    required String? Function(String?) validator,
  }) {
    return SizedBox(
      width: 350,
      height: 55,
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
        validator: validator,
      ),
    );
  }

  Widget _buildDatePicker(
    String label,
    Function(DateTime?) onChanged,
    TextEditingController controller, {
    required String? Function(String?) validator,
  }) {
    return SizedBox(
      width: 350,
      height: 55,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.teal,
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.teal),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0)),
        ),
        validator: validator,
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            onChanged(picked);
            controller.text = picked.toString().substring(0, 10);
          }
        },
      ),
    );
  }
}
