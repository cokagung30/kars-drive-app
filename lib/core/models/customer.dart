import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as num,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
    );
  }

  final num id;

  final String firstName;

  final String lastName;

  final String email;

  final String? phone;

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phone,
  ];
}
