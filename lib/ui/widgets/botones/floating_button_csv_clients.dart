import 'package:flutter/material.dart';

import '../../../services/pick_service.dart';

class FloatingButtonCsvClients extends StatefulWidget {
  const FloatingButtonCsvClients({
    super.key,
  });

  @override
  State<FloatingButtonCsvClients> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButtonCsvClients> {
  @override
  Widget build(BuildContext context) {
    // final listProvider = Provider.of<ListProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          mini: true,
          onPressed: () {
            PickServices.pickClients(context);
            
          }, //listProvider.pickFile,
          child: const Icon(Icons.group_add_rounded),
        ),
      ],
    );
  }
}
