import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class DahsboardApiFailure with EquatableMixin implements Exception {
  const DahsboardApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class FetchSummaryApiFailure extends DahsboardApiFailure {
  FetchSummaryApiFailure(super.error);
}

class DashboardApi {
  DashboardApi(this._dio);

  final Dio _dio;

  Future<Summary> summary() async {
    try {
      return await _dio
          .getWithData<Summary>(path: 'dashboard')
          .then((value) => value.data!);
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);
      throw Error.throwWithStackTrace(
        FetchSummaryApiFailure(exception),
        stackTrace,
      );
    }
  }
}
