import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef TokenProvider = Future<String?> Function();

class ApiClient {
  factory ApiClient.getInstance(
    String baseUrl,
    TokenProvider tokenProvider,
    void Function() onUnAuthorized,
  ) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    dio.interceptors.add(
      CoreApiInterceptor(
        tokenProvider: tokenProvider,
        onUnAuthorized: onUnAuthorized,
      ),
    );

    const kReleaseMode = bool.fromEnvironment('dart.vm.product');

    const kProfileMode = bool.fromEnvironment('dart.vm.profile');

    if (!kReleaseMode && !kProfileMode) {
      dio.interceptors
        ..add(PrettyDioLogger(requestBody: true, requestHeader: true))
        ..add(CurlLoggerDioInterceptor(printOnSuccess: true));
    }

    dio.httpClientAdapter = HttpClientAdapter();

    return ApiClient._(dio);
  }

  ApiClient._(Dio dio) : _dio = dio;

  Dio get dio => _dio;

  final Dio _dio;
}

class CoreApiInterceptor extends InterceptorsWrapper {
  CoreApiInterceptor({
    required TokenProvider tokenProvider,
    required void Function() onUnAuthorized,
  }) : _tokenProvider = tokenProvider,
       _onAuthorized = onUnAuthorized;

  final TokenProvider _tokenProvider;

  final void Function() _onAuthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenProvider();

    if (token != null) {
      options.headers.addAll(<String, String>{
        'Authorization': 'Bearer $token',
      });
    }

    options.headers.addAll(<String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      _onAuthorized.call();
    }

    super.onError(err, handler);
  }
}
