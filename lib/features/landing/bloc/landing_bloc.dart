import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'landing_event.dart';

class LandingBloc extends Bloc<LandingEvent, bool> {
  LandingBloc({SettingRepository? settingRepository})
    : _settingRepository = settingRepository ?? inject(),
      super(false) {
    on<IntroDoneSaved>(_onIntroDoneSaved);
  }

  final SettingRepository _settingRepository;

  Future<void> _onIntroDoneSaved(IntroDoneSaved _, Emitter<bool> emit) async {
    const setting = Setting(isIntroDone: true);

    await _settingRepository.saveSetting(setting);

    emit(true);
  }
}
