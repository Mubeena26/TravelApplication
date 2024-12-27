part of 'tour_bloc.dart';

@immutable
sealed class TourState {}

final class TourInitial extends TourState {}

final class TourLoading extends TourState {}

final class TourLoaded extends TourState {
  final List<Map<String, dynamic>> tours;

  TourLoaded(this.tours);
}

final class TourError extends TourState {
  final String errorMessage;

  TourError(this.errorMessage);
}
