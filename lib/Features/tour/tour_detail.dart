import 'dart:io';

import 'package:flutter/material.dart';

class TourDetail extends StatelessWidget {
  final Map<String, dynamic> tourData; // Data passed from the previous screen

  const TourDetail({Key? key, required this.tourData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display tour image (if available)
                if (tourData['imagePath'] != null)
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(tourData['imagePath']),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Divider(
                  height: 2,
                  thickness: 2,
                ),
                const SizedBox(height: 16),

                // Display other tour details
                Text(
                  'Package Name: ${tourData['packageName'] ?? 'Unknown Package'}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Package Type: ${tourData['packageType'] ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Destination: ${tourData['destination'] ?? 'Unknown Location'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Duration: ${tourData['duration'] ?? 'Unknown Duration'} days',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: \$${tourData['price'] ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Activities: ${tourData['activities']?.join(', ') ?? 'No activities'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Accommodation Type: ${tourData['accommodationType'] ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Meals: ${tourData['meals']?.join(', ') ?? 'No meals'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Inclusions: ${tourData['inclusions']?.join(', ') ?? 'None'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Exclusions: ${tourData['exclusions']?.join(', ') ?? 'None'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Cancellation Policy: ${tourData['cancellationPolicy'] ?? 'No Policy'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Terms & Conditions: ${tourData['termsConditions'] ?? 'None'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Availability: ${tourData['availability'] ?? 'Unknown'} spots left',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
