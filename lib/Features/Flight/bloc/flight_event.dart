part of 'flight_bloc.dart';

@immutable
sealed class FlightEvent {}

class SearchFlights extends FlightEvent {
  final String departure;
  final String arrival;
  final DateTime date;
  SearchFlights(
      {required this.departure, required this.arrival, required this.date});
  @override
  // ignore: override_on_non_overriding_member
  List<Object> get props => [departure, arrival, date];
}
