import 'package:equatable/equatable.dart';

class Withdraw extends Equatable {
  const Withdraw({
    required this.id,
    required this.amountRequest,
    required this.requestDate,
    required this.status,
    required this.bankAccountName,
    required this.bankAccountNumber,
    this.amountApproved,
    this.note,
    this.bankName,
    this.processDate,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) {
    return Withdraw(
      id: json['uuid'] as String,
      amountRequest: num.parse(json['amount_request'] as String),
      requestDate: DateTime.parse(json['request_date'] as String),
      status: json['status'] as String,
      amountApproved: (json['amount_approved'] == null)
          ? null
          : num.parse(json['amount_approved'] as String),
      note: json['note'] as String?,
      bankName: json['bank_name'] as String?,
      bankAccountName: json['bank_account_name'] as String,
      bankAccountNumber: json['bank_account_number'] as String,
      processDate: json['processed_date'] as String?,
    );
  }

  final String id;

  final String bankAccountName;

  final String bankAccountNumber;

  final num amountRequest;

  final num? amountApproved;

  final DateTime requestDate;

  final String? processDate;

  final String status;

  final String? note;

  final String? bankName;

  @override
  List<Object?> get props => [
    id,
    amountRequest,
    amountApproved,
    requestDate,
    status,
    note,
    bankName,
    bankAccountName,
    bankAccountNumber,
    processDate,
  ];
}
