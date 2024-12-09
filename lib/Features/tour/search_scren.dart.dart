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
  double? minPrice;
  double? maxPrice;
  DateTime? selectedDate;

  // Function to open date picker
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 254, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Search Bar with Filter Icon
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchname = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search Tour Packages",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.blue),
                    onPressed: _showFiltersDialog,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Results Section
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _getFilteredStream(),
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

  // Function to show filter dialog
  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apply Filters'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Price Filters
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      minPrice = double.tryParse(value);
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Min Price',
                    hintText: 'Enter min price',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      maxPrice = double.tryParse(value);
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Max Price',
                    hintText: 'Enter max price',
                  ),
                ),
                const SizedBox(height: 10),

                // Date Picker
                Row(
                  children: [
                    const Text('Select Date: '),
                    ElevatedButton(
                      onPressed: _pickDate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 41, 182, 246),
                      ),
                      child: Text(
                        selectedDate == null
                            ? 'Choose Date'
                            : selectedDate!.toLocal().toString().split(' ')[0],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Apply Filters'),
            ),
          ],
        );
      },
    );
  }

  // Get filtered stream based on search name, price, and date
  Stream<QuerySnapshot> _getFilteredStream() {
    Query query = FirebaseFirestore.instance.collection('tours');

    // Apply search filter
    if (searchname.isNotEmpty) {
      query = query
          .where('packageName', isGreaterThanOrEqualTo: searchname)
          .where('packageName', isLessThan: searchname + '\uf8ff');
    }

    // Apply price filters
    if (minPrice != null) {
      query = query.where('price', isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice);
    }

    // Apply date filter
    if (selectedDate != null) {
      query = query.where('date', isEqualTo: selectedDate);
    }

    return query.snapshots();
  }
}
