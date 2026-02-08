import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/app/app_bloc_observer.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef AppBuilder =
    Future<Widget> Function(
      SharedPreferences sharedPreferences,
    );

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id');

  await Jiffy.setLocale('id');

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Color(0x00000000),
    ),
  );

  Intl.systemLocale = 'id';

  final sharedPreferences = await SharedPreferences.getInstance();
  final logger = Logger();
  final blocObserver = AppBlocObserver(logger: logger);

  Bloc.observer = blocObserver;

  runApp(await builder(sharedPreferences));
}
