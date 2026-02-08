import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/main/account.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountBloc(),
      child: const _AccountView(),
    );
  }
}

class _AccountView extends StatelessWidget {
  const _AccountView();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AccountListener(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Akun',
              titleStyle: textTheme.headlineLarge,
            ),
            backgroundColor: ColorName.cultured,
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                spacing: 12,
                children: [
                  UserInformationSection(),
                  FeatureSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
