import 'package:flutter/material.dart';

import '../../../services/pick_service.dart';

class FloatingButtonCsvOrders extends StatefulWidget {
  const FloatingButtonCsvOrders({
    super.key,
  });

  @override
  State<FloatingButtonCsvOrders> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButtonCsvOrders> {
  @override
  Widget build(BuildContext context) {
    // final listProvider = Provider.of<ListProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          mini: true,
          onPressed: () {
            PickServices.pickOrders(context);
          }, //listProvider.pickFile,
          child: const Icon(Icons.add_chart_rounded),
        ),
      ],
    );
  }
}
