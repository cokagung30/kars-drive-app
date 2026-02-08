import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class BalanceApiFailure with EquatableMixin implements Exception {
  const BalanceApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class GetBalanceApiFailure extends BalanceApiFailure {
  GetBalanceApiFailure(super.error);
}

class BalanceApi {
  BalanceApi(this._dio);

  final Dio _dio;

  Future<Balance> getBalance() async {
    try {
      return await _dio
          .getWithData<Balance>(path: 'withdraw/balance')
          .then((value) => value.data!);
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        GetBalanceApiFailure(exception),
        stackTrace,
      );
    }
  }
}
