part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.summary,
    this.showEarningBalance = true,
    this.status = LoadStatus.initial,
  });

  final bool showEarningBalance;

  final Summary? summary;

  final LoadStatus status;

  DashboardState copyWith({
    bool? showEarningBalance,
    Summary? summary,
    LoadStatus? status,
  }) {
    return DashboardState(
      showEarningBalance: showEarningBalance ?? this.showEarningBalance,
      summary: summary ?? this.summary,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [showEarningBalance, summary, status];
}
