import 'package:flutter/material.dart';

class ContainerWithBorderWidget extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const ContainerWithBorderWidget({
    Key? key,
    required this.child,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: child,
    );
  }
}
