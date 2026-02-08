import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';

class WithdrawFailure extends Equatable {
  const WithdrawFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class FetchWithdrawHistoryFailure extends WithdrawFailure {
  const FetchWithdrawHistoryFailure(super.error);
}

class GetWithdrawInformationFailure extends WithdrawFailure {
  const GetWithdrawInformationFailure(super.error);
}

class RequestWithdrawFailure extends WithdrawFailure {
  const RequestWithdrawFailure(super.error);
}

class UpdateWithdrawFailure extends WithdrawFailure {
  const UpdateWithdrawFailure(super.error);
}

class CancelWithdrawFailure extends WithdrawFailure {
  const CancelWithdrawFailure(super.error);
}

class WithdrawRepository {
  WithdrawRepository({required WithdrawApi withdrawApi})
    : _withdrawApi = withdrawApi;

  final WithdrawApi _withdrawApi;

  Future<List<Withdraw>> getHistories() async {
    try {
      final histories = await _withdrawApi.histories().then(
        (value) => value.data ?? <Withdraw>[],
      );

      return histories;
    } on FetchHistoryOrderApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        FetchWithdrawHistoryFailure(error),
        stackTrace,
      );
    }
  }

  Future<dynamic> requestWithdraw({
    required num amount,
    required String bankCode,
    required String bankAccountNumber,
    required String bankAccountName,
    String? note,
  }) async {
    try {
      await _withdrawApi.request(
        amountRequest: amount,
        bankCode: bankCode,
        bankAccountName: bankAccountName,
        bankAccountNumber: bankAccountNumber,
        note: note,
      );
    } on RequestWithdrawApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        RequestWithdrawFailure(error),
        stackTrace,
      );
    }
  }

  Future<WithdrawInfo> getWithdrawInfo() async {
    try {
      final data = await _withdrawApi.withdrawInformation();

      return data;
    } on GetWithdrawInformationApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        GetWithdrawInformationFailure(error),
        stackTrace,
      );
    }
  }

  Future<dynamic> updateWithdraw({
    required String id,
    required num amount,
    required String bankCode,
    required String bankAccountNumber,
    required String bankAccountName,
    String? note,
  }) async {
    try {
      await _withdrawApi.update(
        id: id,
        amountRequest: amount,
        bankCode: bankCode,
        bankAccountName: bankAccountName,
        bankAccountNumber: bankAccountNumber,
        note: note,
      );
    } on UpdateWithdrawApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        UpdateWithdrawFailure(error),
        stackTrace,
      );
    }
  }

  Future<void> cancel(String sequenceId) async {
    try {
      await _withdrawApi.cancel(sequenceId);
    } on CancelWithdrawApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(CancelWithdrawFailure(error), stackTrace);
    }
  }
}
