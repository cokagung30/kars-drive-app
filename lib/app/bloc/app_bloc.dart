import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required User? user,
    required Setting? setting,
    SettingRepository? settingRepository,
    UserRepository? userRepository,
  }) : _settingRepository = settingRepository ?? inject(),
       _userRepository = userRepository ?? inject(),
       super(AppState.fromUser(user, setting)) {
    on<UserChanged>(_onUserChanged);
    on<SettingChanged>(_onSettingChanged);

    _userSubscription = _userRepository.user.listen(_userChanged);
    _settingSubscription = _settingRepository.setting.listen(_settingChanged);
  }

  late StreamSubscription<User?> _userSubscription;

  late StreamSubscription<Setting?> _settingSubscription;

  final UserRepository _userRepository;

  final SettingRepository _settingRepository;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _settingSubscription.cancel();

    return super.close();
  }

  void _userChanged(User? user) => add(UserChanged(user));

  void _settingChanged(Setting? setting) => add(SettingChanged(setting));

  void _onUserChanged(UserChanged event, Emitter<AppState> emit) {
    emit(AppState.fromUser(event.user, state.setting));
  }

  void _onSettingChanged(SettingChanged event, Emitter<AppState> emit) {
    emit(AppState.fromUser(state.user, event.setting));
  }
}
