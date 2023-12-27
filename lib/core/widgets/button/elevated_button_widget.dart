import 'package:flutter/material.dart';

import '../../util/utils/consts/ui_constants.dart';
import 'label_with_icon_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Widget child;
  final Function()? onClick;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final double fontSize;
  final double elevation;
  final double radius;
  final double? width;
  final Color? color;
  final Color? textColor;

  const ElevatedButtonWidget({
    super.key,
    required this.child,
    required this.onClick,
    this.margin,
    this.padding = const EdgeInsets.all(UIConstants.padding),
    this.fontSize = UIConstants.fontSize,
    this.elevation = UIConstants.elevation,
    this.radius = UIConstants.radius,
    this.width,
    this.color,
    this.textColor,
  });

  factory ElevatedButtonWidget.icon({
    Key? key,
    required String label,
    required Icon icon,
    required Function() onClick,
    padding,
    margin,
    fontSize,
    elevation,
    radius,
    isLeadingIcon,
    primary,
    onPrimary,
  }) = _ElevatedButtonWidgetWithIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Theme.of(context).colorScheme.onSecondary, backgroundColor: color ?? Theme.of(context).colorScheme.secondary, minimumSize: const Size(0, 0),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ).merge(
          ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled) ? 0 : elevation,
            ),
          ),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class _ElevatedButtonWidgetWithIcon extends ElevatedButtonWidget {
  _ElevatedButtonWidgetWithIcon({
    super.key,
    required label,
    required icon,
    required onClick,
    padding = const EdgeInsets.all(UIConstants.padding),
    margin = const EdgeInsets.all(UIConstants.margin),
    fontSize = UIConstants.fontSize,
    elevation = UIConstants.elevation,
    radius = UIConstants.radius,
    isLeadingIcon = true,
    primary,
    onPrimary,
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
          color: primary,
          textColor: onPrimary,
        );
}
