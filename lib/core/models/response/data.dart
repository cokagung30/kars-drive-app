import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';

class Data<T> extends Equatable {
  const Data(this.data);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data<T>(
      json['data'] != null ? _Converter<T>().fromJson(json['data']) : null,
    );
  }

  final T? data;

  @override
  List<Object?> get props => [data];
}

class DataCollection<T> extends Equatable {
  const DataCollection(this.data);

  factory DataCollection.fromJson(Map<String, dynamic> json) {
    return DataCollection<T>(
      json['data'] != null
          ? (json['data'] as List<dynamic>)
                .map(_Converter<T>().fromJson)
                .toList()
          : null,
    );
  }

  final List<T>? data;

  @override
  List<Object?> get props => [data];
}

class _Converter<T> {
  const _Converter();

  T fromJson(Object? json) {
    if (json is Map) {
      final response = json as Map<String, dynamic>?;

      if (T == Auth) {
        return Auth.formJson(response!) as T;
      }

      if (T == Summary) {
        return Summary.fromJson(response!) as T;
      }

      if (T == Order) {
        return Order.fromJson(response!) as T;
      }

      if (T == Withdraw) {
        return Withdraw.fromJson(response!) as T;
      }

      if (T == WithdrawInfo) {
        return WithdrawInfo.fromJson(response!) as T;
      }

      if (T == Profile) {
        return Profile.fromJson(response!) as T;
      }

      if (T == Balance) {
        return Balance.fromJson(response!) as T;
      }

      if (T == NotificationMessage) {
        return NotificationMessage.fromJson(response!) as T;
      }
    }

    return json as T;
  }
}
