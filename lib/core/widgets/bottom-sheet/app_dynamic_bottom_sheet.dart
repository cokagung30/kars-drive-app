import 'package:flutter/material.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AppDynamicBottomSheet extends StatelessWidget {
  const AppDynamicBottomSheet({
    required this.children,
    super.key,
    this.withScrollView = true,
    this.marginLeading = const EdgeInsets.all(16),
    this.titleStyle,
    this.title,
    this.leading,
    this.trailing,
  });

  final bool withScrollView;

  final EdgeInsets marginLeading;

  final List<Widget> children;

  final String? title;

  final TextStyle? titleStyle;

  final Widget? leading;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    final widget = Container(
      padding: EdgeInsets.only(bottom: bottom),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          ...children,
        ],
      ),
    );

    if (withScrollView) {
      return SafeArea(child: SingleChildScrollView(child: widget));
    }

    return SafeArea(child: widget);
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Center(
        child: Container(
          width: 69,
          height: 4,
          decoration: const BoxDecoration(
            color: ColorName.darkJungleBlue,
            borderRadius: BorderRadius.all(Radius.circular(69)),
          ),
        ),
      ),
    );
  }
}
