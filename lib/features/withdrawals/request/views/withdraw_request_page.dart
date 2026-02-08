import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class WithdrawRequestPage extends StatelessWidget {
  const WithdrawRequestPage({super.key, this.extra});

  final Withdraw? extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = WithdrawRequestBloc(withdraw: extra);

        bloc.add(const BankListFetched());

        return bloc;
      },
      child: _WithdrawRequestView(extra),
    );
  }
}

class _WithdrawRequestView extends StatefulWidget {
  const _WithdrawRequestView(this.extra);

  final Withdraw? extra;

  @override
  State<_WithdrawRequestView> createState() => __WithdrawRequestViewState();
}

class __WithdrawRequestViewState extends State<_WithdrawRequestView> {
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final _accountNameFocusNode = FocusNode();
  final _accountNumberFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _noteFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _accountNameController.text = widget.extra?.bankAccountName ?? '';
    _accountNumberController.text = widget.extra?.bankAccountNumber ?? '';
    _amountController.text = (widget.extra?.amountRequest).formatCurrency;
    _noteController.text = widget.extra?.note ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _accountNameFocusNode.addListener(() {
      final event = AccountNameFocused(
        hasFocus: _accountNameFocusNode.hasFocus,
      );

      context.read<WithdrawRequestBloc>().add(event);
    });

    _accountNumberFocusNode.addListener(() {
      final event = AccountNumberFocused(
        hasFocus: _accountNumberFocusNode.hasFocus,
      );
      context.read<WithdrawRequestBloc>().add(event);
    });

    _amountFocusNode.addListener(() {
      final event = AmountFocused(hasFocus: _amountFocusNode.hasFocus);
      context.read<WithdrawRequestBloc>().add(event);
    });

    _noteFocusNode.addListener(() {
      final event = DescriptionFocused(hasFocus: _noteFocusNode.hasFocus);
      context.read<WithdrawRequestBloc>().add(event);
    });
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _accountNameFocusNode.dispose();
    _accountNumberFocusNode.dispose();
    _amountFocusNode.dispose();
    _noteFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: ColorName.cultured,
          appBar: CustomAppBar(
            title: 'Formulir Penarikan',
            titleStyle: textTheme.headlineLarge,
          ),
          body: BlocBuilder<WithdrawRequestBloc, WithdrawRequestState>(
            buildWhen: (p, c) => p.fetchBankStatus != c.fetchBankStatus,
            builder: (context, state) {
              if (state.fetchBankStatus == LoadStatus.initial) {
                return const SizedBox.shrink();
              }

              if (state.fetchBankStatus.isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorName.atenoBlue,
                    ),
                  ),
                );
              }

              return WithdrawRequestListener(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  children: [
                    BankSelectField(state.banks),
                    const SizedBox(height: 16),
                    AccountNumberTextField(
                      controller: _accountNumberController,
                      focusNode: _accountNumberFocusNode,
                    ),
                    const SizedBox(height: 16),
                    AccountNameTextField(
                      controller: _accountNameController,
                      focusNode: _accountNameFocusNode,
                    ),
                    const SizedBox(height: 16),
                    AmountTextField(
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                    ),
                    const SizedBox(height: 16),
                    NoteTextField(
                      controller: _noteController,
                      focusNode: _noteFocusNode,
                    ),
                    const SizedBox(height: 24),
                    const _SubmitErrorMessage(),
                    const SubmitButton(),
                    if (widget.extra != null) ...[
                      const CancelButton(),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SubmitErrorMessage extends StatelessWidget {
  const _SubmitErrorMessage();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final errorMessage = context.select<WithdrawRequestBloc, String?>(
      (value) => value.state.errorMessage,
    );

    final submitStatus = context.select<WithdrawRequestBloc, LoadStatus>(
      (value) => value.state.submitStatus,
    );

    return ConditionWidget(
      isFirstCondition: submitStatus == LoadStatus.error,
      firstChild: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          errorMessage ?? 'Terjadi kesalahan, silahkan coba lagi',
          style: textTheme.labelSmall?.copyWith(color: ColorName.candyRed),
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
