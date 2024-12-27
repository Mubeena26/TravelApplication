part of 'tour_bloc.dart';

@immutable
sealed class TourEvent {}

final class FetchToursEvent extends TourEvent {}
