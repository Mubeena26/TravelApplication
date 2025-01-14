import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';

class OrderSummarydetail extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const OrderSummarydetail({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    final packageName = bookingData['packageName'] ?? 'N/A';
    final startDate = bookingData['startDate'] ?? 'N/A';
    final endDate = bookingData['endDate'] ?? 'N/A';
    final Duration = bookingData['duration'] ?? 'N/A';
    final destination = bookingData['destination'] ?? 'N/A';
    final totalPrice = bookingData['totalPrice'] ?? 0.0;
    final bookingDate =
        bookingData['bookingDate']?.toDate().toString() ?? 'N/A';
    final packageDetails = bookingData['packageDetails'] ?? 'N/A';
    final adultCount = bookingData['adultCount'] ?? 0;
    final childCount = bookingData['childCount'] ?? 0;
    final name = bookingData['name'] ?? 'N/A';
    final phoneNumber = bookingData['phoneNumber'] ?? 'N/A';
    final email = bookingData['email'] ?? 'N/A';
    final imageUrls =
        bookingData['imagePath'] as List<dynamic>?; // Assuming it's a list

    return Scaffold(
      backgroundColor: App2,
      appBar: CustomAppBar(
        title: "Order Details",
        backgroundColor: App2,
        toolbarHeight: 60,
        iconTheme: IconThemeData(
          color: whitecolor, // Change this to the desired color
        ),
        style: AppTextStyles.headline1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [whitecolor, whitecolor, whitecolor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Slider
                  if (imageUrls != null && imageUrls.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1.0,
                        autoPlay: true,
                      ),
                      items: imageUrls.map((imageUrl) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://via.placeholder.com/150', // Placeholder if no images
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text('Package Name: $packageName',
                      style: AppTextStyles.button),
                  const SizedBox(height: 10),
                  Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.headline3),
                  // const SizedBox(height: 10),
                  // Text(
                  //   'Booking Date: $bookingDate',
                  //   style: const TextStyle(
                  //       fontSize: 16, fontWeight: FontWeight.w500),
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   'Package Details: $packageDetails',
                  //   style: const TextStyle(
                  //       fontSize: 16, fontWeight: FontWeight.w500),
                  // ),
                  const SizedBox(height: 10),
                  Text('Adults: $adultCount', style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('Children: $childCount', style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('Name: $name', style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('Phone Number: $phoneNumber',
                      style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('Email: $email', style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('Duration: $Duration', style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('Start date: $startDate',
                      style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('End date: $endDate', style: AppTextStyles.headline3),
                  const SizedBox(height: 10),
                  Text('destination: $destination',
                      style: AppTextStyles.headline3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
