import 'package:dio/dio.dart';
import 'package:kars_driver_app/constant/constant.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/client/client.dart';
import 'package:kars_driver_app/core/storage/storage.dart';
import 'package:kars_driver_app/injection/injection.dart';

Future<dynamic> registerRemoteSourceInjection({
  required UserStorage userStorage,
  required TokenStorage tokenStorage,
}) async {
  inject
    ..registerFactory<Dio>(
      () => ApiClient.getInstance(
        Constants.baseUrl,
        tokenStorage.fetchToken,
        () async {
          await tokenStorage.clearToken();
          await userStorage.clearViewer();
        },
      ).dio,
    )
    ..registerSingleton<AuthApi>(AuthApi(inject()))
    ..registerSingleton<DashboardApi>(DashboardApi(inject()))
    ..registerSingleton<OrderApi>(OrderApi(inject()))
    ..registerSingleton<WithdrawApi>(WithdrawApi(inject()))
    ..registerSingleton<ProfileApi>(ProfileApi(inject()))
    ..registerSingleton<BalanceApi>(BalanceApi(inject()))
    ..registerSingleton<NotificationApi>(NotificationApi(inject()));
}
