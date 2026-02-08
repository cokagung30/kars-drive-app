import 'package:flutter/widgets.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/bid/bid_order.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showBidOrderBottomSheet(
  BuildContext context,
  void Function(String) onTap,
) {
  return showAppBottomSheet(
    context,
    child: _BidOrderBottomSheet(
      onTap: (value) => onTap(value),
    ),
  );
}

class _BidOrderBottomSheet extends StatefulWidget {
  const _BidOrderBottomSheet({required this.onTap});

  final void Function(String) onTap;

  @override
  State<_BidOrderBottomSheet> createState() => __BidOrderBottomSheetState();
}

class __BidOrderBottomSheetState extends State<_BidOrderBottomSheet> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppDynamicBottomSheet(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Konfirmasi Ambil Pesanan',
            style: textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sebelum anda mengambil pesanan ini, silahkan berikan pesan kepada penumpang yang perlu diketahui.',
            style: textTheme.labelSmall?.copyWith(color: ColorName.romanSilver),
          ),
        ),
        NoteTextField(_noteController),
        SubmitButton(onTap: () => widget.onTap(_noteController.text)),
        const SizedBox(height: 12),
      ],
    );
  }
}
