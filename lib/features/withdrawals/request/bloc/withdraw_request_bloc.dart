import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'withdraw_request_event.dart';
part 'withdraw_request_state.dart';

class WithdrawRequestBloc
    extends Bloc<WithdrawRequestEvent, WithdrawRequestState> {
  WithdrawRequestBloc({
    Withdraw? withdraw,
    WithdrawRepository? repository,
  }) : _repository = repository ?? inject(),
       _balanceRepository = inject(),
       _eventBus = inject(),
       _withdraw = withdraw,
       super(
         WithdrawRequestState(
           accountName: AccountNameFormz.pure(withdraw?.bankAccountName ?? ''),
           accountNumber: AccountNumberFormz.pure(
             withdraw?.bankAccountNumber ?? '',
           ),
           amount: AmountFormz.pure(value: withdraw?.amountRequest ?? 0),
           description: withdraw?.note,
         ),
       ) {
    on<BankListFetched>(_onBankListFetched);
    on<BankDestinationChanged>(_onBankDestinationChanged);
    on<AccountNameChanged>(_onAccountNameChanged);
    on<AccountNameFocused>(_onAccountNameFocused);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<AccountNumberFocused>(_onAccountNumberFocused);
    on<AmountChanged>(_onAmountChanged);
    on<AmountFocused>(_onAmountFocused);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<DescriptionFocused>(_onDescriptionFocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<WithdrawCanceled>(_onWithdrawCanceled);
  }

  final Withdraw? _withdraw;

  final BalanceRepository _balanceRepository;

  final WithdrawRepository _repository;

  final EventBus _eventBus;

  Future<void> _onBankListFetched(
    BankListFetched _,
    Emitter<WithdrawRequestState> emit,
  ) async {
    emit(state.copyWith(fetchBankStatus: LoadStatus.loading));

    try {
      final data = await Future.wait<dynamic>([
        _repository.getWithdrawInfo(),
        _balanceRepository.getBalance(),
      ]);

      final banks = (data[0] as WithdrawInfo).bankInfo.banks;

      if (_withdraw != null) {
        final bankSelect = banks
            .where(
              (bank) => bank.name == _withdraw.bankName,
            )
            .single;

        emit(
          state.copyWith(
            destinationBank: BankDestinationFormz.pure(bankSelect.code),
          ),
        );
      }

      emit(
        state.copyWith(
          banks: banks,
          balance: (data[1] as Balance).balance,
          fetchBankStatus: LoadStatus.success,
        ),
      );
    } on GetWithdrawInformationApiFailure catch (error, stackTrace) {
      emit(state.copyWith(fetchBankStatus: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(fetchBankStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }

  void _onBankDestinationChanged(
    BankDestinationChanged event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(
      state.copyWith(
        destinationBank: BankDestinationFormz.pure(event.destinationBank),
      ),
    );
  }

  void _onAccountNameChanged(
    AccountNameChanged event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(state.copyWith(accountName: AccountNameFormz.pure(event.accountName)));
  }

  void _onAccountNameFocused(
    AccountNameFocused event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(state.copyWith(accountNameFocus: event.hasFocus));
  }

  void _onAccountNumberChanged(
    AccountNumberChanged event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(
      state.copyWith(
        accountNumber: AccountNumberFormz.pure(event.accountNumber),
      ),
    );
  }

  void _onAccountNumberFocused(
    AccountNumberFocused event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(state.copyWith(accountNumberFocus: event.hasFocus));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(
      state.copyWith(
        amount: AmountFormz.pure(
          value: event.amount.isEmpty
              ? 0
              : num.parse(event.amount.replaceAll('.', '')),
        ),
      ),
    );
  }

  void _onAmountFocused(
    AmountFocused event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(state.copyWith(amountFocus: event.hasFocus));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onDescriptionFocused(
    DescriptionFocused event,
    Emitter<WithdrawRequestState> emit,
  ) {
    emit(state.copyWith(descriptionFocus: event.hasFocus));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<WithdrawRequestState> emit,
  ) async {
    final bankDestination = BankDestinationFormz.dirty(
      state.destinationBank.value,
    );
    final accountName = AccountNameFormz.dirty(state.accountName.value);
    final accountNumber = AccountNumberFormz.dirty(state.accountNumber.value);
    final amount = AmountFormz.dirty(
      value: state.amount.value ?? 0,
      lastBalance: state.balance,
    );
    final description = state.description;

    if (!state.isValid) {
      emit(
        state.copyWith(
          destinationBank: bankDestination,
          accountName: accountName,
          accountNumber: accountNumber,
          amount: amount,
          description: description,
        ),
      );

      return;
    }

    emit(state.copyWith(submitStatus: LoadStatus.loading));

    try {
      final bankDestinationName = state.banks
          .where((bank) => bank.code == bankDestination.value)
          .first;

      if (_withdraw != null) {
        await _repository.updateWithdraw(
          id: _withdraw.id,
          amount: amount.value!,
          bankCode: bankDestinationName.bankStringCode,
          bankAccountNumber: accountNumber.value,
          bankAccountName: accountName.value,
          note: description,
        );
      } else {
        await _repository.requestWithdraw(
          amount: amount.value!,
          bankCode: bankDestinationName.bankStringCode,
          bankAccountNumber: accountNumber.value,
          bankAccountName: accountName.value,
          note: description,
        );
      }

      _eventBus.fire(const WithdrawEvent());

      emit(state.copyWith(submitStatus: LoadStatus.success));
    } on RequestWithdrawApiFailure catch (error, stackTrace) {
      emit(
        state.copyWith(
          submitStatus: LoadStatus.error,
          errorMessage: error.error.entity?.message,
        ),
      );
      addError(error, stackTrace);
    } on UpdateWithdrawApiFailure catch (error, stackTrace) {
      emit(
        state.copyWith(
          submitStatus: LoadStatus.error,
          errorMessage: error.error.entity?.message,
        ),
      );
      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));
      addError(error, stackTrace);
    }
  }

  Future<void> _onWithdrawCanceled(
    WithdrawCanceled _,
    Emitter<WithdrawRequestState> emit,
  ) async {
    if (_withdraw == null) return;

    emit(state.copyWith(cancelStatus: LoadStatus.loading));

    try {
      await _repository.cancel(_withdraw.id);

      emit(state.copyWith(cancelStatus: LoadStatus.success));
      _eventBus.fire(const WithdrawEvent());
    } catch (error, stackTrace) {
      emit(state.copyWith(cancelStatus: LoadStatus.error));
      addError(error, stackTrace);
    }
  }
}
