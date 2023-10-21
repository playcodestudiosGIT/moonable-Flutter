import 'package:flutter/material.dart';
import 'package:moonable/providers/operations_provider.dart';
import 'package:provider/provider.dart';

import '../../settings/constants.dart';

class MonitorTopGraph extends StatelessWidget {
  const MonitorTopGraph({super.key});

  @override
  Widget build(BuildContext context) {
    late bool isDarkMode;
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: (isDarkMode)
                    ? Colors.white.withOpacity(0.1)
                    : primary(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 3)
                ]),
            width: 120,
            height: 120,
            child: Column(
              children: [
                const Spacer(),
                Text(
                  'Mier 26 Oct',
                  style: text10miniOp(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Provider.of<OperationsProvider>(context).allOperationsDB.length.toString(),
                      style: text32Headline(context),
                    ),
                    Text(
                      'operaciones',
                      style: text10miniOp(context),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            constraints: const BoxConstraints(maxWidth: 160),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
                color: (isDarkMode)
                    ? Colors.white.withOpacity(0.1)
                    : primary(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 3)
                ]),
            child: Stack(
              children: [
                Positioned(
                    top: 10,
                    left: 20,
                    child: Text(
                      'Operaciones hoy',
                      style: text10miniOp(context),
                    )),
                const Positioned(
                  top: 45,
                  left: 8,
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                    value: 1,
                  ),
                ),
                const Positioned(
                  top: 45,
                  left: 8,
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                    value: .84,
                  ),
                ),
                const Positioned(
                  top: 45,
                  left: 8,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    value: .6,
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 55,
                    child: Row(
                      children: [
                        Text(
                          '23',
                          style: text10miniOp(context)
                              .copyWith(color: primary(context)),
                        ),
                        const SizedBox(width: 10),
                        Text('COMPLETADAS',
                            style: text10miniOp(context)
                                .copyWith(color: Colors.green)),
                        // Spacer(),
                      ],
                    )),
                Positioned(
                    top: 55,
                    left: 55,
                    child: Container(
                      width: 95,
                      child: Row(
                        children: [
                          Text(
                            '9',
                            style: text10miniOp(context)
                                .copyWith(color: primary(context)),
                          ),
                          Spacer(),
                          Text(
                            'PENDIENTES',
                            style: text10miniOp(context)
                                .copyWith(color: Colors.orange),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    top: 70,
                    left: 55,
                    child: Row(
                      children: [
                        Text(
                          '40',
                          style: text10miniOp(context)
                              .copyWith(color: primary(context)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'CANCELADAS',
                          style: text10miniOp(context)
                              .copyWith(color: Colors.redAccent),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
