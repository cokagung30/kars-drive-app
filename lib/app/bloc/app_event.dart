part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class UserChanged extends AppEvent {
  const UserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}

class SettingChanged extends AppEvent {
  const SettingChanged(this.setting);

  final Setting? setting;

  @override
  List<Object?> get props => [setting];
}
