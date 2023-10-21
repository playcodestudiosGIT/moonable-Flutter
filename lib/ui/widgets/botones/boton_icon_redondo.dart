import 'package:flutter/material.dart';
import 'package:moonable/settings/constants.dart';

class BotonRedondoIcono extends StatelessWidget {
  final Color? fillColor;
  final Color? iconColor;
  final IconData icon;
  final Function onTap;

  const BotonRedondoIcono({
    super.key,
    this.fillColor,
    this.iconColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    late bool isDarkMode;
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    return GestureDetector(
      onTap: () => onTap(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: fillColor,
          ),
          child: Center(
              child: Icon(
            icon,
            color: (isDarkMode) ?iconColor: primary(context),
          )),
        ),
      ),
    );
  }
}
