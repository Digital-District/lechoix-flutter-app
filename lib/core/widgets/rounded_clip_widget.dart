import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class RoundedClipWidget extends StatelessWidget {
  final Widget child;
  final double radius;

  const RoundedClipWidget({
    super.key,
    required this.child,
    this.radius = UIConstants.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: child,
    );
  }
}
