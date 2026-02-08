import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.status = false,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'status': status,
    };
  }

  final String name;

  final String email;

  final String? phone;

  final String? avatar;

  final bool status;

  @override
  List<Object?> get props => [];
}
