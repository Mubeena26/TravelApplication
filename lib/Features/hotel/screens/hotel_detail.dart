import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';

const double usdToInrConversionRate = 74.5;

class HotelItem extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelItem({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double priceInUsd = 0.0;
    if (hotel['rate_per_night'] != null) {
      String priceString = hotel['rate_per_night']['lowest'];

      priceString = priceString.replaceAll('\$', '');

      priceInUsd = double.tryParse(priceString) ?? 0.0;
    }
    double priceInInr = priceInUsd * usdToInrConversionRate;

    return Container(
      // color: App2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: App3,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: App4,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Text(hotel['name'] ?? 'Name not available',
              style: TextStyle(
                  color: whitecolor, fontFamily: "myFlutterApp", fontSize: 18)),
          const Divider(),
          const SizedBox(height: 8.0),
          Text(hotel['description'] ?? 'Description not available',
              style: TextStyle(
                  color: whitecolor, fontFamily: "myFlutterApp", fontSize: 13)),
          const SizedBox(height: 8.0),
          Text(
              hotel['rate_per_night'] != null
                  ? 'Rate per night: ${hotel['rate_per_night']['lowest']} (USD) | ₹${priceInInr.toStringAsFixed(2)} (INR)'
                  : 'Rate not available',
              style: TextStyle(
                  color: whitecolor, fontFamily: "myFlutterApp", fontSize: 13)),
          const SizedBox(height: 8.0),
          Text('Check-in Time: ${hotel['check_in_time']}',
              style: TextStyle(
                  color: whitecolor, fontFamily: "myFlutterApp", fontSize: 13)),
          Text('Check-out Time: ${hotel['check_out_time']}',
              style: TextStyle(
                  color: whitecolor, fontFamily: "myFlutterApp", fontSize: 13)),
          const SizedBox(height: 8.0),
          const Text('Nearby places:',
              style: TextStyle(
                  color: whitecolor, fontFamily: "myFlutterApp", fontSize: 13)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              hotel['nearby_places'].length,
              (index) => Text('- ${hotel['nearby_places'][index]['name']}',
                  style: TextStyle(
                      color: whitecolor,
                      fontFamily: "myFlutterApp",
                      fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
