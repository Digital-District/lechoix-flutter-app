import 'package:flutter/material.dart';

import '../../util/utils/consts/ui_constants.dart';
import '../space_widget.dart';

class DialogMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onClick;

  const DialogMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: UIConstants.margin,
        vertical: 4.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(UIConstants.radius),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.margin,
            vertical: 4.0,
          ),
          child: Row(
            children: [
              Icon(icon, size: 21),
              const HorizontalSpace(16),
              Expanded(
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
