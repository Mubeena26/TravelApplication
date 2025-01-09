import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/tour/screens/tour_detail.dart';

// Controller for Search State
class SearchController extends GetxController {
  // These values will reset to initial states whenever the page is rebuilt
  var searchname = ''.obs;
  var minPrice = Rxn<double>();
  var maxPrice = Rxn<double>();
  var selectedStartDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    resetFilters(); // Reset filters when the controller is initialized
  }

  @override
  void dispose() {
    super.dispose();
    // Reset the filters when the page is disposed (you can also clear any stream here)
    resetFilters();
  }

  // Method to reset filters to their default state
  void resetFilters() {
    searchname.value = '';
    minPrice.value = null;
    maxPrice.value = null;
    selectedStartDate.value = null;
    selectedEndDate.value = null;
  }

  Stream<QuerySnapshot> getFilteredStream() {
    Query query = FirebaseFirestore.instance.collection('tours');

    // Apply search filter
    if (searchname.isNotEmpty) {
      query = query
          .where('packageName', isGreaterThanOrEqualTo: searchname.value)
          .where('packageName', isLessThan: searchname.value + '\uf8ff');
    }

    // Apply price filters
    if (minPrice.value != null) {
      query = query.where('price', isGreaterThanOrEqualTo: minPrice.value);
    }
    if (maxPrice.value != null) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice.value);
    }

    // Apply date filters
    if (selectedStartDate.value != null) {
      query = query.where('startDate',
          isGreaterThanOrEqualTo:
              selectedStartDate.value!.toIso8601String().split('T')[0]);
    }
    if (selectedEndDate.value != null) {
      query = query.where('endDate',
          isLessThanOrEqualTo:
              selectedEndDate.value!.toIso8601String().split('T')[0]);
    }

    return query.snapshots();
  }
}

class Search extends StatelessWidget {
  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    controller.resetFilters();
    return Scaffold(
      backgroundColor: homebg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Search Bar with Filter Icon
              Row(
                children: [
                  Expanded(
                    child: // Inside Search Widget
                        TextField(
                      onChanged: (value) {
                        // Reset filters before searching
                        controller.resetFilters();
                        controller.searchname.value = value.trim();
                      },
                      decoration: InputDecoration(
                        hintText: "Search Tour Packages",
                        hintStyle: const TextStyle(color: grey),
                        prefixIcon: const Icon(Icons.search, color: grey),
                        filled: true,
                        fillColor: whitecolor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: bluetheme2),
                    onPressed: () => _showFiltersDialog(context, controller),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Results Section
              Expanded(
                child: Obx(() {
                  return StreamBuilder<QuerySnapshot>(
                    stream: controller.getFilteredStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return const Center(
                            child: Text('Something went wrong'));
                      }

                      final searchResults = snapshot.data?.docs ?? [];
                      if (searchResults.isEmpty) {
                        return const Center(child: Text('No results found.'));
                      }

                      return ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final data = searchResults[index].data()
                              as Map<String, dynamic>;
                          return ListTile(
                            title:
                                Text(data['packageName'] ?? 'Unknown Package'),
                            subtitle: Text(
                                data['destination'] ?? 'Unknown Destination'),
                            leading: const Icon(Icons.location_on,
                                color: bluetheme2),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    TourDetail(tourData: data),
                              ));
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFiltersDialog(BuildContext context, SearchController controller) {
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
                  onChanged: (value) =>
                      controller.minPrice.value = double.tryParse(value),
                  decoration: const InputDecoration(
                    labelText: 'Min Price',
                    hintText: 'Enter min price',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      controller.maxPrice.value = double.tryParse(value),
                  decoration: const InputDecoration(
                    labelText: 'Max Price',
                    hintText: 'Enter max price',
                  ),
                ),
                const SizedBox(height: 10),

                // Start Date Picker
                Row(
                  children: [
                    const Text('Start Date: '),
                    ElevatedButton(
                      onPressed: () =>
                          _pickDate(context, controller.selectedStartDate),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tab1,
                      ),
                      child: Obx(() {
                        return Text(
                          controller.selectedStartDate.value == null
                              ? 'Start Date'
                              : controller.selectedStartDate.value!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // End Date Picker
                Row(
                  children: [
                    const Text('End Date: '),
                    ElevatedButton(
                      onPressed: () =>
                          _pickDate(context, controller.selectedEndDate),
                      style: ElevatedButton.styleFrom(backgroundColor: tab1),
                      child: Obx(() {
                        return Text(
                          controller.selectedEndDate.value == null
                              ? 'End Date'
                              : controller.selectedEndDate.value!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            // "Clear Filters" Button
            TextButton(
              onPressed: () {
                controller.resetFilters();
                Navigator.pop(context);
              },
              child: const Text('Clear Filters'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply Filters'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickDate(
      BuildContext context, Rxn<DateTime> selectedDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }
}
