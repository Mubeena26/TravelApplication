import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:travelapp_project/Features/Home/widgets/home_screen.dart';
import 'package:travelapp_project/Features/screens/bottom_nav.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_bloc.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_event.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_state.dart';
import 'package:travelapp_project/Features/tour/order_summary.dart';
import 'package:travelapp_project/Features/tour/razorpay.dart';

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
        backgroundColor: const Color.fromARGB(255, 244, 254, 255),
        appBar: AppBar(
          title: const Text('Booking Details'),
          backgroundColor: const Color.fromARGB(255, 244, 254, 255),
        ),
        body: Container(
          color: const Color.fromARGB(255, 244, 254, 255),
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
                                    labelStyle: TextStyle(
                                      fontWeight:
                                          FontWeight.bold, // Bold label text
                                    ),
                                    hintText:
                                        name.isNotEmpty ? name : "No Name",
                                    hintStyle: TextStyle(
                                      fontWeight:
                                          FontWeight.bold, // Bold hint text
                                    ),
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
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 41, 182, 246),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit Booking',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        'Booking Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 66, 88, 132),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Color.fromARGB(255, 66, 88, 132),
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
                                  Text(
                                    'Name:',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '$name',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Email:',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '$email',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PackageName:',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    packageName,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Adults:',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '$adultCount',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    'Children:',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '$childCount',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
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
                                    backgroundColor:
                                        const Color.fromARGB(255, 41, 182, 246),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                  ),
                                  child: const Text(
                                    'Pay Now',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
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
