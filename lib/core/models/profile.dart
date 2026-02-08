import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone_number'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  final String name;

  final String email;

  final String? phone;

  final String? avatar;

  @override
  List<Object?> get props => [name, email, phone, avatar];
}
