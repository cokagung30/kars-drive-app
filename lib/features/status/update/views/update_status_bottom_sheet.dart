import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/status/update/update_status.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showUpdateStatusBottomSheet(BuildContext context, {required bool status}) {
  return showAppBottomSheet(
    context,
    child: BlocProvider(
      create: (_) => UpdateStatusBloc(currentStatus: status),
      child: const UpdateStatusBottomSheet(),
    ),
  );
}

class UpdateStatusBottomSheet extends StatefulWidget {
  const UpdateStatusBottomSheet({super.key});

  @override
  State<UpdateStatusBottomSheet> createState() =>
      _UpdateStatusBottomSheetState();
}

class _UpdateStatusBottomSheetState extends State<UpdateStatusBottomSheet> {
  final _reasonController = TextEditingController();

  final _reasonFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _reasonFocusNode.addListener(() {
      final event = ReasonFocused(isFocused: _reasonFocusNode.hasFocus);
      context.read<UpdateStatusBloc>().add(event);
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _reasonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return UpdateStatusListener(
      child: AppDynamicBottomSheet(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Perbaharui Status Driver',
              style: textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Karena kamu ingin me-nonaktifkan status pengemudi anda, silahkan berikan alasan terbaikmu',
              style: textTheme.labelSmall?.copyWith(
                color: ColorName.romanSilver,
              ),
            ),
          ),
          ReasonTextField(
            controller: _reasonController,
            focusNode: _reasonFocusNode,
          ),
          const SubmitButton(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
