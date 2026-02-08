import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kars_driver_app/app/app.dart';
import 'package:kars_driver_app/bootstrap.dart';
import 'package:kars_driver_app/core/notification/notification.dart';
import 'package:kars_driver_app/core/storage/mapper/mapper.dart';
import 'package:kars_driver_app/core/storage/storage.dart';
import 'package:kars_driver_app/injection/injection.dart';
import 'package:logger/logger.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationClient.setupFlutterNotifications();
  await NotificationClient.displayNotifications(message);
}

void main() {
  bootstrap((sharedPreferences) async {
    final logger = Logger();

    final persistenStorage = PersistentStorage(
      sharedPreferences: sharedPreferences,
    );

    final tokenStorage = TokenStorage(storageConfig: persistenStorage);
    final userStorage = UserStorage(storageConfig: persistenStorage);
    final settingStorage = SettingStorage(storageConfig: persistenStorage);
    final notificationClient = NotificationClient(
      firebaseMessaging: FirebaseMessaging.instance,
      logger: logger,
    );

    await configureDependencies(
      userStorage: userStorage,
      tokenStorage: tokenStorage,
      settingStorage: settingStorage,
      notificationClient: notificationClient,
    );

    await notificationClient.init();
    await notificationClient.requestPermissions();
    // Aktifkan setup untuk foreground notifications
    await NotificationClient.setupFlutterNotifications();

    final user = await userStorage.fetchViewer().then((value) {
      return value?.toModel();
    });
    final setting = await settingStorage.fetchSetting().then((value) {
      return value?.toModel();
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    return App(user: user, setting: setting);
  });
}
