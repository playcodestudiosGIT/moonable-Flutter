import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/models/operation_model.dart';
import 'package:moonable/ui/widgets/dialogs/create_edit_client_dialog.dart';

import '../../settings/constants.dart';
import 'dialogs/confirm_delete.dart';

class ClientItem extends StatefulWidget {
  final Client client;
  const ClientItem({super.key, required this.client});

  @override
  State<ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  late List<Operation> operations;
  late double total = 0.0;
  late bool isDarkMode;

  @override
  void initState() {
    operations = widget.client.operations;
    for (var operation in operations) {
      total = total + operation.fiatAmount;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    return Container(
        constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.all(5),
        width: 500,
        height: 72,
        decoration: BoxDecoration(
            color: (isDarkMode)
                ? Colors.white.withOpacity(0.1)
                : primary(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CountryFlag.fromCountryCode(
                  (widget.client.ibanWallet.isNotEmpty)
                      ? (widget.client.ibanWallet[0].length > 2)
                          ? widget.client.ibanWallet[0].substring(0, 2)
                          : ''
                      : '',
                  height: 80,
                  width: 80,
                  borderRadius: 0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  if (widget.client.tierStatus == "Approved")
                    Text('Approved',
                        style: text10mini(context).copyWith(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold)),
                  if (widget.client.tierStatus == "Pending")
                    Text('Pending',
                        style: text10mini(context).copyWith(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold)),
                  if (widget.client.tierStatus == "")
                    Text('Pending',
                        style: text10mini(context).copyWith(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        widget.client.clientType,
                        style: text10miniOp(context),
                      ),
                      const SizedBox(width: 10),
                      (widget.client.tier == '')
                          ? Text(
                              'Tier - 0',
                              style: text10miniOp(context),
                            )
                          : Text(
                              widget.client.tier,
                              style: text10miniOp(context),
                            ),
                    ],
                  ),
                  if (widget.client.firstName != "")
                    FittedBox(
                      child: Text(
                        '${widget.client.firstName} ${widget.client.lastName}',
                        style: text14BodyM(context),
                      ),
                    ),
                  if (widget.client.businessName != '')
                    Text(
                      widget.client.businessName,
                      style: text14BodyM(context),
                    ),
                  FittedBox(
                    child: Text(
                      widget.client.ibanWallet[0],
                      style: text10mini(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Center(
                child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  ...widget.client.operations.map((e) => SizedBox(
                      width: 130,
                      // color: Colors.greenAccent.withOpacity(0.1),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_drop_up,
                            size: 15,
                            color: Colors.green,
                          ),
                          const Spacer(),
                          Text(e.fiatType),
                          const SizedBox(width: 10),
                          Text(e.fiatAmount.toString()),
                        ],
                      ))),
                  Container(
                    width: 130,
                    height: 0.5,
                    color: Colors.greenAccent,
                  ),
                  Builder(builder: (context) {
                    return SizedBox(
                        width: 130,
                        child: Container(
                          color: Colors.greenAccent.withOpacity(0.1),
                          child: Row(
                            children: [
                              Text(
                                'TOTAL:',
                                style: text10miniOp(context),
                              ),
                              const Spacer(),
                              const Text(' EUR'),
                              const SizedBox(width: 10),
                              Text(total.toString()),
                            ],
                          ),
                        ));
                  })
                ],
              ),
            )),
            const Spacer(),
            IconButton(
                onPressed: () async {
                  final isOk = await showDialog(
                    context: context,
                    builder: (context) => CreateEditClientDialog(
                      client: widget.client,
                    ),
                  );
                  if (isOk) setState(() {});
                },
                icon: Icon(
                  Icons.edit,
                  color: primary(context),
                  size: 16,
                )),
            Center(
                child: IconButton(
              icon: Icon(
                Icons.delete,
                size: 16,
                color: Colors.red.shade300,
              ),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => ConfirmDeleteDialog(
                          obj: widget.client,
                        ));
                setState(() {});
              },
            )),
          ],
        ));
  }
}
