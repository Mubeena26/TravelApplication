import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';
import 'package:travelapp_project/Features/hotel/bloc/bloc/hotel_bloc.dart';
import 'package:travelapp_project/Features/hotel/screens/hotel_detail.dart';

class HotelResultsScreen extends StatelessWidget {
  const HotelResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Hotel Results",
        style: AppTextStyles.headline1,
        backgroundColor: lightPrimary,
        toolbarHeight: 60,
        titleSpacing: 30,
        automaticallyImplyLeading: true,
        // backgroundColor: const Color.fromARGB(255, 102, 163, 212)
      ),
      body: BlocBuilder<HotelBloc, HotelState>(
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
    );
  }
}
