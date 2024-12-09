import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> tourData;

  const BookingScreen({Key? key, required this.tourData}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNumber = '';
  int adultCount = 0;
  int childCount = 0;

  double _calculateTotalPrice() {
    final double adultPrice =
        double.tryParse(widget.tourData['adultPer']?.toString() ?? '0') ?? 0;
    final double childPrice =
        double.tryParse(widget.tourData['childPer']?.toString() ?? '0') ?? 0;

    return (adultCount * adultPrice) + (childCount * childPrice);
  }

  void _saveBooking() async {
    if (_formKey.currentState!.validate()) {
      final double totalPrice = _calculateTotalPrice();

      try {
        final booking = {
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'adultCount': adultCount,
          'childCount': childCount,
          'price': totalPrice,
          'status': 'Pending',
        };

        await FirebaseFirestore.instance.collection('bookings').add(booking);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving booking!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = _calculateTotalPrice();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      ),
      body: Container(
        color: const Color.fromARGB(255, 244, 254, 255),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Card(
                        margin: const EdgeInsets.all(12.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Name'),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter your name'
                                        : null,
                                onChanged: (value) =>
                                    setState(() => name = value),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                                validator: (value) =>
                                    value == null || !value.contains('@')
                                        ? 'Enter a valid email'
                                        : null,
                                onChanged: (value) =>
                                    setState(() => email = value),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Phone Number'),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter your phone number'
                                        : null,
                                onChanged: (value) =>
                                    setState(() => phoneNumber = value),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Adults'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) => value == null ||
                                              int.tryParse(value) == null
                                          ? 'Enter a valid number'
                                          : null,
                                      onChanged: (value) => setState(() =>
                                          adultCount =
                                              int.tryParse(value) ?? 0),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Children'),
                                      keyboardType: TextInputType.number,
                                      validator: (value) => value == null ||
                                              int.tryParse(value) == null
                                          ? 'Enter a valid number'
                                          : null,
                                      onChanged: (value) => setState(() =>
                                          childCount =
                                              int.tryParse(value) ?? 0),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _saveBooking,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 41, 182, 246),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                                child: const Text(
                                  'Submit Booking',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'Booking Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 66, 88, 132),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Color.fromARGB(255, 66, 88, 132),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Name:',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email:',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  email,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Adults:',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  adultCount.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  'Children:',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  childCount.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price:',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '\$${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add Pay Now functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 41, 182, 246),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
