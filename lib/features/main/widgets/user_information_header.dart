import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/core/models/user.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class UserInformationHeader extends StatelessWidget {
  const UserInformationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final user = context.select<AppBloc, User?>((value) => value.state.user);

    return Row(
      children: [
        const SizedBox(width: 20),
        Expanded(
          child: Row(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: AppUserAvatar(
                      imageUrl: user?.avatar,
                      size: 28,
                      borderColor: ColorName.atenoBlue,
                      borderThickness: 2,
                      borderRadius: 28,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: (user != null && user.status)
                            ? ColorName.greenSalem
                            : ColorName.candyRed,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Text(
                'Hi, ${user?.name ?? ''}!',
                style: textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        Row(
          spacing: 12,
          children: [
            _MenuItem(
              icon: SvgPicture.asset(
                Assets.icons.icNotification.path,
                width: 18,
                height: 18,
              ),
              label: 'Notifikasi',
              onTap: () => context.pushNamed('notification'),
            ),
            _MenuItem(
              icon: SvgPicture.asset(
                Assets.icons.icAccount.path,
                width: 18,
                height: 18,
              ),
              label: 'Akun',
              onTap: () => context.pushNamed('account'),
            ),
          ],
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;

  final String label;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(label, style: textTheme.labelSmall?.copyWith(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
