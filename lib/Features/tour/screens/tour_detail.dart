import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/tour/screens/booking_popup.dart';

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
      body: Stack(
        children: [
          // Display the images in a carousel slider
          Container(
            height: 500,
            width:
                double.infinity, // Define the height you want for the carousel
            child: imageUrls.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double
                            .infinity, // Ensure the container fills the width
                        height: double.infinity,
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit
                              .cover, // Make sure the image covers the container
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9, // Aspect ratio remains 16:9
                      viewportFraction: 1.0,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      height: 650,
                    ),
                  )
                : const Center(
                    child: Text(
                      'Image not available',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        minWidth: 0,
                        height: 40,
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: App2,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    packageName,
                                    style: const TextStyle(
                                      color: whitecolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                      fontFamily: 'icomoon',
                                    ),
                                  ),
                                  subtitle: Text(
                                    destination,
                                    style: TextStyle(color: whitecolor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                    vertical: 8.0,
                                  ),
                                  child: imageUrls.isNotEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(4, (index) {
                                              if (index < imageUrls.length) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    // Show image in a popup
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Image.network(
                                                            imageUrls[index],
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            imageUrls[index]),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox(); // Empty space if there are less than 4 images
                                              }
                                            }),
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                ExpansionTile(
                                  title: const Text(
                                    "Show Details",
                                    style: TextStyle(
                                      color: whitecolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start Date: $startDate",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: whitecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "End Date: $endDate",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: whitecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "Transportation: $transportation",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: whitecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "Accommodation Type: $accommodationType",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: whitecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "Adult Price: \$${adultPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: orangecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "Child Price: \$${childPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: orangecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Text(
                                            "Activities:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: whitecolor,
                                            ),
                                          ),
                                          ...activities.map(
                                            (activity) => Text(
                                              "- $activity",
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: whitecolor),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Text(
                                            "Inclusions:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: whitecolor,
                                            ),
                                          ),
                                          ...inclusions.map(
                                            (inclusion) => Text(
                                              "- $inclusion",
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: whitecolor),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Text(
                                            "Exclusions:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: whitecolor,
                                            ),
                                          ),
                                          ...exclusions.map(
                                            (exclusion) => Text(
                                              "- $exclusion",
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: whitecolor),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "Terms & Conditions: $termsConditions",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: whitecolor),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "Cancellation Policy: $cancellationPolicy",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: whitecolor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            color: App2,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "\$${price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 16.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                ),
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Book Now",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Container(
                                      padding: const EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.orange,
                                        size: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
