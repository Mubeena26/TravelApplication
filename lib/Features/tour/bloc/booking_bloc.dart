import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_event.dart';
import 'package:travelapp_project/Features/tour/bloc/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is BookingSaveEvent) {
      yield BookingLoadingState();
      try {
        // Create a booking object (logic preserved for potential further use)
        final booking = {
          'name': event.name,
          'email': event.email,
          'phoneNumber': event.phoneNumber,
          'adultCount': event.adultCount,
          'childCount': event.childCount,
          'price': (event.adultCount * 100.0) +
              (event.childCount * 50.0), // Adjust the price logic as needed
          'status': 'Pending',
        };

        // Simulate a success state without persisting to Firestore
        print('Booking data (simulated): $booking');
        yield BookingSuccessState();
      } catch (e) {
        yield BookingErrorState('Error processing booking!');
      }
    }
  }
}
