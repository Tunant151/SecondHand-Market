import '../utils/logger.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? district;
  final String? profileImageUrl;
  final double rating;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.district,
    this.profileImageUrl,
    this.rating = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    logger.d('Raw JSON for user: $json');
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      district: json['district'],
      profileImageUrl: json['profile_image_url'] ??
          json['profileImageUrl'], // Check both possible keys
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'district': district,
      'profile_image_url': profileImageUrl,
      'rating': rating,
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? district,
    String? profileImageUrl,
    double? rating,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      district: district ?? this.district,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      rating: rating ?? this.rating,
    );
  }
}
