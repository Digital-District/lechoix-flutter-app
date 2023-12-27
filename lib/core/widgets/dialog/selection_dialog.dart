import 'package:flutter/material.dart';

import '../../util/utils/consts/ui_constants.dart';

class SelectionDialog extends StatelessWidget {
  final List<Widget> children;

  const SelectionDialog({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(UIConstants.padding),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radius)),
      children: children,
    );
  }
}
