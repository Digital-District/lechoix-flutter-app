import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class IconButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onClick;
  final double iconSize;
  final Color? color;
  final EdgeInsets padding;

  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onClick,
    this.iconSize = 24,
    this.color,
    this.padding = const EdgeInsets.all(UIConstants.padding),
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClick,
      icon: icon,
      iconSize: iconSize,
      color: color,
      splashRadius: 21,
      padding: padding,
    );
  }
}
