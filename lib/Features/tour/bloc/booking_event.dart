abstract class BookingEvent {}

class BookingSaveEvent extends BookingEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final int adultCount;
  final int childCount;

  BookingSaveEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.adultCount,
    required this.childCount,
  });
}
