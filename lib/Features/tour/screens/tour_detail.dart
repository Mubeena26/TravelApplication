import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';
import 'package:travelapp_project/Features/tour/screens/booking_popup.dart';
import 'package:url_launcher/url_launcher.dart';

class TourDetail extends StatefulWidget {
  final Map<String, dynamic> tourData;

  const TourDetail({Key? key, required this.tourData}) : super(key: key);

  @override
  _TourDetailState createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tourData = widget.tourData;
    List<dynamic> imageUrls = tourData['imagePath'] ?? [];

    if (imageUrls.isEmpty) {
      return const Center(child: Text('Image path not available.'));
    }

    final String packageName = tourData['packageName'] ?? 'Unknown Package';
    final String destination = tourData['destination'] ?? 'Unknown Destination';
    final double price = (tourData['price'] ?? 0).toDouble();
    final String description =
        tourData['description'] ?? 'No description available';
    final String startDate = tourData['startDate'] ?? 'Not available';
    final String endDate = tourData['endDate'] ?? 'Not available';
    final String departureTime = tourData['departureTime'] ?? 'Not available';
    final String arrivalTime = tourData['arrivalTime'] ?? 'Not available';

    final String adultPriceString =
        tourData['adultPer'] ?? '0'; // Kept as String
    final String childPriceString =
        tourData['childPer'] ?? '0'; // Kept as String

    // Convert the string values to double
    final double adultPrice = double.tryParse(adultPriceString) ?? 0.0;
    final double childPrice = double.tryParse(childPriceString) ?? 0.0;

    final List<String> activities =
        List<String>.from(tourData['activities'] ?? []);
    final String accommodationType =
        tourData['accommodationType'] ?? 'Not available';
    final String transportation =
        tourData['transportationMode'] ?? 'Not available';
    final List<String> inclusions =
        List<String>.from(tourData['inclusions'] ?? []);
    final List<String> exclusions =
        List<String>.from(tourData['exclusions'] ?? []);
    final String termsConditions =
        tourData['termsConditions'] ?? 'No terms and conditions available';
    final String cancellationPolicy =
        tourData['cancellationPolicy'] ?? 'No cancellation policy available';

    return Scaffold(
      backgroundColor: lightPrimary,
      appBar: CustomAppBar(
        title: "Tour Details",
        backgroundColor: lightPrimary,
        toolbarHeight: 60,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel Image Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CarouselSlider.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageUrl = imageUrls[index];
                    return Container(
                      height: 340,
                      width: 320,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: whitecolor, blurRadius: 4),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Basic Tour Info Section (Package Name Card)
              _buildInfoCard(packageName, destination, price),

              const SizedBox(height: 20),

              // All Detailed Info in One Card with Compact Row Layout
              _buildAllDetailsCard(
                  description,
                  startDate,
                  endDate,
                  departureTime,
                  arrivalTime,
                  adultPrice,
                  childPrice,
                  activities,
                  accommodationType,
                  transportation,
                  inclusions,
                  exclusions,
                  termsConditions,
                  cancellationPolicy,
                  imageUrls),

              const SizedBox(height: 20),

              // Book Now Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          tourData: {
                            ...tourData, // Pass all the existing data
                            'selectedPackageName':
                                packageName, // Add the selected packageName
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: button1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create info cards for package name, destination, and price
  Widget _buildInfoCard(String title, String subTitle, double price) {
    return Container(
      height: 90,
      width: 320,
      decoration: BoxDecoration(
        color: whitecolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: lightPrimary,
                      fontStyle: FontStyle.italic),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final Uri url = Uri(scheme: 'tel', path: '7025963877');

                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "can't do the call",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: whitecolor,
                    ));
                  }
                },
                icon: const Icon(
                  Icons.call,
                  color: lightPrimary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  subTitle,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: lightPrimary,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllDetailsCard(
      String description,
      String startDate,
      String endDate,
      String departureTime,
      String arrivalTime,
      double adultPrice,
      double childPrice,
      List<String> activities,
      String accommodationType,
      String transportation,
      List<String> inclusions,
      List<String> exclusions,
      String termsConditions,
      String cancellationPolicy,
      List<dynamic> imageUrls // Added imageUrls to pass the list of images
      ) {
    return Card(
      color: whitecolor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small images section
            if (imageUrls.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    if (index < imageUrls.length) {
                      return Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(imageUrls[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(); // Empty space if there are less than 4 images
                    }
                  }),
                ),
              ),

            // The rest of the details in the card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailText(
                    'Adult Price\n', '\$${adultPrice.toStringAsFixed(2)}'),
                _buildDetailText(
                    'Child Price\n', '\$${childPrice.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailText('Departure\n', departureTime),
                _buildDetailText('Arrival\n', arrivalTime),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailText('Accommodation\n', accommodationType),
                _buildDetailText('Transportation\n', transportation),
              ],
            ),
            _buildDetailText('Start\n', startDate),
            _buildDetailText('End\n', endDate),
            _buildDetailText('Inclusions\n', inclusions.join(', ')),
            _buildDetailText('Exclusions\n', exclusions.join(', ')),
            _buildDetailText('Terms and Conditions\n', termsConditions),
            _buildDetailText('Cancellation Policy\n', cancellationPolicy),
          ],
        ),
      ),
    );
  }

  // Helper function to create text sections within cards
  Widget _buildDetailText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: lightPrimary,
                fontStyle: FontStyle.italic,
              ),
            ),
            TextSpan(
              text: content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
