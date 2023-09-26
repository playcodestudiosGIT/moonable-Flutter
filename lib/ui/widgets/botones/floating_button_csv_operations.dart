import 'package:flutter/material.dart';

import '../../../services/pick_service.dart';

class FloatingButtonCsvOp extends StatefulWidget {
  const FloatingButtonCsvOp({
    super.key,
  });

  @override
  State<FloatingButtonCsvOp> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButtonCsvOp> {
  @override
  Widget build(BuildContext context) {
    // final listProvider = Provider.of<ListProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          mini: true,
          onPressed: () {
            PickServices.pickOp(context);
            
          }, //listProvider.pickFile,
          child: const Icon(Icons.add_chart_rounded),
        ),
      ],
    );
  }
}
