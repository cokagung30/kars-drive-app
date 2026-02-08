import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/features/withdrawals/main/withdrawals.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/injection/injection.dart';

class WithdrawalsPage extends StatelessWidget {
  const WithdrawalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WithdrawlsBloc()..add(const WithdrawHistoryFetched()),
      child: const _WithdrawalsView(),
    );
  }
}

class _WithdrawalsView extends StatefulWidget {
  const _WithdrawalsView();

  @override
  State<_WithdrawalsView> createState() => _WithdrawalsViewState();
}

class _WithdrawalsViewState extends State<_WithdrawalsView> {
  StreamSubscription<WithdrawEvent>? _withdrawEventSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final withdrawStreamEvent = inject<EventBus>().on<WithdrawEvent>();

    _withdrawEventSubscription ??= withdrawStreamEvent.listen((event) {
      if (mounted) {
        context.read<WithdrawlsBloc>().add(const WithdrawHistoryFetched());
      }
    });
  }

  @override
  void dispose() {
    _withdrawEventSubscription?.cancel();
    _withdrawEventSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: ColorName.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('Riwayat Penarikan', style: textTheme.headlineLarge),
            const SizedBox(height: 16),
            const Expanded(child: WithdrawList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('withdraw-request'),
        backgroundColor: ColorName.atenoBlue,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: SvgPicture.asset(
          Assets.icons.icPlus.path,
          height: 24,
        ),
      ),
    );
  }
}
