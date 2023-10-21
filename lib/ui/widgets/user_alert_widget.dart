import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/models/operation_model.dart';

import '../../settings/constants.dart';

class UserAlertWidget extends StatefulWidget {
  final Client client;
  const UserAlertWidget({super.key, required this.client});

  @override
  State<UserAlertWidget> createState() => _UserAlertWidgetState();
}

class _UserAlertWidgetState extends State<UserAlertWidget> {
  late bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    double total = 0;

    List<Operation> ops = widget.client.operations;
    for (var op in ops) {
      total = total + op.fiatAmount;
    }
    ops.sort((a, b) => a.createdAt.compareTo(b.createdAt));

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
      child: Row(
        children: [
          SizedBox(width: 15),
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
          SizedBox(width: 15),
          SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.client.firstName} ${widget.client.lastName}',
                    style: text14BodyM(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  FittedBox(
                    child: Text(
                      '${widget.client.ibanWallet[0]}',
                      style: text10miniOp(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
          SizedBox(width: 15),
          SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  'TOTAL',
                  style: text10miniOp(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '\$ ${total}',
                style: text14BodyM(context),
                overflow: TextOverflow.ellipsis,
              ),
              
            ],
          ))
        ],
      ),
    );
  }
}
