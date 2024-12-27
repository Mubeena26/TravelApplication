abstract class BookingState {}

class BookingInitialState extends BookingState {}

class BookingLoadingState extends BookingState {}

class BookingSuccessState extends BookingState {}

class BookingErrorState extends BookingState {
  final String errorMessage;

  BookingErrorState(this.errorMessage);
}
