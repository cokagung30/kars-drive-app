import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class OrderApiFailure with EquatableMixin implements Exception {
  OrderApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class GetDetailOrderApiFailure extends OrderApiFailure {
  GetDetailOrderApiFailure(super.error);
}

class FetchOrderOpenApiFailure extends OrderApiFailure {
  FetchOrderOpenApiFailure(super.error);
}

class PickOrderApiFailure extends OrderApiFailure {
  PickOrderApiFailure(super.error);
}

class FetchHistoryOrderApiFailure extends OrderApiFailure {
  FetchHistoryOrderApiFailure(super.error);
}

class FinishOrderApiFailure extends OrderApiFailure {
  FinishOrderApiFailure(super.error);
}

class OrderApi {
  OrderApi(this._dio);

  final Dio _dio;

  Future<Order> detail(String id) async {
    try {
      return await _dio
          .getWithData<Order>(path: 'bids/$id')
          .then((value) => value.data!);
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);
      throw Error.throwWithStackTrace(
        GetDetailOrderApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<DataCollection<Order>> orders(String? query) async {
    try {
      return await _dio.postWithDataCollection(
        path: 'bids',
        request: {
          'guest_name': query,
        }..removeWhere((value, _) => value.isEmpty),
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);
      throw Error.throwWithStackTrace(
        FetchOrderOpenApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> pickOrder(String id, String? note) async {
    try {
      return await _dio.postWithData<dynamic>(
        path: 'bids/pick-now/$id',
        request: {
          'note': note,
        }..removeWhere((value, _) => value.isEmpty),
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);
      throw Error.throwWithStackTrace(
        PickOrderApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<DataCollection<Order>> histories() async {
    try {
      return await _dio.getWithDataCollection<Order>(path: 'history');
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);
      throw Error.throwWithStackTrace(
        FetchHistoryOrderApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> finishOrder({
    required String id,
    required FinishOrderRequest request,
  }) async {
    try {
      await _dio.postWithMultipartNullData(
        path: 'bids/progress-update/$id',
        request: request.toFormData(),
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);
      throw Error.throwWithStackTrace(
        FinishOrderApiFailure(exception),
        stackTrace,
      );
    }
  }
}
