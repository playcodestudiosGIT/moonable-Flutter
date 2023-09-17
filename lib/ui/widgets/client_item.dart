import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';

import '../../settings/constants.dart';

class ClientItem extends StatelessWidget {
  final Cliente client;
  const ClientItem({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.all(5),
        width: 500,
        height: 90,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
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
                  client.ibanWallet[0].substring(0, 2),
                  height: 80,
                  width: 80,
                  borderRadius: 0,
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        client.clientType,
                        style: text10miniOp(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        client.tier,
                        style: text10miniOp(context),
                      ),
                      const SizedBox(width: 10),
                      if (client.tierStatus == "Approved") Text('Approved', style: text10mini(context).copyWith(color: Colors.green[900])),
                      if (client.tierStatus == "Pending") Text('Pending', style: text10mini(context).copyWith(color: Colors.amber[900]))
                    ],
                  ),
                  Text(
                    '${client.firstName} ${client.lastName}',
                    style: text14BodyM(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...client.ibanWallet.map((e) {
                        if (e != "") {
                          return Text(
                            e,
                            style: text10mini(context),
                          );
                        }
                        return Text(
                          '-',
                          style: text10mini(context),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tier Risk ${client.tierRisk}',
                  style: text10miniOp(context),
                ),
                Text(
                  'Iban Geo Risk ${client.ibanGeoRisk}',
                  style: text10miniOp(context),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Client Id #${client.clientId}',
                  style: text10miniOp(context),
                ),
                Text(
                  'Residence risk ${client.residenceRisk}',
                  style: text10miniOp(context),
                ),
                
              ],
            ),
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
