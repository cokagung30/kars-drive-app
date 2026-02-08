import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/theme/theme.dart';
import 'package:kars_driver_app/core/widgets/condition_widget.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AppTextField<T> extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.obscureCharacter,
    this.enableBorderColor,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.counterWidget,
    this.hintColor,
    this.focusNode,
    this.keyboardType,
    this.fontWeightSubtitle,
    this.onTap,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.inputTextStyle,
    this.hintTextStyle,
    this.contentPadding,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.errorText,
    this.initialValue,
    this.focusBorderColor,
    this.fillColor,
    this.enableInteractiveSelection,
    this.textInputAction,
    this.labelTextStyle,
    this.textAlign = TextAlign.start,
    this.obscure = false,
    this.isReadOnly = false,
    this.autoFocus = false,
    this.isFocused = false,
    this.hasValidationSymbol = false,
    this.theme = AppInputDecorationStyle.normal,
    this.maxLine = 1,
    this.autofills,
  });

  final InputDecorationTheme theme;

  final TextEditingController? controller;

  final String? initialValue;

  final String? labelText;

  final String? hintText;

  final String? obscureCharacter;

  final bool obscure;

  final bool isReadOnly;

  final bool autoFocus;

  final bool isFocused;

  final bool? enableInteractiveSelection;

  final bool hasValidationSymbol;

  final Color? fillColor;

  final Color? hintColor;

  final Color? enableBorderColor;

  final Color? focusBorderColor;

  final BoxConstraints? prefixIconConstraints;

  final BoxConstraints? suffixIconConstraints;

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final Widget? counterWidget;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final FontWeight? fontWeightSubtitle;

  final FocusNode? focusNode;

  final GestureTapCallback? onTap;

  final TextAlign textAlign;

  final List<TextInputFormatter>? inputFormatters;

  final EdgeInsets? contentPadding;

  final TextStyle? labelTextStyle;

  final TextStyle? inputTextStyle;

  final TextStyle? hintTextStyle;

  final ValueChanged<String>? onChanged;

  final FormFieldValidator<String>? validator;

  final int? maxLine;

  final int? maxLength;

  final String? errorText;

  final Iterable<String>? autofills;

  bool get _hasBoxShadow {
    return isFocused || errorText != null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final focusedBorder = focusBorderColor != null
        ? theme.focusedBorder!.copyWith(
            borderSide: BorderSide(color: focusBorderColor!),
          )
        : theme.focusedBorder;

    final enabledBorder = enableBorderColor == null
        ? theme.enabledBorder
        : theme.enabledBorder!.copyWith(
            borderSide: BorderSide(color: enableBorderColor!),
          );

    final border = enabledBorder != null
        ? theme.border!.copyWith(
            borderSide: BorderSide(color: enableBorderColor!),
          )
        : theme.border;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: labelText,
                    style: labelTextStyle ?? textTheme.bodyMedium,
                  ),
                  if (hasValidationSymbol)
                    TextSpan(
                      text: ' *',
                      style: textTheme.bodyMedium?.copyWith(
                        color: ColorName.candyRed,
                      ),
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: _hasBoxShadow
                    ? [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 2,
                          color: errorText != null
                              ? ColorName.candyRed.withValues(alpha: 0.15)
                              : ColorName.quickSilver.withValues(alpha: 0.15),
                        ),
                      ]
                    : null,
              ),
              child: TextField(
                autofillHints: autofills,
                controller: controller,
                focusNode: focusNode,
                autofocus: autoFocus,
                keyboardType: keyboardType,
                obscureText: obscure,
                magnifierConfiguration: TextMagnifierConfiguration.disabled,
                textInputAction: textInputAction ?? TextInputAction.next,
                textAlign: textAlign,
                enableInteractiveSelection: true,
                readOnly: isReadOnly,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                style: inputTextStyle ?? textTheme.bodyMedium,
                maxLength: maxLength,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: fillColor ?? theme.fillColor,
                  filled: theme.fillColor != null,
                  hintText: hintText,
                  suffixIcon: suffixIcon,
                  prefixIconConstraints: prefixIconConstraints,
                  suffixIconConstraints: suffixIconConstraints,
                  prefixIcon: prefixIcon,
                  hintStyle: hintTextStyle ?? theme.hintStyle,
                  contentPadding: contentPadding ?? theme.contentPadding,
                  focusedBorder: focusedBorder,
                  enabledBorder: enabledBorder,
                  border: border,
                  counter: counterWidget,
                  counterText: '',
                ),
                obscuringCharacter: obscureCharacter ?? '•',
                onTap: onTap,
                maxLines: maxLine,
              ),
            ),
          ),
          ConditionWidget(
            isFirstCondition: errorText != null,
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.icons.icAlert.path,
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      ColorName.candyRed,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      errorText ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorName.candyRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
