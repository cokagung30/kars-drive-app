import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';

class BankInfo extends Equatable {
  const BankInfo({
    required this.description,
    required this.banks,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) {
    return BankInfo(
      description: json['description'] as String?,
      banks: (json['value'] as List<dynamic>).map((dynamic bank) {
        return Bank.fromJson(bank as Map<String, dynamic>);
      }).toList(),
    );
  }

  final String? description;

  final List<Bank> banks;

  @override
  List<Object?> get props => [description, banks];
}
