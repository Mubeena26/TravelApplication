import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/tour/bloc/tour_bloc.dart';
import 'package:travelapp_project/Features/tour/screens/search_scren.dart.dart';

import 'package:travelapp_project/Features/tour/screens/tour_detail.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TourBloc()..add(FetchToursEvent()), // Initialize and fetch data
      child: Scaffold(
        backgroundColor: App2,
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Search TextField
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                      print("Container tapped!");
                    },
                    child: Container(
                      height: 40,
                      width: 450,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whitecolor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Tour package', // Add text or content you need
                              style: TextStyle(fontSize: 16, color: App2),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              print("Icon Button Pressed!");
                            },
                            icon: Icon(
                              Icons.search,
                              color: App2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Horizontal List of Tours
                SizedBox(
                  height: 250, // Set a specific height for the horizontal list
                  child: BlocBuilder<TourBloc, TourState>(
                    builder: (context, state) {
                      if (state is TourLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TourError) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is TourLoaded) {
                        final tours = state.tours;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tours.length,
                          itemBuilder: (context, index) {
                            final data = tours[index];
                            List<dynamic> imageUrls = data['imagePath'] ?? [];
                            final String? firstImageUrl = imageUrls.isNotEmpty
                                ? imageUrls.first as String
                                : null;

                            if (firstImageUrl == null) {
                              return const Center(
                                  child: Text('Image path not available.'));
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TourDetail(
                                      tourData: data, // Pass the tour data
                                    ),
                                  ));
                                },
                                child: Container(
                                  height: 232,
                                  width: 233,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: App2,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 208,
                                        height: 157,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: whitecolor,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: firstImageUrl != null
                                              ? Image.network(
                                                  firstImageUrl,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 500,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                      Icons.broken_image,
                                                      size: 100,
                                                      color: App2,
                                                    );
                                                  },
                                                )
                                              : const Icon(
                                                  Icons.image_not_supported,
                                                  size: 100,
                                                  color: grey,
                                                ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['packageName'] ??
                                                      'Unknown Package',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'icomoon',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: whitecolor),
                                                ),
                                                Text(
                                                  data['destination'] ??
                                                      'Unknown Location',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: whitecolor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No tours available.'));
                      }
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: Row(
                    children: [
                      Text(
                        'Popular',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: whitecolor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Vertical List of Popular Destinations
                // Vertical List of Popular Destinations
                SizedBox(
                  height: 150, // Set a height for the vertical list
                  child: BlocBuilder<TourBloc, TourState>(
                    builder: (context, state) {
                      if (state is TourLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TourError) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is TourLoaded) {
                        final tours = state.tours;

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: tours.length,
                          itemBuilder: (context, index) {
                            final data = tours[index];
                            List<dynamic> imageUrls = data['imagePath'] ?? [];
                            final String? firstImageUrl = imageUrls.isNotEmpty
                                ? imageUrls.first as String
                                : null;

                            if (firstImageUrl == null) {
                              return const Center(
                                  child: Text('Image path not available.'));
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 11),
                              child: Container(
                                width: 331,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: App3,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => TourDetail(
                                              tourData:
                                                  data, // Pass the tour data
                                            ),
                                          ));
                                        },
                                        child: Container(
                                          width: 51,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: App2,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: firstImageUrl != null
                                                ? Image.network(
                                                    firstImageUrl,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const Icon(
                                                    Icons.image_not_supported,
                                                    size: 50,
                                                    color: grey,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          data['packageName'] ??
                                              'Unknown Package',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'icomoon',
                                              color: whitecolor),
                                        ),
                                        subtitle: Text(
                                          data['destination'] ??
                                              'Unknown Dates',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              color: whitecolor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: Text('No destinations available.'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
