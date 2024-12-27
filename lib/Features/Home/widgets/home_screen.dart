import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:travelapp_project/Features/Authentication/login_screen.dart';
import 'package:travelapp_project/Features/bottom_nav.dart';

import 'package:travelapp_project/Features/hotel/hotel.dart';
import 'package:travelapp_project/Features/Flight/flight.dart';
import 'package:travelapp_project/Features/tour/tour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController(initialPage: 0);
  late TabController _tabController;
  // ignore: unused_field
  int _selectedIndex = 0;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  void _onTabButtonPressed(int index) {
    setState(() {
      _selected = index;
      _tabController.index = index; // Change the tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logout successful')));
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.logout),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 254, 255),
        title: const Text(
          'Explore',
          style: TextStyle(color: Color.fromARGB(255, 66, 88, 132)),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      onPressed: () => _onTabButtonPressed(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == 0
                            ? const Color.fromARGB(255, 41, 182, 246)
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        'Tour',
                        style:
                            TextStyle(color: Color.fromARGB(255, 66, 88, 132)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      onPressed: () => _onTabButtonPressed(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == 1
                            ? const Color.fromARGB(255, 41, 182, 246)
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text('Hotel'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      onPressed: () => _onTabButtonPressed(2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == 2
                            ? const Color.fromARGB(255, 41, 182, 246)
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text('Flight'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const TourScreen(),
                    Hotel(),
                    const FlightPage(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
  // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home, size: 25),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat, size: 25),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.map_outlined, size: 25),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list_alt_outlined, size: 25),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person, size: 25),
      //       label: '',
      //     ),
      //   ],
      // ),

       // PageView(
          //   controller: pageController,
          //   onPageChanged: (index) {
          //     setState(() {
          //       _selectedIndex = index;
          //     });
          //   },
          //   children: const <Widget>[
          //     Center(child: HomeScreen()),
          //     Center(child: ChatScreen()),
          //     Center(child: MapScreen()),
          //     Center(child: MyBookings()),
          //     Center(child: UserScreen()),
          //   ],
          // ),