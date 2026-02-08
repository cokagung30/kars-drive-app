part of 'withdrawls_bloc.dart';

class WithdrawlsState extends Equatable {
  const WithdrawlsState({
    this.status = LoadStatus.initial,
    this.withdrawls = const <Withdraw>[],
  });

  final LoadStatus status;

  final List<Withdraw> withdrawls;

  WithdrawlsState copyWith({
    LoadStatus? status,
    List<Withdraw>? withdrawls,
  }) {
    return WithdrawlsState(
      status: status ?? this.status,
      withdrawls: withdrawls ?? this.withdrawls,
    );
  }

  @override
  List<Object?> get props => [status, withdrawls];
}
