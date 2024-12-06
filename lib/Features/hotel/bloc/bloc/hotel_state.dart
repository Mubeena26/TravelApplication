part of 'hotel_bloc.dart';

@immutable
sealed class HotelState {}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<dynamic> hotelDetails;
  HotelLoaded(this.hotelDetails);

  @override
  // ignore: override_on_non_overriding_member
  List<Object?> get props => [hotelDetails];
}

class HotelError extends HotelState {
  final String message;
  HotelError(this.message);

  @override
  // ignore: override_on_non_overriding_member
  List<Object?> get props => [message];
}
