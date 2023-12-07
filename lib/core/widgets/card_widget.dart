import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double radius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color? color;
  final Color? borderColor;
  final Color? shadowColor;

  const CardWidget({
    Key? key,
    required this.child,
    this.elevation = UIConstants.elevation,
    this.radius = UIConstants.radius,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: color,
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        side: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
