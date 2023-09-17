import 'package:flutter/material.dart';

import '../../../settings/constants.dart';

class MonitorView extends StatelessWidget {
  const MonitorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 30),
                Text('Monitor', style: text32Headline(context)),
              ],
            ),
            
          ],
        ),
      ),
    ));
  }
}
