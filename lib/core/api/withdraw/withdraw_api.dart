import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class WithdrawApiFailure with EquatableMixin implements Exception {
  WithdrawApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class FetchWithdrawHistoryApiFailure extends WithdrawApiFailure {
  FetchWithdrawHistoryApiFailure(super.error);
}

class GetWithdrawInformationApiFailure extends WithdrawApiFailure {
  GetWithdrawInformationApiFailure(super.error);
}

class CancelWithdrawApiFailure extends WithdrawApiFailure {
  CancelWithdrawApiFailure(super.error);
}

class RequestWithdrawApiFailure extends WithdrawApiFailure {
  RequestWithdrawApiFailure(super.error);
}

class UpdateWithdrawApiFailure extends WithdrawApiFailure {
  UpdateWithdrawApiFailure(super.error);
}

class WithdrawApi {
  WithdrawApi(this._dio);

  final Dio _dio;

  Future<DataCollection<Withdraw>> histories() async {
    try {
      return await _dio.getWithDataCollection(path: 'withdraw/history');
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        FetchWithdrawHistoryApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> request({
    required num amountRequest,
    required String bankCode,
    required String bankAccountNumber,
    required String bankAccountName,
    String? note,
  }) async {
    try {
      return await _dio.postWithData<dynamic>(
        path: 'withdraw/store',
        request: {
          'amount_request': amountRequest,
          'bank_code': bankCode,
          'bank_account_number': bankAccountNumber,
          'bank_account_name': bankAccountName,
          'note': note,
        }..removeWhere((value, _) => value.isEmpty),
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        RequestWithdrawApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<WithdrawInfo> withdrawInformation() async {
    try {
      return await _dio
          .getWithData<WithdrawInfo>(path: 'payment')
          .then((value) => value.data!);
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        GetWithdrawInformationApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> update({
    required String id,
    required num amountRequest,
    required String bankCode,
    required String bankAccountNumber,
    required String bankAccountName,
    String? note,
  }) async {
    try {
      return await _dio.postWithData<dynamic>(
        path: 'withdraw/update/$id',
        request: {
          'amount_request': amountRequest,
          'bank_code': bankCode,
          'bank_account_number': bankAccountNumber,
          'bank_account_name': bankAccountName,
          'note': note,
        }..removeWhere((value, _) => value.isEmpty),
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        UpdateWithdrawApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<void> cancel(String sequenceId) async {
    try {
      await _dio.getWithData<dynamic>(path: 'withdraw/cancel/$sequenceId');
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        CancelWithdrawApiFailure(exception),
        stackTrace,
      );
    }
  }
}
