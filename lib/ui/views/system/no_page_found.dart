import 'package:flutter/material.dart';

import '../../../settings/constants.dart';


class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF00041C),
      child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          Text(
            '404 not found',
            style: text45DisplayM(context),
          ),
        ],
      ),
    );
  }
}
