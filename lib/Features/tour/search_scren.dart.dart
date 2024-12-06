import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/tour/tour_detail.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchname = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search Tour Packages",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Results Section
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (searchname.isEmpty)
                      ? FirebaseFirestore.instance
                          .collection('tours')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('tours')
                          .where('packageName',
                              isGreaterThanOrEqualTo: searchname)
                          .where('packageName',
                              isLessThan: searchname + '\uf8ff')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    final searchResults = snapshot.data?.docs ?? [];
                    if (searchResults.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }

                    return ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final data =
                            searchResults[index].data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data['packageName'] ?? 'Unknown Package'),
                          subtitle: Text(
                              data['destination'] ?? 'Unknown Destination'),
                          leading:
                              const Icon(Icons.location_on, color: Colors.blue),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TourDetail(tourData: data),
                            ));
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
