import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';

class WithdrawInfo extends Equatable {
  const WithdrawInfo({required this.bankInfo});

  factory WithdrawInfo.fromJson(Map<String, dynamic> json) {
    return WithdrawInfo(
      bankInfo: BankInfo.fromJson(json['banks'] as Map<String, dynamic>),
    );
  }

  final BankInfo bankInfo;

  @override
  List<Object?> get props => [bankInfo];
}
