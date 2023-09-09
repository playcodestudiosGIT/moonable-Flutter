import 'package:flutter/material.dart';




class NotifServ {
  static GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>(debugLabel: 'msgKey');

  static showSnackbarError( String msg, Color color) {
    final snackBar = SnackBar(
        backgroundColor: color,
        content: Text(
          msg,
         
        ));

    msgKey.currentState!.showSnackBar(snackBar);
  }
}
