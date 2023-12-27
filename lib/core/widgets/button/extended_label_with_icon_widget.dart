import 'package:flutter/material.dart';

class ExtendedLabelWithIconWidget extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool isLeadingIcon;
  final EdgeInsets textPadding;

  const ExtendedLabelWithIconWidget({
    super.key,
    required this.label,
    required this.icon,
    this.isLeadingIcon = true,
    this.textPadding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      icon,
      const SizedBox(width: 8.0),
      Expanded(
        child: Padding(
          padding: textPadding,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: isLeadingIcon ? children : children.reversed.toList(),
    );
  }
}
