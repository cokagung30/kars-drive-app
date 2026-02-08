import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class UserInformationSection extends StatelessWidget {
  const UserInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final user = context.select<AppBloc, User?>((value) => value.state.user);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppUserAvatar(
                imageUrl: user?.avatar,
                size: 30,
                borderColor: ColorName.atenoBlue,
                borderThickness: 2,
                borderRadius: 30,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? '-',
                  style: textTheme.bodyLarge?.copyWith(
                    color: ColorName.atenoBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '-',
                  style: textTheme.labelSmall,
                ),
                const SizedBox(height: 8),
                ConditionWidget(
                  isFirstCondition: user?.phone == null,
                  firstChild: const SizedBox.shrink(),
                  secondChild: Text(
                    '087853389379',
                    style: textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: ColorName.romanSilver,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
