part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.logoutStatus = LoadStatus.initial});

  final LoadStatus logoutStatus;

  AccountState copyWith({LoadStatus? logoutStatus}) {
    return AccountState(logoutStatus: logoutStatus ?? this.logoutStatus);
  }

  @override
  List<Object?> get props => [logoutStatus];
}
