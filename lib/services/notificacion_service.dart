import 'package:flutter/material.dart';

class NotifServ {
  static GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>(debugLabel: 'msgKey');

  static showSnackbarError({
    required String msg,
    required bool ok,

  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
        content: Text(
          msg,
          style: TextStyle(color: (ok) ? Colors.green : Colors.red),
        ));

    msgKey.currentState!.showSnackBar(snackBar);
  }
}
