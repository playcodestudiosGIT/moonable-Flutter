import 'package:flutter/material.dart';
import 'package:moonable/providers/clients_provider.dart';
import 'package:moonable/ui/widgets/flag_country_widget.dart';
import 'package:provider/provider.dart';

import '../../models/operation_model.dart';
import '../../settings/constants.dart';
import 'dialogs/confirm_delete.dart';
import 'dialogs/create_edit_op_dialog.dart';

class OperationItem extends StatefulWidget {
  final Operation operation;

  const OperationItem({super.key, required this.operation});

  @override
  State<OperationItem> createState() => _OperationItemState();
}

class _OperationItemState extends State<OperationItem> {
  late bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    final seconds =
        DateTime.now().difference(widget.operation.dueDate).inSeconds;
    String duration = '';

    if (seconds.isNegative) {
      final String srt = seconds.toString().substring(1);

      final int positiveDuration = int.parse(srt);

      if (positiveDuration < 3600) {
        duration = '${Duration(seconds: positiveDuration).inMinutes} minutos';
      }
      if (positiveDuration <= 86400 && positiveDuration >= 3600) {
        duration = '${Duration(seconds: positiveDuration).inHours} horas';
      }
    } else {
      if (seconds < 3600) {
        duration = '${Duration(seconds: seconds).inMinutes} minutos';
      }
      if (seconds <= 86400 && seconds > 3600) {
        if (Duration(seconds: seconds).inHours <= 1) {
          duration = '${Duration(seconds: seconds).inHours} hora';
        } else {
          duration = '${Duration(seconds: seconds).inHours} horas';
        }
      }
      if (seconds >= 86400) {
        if (Duration(seconds: seconds).inDays <= 1) {
          duration = '${Duration(seconds: seconds).inDays} dia';
        } else {
          duration = '${Duration(seconds: seconds).inDays} dias';
        }
      }
      if (seconds >= 2628000) {
        final time = Duration(seconds: seconds).inDays / 30;
        if (time < 1.0) {
          duration = '${time.toStringAsFixed(1)} mes';
        } else {
          duration = '${time.toStringAsFixed(1)} meses';
        }
      }
    }

    final client = Provider.of<ClientsProvider>(context)
        .getClientById(id: widget.operation.client);

    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }

    String fiat = '\$';

    if (widget.operation.assetType == 'EUR') {
      fiat = '€';
    }

    return Container(
        constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.all(5),
        width: 500,
        height: 75,
        decoration: BoxDecoration(
            color: (isDarkMode)
                ? Colors.white.withOpacity(0.1)
                : primary(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlagWCountryWidget(
                country: widget.operation.ibanWallet.substring(0, 2)),
            const SizedBox(width: 15),
            SizedBox(
              width: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (client!.firstName != '' && client.lastName != '')
                    FittedBox(
                      child: Text(
                        '${client.firstName} ${client.lastName}',
                        style: text14BodyM(context),
                      ),
                    ),
                  if (client.businessName != '')
                    Text(
                      client.businessName,
                      style: text14BodyM(context),
                    ),
                  FittedBox(
                    child: Text(
                      widget.operation.ibanWallet,
                      style: text10mini(context),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Platform: ',
                        style: text10miniOp(context),
                      ),
                      Text(
                        widget.operation.platform,
                        style: text10mini(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if(wSize(context) > 376)
            SizedBox(
              width: (wSize(context) > 465) ? 160 : 65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (wSize(context) > 465)
                        Text(
                          'Amount: ',
                          style: text10miniOp(context),
                        ),
                      FittedBox(
                        child: Text(
                          ' ${widget.operation.fiatAmount} $fiat',
                          style: text14BodyM(context),
                        ),
                      ),
                    ],
                  ),
                  if (wSize(context) > 465)
                  Row(
                    children: [
                      Text(
                        'Percent: ',
                        style: text10miniOp(context),
                      ),
                      Text(
                        ' ${widget.operation.percent} %',
                        style: text10mini(context),
                      ),
                    ],
                  ),

                  Wrap(
                    children: [
                      if (seconds.isNegative)
                        Text('OPEN      ',
                            style: text10miniOp(context)
                                .copyWith(color: Colors.greenAccent)),
                      if (!seconds.isNegative)
                        Text('EXPIRED ',
                            style: text10miniOp(context)
                                .copyWith(color: Colors.redAccent)),
                      if (seconds.isNegative)
                        Text(duration, style: text10mini(context)),
                      if (!seconds.isNegative)
                        Text(duration, style: text10mini(context))
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          final isOk = await showDialog(
                            context: context,
                            builder: (context) => CreateEditOperationDialog(
                              operation: widget.operation,
                            ),
                          );
                          if (isOk) setState(() {});
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 16,
                          color: primary(context),
                        )),
                    IconButton(
                        onPressed: () async {
                          final isOk = await showDialog(
                              context: context,
                              builder: (context) =>
                                  ConfirmDeleteDialog(obj: widget.operation));
                          if (isOk) {
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 16,
                          color: Colors.red.shade300,
                        )),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
