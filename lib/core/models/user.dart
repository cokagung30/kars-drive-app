import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.status = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      status: json.containsKey('status') || json['status'] as bool,
    );
  }

  final String name;

  final String email;

  final String? phone;

  final String? avatar;

  final bool status;

  User copyWith({bool? status}) {
    return User(
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, avatar, status];
}
