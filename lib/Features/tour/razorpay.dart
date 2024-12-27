// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class Razorpay extends StatefulWidget {
//   const Razorpay({super.key});

//   @override
//   State<Razorpay> createState() => _RazorpayState();
// }

// class _RazorpayState extends State<Razorpay> {
//   Razorpay razorpay = Razorpay();
//   @override
//   Widget build(BuildContext context) {
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     return const Placeholder();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(msg: "payment success");
//     // Do something when payment succeeds
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//      Fluttertoast.showToast(msg: "payment failed");
//     // Do something when payment fails
//   }
// }
