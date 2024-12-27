import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderSummaryScreen extends StatelessWidget {
  final String bookingId; // Unique booking ID to fetch details

  const OrderSummaryScreen({
    super.key,
    required this.bookingId,
  });

  Stream<DocumentSnapshot> _fetchBookingDetails() {
    // Listen for real-time changes to the booking document
    return FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    // Return early if bookingId is empty
    if (bookingId.isEmpty) {
      return const Center(child: Text('No booking details available.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _fetchBookingDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;

            // Check if data is null or empty
            if (data.isEmpty) {
              return const Center(child: Text('No data found.'));
            }

            final orderDetails = [
              {'label': 'Name', 'value': data['name'] ?? 'N/A'},
              {'label': 'Email', 'value': data['email'] ?? 'N/A'},
              {'label': 'Phone Number', 'value': data['phoneNumber'] ?? 'N/A'},
              {
                'label': 'Adults',
                'value': (data['adultCount'] ?? 0).toString()
              },
              {
                'label': 'Children',
                'value': (data['childCount'] ?? 0).toString()
              },
              {
                'label': 'Total Price',
                'value': '\$${(data['totalPrice'] ?? 0).toStringAsFixed(2)}',
              },
              // Add selected package details here
              {
                'label': 'Selected Package',
                'value': data['selectedPackage'] ?? 'N/A',
              },
            ];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orderDetails.length,
                          itemBuilder: (context, index) {
                            final detail = orderDetails[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    detail['label']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    detail['value']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: index == orderDetails.length - 1
                                          ? Colors.green
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}
