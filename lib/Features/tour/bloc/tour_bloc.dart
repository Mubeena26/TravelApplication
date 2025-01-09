import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  TourBloc() : super(TourInitial()) {
    on<FetchToursEvent>(_onFetchTours);
  }
  Future<void> _onFetchTours(
      FetchToursEvent event, Emitter<TourState> emit) async {
    emit(TourLoading());
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('tours').get();

      // Get the current date
      final currentDate = DateTime.now();

      // Filter out the expired tours and avoid null values
      final tours = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final startDateString = data['startDate'] as String;

            // Convert the startDate string into a DateTime object
            final startDate = DateTime.parse(startDateString);

            // Only return tours whose startDate is after the current date
            if (startDate.isAfter(currentDate)) {
              return data;
            }
            return null; // Skip expired tours
          })
          .whereType<Map<String, dynamic>>() // Remove null values safely
          .toList(); // Now it's a List<Map<String, dynamic>>

      emit(TourLoaded(tours)); // Pass the valid list to the TourLoaded state
    } catch (e) {
      emit(TourError(e.toString()));
    }
  }
}
