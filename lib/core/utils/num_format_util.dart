import 'package:intl/intl.dart';

extension NumX on num? {
  String get formatCurrency {
    final formatter = NumberFormat.currency(
      locale: 'id',
      decimalDigits: 0,
      symbol: '',
    );

    return formatter.format(this ?? 0);
  }
}
