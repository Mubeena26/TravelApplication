import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelapp_project/Features/Authentication/screens/forgot_password_screen.dart';
import 'package:travelapp_project/Features/Authentication/services/firebase_auth.dart';
import 'package:travelapp_project/Features/Home/components/form_container.dart';
import 'package:travelapp_project/Features/Home/screens/bottom_nav.dart';
import 'package:travelapp_project/Features/Home/screens/home_screen.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';

class AuthThreePage extends StatefulWidget {
  static const String path = "lib/src/pages/login/auth3.dart";

  const AuthThreePage({super.key});

  @override
  _AuthThreePageState createState() => _AuthThreePageState();
}

class _AuthThreePageState extends State<AuthThreePage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String backImg = "";
  late bool formVisible;
  int? _formsIndex;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: App2,
        body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image:
          //         AssetImage("assets/Friends vacation_ Men woman with 1.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.black54,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: kToolbarHeight + 40),
                    Expanded(
                      child: Column(
                        children: const <Widget>[
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Welcome to this awesome login app. \n You are awesome",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: whitecolor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(color: App2),
                            ),
                            onPressed: () {
                              setState(() {
                                formVisible = true;
                                _formsIndex = 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade700,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text("Signup"),
                            onPressed: () {
                              setState(() {
                                formVisible = true;
                                _formsIndex = 2;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: App2),
                        backgroundColor: App2,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      icon: const Icon(FontAwesomeIcons.google),
                      label: const Text("Continue with Google"),
                      onPressed: () =>
                          signInWithGoogle(context), // Linking Google Sign-In
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: (!formVisible)
                    ? null
                    : Container(
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: _formsIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    backgroundColor:
                                        _formsIndex == 1 ? App2 : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  child: const Text("Login"),
                                  onPressed: () {
                                    setState(() {
                                      _formsIndex = 1;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: _formsIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                    backgroundColor:
                                        _formsIndex == 2 ? App2 : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  child: const Text("Signup"),
                                  onPressed: () {
                                    setState(() {
                                      _formsIndex = 2;
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                IconButton(
                                  color: Colors.white,
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      formVisible = false;
                                    });
                                  },
                                )
                              ],
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _formsIndex == 1
                                  ? const LoginForm()
                                  : const SignupForm(),
                            )
                          ],
                        ),
                      ),
              )
            ],
          ),
        ));
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
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // FirebaseAuth instance for Google sign-in
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            FormContainer(
              obscureText: false,
              controller: _emailController,
              hintText: 'enter your email',
              labelText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            FormContainer(
              isPasswordField: true, // Password field
              obscureText: _obscureText, // Pass the obscureText state
              controller: _passwordController,
              hintText: 'Enter your password',
              labelText: 'Password',
              onTapSuffixIcon: () {
                setState(() {
                  _obscureText = !_obscureText; // Toggle password visibility
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
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: App2,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text("Login"),
              onPressed: () => _login(),
            ),
            const SizedBox(height: 10.0),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPassword(),
                  ));
                },
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(color: App2),
                ))
          ],
        ),
      ),
    );
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

  // signInWithGoogle(BuildContext context) async {
  //   final GoogleSignIn _googleSignIn = GoogleSignIn();

  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //           idToken: googleSignInAuthentication.idToken,
  //           accessToken: googleSignInAuthentication.accessToken);
  //       await _firebaseAuth.signInWithCredential(credential);
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => HomeScreen(),
  //       ));
  //     }
  //   } catch (e) {
  //     print("Google sign-in error: $e");
  //     _showErrorDialog('Google sign-in failed. Please try again.');
  //   }
  // }

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

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
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
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: App2,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text("Signup"),
              onPressed: () {
                print('pressed');
                if (_formKey.currentState!.validate()) {
                  _signUp();
                  userSetup(_nameController.text, _emailController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    // ignore: unused_local_variable
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      User? user = await _auth.signUpWithEmailPassword(email, password);
      Navigator.of(context).pop();
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-Up successful!'),
            duration: Duration(seconds: 2),
          ),
        );
        userSetup(_nameController.text, _emailController.text);
        final String bookingId = await _getBookingIdForUser(user.uid);
        // Navigate to HomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => BottomNav(
                    bookingId: bookingId,
                  )),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog('An error occurred: ${e.toString()}');
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
