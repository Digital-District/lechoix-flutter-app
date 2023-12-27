import 'package:flutter/material.dart';

import '../../util/utils/consts/text_style_constants.dart';

class LabelWithIconWidget extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool isLeadingIcon;
  final EdgeInsets textPadding;

  const LabelWithIconWidget({
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
      Flexible(
        child: Padding(
          padding: textPadding,
          child: Text(
            label,
            style: TextStyleConstants.bodyRegular,
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
