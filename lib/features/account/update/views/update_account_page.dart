import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/custom_app_bar.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class UpdateAccountPage extends StatelessWidget {
  const UpdateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;

    return BlocProvider(
      create: (_) => UpdateAccountBloc(
        userStatus: user?.status ?? false,
      )..add(const ProfileFetched()),
      child: const _UpdateAccountView(),
    );
  }
}

class _UpdateAccountView extends StatefulWidget {
  const _UpdateAccountView();

  @override
  State<_UpdateAccountView> createState() => __UpdateAccountViewState();
}

class __UpdateAccountViewState extends State<_UpdateAccountView> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _nameFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();

  final _phoneFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _nameFocusNode.addListener(() {
      final event = NameFocused(isFocus: _nameFocusNode.hasFocus);
      context.read<UpdateAccountBloc>().add(event);
    });

    _emailFocusNode.addListener(() {
      final event = EmailFocused(isFocus: _emailFocusNode.hasFocus);
      context.read<UpdateAccountBloc>().add(event);
    });

    _phoneFocusNode.addListener(() {
      final event = PhoneNumberFocused(isFocus: _phoneFocusNode.hasFocus);
      context.read<UpdateAccountBloc>().add(event);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Perbaharui Akun',
            titleStyle: textTheme.headlineLarge,
          ),
          backgroundColor: ColorName.cultured,
          body: BlocBuilder<UpdateAccountBloc, UpdateAccountState>(
            buildWhen: (p, c) => p.fetchStatus != c.fetchStatus,
            builder: (context, state) {
              final status = state.fetchStatus;

              if (status == LoadStatus.initial) return const SizedBox.shrink();

              if (status.isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (status.isError) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Center(
                    child: Text('Terjadi kesalahan, silahkan coba lagi!'),
                  ),
                );
              }

              _initializeController(state.profile);

              return UpdateAccountListener(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: UserAvatarInput(state.profile?.avatar),
                        ),
                        const SizedBox(height: 16),
                        NameTextField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                        ),
                        const SizedBox(height: 16),
                        EmailTextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                        ),
                        const SizedBox(height: 16),
                        PhoneTextField(
                          controller: _phoneController,
                          focusNode: _phoneFocusNode,
                        ),
                        const SizedBox(height: 24),
                        const SubmitButton(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _initializeController(Profile? profile) {
    if (profile != null) {
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _phoneController.text = profile.phone ?? '';
    }
  }
}
