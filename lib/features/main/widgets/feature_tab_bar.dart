import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/features/main/main.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class FeatureTabBar extends StatelessWidget {
  const FeatureTabBar(
    this.controller, {
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select<FeatureTabBarCubit, int>(
      (value) => value.state,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: FeatureTabEnum.values.map((e) {
          final index = FeatureTabEnum.values.indexOf(e);

          return Expanded(
            child: _TabBarItem(
              item: e,
              index: index,
              selectedIndex: currentIndex,
              onTap: (_, index) {
                navigationShell.goBranch(index);

                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.linear,
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
    required this.item,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  final FeatureTabEnum item;

  final int index;

  final int selectedIndex;

  final void Function(BuildContext context, int index) onTap;

  bool get _isSelected => index == selectedIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Material(
      color: _isSelected ? ColorName.atenoBlue : ColorName.white,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        onTap: () => onTap(context, index),
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(12),
          child: Center(
            child: Text(
              item.label,
              style: textTheme.labelLarge?.copyWith(
                color: _isSelected ? ColorName.white : ColorName.darkJungleBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
