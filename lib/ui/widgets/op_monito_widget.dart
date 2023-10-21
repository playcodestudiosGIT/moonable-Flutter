import 'package:flutter/material.dart';

import 'package:moonable/models/operation_model.dart';

import '../../settings/constants.dart';

class OpMonitorWidget extends StatefulWidget {
  final Operation client;
  const OpMonitorWidget({super.key, required this.client});

  @override
  State<OpMonitorWidget> createState() => _OpMonitorWidgetState();
}

class _OpMonitorWidgetState extends State<OpMonitorWidget> {
   late bool isDarkMode;
  
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    return Container(
      // constraints: BoxConstraints(maxWidth: 300),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
            color: (isDarkMode)
                ? Colors.white.withOpacity(0.1)
                : primary(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
      width: double.infinity,
      height: 42,
      child: Row(),
    );
  }
}
