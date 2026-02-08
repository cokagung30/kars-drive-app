import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';

class Summary extends Equatable {
  const Summary({
    required this.totalBids,
    required this.currency,
    required this.income,
    required this.history,
    required this.balance,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalBids: json['total_bids'] as num,
      currency: json['currency'] as String,
      income: json['estimate_income'] as num,
      balance: Balance.fromJson(json['balance_data'] as Map<String, dynamic>),
      history: (json['history'] as List<dynamic>).map((dynamic e) {
        return Order.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }

  final num totalBids;

  final String currency;

  final num income;

  final Balance balance;

  final List<Order> history;

  @override
  List<Object?> get props => [totalBids, currency, income, history, balance];
}
