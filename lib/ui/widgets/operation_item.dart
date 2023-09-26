
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/providers/list_clients_provider.dart';
import 'package:moonable/ui/widgets/flag_country_widget.dart';
import 'package:provider/provider.dart';

import '../../models/operation_model.dart';
import '../../settings/constants.dart';

class OperationItem extends StatefulWidget {
  final Operation operation;
  const OperationItem({super.key, required this.operation});

  @override
  State<OperationItem> createState() => _OperationItemState();
}

class _OperationItemState extends State<OperationItem> {
  late final Cliente? client;

  @override
  void initState() {
    client = Provider.of<ListClientsProvider>(context, listen: false)
        .getClientById(id: widget.operation.client!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.all(5),
        width: 500,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlagWCountryWidget(
                country: widget.operation.ibanWallet.substring(0, 2)),
            const SizedBox(width: 15),
            SizedBox(
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${client?.firstName ?? 'N/A'} ${client?.lastName ?? 'N/A'}',
                    style: text14BodyM(context),
                  ),
                  Text(
                    'Iban Wallet',
                    style: text10miniOp(context),
                  ),
                  Text(
                    widget.operation.ibanWallet,
                    style: text10mini(context),
                  ),
                  Row(
                    children: [
                      Text(
                        'Platform: ',
                        style: text10miniOp(context),
                      ),
                      Text(
                        widget.operation.platform ?? '-',
                        style: text10mini(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fiat Amount:',
                  style: text10miniOp(context),
                ),
                Text(
                  '${widget.operation.fiatAmount} ${widget.operation.fiatType}',
                  style: text14BodyM(context),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Percent:',
                  style: text10miniOp(context),
                ),
                Text(
                  '${widget.operation.percent} %',
                  style: text14BodyM(context),
                ),
                Text(
                  'Due date:',
                  style: text10miniOp(context),
                ),
                Text(
                  '${widget.operation.dueDate.day}/${widget.operation.dueDate.month}/${widget.operation.dueDate.year} - ${widget.operation.dueDate.hour}:${widget.operation.dueDate.minute}',
                  style: text10mini(context),
                ),
                Text(
                  '${DateTime.now().difference(widget.operation.dueDate).inHours}',
                  style: text14BodyM(context),
                ),
              ],
            ),
          ],
        ));
  }
}
