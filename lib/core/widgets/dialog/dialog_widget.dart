import 'package:flutter/material.dart';
import '../button/elevated_button_widget.dart';
import '../button/outlined_button_widget.dart';
import '../space_widget.dart';
import '../card_widget.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String confirmMsg;
  final Function() onConfirm;
  final String? cancelMsg;
  final Function()? onCancel;

  const DialogWidget({
    super.key,
    required this.title,
    required this.confirmMsg,
    required this.onConfirm,
    this.cancelMsg,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CardWidget(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                    fontSize: 18,
                  ),
                ),
                const VerticalSpace(20),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButtonWidget(
                        onClick: onConfirm,
                        child: Text(confirmMsg),
                      ),
                    ),
                    const SizedBox(height: 10),
                    cancelMsg == null
                        ? Container()
                        : SizedBox(
                            width: double.infinity,
                            child: OutlinedButtonWidget(
                                borderColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                onClick: onCancel,
                                child: Text(cancelMsg ?? "")),
                          ),
                  ],
                ),
                const VerticalSpace(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
