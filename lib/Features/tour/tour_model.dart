class Booking {
  final String id;
  final String email;
  final String phoneNumber;
  final int childCount;
  final int adultCount;
  final double price;

  Booking({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.childCount,
    required this.adultCount,
    required this.price,
  });

  // Factory constructor to create a Booking instance from JSON
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      childCount: json['childCount'] ?? 0,
      adultCount: json['adultCount'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  // Convert a Booking instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'childCount': childCount,
      'adultCount': adultCount,
      'price': price,
    };
  }
}
