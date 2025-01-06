import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelapp_project/Features/Authentication/login_screen.dart';
import 'package:travelapp_project/Features/settings/about.dart';
import 'package:travelapp_project/Features/settings/privacy.dart';
import 'package:travelapp_project/Features/settings/support.dart';
import 'package:travelapp_project/Features/utils/utils_colors.dart';

// ignore: must_be_immutable
class UserScreen extends StatelessWidget {
  TextStyle blackText = const TextStyle(
    color: Colors.black,
  );

  TextStyle buttonText = const TextStyle(fontSize: 16.0);
  TextStyle linkText = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  );

  final TextStyle shadedTitle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600);

  static const String path = "lib/src/pages/settings/settings2.dart";
  final TextStyle whiteText = const TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = const TextStyle(
    color: Colors.grey,
  );

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 240, 253),
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0, // Controls the size of the avatar
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(
                              user!.photoURL!) // User's profile image
                          : null, // Default to null if no photoURL
                      child: user?.photoURL == null
                          ? const Icon(
                              Icons.person,
                              size: 40.0,
                              color: Colors.grey,
                            )
                          : null, // Fallback icon if no profile image
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user?.displayName ?? "No Name",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                          Text(
                            user?.email ?? "No Email",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: const Text(
                    "About us",
                  ),
                  // subtitle: Text(
                  //   "English US",
                  //   style: greyTExt,
                  // ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ));
                  },
                ),
                ListTile(
                  title: const Text(
                    "Privacy policy",
                  ),
                  // subtitle: Text(
                  //   user?.displayName ?? "No Name",
                  //   style: greyTExt,
                  // ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                    ));
                  },
                ),
                ListTile(
                  title: const Text(
                    "Support",
                  ),
                  // subtitle: Text(
                  //   user?.displayName ?? "No Name",
                  //   style: greyTExt,
                  // ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Support(),
                    ));
                  },
                ),
                ListTile(
                  title: const Text(
                    "Logout",
                  ),
                  onTap: () async {
                    // await FirebaseAuth.instance.signOut();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Logout successful')));
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
