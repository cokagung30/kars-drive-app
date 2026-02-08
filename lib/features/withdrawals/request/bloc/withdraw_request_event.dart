part of 'withdraw_request_bloc.dart';

abstract class WithdrawRequestEvent extends Equatable {
  const WithdrawRequestEvent();

  @override
  List<Object?> get props => [];
}

class BankListFetched extends WithdrawRequestEvent {
  const BankListFetched();
}

class BankDestinationChanged extends WithdrawRequestEvent {
  const BankDestinationChanged(this.destinationBank);

  final String destinationBank;

  @override
  List<Object?> get props => [destinationBank];
}

class AccountNumberChanged extends WithdrawRequestEvent {
  const AccountNumberChanged(this.accountNumber);

  final String accountNumber;

  @override
  List<Object?> get props => [accountNumber];
}

class AccountNumberFocused extends WithdrawRequestEvent {
  const AccountNumberFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class AccountNameChanged extends WithdrawRequestEvent {
  const AccountNameChanged(this.accountName);

  final String accountName;

  @override
  List<Object?> get props => [accountName];
}

class AccountNameFocused extends WithdrawRequestEvent {
  const AccountNameFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class AmountChanged extends WithdrawRequestEvent {
  const AmountChanged(this.amount);

  final String amount;

  @override
  List<Object?> get props => [amount];
}

class AmountFocused extends WithdrawRequestEvent {
  const AmountFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class DescriptionChanged extends WithdrawRequestEvent {
  const DescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class DescriptionFocused extends WithdrawRequestEvent {
  const DescriptionFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class FormSubmitted extends WithdrawRequestEvent {
  const FormSubmitted();
}

class WithdrawCanceled extends WithdrawRequestEvent {
  const WithdrawCanceled();
}
