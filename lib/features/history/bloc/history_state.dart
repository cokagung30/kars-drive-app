part of 'history_bloc.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.status = LoadStatus.initial,
    this.histories = const [],
  });

  final LoadStatus status;

  final List<Order> histories;

  HistoryState copyWith({
    LoadStatus? status,
    List<Order>? histories,
  }) {
    return HistoryState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
    );
  }

  @override
  List<Object?> get props => [status, histories];
}
