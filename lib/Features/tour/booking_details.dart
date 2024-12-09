import 'package:flutter/material.dart';

class BookingSummary extends StatelessWidget {
  final double price;

  const BookingSummary({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Price: \$${price.toStringAsFixed(2)}', // Show the total price
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
