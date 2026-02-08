import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showBankSelectBottomSheet(
  BuildContext context, {
  required List<Bank> banks,
  required void Function(Bank) onTap,
  required String? bankSelected,
}) {
  return showAppBottomSheet(
    context,
    child: BlocProvider(
      create: (_) => BankBloc(banks: banks),
      child: _BankSelectView(onTap: onTap, bankSelected: bankSelected),
    ),
  );
}

class _BankSelectView extends StatefulWidget {
  const _BankSelectView({required this.onTap, this.bankSelected});

  final String? bankSelected;

  final void Function(Bank) onTap;

  @override
  State<_BankSelectView> createState() => __BankSelectViewState();
}

class __BankSelectViewState extends State<_BankSelectView> {
  final _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDynamicBottomSheet(
      children: [
        SearchTextField(
          controller: _searchTextController,
          onChange: (text) {
            final event = BankFiltered(text);
            context.read<BankBloc>().add(event);
          },
        ),
        const SizedBox(height: 16),
        _BankOptions(
          bankSelected: widget.bankSelected,
          onTap: (bank) => widget.onTap(bank),
        ),
      ],
    );
  }
}

class _BankOptions extends StatelessWidget {
  const _BankOptions({required this.onTap, this.bankSelected});

  final void Function(Bank) onTap;

  final String? bankSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final bankOptions = context.select<BankBloc, List<Bank>>(
      (value) => value.state.filteredBanks,
    );

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: bankOptions.length,
        itemBuilder: (_, index) {
          final bank = bankOptions[index];

          return Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => onTap(bank),
              splashColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(bank.name, style: textTheme.labelSmall),
                        ),
                        ConditionWidget(
                          isFirstCondition:
                              bankSelected != null && bank.code == bankSelected,
                          firstChild: SvgPicture.asset(
                            Assets.icons.icChecked.path,
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              ColorName.atenoBlue,
                              BlendMode.srcIn,
                            ),
                          ),
                          secondChild: const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: ColorName.platinum,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
