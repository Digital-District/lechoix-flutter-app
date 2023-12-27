import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../util/utils/consts/ui_constants.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  final bool obscureText;
  final int? maxLength;
  final int maxLines;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final bool isSuccess;
  final bool readOnly;
  final bool hideBorder;
  final Color? fillColor;
  final Function(String)? onSubmit;
  final Function()? onClick;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.errorText,
    this.enabled = true,
    this.obscureText = false,
    this.maxLength,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.padding,
    this.margin,
    this.prefixIcon,
    this.suffixIcon,
    this.hint,
    this.isSuccess = false,
    this.readOnly = false,
    this.hideBorder = false,
    this.fillColor,
    this.onSubmit,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabled,
        readOnly: readOnly,
        onTap: onClick,
        onFieldSubmitted: onSubmit,
        cursorColor: UIConstants.gray1Color,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: padding,
          errorText: errorText,
          hintText: tr(hint ?? ""),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          filled: fillColor != null,
          hintStyle: const TextStyle(color: UIConstants.gray4Color),
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: UIConstants.redColor,
          ),
          border: OutlineInputBorder(
            borderSide: hideBorder
                ? BorderSide.none
                : BorderSide(
                    color: isSuccess
                        ? UIConstants.green2Color
                        : UIConstants.gray4Color,
                  ),
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: hideBorder
                ? BorderSide.none
                : BorderSide(
                    color: isSuccess
                        ? UIConstants.green2Color
                        : UIConstants.gray4Color,
                  ),
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: hideBorder
                ? BorderSide.none
                : BorderSide(
                    color: isSuccess
                        ? UIConstants.green2Color
                        : UIConstants.gray1Color,
                  ),
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: hideBorder
                ? BorderSide.none
                : const BorderSide(color: UIConstants.gray1Color),
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: hideBorder
                ? BorderSide.none
                : const BorderSide(color: UIConstants.gray1Color),
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
        ),
      ),
    );
  }
}

class TextLength {
  static const password = 32;
  static const email = 32;
  static const text = 32;
  static const phone = 11;
  static const paragraph = 1000;
}
