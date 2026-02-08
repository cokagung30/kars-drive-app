import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class OrderUpdatePage extends StatelessWidget {
  const OrderUpdatePage({required this.extra, super.key});

  final OrderUpdateExtra extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderUpdateBloc(
        orderId: extra.orderId,
        status: extra.status,
      ),
      child: const _OrderUpdateView(),
    );
  }
}

class _OrderUpdateView extends StatefulWidget {
  const _OrderUpdateView();

  @override
  State<_OrderUpdateView> createState() => __OrderUpdateViewState();
}

class __OrderUpdateViewState extends State<_OrderUpdateView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: FinishOrderListener(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            appBar: CustomAppBar(
              title: 'Perbaharui Progress Pesanan',
              titleStyle: textTheme.headlineLarge,
            ),
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 18),
                  FirstPhotoProofField(),
                  SizedBox(height: 16),
                  SecondPhotoProofField(),
                  SizedBox(height: 24),
                  SubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
