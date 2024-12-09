import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/tour/booking_popup.dart';

class TourDetail extends StatefulWidget {
  final Map<String, dynamic> tourData;

  const TourDetail({Key? key, required this.tourData}) : super(key: key);

  @override
  _TourDetailState createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail> {
  bool _isExpanded = false; // For toggling the "Read More" section

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tourData = widget.tourData;
    final String imagePath = tourData['imagePath'] ?? '';
    final String packageName = tourData['packageName'] ?? 'Unknown Package';
    final String destination = tourData['destination'] ?? 'Unknown Destination';
    final double price = (tourData['price'] ?? 0).toDouble();
    final String description =
        tourData['description'] ?? 'No description available';
    final String startDate = tourData['startDate'] ?? 'Not available';
    final String endDate = tourData['endDate'] ?? 'Not available';
    final String departureTime = tourData['departureTime'] ?? 'Not available';
    final String arrivalTime = tourData['arrivalTime'] ?? 'Not available';
    final double adultPrice = tourData['adultPrice'] ?? 0.0;
    final double childPrice = tourData['childPrice'] ?? 0.0;
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
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 55),
          child: Text('Tour Detail'),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 340,
                  width: 320,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 4),
                    ],
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
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
                  cancellationPolicy),

              const SizedBox(height: 20),

              // Book Now Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(tourData: tourData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 182, 246),
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
      height: 100,
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
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
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Color.fromARGB(255, 66, 88, 132),
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
                    color: Color.fromARGB(255, 66, 88, 132),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

  // Helper function to create a single card with all details in compact format
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
      String cancellationPolicy) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailText('Description:\n', '$description '),
            if (_isExpanded) ...[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildDetailText('Start:\n', startDate),
              //     _buildDetailText('End:\n', endDate),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailText(
                      'Adult Price:\n', '\$${adultPrice.toStringAsFixed(2)}'),
                  _buildDetailText(
                      'Child Price:\n', '\$${childPrice.toStringAsFixed(2)}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailText('Departure:\n', departureTime),
                  _buildDetailText('Arrival:\n', arrivalTime),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailText('Accommodation:\n', accommodationType),
                  _buildDetailText('Transportation:\n', transportation),
                ],
              ),
              _buildDetailText('Start:\n', startDate),
              _buildDetailText('End:\n', endDate),
              _buildDetailText('Inclusions:', inclusions.join(', ')),
              _buildDetailText('Exclusions:', exclusions.join(', ')),
              _buildDetailText('Terms and Conditions:', termsConditions),
              _buildDetailText('Cancellation Policy:', cancellationPolicy),
            ],
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(_isExpanded ? 'Show Less' : 'Read More'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create text sections within cards
  // Helper function to create text sections within cards
  Widget _buildDetailText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        '$title $content',
        style: TextStyle(
          fontSize: 16,
          fontWeight: title == 'Description:\n' ||
                  title == 'Inclusions:' ||
                  title == 'Exclusions:' ||
                  title == 'Terms and Conditions:' ||
                  title == 'Cancellation Policy:'
              ? FontWeight.bold
              : FontWeight.normal, // Make title bold
          color: const Color.fromARGB(255, 66, 88, 132),
        ),
      ),
    );
  }
}
