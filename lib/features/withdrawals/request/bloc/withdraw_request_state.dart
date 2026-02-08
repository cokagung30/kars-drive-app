part of 'withdraw_request_bloc.dart';

class WithdrawRequestState with FormzMixin, EquatableMixin {
  const WithdrawRequestState({
    this.banks = const [],
    this.accountNumber = const AccountNumberFormz.pure(),
    this.accountName = const AccountNameFormz.pure(),
    this.amount = const AmountFormz.pure(),
    this.destinationBank = const BankDestinationFormz.pure(),
    this.accountNameFocus = false,
    this.accountNumberFocus = false,
    this.amountFocus = false,
    this.descriptionFocus = false,
    this.fetchBankStatus = LoadStatus.initial,
    this.submitStatus = LoadStatus.initial,
    this.cancelStatus = LoadStatus.initial,
    this.balance = 0,
    this.description,
    this.errorMessage,
  });

  final List<Bank> banks;

  final num balance;

  final BankDestinationFormz destinationBank;

  final AccountNumberFormz accountNumber;

  final bool accountNumberFocus;

  final AccountNameFormz accountName;

  final bool accountNameFocus;

  final AmountFormz amount;

  final bool amountFocus;

  final String? description;

  final bool descriptionFocus;

  final LoadStatus fetchBankStatus;

  final LoadStatus submitStatus;

  final LoadStatus cancelStatus;

  final String? errorMessage;

  @override
  bool get isValid {
    final isAmountValid = amount.value != null && amount.value != 0;

    return destinationBank.value.isNotEmpty &&
        accountName.value.isNotEmpty &&
        accountNumber.value.isNotEmpty &&
        isAmountValid;
  }

  WithdrawRequestState copyWith({
    List<Bank>? banks,
    BankDestinationFormz? destinationBank,
    AccountNumberFormz? accountNumber,
    AccountNameFormz? accountName,
    AmountFormz? amount,
    String? description,
    bool? accountNumberFocus,
    bool? accountNameFocus,
    bool? amountFocus,
    bool? descriptionFocus,
    LoadStatus? fetchBankStatus,
    LoadStatus? submitStatus,
    LoadStatus? cancelStatus,
    num? balance,
    String? errorMessage,
  }) {
    return WithdrawRequestState(
      banks: banks ?? this.banks,
      destinationBank: destinationBank ?? this.destinationBank,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      fetchBankStatus: fetchBankStatus ?? this.fetchBankStatus,
      accountNameFocus: accountNameFocus ?? this.accountNameFocus,
      accountNumberFocus: accountNumberFocus ?? this.accountNumberFocus,
      amountFocus: amountFocus ?? this.amountFocus,
      descriptionFocus: descriptionFocus ?? this.descriptionFocus,
      submitStatus: submitStatus ?? this.submitStatus,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      balance: balance ?? this.balance,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    banks,
    accountNumber,
    accountName,
    amount,
    description,
    destinationBank,
    fetchBankStatus,
    accountNameFocus,
    accountNumberFocus,
    amountFocus,
    descriptionFocus,
    submitStatus,
    cancelStatus,
    balance,
    errorMessage,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
    destinationBank,
    accountName,
    accountNumber,
    amount,
  ];
}
