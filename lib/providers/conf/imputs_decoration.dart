import 'package:flutter/material.dart';
import 'package:moonable/settings/constants.dart';

class InputsDeco {
  static InputDecoration textFormDeco(
      {required BuildContext context,
      required String label,
      String hint = '',
      IconData icon = Icons.abc, required bool isDarkMode}) {
    
    
    return InputDecoration(
        icon: (icon == Icons.abc) ? null : Icon(icon),
        label: Text(
          label,
          style: text14BodyM(context),
        ),
        fillColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        
        contentPadding: const EdgeInsets.all(8),
        hintText: hint,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
          
            borderSide: BorderSide(
                color: (isDarkMode)
                    ? Colors.white.withOpacity(0.4)
                    : primary(context).withOpacity(0.4)
                    )));
  }
}
