import 'package:flutter/material.dart';

import 'package:moonable/settings/constants.dart';


class SeparadorMenuTexto extends StatelessWidget {
  final String text;

  const SeparadorMenuTexto({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: text14BodyM(context).copyWith(color: textColor(context).withOpacity(0.3)),
      ),
    );
  }
}
