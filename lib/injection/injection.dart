import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:kars_driver_app/core/notification/notification.dart';
import 'package:kars_driver_app/core/storage/storage.dart';
import 'package:kars_driver_app/injection/data_source_api_di.dart';
import 'package:kars_driver_app/injection/data_source_repository_di.dart';

final GetIt inject = GetIt.instance;

Future<dynamic> configureDependencies({
  required UserStorage userStorage,
  required TokenStorage tokenStorage,
  required SettingStorage settingStorage,
  required NotificationClient notificationClient,
}) async {
  await registerRemoteSourceInjection(
    userStorage: userStorage,
    tokenStorage: tokenStorage,
  );

  await registerRepositorySoruceInjection(
    userStorage: userStorage,
    tokenStorage: tokenStorage,
    settingStorage: settingStorage,
    notificationClient: notificationClient,
  );

  inject.registerSingleton(EventBus());
}
