class User {
  final String name;
  final String email;
  final String password;

  // Constructor
  User({
    required this.name,
    required this.email,
    required this.password,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'No name', // Default value if null
      email: json['email'] ?? 'No email',
      password: json['password'] ?? '',
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
