part of 'flight_bloc.dart';

@immutable
sealed class FlightState {}

final class FlightInitial extends FlightState {}

class FlightLoading extends FlightState {}

class FlightLoaded extends FlightState {
  final List<dynamic> flightdetails;
  FlightLoaded(this.flightdetails);

  @override
  // ignore: override_on_non_overriding_member
  List<Object> get props => [flightdetails];
}

class FlightError extends FlightState {
  final String message;
  FlightError(this.message);
  @override
  // ignore: override_on_non_overriding_member
  List<Object> get props => [message];
}
