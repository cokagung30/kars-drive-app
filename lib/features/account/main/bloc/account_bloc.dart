import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    AuthRepository? repository,
  }) : _repository = repository ?? inject(),
       super(const AccountState()) {
    on<AccountLoggedOut>(_onAccountLoggedOut);
  }

  final AuthRepository _repository;

  Future<void> _onAccountLoggedOut(
    AccountLoggedOut _,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(logoutStatus: LoadStatus.loading));

    try {
      await _repository.logout();
      emit(state.copyWith(logoutStatus: LoadStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(logoutStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
