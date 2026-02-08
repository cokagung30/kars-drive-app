part of 'bank_bloc.dart';

class BankState extends Equatable {
  const BankState({
    this.banks = const [],
    this.filteredBanks = const [],
  });

  final List<Bank> banks;

  final List<Bank> filteredBanks;

  BankState copyWith({
    List<Bank>? banks,
    List<Bank>? filteredBanks,
  }) {
    return BankState(
      banks: banks ?? this.banks,
      filteredBanks: filteredBanks ?? this.filteredBanks,
    );
  }

  @override
  List<Object?> get props => [banks, filteredBanks];
}
