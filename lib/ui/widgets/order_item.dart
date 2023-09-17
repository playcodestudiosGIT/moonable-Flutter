import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../settings/constants.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.all(5),
        width: 450,
        height: 80,
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
                  order.ibanWallet[0].substring(0, 2),
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
                  Text(
                    '${order.firstName} ${order.lastName}',
                    style: text14BodyM(context),
                  ),
                  Text(
                    'Iban Wallet',
                    style: text10miniOp(context),
                  ),
                  Column(
                    children: [
                      ...order.ibanWallet.map((e) => Text(
                            e,
                            style: text10mini(context),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Platform: ',
                        style: text10miniOp(context),
                      ),
                      Text(
                        order.platform,
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
                  '${order.fiatAmount} ${order.fiatType}',
                  style: text14BodyM(context),
                ),
                Text(
                  'Total purchase:',
                  style: text10miniOp(context),
                ),
                Text(
                  '${order.totalAssetPurchase} ${order.assetType}',
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
                  '${order.percent} %',
                  style: text14BodyM(context),
                ),
                Text(
                  'Due date:',
                  style: text10miniOp(context),
                ),
                Text(
                  order.dueDate,
                  style: text14BodyM(context),
                ),
              ],
            ),
          ],
        ));
  }
}
