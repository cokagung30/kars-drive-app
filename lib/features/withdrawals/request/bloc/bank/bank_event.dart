part of 'bank_bloc.dart';

abstract class BankEvent extends Equatable {
  const BankEvent();

  @override
  List<Object?> get props => [];
}

class BankFiltered extends BankEvent {
  const BankFiltered(this.query);

  final String? query;

  @override
  List<Object?> get props => [query];
}
