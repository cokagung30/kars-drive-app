import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kars_driver_app/core/notification/notification_client_failure.dart';
import 'package:logger/logger.dart';

typedef OnMessage = void Function(Map<String, dynamic> message);

class NotificationClient {
  NotificationClient({
    required FirebaseMessaging firebaseMessaging,
    required Logger logger,
  }) : _firebaseMessaging = firebaseMessaging,
       _logger = logger;

  final FirebaseMessaging _firebaseMessaging;

  final Logger _logger;

  static final _localNotification = FlutterLocalNotificationsPlugin();

  static final _channel = AndroidNotificationChannel(
    'kars_driver_channel',
    'Kars Driver Channel Name',
    importance: Importance.max,
    vibrationPattern: Int64List.fromList([500, 1000, 500, 2000, 400, 1000]),
  );

  Future<String?> getFcmToken() async {
    try {
      final token = await _firebaseMessaging.getToken();

      _logger.d('FCM Token: $token');

      return token;
    } catch (error) {
      return null;
    }
  }

  Future<void> deleteFCMToken() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FCMDeleteTokenFailure(error),
        stackTrace,
      );
    }
  }

  // Tambahkan penampung callback untuk klik notifikasi
  static OnMessage? _onNotificationTap;

  // Ganti method menjadi setter
  static set onNotificationTap(OnMessage? callback) {
    _onNotificationTap = callback;
  }

  Future<void> init() async {
    await _localNotification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null && payload.isNotEmpty) {
          try {
            final data = jsonDecode(payload) as Map<String, dynamic>;
            _onNotificationTap?.call(data);
          } catch (_) {
            _logger.d('Payload JSON tidak valid');
          }
        }
      },
    );
  }

  static Future<void> setupFlutterNotifications() async {
    final channels = await _localNotification.getActiveNotifications();

    final generalChannel = channels.firstWhereOrNull(
      (element) => element.channelId == _channel.id,
    );

    if (generalChannel != null) return;

    await _androidNotificationPlugin()?.createNotificationChannel(_channel);

    final firebasInstance = FirebaseMessaging.instance;
    await firebasInstance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> handleMessageInteraction() async {
    _logger.d('Handling message interactions');

    await _localNotification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  Future<bool?> requestPermissions() async {
    try {
      if (Platform.isIOS) {
        return await _iosNotificationPlugin()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
      return _androidNotificationPlugin()?.requestNotificationsPermission();
    } on Exception catch (e, s) {
      _logger.e('Error requesting permissions', error: e, stackTrace: s);

      return false;
    }
  }

  static IOSFlutterLocalNotificationsPlugin? _iosNotificationPlugin() {
    return _localNotification.resolvePlatformSpecificImplementation();
  }

  static AndroidFlutterLocalNotificationsPlugin? _androidNotificationPlugin() {
    return _localNotification.resolvePlatformSpecificImplementation();
  }

  static Future<void> displayNotifications(RemoteMessage message) async {
    // Ambil dari data terlebih dahulu; fallback ke message.notification.*
    final data = message.data;
    final title = getValue(data, 'title') ?? message.notification?.title;
    final body = getValue(data, 'body') ?? message.notification?.body;
    final payload = jsonEncode(data);

    await _localNotification.show(
      _channel.hashCode,
      title,
      body,
      _notificaitonDetails(),
      payload: payload,
    );
  }

  static NotificationDetails _notificaitonDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        icon: 'mipmap/ic_launcher',
        channelDescription: _channel.description,
        priority: Priority.high,
        importance: Importance.max,
        vibrationPattern: Int64List.fromList([500, 1000, 500, 2000, 400, 1000]),
        showWhen: false,
      ),
      iOS: const DarwinNotificationDetails(
        threadIdentifier: 'thread_id',
      ),
    );
  }

  static Future<void> cancelNotificationSchedule() async {
    await _localNotification.cancelAll();
  }

  static String? getValue(Map<String, dynamic> json, String key) {
    if (json.containsKey(key) && json[key] is String) {
      return json[key] as String;
    }

    return null;
  }
}
