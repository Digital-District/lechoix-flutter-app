import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/space_widget.dart';

class TitleDividerWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const  TitleDividerWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UIConstants.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 2,
            child: Divider(indent: 8, endIndent: 8),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 21),
                const HorizontalSpace(8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: Divider(indent: 8, endIndent: 8),
          ),
        ],
      ),
    );
  }
}
