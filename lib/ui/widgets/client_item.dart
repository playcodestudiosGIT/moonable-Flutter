import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/models/operation_model.dart';

import '../../settings/constants.dart';

class ClientItem extends StatefulWidget {
  final Cliente client;
  const ClientItem({super.key, required this.client});

  @override
  State<ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  late List<Operation> operations;
  late double total = 0.0;
  @override
  void initState() {
    operations = widget.client.operations!;
    for (var operation in operations) {
      total = total + operation.fiatAmount;
    }
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
            SizedBox(
              width: 30,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CountryFlag.fromCountryCode(
                  (widget.client.ibanWallet[0].length > 2)
                      ? widget.client.ibanWallet[0].substring(0, 2)
                      : '',
                  height: 80,
                  width: 80,
                  borderRadius: 0,
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.client.clientType ?? '',
                        style: text10miniOp(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.client.tier ?? '',
                        style: text10miniOp(context),
                      ),
                      const SizedBox(width: 10),
                      if (widget.client.tierStatus == "Approved")
                        Text('Approved',
                            style: text10mini(context)
                                .copyWith(color: Colors.green[900])),
                      if (widget.client.tierStatus == "Pending")
                        Text('Pending',
                            style: text10mini(context)
                                .copyWith(color: Colors.amber[900]))
                    ],
                  ),
                  Text(
                    '${widget.client.firstName} ${widget.client.lastName}',
                    style: text14BodyM(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.client.ibanWallet.map((e) {
                        if (e != "000000") {
                          return Text(
                            e,
                            style: text10mini(context),
                          );
                        }
                        return Text(
                          'SIN IBAN WALLET',
                          style: text10mini(context),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  ...widget.client.operations!.map((e) => Container(
                      width: 150,
                      color: Colors.greenAccent.withOpacity(0.1),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_drop_up, size: 15, color: Colors.green,),
                          const Spacer(),
                          Text(e.fiatType),
                          const SizedBox(width: 10),
                          Text(e.fiatAmount.toString()),
                          
                        ],
                      ))),
                  Container(
                    width: 150,
                    height: 0.5,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Builder(builder: (context) {
                    return SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            const Text('TOTAL:'),
                            const Spacer(),
                            const Text(' EUR'),
                            const SizedBox(width: 10),
                            Text(total.toString()),
                          ],
                        ));
                  })
                ],
              ),
            )),
            const Spacer(),
            Center(
                child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
              onPressed: () {},
            ))
          ],
        ));
  }
}
