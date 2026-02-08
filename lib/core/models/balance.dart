import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  const Balance({
    required this.balance,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      balance: (json['balance'] is String)
          ? num.parse(json['balance'] as String)
          : json['balance'] as num,
    );
  }

  final num balance;

  @override
  List<Object?> get props => [balance];
}
