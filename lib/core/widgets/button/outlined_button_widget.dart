import 'package:flutter/material.dart';

import '../../util/utils/consts/ui_constants.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final Function()? onClick;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double fontSize;
  final double elevation;
  final double radius;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? width;

  const OutlinedButtonWidget({
    super.key,
    required this.child,
    required this.onClick,
    this.padding = const EdgeInsets.all(UIConstants.padding),
    this.margin,
    this.fontSize = UIConstants.fontSize,
    this.elevation = UIConstants.elevation,
    this.radius = UIConstants.radius,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor ?? Theme.of(context).colorScheme.onPrimary, padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          side:
              BorderSide(color: borderColor ?? Theme.of(context).dividerColor),
          backgroundColor: backgroundColor,
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
              ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
