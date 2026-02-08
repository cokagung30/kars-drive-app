import 'package:equatable/equatable.dart';

class Bank extends Equatable {
  const Bank({
    required this.name,
    required this.code,
    required this.bankStringCode,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'] as String,
      code: json['code'] as String,
      bankStringCode: json['string_code'] as String,
    );
  }

  final String name;

  final String code;

  final String bankStringCode;

  @override
  List<Object?> get props => [name, code, bankStringCode];
}
