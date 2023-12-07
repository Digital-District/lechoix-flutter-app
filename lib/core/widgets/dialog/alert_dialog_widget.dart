import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final Widget positiveAction;
  final Widget? negativeAction;

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.positiveAction,
    this.negativeAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(UIConstants.padding),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radius)),
      title: Text(title),
      content: Text(content),
      actions: [
        positiveAction,
        negativeAction ?? Container(),
      ],
    );
  }
}
