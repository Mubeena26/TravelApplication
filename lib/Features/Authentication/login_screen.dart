import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelapp_project/Features/Authentication/firebase_auth.dart';
import 'package:travelapp_project/Features/Authentication/forgot_password.dart';
import 'package:travelapp_project/Features/Home/widgets/form_container.dart';
import 'package:travelapp_project/Features/Home/widgets/home_screen.dart';
import 'package:travelapp_project/Features/Authentication/signup_screen.dart';
import 'package:travelapp_project/Features/screens/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; // FirebaseAuth instance for Google sign-in
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 139, 216, 249),
              Color.fromARGB(255, 112, 197, 233),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.8, 1],
          ),
        ),
      ),
      Positioned(
        top: 70,
        left: 0,
        right: 0,
        child: Image.asset(
          'assets/10476-[Converted] 2.png',
          fit: BoxFit.contain,
        ),
      ),
      Positioned(
        top: 430,
        left: 20,
        right: 20,
        child: Container(
          height: 226,
          width: 325,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 40)),
                  Text(
                    'Logins',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormContainer(
                  obscureText: false,
                  controller: _emailController,
                  hintText: 'enter your email',
                  labelText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormContainer(
                  isPasswordField: true, // Password field
                  obscureText: _obscureText, // Pass the obscureText state
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  onTapSuffixIcon: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Toggle password visibility
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ));
                    },
                    child: const Text(
                      'Forgot Details?',
                      style: TextStyle(color: Color.fromARGB(255, 221, 26, 26)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Color.fromARGB(255, 41, 98, 246)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 625,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          child: ElevatedButton(
            onPressed: () => _login(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 41, 182, 246),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text('Login'),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Positioned(
        top: 700,
        left: 95,
        child: GestureDetector(
          onTap: () => signInWithGoogle(context), // Linking Google Sign-In
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/New_Google_Favicon_Logo_PNG_Vector__EPS__Free_Download-removebg-preview.png', // Path to the image
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              const Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      )
    ]));
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Simple email validation
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegExp.hasMatch(email)) {
      _showErrorDialog('Invalid email format');
      return;
    }

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      // Display success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          duration: Duration(seconds: 2),
        ),
      );
      final String bookingId = await _getBookingIdForUser(user.uid);
      // Navigate to HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => BottomNav(
                  bookingId: bookingId,
                )),
      );
    } else {
      _showErrorDialog('Sign-in failed. Please try again later.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await _firebaseAuth.signInWithCredential(credential);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
    } catch (e) {
      print("Google sign-in error: $e");
      _showErrorDialog('Google sign-in failed. Please try again.');
    }
  }

  Future<String> _getBookingIdForUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot['bookingId'] ?? '';
      } else {
        return ''; // Return a default value if bookingId is not available
      }
    } catch (e) {
      debugPrint('Failed to fetch bookingId: $e');
      return ''; // Return a default value on error
    }
  }
}
