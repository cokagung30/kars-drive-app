import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/condition_widget.dart';
import 'package:kars_driver_app/features/account/main/account.dart';
import 'package:kars_driver_app/features/status/update/update_status.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FeatureItem(
          iconLeading: Assets.icons.icNoteOutlined.path,
          title: 'Perbaharui Akun',
          borderTopRadius: 8,
          onTap: () => context.pushNamed('update-account'),
        ),
        const _FeatureDivider(),
        _FeatureItem(
          iconLeading: Assets.icons.icKey.path,
          title: 'Perbaharui Kata Sandi',
          onTap: () => context.pushNamed('update-password'),
        ),
        const _FeatureDivider(),
        const _StatusDriverSection(),
        const _FeatureDivider(),
        _FeatureItem(
          iconLeading: Assets.icons.icHistory.path,
          title: 'Riwayat Pengajuan',
          onTap: () => context.pushNamed('history'),
        ),
        const _FeatureDivider(),
        _FeatureItem(
          title: 'Keluar',
          titleColor: ColorName.candyRed,
          borderBottomRadius: 8,
          onTap: () {
            showLogoutDialog(
              context,
              onLogoutTap: () {
                context.read<AccountBloc>().add(const AccountLoggedOut());
              },
            );
          },
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.title,
    this.titleColor,
    this.prefix,
    this.onTap,
    this.iconLeading = '',
    this.borderTopRadius = 0,
    this.borderBottomRadius = 0,
  });

  final String title;

  final Color? titleColor;

  final String iconLeading;

  final Widget? prefix;

  final double borderTopRadius;

  final double borderBottomRadius;

  final GestureTapCallback? onTap;

  BorderRadius get borderRadius => BorderRadius.only(
    topLeft: Radius.circular(borderTopRadius),
    topRight: Radius.circular(borderTopRadius),
    bottomLeft: Radius.circular(borderBottomRadius),
    bottomRight: Radius.circular(borderBottomRadius),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        borderRadius: borderRadius,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Row(
            children: [
              ConditionWidget(
                isFirstCondition: iconLeading.isNotEmpty,
                firstChild: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SvgPicture.asset(
                    iconLeading,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      ColorName.darkJungleBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
              ),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    color: titleColor ?? ColorName.darkJungleBlue,
                  ),
                ),
              ),
              if (prefix != null) prefix!,
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureDivider extends StatelessWidget {
  const _FeatureDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: ColorName.platinum, height: 0),
    );
  }
}

class _StatusDriverSection extends StatelessWidget {
  const _StatusDriverSection();

  @override
  Widget build(BuildContext context) {
    final user = context.select<AppBloc, User?>((value) => value.state.user);

    return _FeatureItem(
      title: 'Status Driver',
      prefix: SizedBox(
        width: 38,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Switch(
            value: user?.status ?? false,
            activeTrackColor: ColorName.atenoBlue,
            inactiveTrackColor: ColorName.quickSilver,
            onChanged: (_) => showUpdateStatusBottomSheet(
              context,
              status: user?.status ?? false,
            ),
          ),
        ),
      ),
    );
  }
}
