import 'package:flutter/material.dart';

class ContainerWithBorderWidget extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const ContainerWithBorderWidget({
    super.key,
    required this.child,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: child,
    );
  }
}
