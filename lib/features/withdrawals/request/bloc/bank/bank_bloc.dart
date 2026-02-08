import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  BankBloc({required List<Bank> banks})
    : super(BankState(banks: banks, filteredBanks: banks)) {
    on<BankFiltered>(_onBankFiltered, transformer: debounce());
  }

  void _onBankFiltered(BankFiltered event, Emitter<BankState> emit) {
    if (event.query != null && event.query!.isNotEmpty) {
      final filteredBanks = state.banks.where(
        (bank) {
          return bank.name.toLowerCase().contains(
            event.query!.toLowerCase(),
          );
        },
      ).toList();
      emit(state.copyWith(filteredBanks: filteredBanks));
    } else {
      emit(state.copyWith(filteredBanks: state.banks));
    }
  }
}
