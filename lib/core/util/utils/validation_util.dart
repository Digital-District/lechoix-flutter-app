import 'package:flutter/material.dart';

extension ValidationExtension on TextEditingController {
  String getText() => text.trim();

  bool isEmpty() => text.isEmpty;

  bool isValidEmail() => isEmpty()
      ? false
      : RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(text);

  bool isValidPassword() => isEmpty()
      ? false
      : text.length < 6
          ? false
          : true;

  bool isValidPhone(String regex) {
    return isEmpty() ? false : RegExp(r"" + regex).hasMatch(text);
  }

  bool isValidName() {
    var carLength =   getText().length ;
    return carLength >= 4 && carLength <= 10;
  }

  bool hasNumbers() =>
      RegExp("[0-9]").hasMatch(text) || RegExp("[٠-٩]").hasMatch(text);
}
