import 'package:flutter/material.dart';
import 'package:travelapp_project/screens/chat_screen.dart';
import 'package:travelapp_project/screens/map_screen.dart';
import 'package:travelapp_project/screens/my_bookings.dart';
import 'package:travelapp_project/screens/user_screen.dart';
import 'package:travelapp_project/widgets/flight.dart';
import 'package:travelapp_project/widgets/hotel.dart';
import 'package:travelapp_project/widgets/tour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController(initialPage: 0);
  late TabController _tabController;
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
        backgroundColor: const Color.fromARGB(255, 244, 254, 255),
        title: const Text(
          'Explore',
          style: TextStyle(color: Color.fromARGB(255, 66, 88, 132)),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: const <Widget>[
              Center(child: HomeScreen()),
              Center(child: ChatScreen()),
              Center(child: MapScreen()),
              Center(child: MyBookings()),
              Center(child: UserScreen()),
            ],
          ),
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
                      child: const Text('Flight'),
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
                      child: const Text('Hotel'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    TourScreen(),
                    Flight(),
                    Hotel(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined, size: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined, size: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 25),
            label: '',
          ),
        ],
      ),
    );
  }
}
