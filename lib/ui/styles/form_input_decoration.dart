

import 'package:flutter/material.dart';

import '../../settings/constants.dart';

class FormDecor {


    static InputDecoration formFieldInputDecoration({required BuildContext context, required String label, IconData? icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primary(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary(context)),
      ),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: primary(context).withOpacity(0.3))),
      labelText: label,
      labelStyle: text14BodyM(context),
      prefixIcon: (icon == null) ? null : Icon(icon, color: primary(context).withOpacity(0.3)),
      suffixIconColor: primary(context).withOpacity(0.3));
}