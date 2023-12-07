import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

import 'label_with_icon_widget.dart';

class TextButtonWidget extends StatelessWidget {
  final Widget child;
  final Function()? onClick;
  final EdgeInsets padding;
  final double fontSize;
  final double elevation;
  final double radius;
  final Color? textColor;

  const TextButtonWidget({
    super.key,
    required this.child,
    required this.onClick,
    this.padding = const EdgeInsets.all(UIConstants.padding),
    this.fontSize = UIConstants.fontSize,
    this.elevation = UIConstants.elevation,
    this.radius = UIConstants.radius,
    this.textColor,
  });

  factory TextButtonWidget.icon({
    Key? key,
    required label,
    required icon,
    required onClick,
    padding,
    margin,
    fontSize,
    elevation,
    radius,
    isLeadingIcon,
    textColor,
  }) = _TextButtonWidgetWithIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? Theme.of(context).colorScheme.secondary, minimumSize: const Size(0, 0),
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _TextButtonWidgetWithIcon extends TextButtonWidget {
  _TextButtonWidgetWithIcon({
   super. key,
    required label,
    required icon,
    required onClick,
    padding = const EdgeInsets.all(4),
    margin = const EdgeInsets.all(UIConstants.margin),
    fontSize = UIConstants.fontSize,
    elevation = UIConstants.elevation,
    radius = UIConstants.radius,
    textColor,
    isLeadingIcon = true,
  }) : super(
          child: LabelWithIconWidget(
            label: label,
            icon: icon,
            isLeadingIcon: isLeadingIcon,
          ),
          onClick: onClick,
          padding: padding,
          fontSize: fontSize,
          elevation: elevation,
          radius: radius,
          textColor: textColor,
        );
}
