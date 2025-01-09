import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:travelapp_project/Features/Home/screens/home_screen.dart';
import 'package:travelapp_project/Features/Home/screens/bottom_nav.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_bloc.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_event.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_state.dart';
import 'package:travelapp_project/Features/tour/screens/order_summary.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> tourData;

  const BookingScreen({Key? key, required this.tourData}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Razorpay razorpay = Razorpay();
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNumber = '';
  int adultCount = 0;
  int childCount = 0;
  DateTime bookedDate = DateTime.now(); // Initialize bookedDate

  double _calculateTotalPrice() {
    final double adultPrice =
        double.tryParse(widget.tourData['adultPer']?.toString() ?? '0') ?? 0;
    final double childPrice =
        double.tryParse(widget.tourData['childPer']?.toString() ?? '0') ?? 0;

    return (adultCount * adultPrice) + (childCount * childPrice);
  }

  void _getUserDetails() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        name =
            user.displayName ?? 'Guest'; // If displayName is null, use 'Guest'
        email = user.email ??
            'Not available'; // If email is null, use 'Not available'
      });
    }
  }

  @override
  void initState() {
    _getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    final String packageName =
        widget.tourData['packageName'] ?? 'Not specified';
    return BlocProvider(
      create: (_) => BookingBloc(),
      child: Scaffold(
        backgroundColor: homebg,
        appBar: CustomAppBar(
          title: "Booking Details",
          backgroundColor: lightPrimary,
          toolbarHeight: 60,
        ),
        body: Container(
          color: homebg,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Card(
                          margin: const EdgeInsets.all(12.0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: AppTextStyles.bold,
                                    hintText:
                                        name.isNotEmpty ? name : "No Name",
                                    hintStyle: AppTextStyles.bold,
                                  ),
                                  initialValue: name,
                                  enabled: false, // Prevent editing the name
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText:
                                        email.isNotEmpty ? email : "No Email",
                                  ),
                                  initialValue: email,
                                  enabled: false, // Prevent editing the email
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Phone Number'),
                                  validator: (value) => value == null ||
                                          value.isEmpty ||
                                          value.contains(' ')
                                      ? 'Enter your phone number'
                                      : null,
                                  onChanged: (value) =>
                                      setState(() => phoneNumber = value),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Adults'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) => value == null ||
                                                int.tryParse(value) == null ||
                                                value.contains(' ')
                                            ? 'Enter a valid number'
                                            : null,
                                        onChanged: (value) => setState(() =>
                                            adultCount =
                                                int.tryParse(value) ?? 0),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Children'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) => value == null ||
                                                int.tryParse(value) == null ||
                                                value.contains(' ')
                                            ? 'Enter a valid number'
                                            : null,
                                        onChanged: (value) => setState(() =>
                                            childCount =
                                                int.tryParse(value) ?? 0),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<BookingBloc>(context).add(
                                        BookingSaveEvent(
                                          name: name,
                                          email: email,
                                          phoneNumber: phoneNumber,
                                          adultCount: adultCount,
                                          childCount: childCount,
                                          bookedDate: DateTime
                                              .now(), // Pass the current timestamp
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tab1,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                  ),
                                  child: const Text('Submit Booking',
                                      style: AppTextStyles.button),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text('Booking Summary', style: AppTextStyles.body4),
                      const SizedBox(height: 10),
                      Card(
                        color: lightPrimary,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Name:', style: AppTextStyles.booking),
                                  Text('$name', style: AppTextStyles.booking2),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Email:', style: AppTextStyles.booking),
                                  Text('$email', style: AppTextStyles.booking2)
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('PackageName:',
                                      style: AppTextStyles.booking),
                                  Text(packageName,
                                      style: AppTextStyles.booking2),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Adults:', style: AppTextStyles.booking),
                                  Text('$adultCount',
                                      style: AppTextStyles.booking2),
                                  Text('Children:',
                                      style: AppTextStyles.booking),
                                  Text('$childCount',
                                      style: AppTextStyles.booking2),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Price:',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    '\$${_calculateTotalPrice()}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    var options = {
                                      'key': "rzp_test_sZxZypcRFmbl7I",
                                      'amount': 50000,
                                      'name': 'Lexplore',
                                      'description': 'Fine T-Shirt',
                                      'prefill': {
                                        'contact': '7025963877',
                                        'email': 'mubee160@gmail.com'
                                      }
                                    };
                                    razorpay.open(options);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tab1,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                  ),
                                  child: const Text('Pay Now',
                                      style: AppTextStyles.button),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // BlocListener<BookingBloc, BookingState>(
              //   listener: (context, state) {
              //     if (state is BookingLoadingState) {
              //       // Show loading indicator
              //     }
              //     if (state is BookingSuccessState) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //             content: Text('Booking saved successfully!')),
              //       );
              //     }
              //     if (state is BookingErrorState) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(state.errorMessage)),
              //       );
              //     }
              //   },
              //   child: const SizedBox(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isPaymentProcessed = false;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (_isPaymentProcessed) return; // Prevent multiple invocations
    _isPaymentProcessed = true;

    try {
      var userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        // Handle case where user is not logged in
        return;
      }

      var bookingRef =
          await FirebaseFirestore.instance.collection('bookings').add({
        'userId': userId,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'adultCount': adultCount,
        'childCount': childCount,
        'totalPrice': _calculateTotalPrice(),
        'paymentId': response.paymentId,
        'packageName': widget.tourData['packageName'] ?? 'Not specified',
        'imagePath': widget.tourData['imagePath'] ?? 'Not specified',
        'startDate': widget.tourData['startDate'] ?? 'Not specified',
        'endDate': widget.tourData['endDate'] ?? 'Not specified',
        'destination': widget.tourData['destination'] ?? 'Not specified',
        'duration': widget.tourData['duration'] ?? 'Not specified',
        'bookeDate': bookedDate,
      });

      String bookingId = bookingRef.id;
      if (bookingId.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(bookingId: bookingId),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Booking failed, please try again.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to save booking details: $e");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "payment failed");
    // Do something when payment fails
  }
}
