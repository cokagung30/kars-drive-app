import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';

class OrderFailure extends Equatable {
  const OrderFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class GetDetailOrderFailure extends OrderFailure {
  const GetDetailOrderFailure(super.error);
}

class FetchOrdersOpenFailure extends OrderFailure {
  const FetchOrdersOpenFailure(super.error);
}

class PickOrderFailure extends OrderFailure {
  const PickOrderFailure(super.error);
}

class FetchHistoryOrderFailure extends OrderFailure {
  const FetchHistoryOrderFailure(super.error);
}

class FinishOrderFailure extends OrderFailure {
  const FinishOrderFailure(super.error);
}

class OrderRepository {
  OrderRepository({required OrderApi orderApi}) : _orderApi = orderApi;

  final OrderApi _orderApi;

  Future<Order> getDetail(String id) {
    try {
      final order = _orderApi.detail(id);

      return order;
    } on GetDetailOrderApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(GetDetailOrderFailure(error), stackTrace);
    }
  }

  Future<List<Order>> fetchOrders(String? query) async {
    try {
      return await _orderApi.orders(query).then((value) => value.data ?? []);
    } on FetchOrderOpenApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        FetchOrdersOpenFailure(error),
        stackTrace,
      );
    }
  }

  Future<dynamic> pickOrder(String id, String? note) async {
    try {
      return await _orderApi.pickOrder(id, note);
    } on PickOrderApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        PickOrderFailure(error),
        stackTrace,
      );
    }
  }

  Future<List<Order>> fetchHistories() async {
    try {
      return await _orderApi.histories().then((value) => value.data ?? []);
    } on FetchHistoryOrderApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        FetchHistoryOrderFailure(error),
        stackTrace,
      );
    }
  }

  Future<void> finishOrder({
    required String id,
    required FinishOrderRequest request,
  }) async {
    try {
      await _orderApi.finishOrder(id: id, request: request);
    } on FinishOrderApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        FinishOrderFailure(error),
        stackTrace,
      );
    }
  }
}
