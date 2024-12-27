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
      final tours = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      emit(TourLoaded(tours));
    } catch (e) {
      emit(TourError(e.toString()));
    }
  }
}
