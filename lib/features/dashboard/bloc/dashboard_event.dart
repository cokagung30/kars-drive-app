part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class ShowEarningBalanceChanged extends DashboardEvent {
  const ShowEarningBalanceChanged();
}

class SummaryFetched extends DashboardEvent {
  const SummaryFetched();
}
