import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

showToast(String? message) {
  Fluttertoast.showToast(
      backgroundColor: UIConstants.blackColor,
      textColor: Colors.white,
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2);
}
