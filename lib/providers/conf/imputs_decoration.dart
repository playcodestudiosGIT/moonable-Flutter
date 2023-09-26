


import 'package:flutter/material.dart';

class InputsDeco {

  static InputDecoration textFormDeco({required String label, String hint = '', IconData icon = Icons.abc}) => InputDecoration(
              icon: (icon == Icons.abc) ? null :Icon(icon),
              label: Text(label),
              hintText: hint,
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.4)))
            );


}