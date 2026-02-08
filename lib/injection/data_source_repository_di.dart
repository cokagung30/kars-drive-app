import 'package:kars_driver_app/core/notification/notification.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/storage/storage.dart';
import 'package:kars_driver_app/injection/injection.dart';

Future<dynamic> registerRepositorySoruceInjection({
  required UserStorage userStorage,
  required TokenStorage tokenStorage,
  required SettingStorage settingStorage,
  required NotificationClient notificationClient,
}) async {
  inject
    ..registerSingleton<AuthRepository>(
      AuthRepository(
        authApi: inject(),
        userStorage: userStorage,
        tokenStorage: tokenStorage,
        notificationClient: notificationClient,
      ),
    )
    ..registerSingleton<SettingRepository>(
      SettingRepository(settingStorage: settingStorage),
    )
    ..registerSingleton<UserRepository>(
      UserRepository(userStorage: userStorage),
    )
    ..registerSingleton<DashboardRepository>(
      DashboardRepository(dashboardApi: inject()),
    )
    ..registerSingleton<OrderRepository>(OrderRepository(orderApi: inject()))
    ..registerSingleton<WithdrawRepository>(
      WithdrawRepository(withdrawApi: inject()),
    )
    ..registerSingleton<ProfileRepository>(
      ProfileRepository(profileApi: inject(), userStorage: userStorage),
    )
    ..registerSingleton<BalanceRepository>(
      BalanceRepository(balanceApi: inject()),
    )
    ..registerSingleton<NotificationRepository>(
      NotificationRepository(notificationApi: inject()),
    );
}
