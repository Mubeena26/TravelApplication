import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_event.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is BookingSaveEvent) {
      yield BookingLoadingState();
      try {
        final booking = {
          'name': event.name,
          'email': event.email,
          'phoneNumber': event.phoneNumber,
          'adultCount': event.adultCount,
          'childCount': event.childCount,
          'price': (event.adultCount * 100.0) +
              (event.childCount *
                  50.0), // Adjust the price logic as per your requirement
          'status': 'Pending',
        };

        await FirebaseFirestore.instance.collection('bookings').add(booking);
        yield BookingSuccessState();
      } catch (e) {
        yield BookingErrorState('Error saving booking!');
      }
    }
  }
}
