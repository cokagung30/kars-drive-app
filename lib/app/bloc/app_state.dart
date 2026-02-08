part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    required this.appStatus,
    required this.user,
    this.setting,
  });

  factory AppState.fromUser(User? user, Setting? setting) {
    if (user == null) {
      return AppState(
        appStatus: AppStatus.unauthenticated,
        user: user,
        setting: setting,
      );
    }

    return AppState(
      appStatus: AppStatus.authenticated,
      user: user,
      setting: setting,
    );
  }

  final AppStatus appStatus;

  final Setting? setting;

  final User? user;

  AppState copyWith({
    AppStatus? appStatus,
    User? user,
    Setting? setting,
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      user: user ?? this.user,
      setting: setting ?? this.setting,
    );
  }

  @override
  List<Object?> get props => [appStatus, user, setting];
}

enum AppStatus { authenticated, unauthenticated }
