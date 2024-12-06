part of 'hotel_bloc.dart';

@immutable
sealed class HotelEvent {}

class SearchHotelsEvent extends HotelEvent {
  final String? hotelCity;
  final DateTime? checkIn;
  final DateTime? checkOut;

  SearchHotelsEvent({this.hotelCity, this.checkIn, this.checkOut});
}
