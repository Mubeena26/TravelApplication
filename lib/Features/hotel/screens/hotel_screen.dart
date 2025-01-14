import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';
import 'package:travelapp_project/Features/hotel/bloc/bloc/hotel_bloc.dart';
import 'package:travelapp_project/Features/hotel/screens/hotel_detail.dart';

class HotelResultsScreen extends StatefulWidget {
  const HotelResultsScreen({super.key});

  @override
  State<HotelResultsScreen> createState() => _HotelResultsScreenState();
}

class _HotelResultsScreenState extends State<HotelResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration for the slide animation
    );

    _slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(); // Start the sliding animation
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App2,
      appBar: CustomAppBar(
        title: "Hotel Results",
        style: AppTextStyles.headline1,
        backgroundColor: App2,
        toolbarHeight: 60,
        titleSpacing: 30,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: whitecolor, // Change this to the desired color
        ),
      ),
      body: Center(
        child: SlideTransition(
          position: _slideAnimation, // Apply slide animation
          child: BlocBuilder<HotelBloc, HotelState>(
            builder: (context, state) {
              if (state is HotelLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HotelError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is HotelLoaded) {
                return ListView.builder(
                  itemCount: state.hotelDetails.length,
                  itemBuilder: (context, index) {
                    final hotel = state.hotelDetails[index];
                    return HotelItem(hotel: hotel);
                  },
                );
              } else {
                return const Center(
                  child: Text('No hotels found'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
