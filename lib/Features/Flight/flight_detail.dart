import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/hotel/hotel_detail.dart';
import 'package:travelapp_project/Features/utils/utils_colors.dart';

class FlightItem extends StatelessWidget {
  final dynamic flight;

  const FlightItem({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double priceInUsd = (flight['price'] ?? 0.0).toDouble();
    double priceInInr = priceInUsd * usdToInrConversionRate;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: whitecolor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              flight['airline_logo'],
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${flight['flights'][0]['departure_airport']['name']} to ${flight['flights'][0]['arrival_airport']['name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Duration: ${flight['total_duration']} mins',
                    style: const TextStyle(fontSize: 14.0, color: grey),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Price: \$${priceInInr.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14.0, color: orangecolor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
