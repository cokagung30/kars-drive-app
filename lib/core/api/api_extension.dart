import 'package:dio/dio.dart';
import 'package:kars_driver_app/core/models/models.dart';

extension ApiExtension<T> on Dio {
  Future<Data<T>> getWithData<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    final service = get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: options,
    );

    return service.then((value) => Data<T>.fromJson(value.data!));
  }

  Future<DataCollection<T>> getWithDataCollection<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    final service = get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: options,
    );

    return service.then((value) => DataCollection<T>.fromJson(value.data!));
  }

  Future<Data<T>> postWithData<T>({
    required String path,
    Map<String, dynamic>? request,
  }) {
    final service = post<Map<String, dynamic>>(path, data: request);

    return service.then((value) => Data<T>.fromJson(value.data!));
  }

  Future<DataCollection<T>> postWithDataCollection<T>({
    required String path,
    Map<String, dynamic>? request,
  }) {
    final service = post<Map<String, dynamic>>(path, data: request);

    return service.then((value) => DataCollection<T>.fromJson(value.data!));
  }

  Future<Data<void>> postWithMultipartNullData({
    required String path,
    FormData? request,
  }) {
    return post<Map<String, dynamic>>(
      path,
      data: request,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    ).then<Data<void>>(
      (value) => Data<void>.fromJson(value.data!),
    );
  }
}
