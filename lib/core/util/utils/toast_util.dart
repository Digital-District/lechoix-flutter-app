import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void showErrorMsg(String msg) {
  if (msg.isEmpty) return;
  showToast(msg, Icons.error, Colors.redAccent);
}

void showToast(String msg, IconData icon, Color color) {
  BotToast.showCustomText(
    duration: const Duration(seconds: 2),
    onlyOne: true,
    align: const Alignment(0, 0.8),
    toastBuilder: (_) => Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                msg,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 16.0,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
