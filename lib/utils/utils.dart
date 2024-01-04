import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void showToastMessage(String message,
      {Color bgColor = Colors.red, Color textColor = Colors.white}) {
    Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        msg: message,
        backgroundColor: bgColor,
        textColor: textColor);
  }
}
