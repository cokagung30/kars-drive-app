part of 'withdrawls_bloc.dart';

abstract class WithdrawlsEvent extends Equatable {
  const WithdrawlsEvent();

  @override
  List<Object?> get props => [];
}

class WithdrawHistoryFetched extends WithdrawlsEvent {
  const WithdrawHistoryFetched();
}
