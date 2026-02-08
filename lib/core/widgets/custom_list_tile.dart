import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.titleWidget,
    this.titleTrailingWidget,
    this.leadingWidget,
    this.margin,
    this.onTap,
    this.subtitle,
    this.subtitleWidget,
    this.subtitleStyle,
    this.titleStyle,
    this.trailingWidget,
    this.leftDividerWidth = 16,
    this.rightDividerWidth = 16,
    this.leadingSpace = 16,
    this.topDividerWidth = 0,
    this.bottomDividerWidth = 0,
    this.space = 4,
    this.splashRadius = 0,
    this.showDivider = true,
    this.dividerAfterTitle = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.contentAlignment = CrossAxisAlignment.center,
  });

  final bool showDivider;

  final double leftDividerWidth;

  final double rightDividerWidth;

  final double topDividerWidth;

  final double bottomDividerWidth;

  final double space;

  final double splashRadius;

  final double leadingSpace;

  final String? title;

  final String? subtitle;

  final Widget? titleWidget;

  final Widget? titleTrailingWidget;

  final Widget? leadingWidget;

  final Widget? trailingWidget;

  final Widget? subtitleWidget;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final GestureTapCallback? onTap;

  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  final bool dividerAfterTitle;

  final CrossAxisAlignment contentAlignment;

  bool get showLeading => leadingWidget != null;

  bool get showTrailing => trailingWidget != null;

  bool get showSubtitle => subtitleWidget != null || subtitle != null;

  Widget _buildLeading() {
    return Padding(
      padding: EdgeInsets.only(right: leadingSpace),
      child: leadingWidget,
    );
  }

  Widget _buildTrailing() {
    return trailingWidget!;
  }

  Widget _buildTitle() {
    if (titleWidget == null && title == null) {
      return const SizedBox.shrink();
    }

    if (titleWidget != null) {
      return titleWidget!;
    }

    return Row(
      children: [
        Flexible(
          child: Text(
            title!,
            style: titleStyle ?? const TextStyle(fontSize: 16),
          ),
        ),
        if (titleTrailingWidget != null) ...[
          const SizedBox(width: 4),
          titleTrailingWidget!,
        ],
      ],
    );
  }

  Widget _buildSubtitle() {
    if (subtitleWidget != null) {
      return subtitleWidget!;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        subtitle!,
        style:
            subtitleStyle ??
            const TextStyle(
              fontSize: 14,
              height: 1.6,
            ),
      ),
    );
  }

  Widget _buildDivider() {
    if (!showDivider) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(
        left: leftDividerWidth,
        right: rightDividerWidth,
        top: topDividerWidth,
        bottom: bottomDividerWidth,
      ),
      child: const CustomDivider(
        top: 4,
        thickness: 1,
        color: ColorName.platinum,
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(height: space);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(splashRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(splashRadius),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(splashRadius),
                ),
              ),
              margin: margin,
              padding: padding,
              child: Row(
                crossAxisAlignment: contentAlignment,
                children: [
                  if (showLeading) _buildLeading(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(),
                        if (showSubtitle) _buildSpace(),
                        if (showSubtitle) _buildSubtitle(),
                      ],
                    ),
                  ),
                  if (showTrailing) const SizedBox(width: 12),
                  if (showTrailing) _buildTrailing(),
                ],
              ),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }
}
