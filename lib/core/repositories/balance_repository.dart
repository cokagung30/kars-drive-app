import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';

class BalanceFailure with EquatableMixin implements Exception {
  BalanceFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class GetBalanceFailure extends BalanceFailure {
  GetBalanceFailure(super.error);
}

class BalanceRepository {
  BalanceRepository({required BalanceApi balanceApi})
    : _balanceApi = balanceApi;

  final BalanceApi _balanceApi;

  Future<Balance> getBalance() async {
    try {
      final balance = await _balanceApi.getBalance().then((value) => value);

      return balance;
    } on GetBalanceApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(GetBalanceFailure(error), stackTrace);
    }
  }
}
