// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class OrderSummaryScreen extends StatelessWidget {
//   const OrderSummaryScreen({super.key});

//   // Method to fetch all bookings by the userId
//   Stream<QuerySnapshot> _fetchBookingDetails(String userId) {
//     return FirebaseFirestore.instance
//         .collection('bookings')
//         .where('userId', isEqualTo: userId) // Query by userId
//         .snapshots(); // Fetch all documents related to the user
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userId = FirebaseAuth.instance.currentUser?.uid;

//     if (userId == null) {
//       return const Center(child: Text('You are not logged in.'));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Summary'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _fetchBookingDetails(userId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData && snapshot.data != null) {
//             final bookings = snapshot.data!.docs;

//             if (bookings.isEmpty) {
//               return const Center(child: Text('No booking data found.'));
//             }

//             return ListView.builder(
//               itemCount: bookings.length,
//               itemBuilder: (context, index) {
//                 final data = bookings[index].data() as Map<String, dynamic>;

//                 final orderDetails = [
//                   {'label': 'Name', 'value': data['name'] ?? 'N/A'},
//                   {'label': 'Email', 'value': data['email'] ?? 'N/A'},
//                   {
//                     'label': 'Phone Number',
//                     'value': data['phoneNumber'] ?? 'N/A'
//                   },
//                   {
//                     'label': 'Adults',
//                     'value': (data['adultCount'] ?? 0).toString()
//                   },
//                   {
//                     'label': 'Children',
//                     'value': (data['childCount'] ?? 0).toString()
//                   },
//                   {
//                     'label': 'Total Price',
//                     'value': '\$${(data['totalPrice'] ?? 0).toStringAsFixed(2)}'
//                   },
//                   {
//                     'label': 'Selected Package',
//                     'value': data['packageName'] ?? 'N/A'
//                   },
//                 ];

//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Order Summary',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           ListView.builder(
//                             shrinkWrap: true, // Prevents overflow
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: orderDetails.length,
//                             itemBuilder: (context, detailIndex) {
//                               final detail = orderDetails[detailIndex];
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       detail['label']!,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                     Text(
//                                       detail['value']!,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w400,
//                                         color: detailIndex ==
//                                                 orderDetails.length - 1
//                                             ? Colors.green
//                                             : Colors.black54,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No booking data found.'));
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';
import 'package:travelapp_project/Features/tour/screens/my_order_detail.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  // Method to fetch all bookings by the userId
  Stream<QuerySnapshot> _fetchBookingDetails(String userId) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: userId) // Query by userId
        .snapshots(); // Fetch all documents related to the user
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Center(child: Text('You are not logged in.'));
    }

    return Scaffold(
      backgroundColor: home,
      appBar: CustomAppBar(
          title: "Order Summary",
          backgroundColor: homebg,
          toolbarHeight: 60,
          style: AppTextStyles.home),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchBookingDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final bookings = snapshot.data!.docs;

            if (bookings.isEmpty) {
              return const Center(child: Text('No booking data found.'));
            }

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final data = bookings[index].data() as Map<String, dynamic>;

                final packageName = data['packageName'] ?? 'N/A';
                final totalPrice = data['totalPrice'] ?? 0.0;
                final imageUrls =
                    data['imagePath'] as List<dynamic>?; // Assuming it's a list
                final imageUrl = (imageUrls != null && imageUrls.isNotEmpty)
                    ? imageUrls.first // Fetch first image from the list
                    : 'https://via.placeholder.com/150'; // Placeholder if no image

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left Section: Package Name and Total Price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Package Name:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: lightPrimary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  packageName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: bluetheme),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Total Amount:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: blackcolor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '\$${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Right Section: Image Display
                          GestureDetector(
                            onTap: () {
                              // Pass the selected booking data to the detail screen
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderSummarydetail(
                                  bookingData: data,
                                ),
                              ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No booking data found.'));
          }
        },
      ),
    );
  }
}
