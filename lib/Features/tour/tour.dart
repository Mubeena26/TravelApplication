import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp_project/Features/tour/search_scren.dart.dart';
import 'package:travelapp_project/Features/tour/tour_detail.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  @override
  Widget build(BuildContext context) {
    final popularDestinations = [
      {'title': 'Malaysia', 'dates': '12-02-2024 : 23-02-2024'},
      {'title': 'Japan', 'dates': '10-05-2024 : 20-05-2024'},
      {'title': 'Australia', 'dates': '15-07-2024 : 25-07-2024'},
      {'title': 'Switzerland', 'dates': '01-09-2024 : 10-09-2024'},
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Search(),
                    ));
                    print("Container tapped!");
                  },
                  child: Container(
                    height: 40,
                    width: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // You can add any other widgets here if needed
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Tour package', // Add text or content you need
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 66, 88, 132)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              // Handle icon button press action here
                              print("Icon Button Pressed!");
                            },
                            icon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 66, 88, 132),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Horizontal List of Tours
              SizedBox(
                height: 250, // Set a specific height for the horizontal list
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('tours')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading data.'));
                    }

                    final docs = snapshot.data?.docs ?? [];

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;

                        // Extract imagePath for each item
                        final imagePath = data['imagePath'] ?? '';

                        if (imagePath.isEmpty) {
                          return const Center(
                              child: Text('Image path not available.'));
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              // Pass tour details to TourDetail screen
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TourDetail(
                                  tourData: data, // Pass the tour data
                                ),
                              ));
                            },
                            child: Container(
                              height: 232,
                              width: 233,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 208,
                                    height: 157,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // This clips the image to match the border radius
                                      child: Image.network(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['packageName'] ??
                                                  'Unknown Package',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 66, 88, 132),
                                              ),
                                            ),
                                            Text(
                                              data['destination'] ??
                                                  'Unknown Location',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 66, 88, 132),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Row(
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 66, 88, 132),
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
              ),

              // Vertical List of Popular Destinations
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: popularDestinations.length,
                itemBuilder: (context, index) {
                  final destination = popularDestinations[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: 331,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 51,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              child: Image.asset(
                                'assets/Mask group (1).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                destination['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 66, 88, 132),
                                ),
                              ),
                              subtitle: Text(
                                destination['dates']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 66, 88, 132),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
