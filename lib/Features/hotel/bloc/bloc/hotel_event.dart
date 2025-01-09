part of 'hotel_bloc.dart';

@immutable
sealed class HotelEvent {}

class SearchHotelsEvent extends HotelEvent {
  final String? hotelCity;
  final DateTime? checkIn;
  final DateTime? checkOut;

  SearchHotelsEvent({this.hotelCity, this.checkIn, this.checkOut});
}

class UpdateCheckinDateEvent extends HotelEvent {
  final DateTime? checkinDate;
  UpdateCheckinDateEvent(this.checkinDate);
}

class UpdateCheckoutDateEvent extends HotelEvent {
  final DateTime? checkoutDate;
  UpdateCheckoutDateEvent(this.checkoutDate);
}
