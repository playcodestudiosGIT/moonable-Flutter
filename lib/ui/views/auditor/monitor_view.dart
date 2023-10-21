import 'package:flutter/material.dart';
import 'package:moonable/providers/clients_provider.dart';
import 'package:moonable/providers/operations_provider.dart';
import 'package:moonable/ui/widgets/op_monito_widget.dart';
import 'package:moonable/ui/widgets/title_tags.dart';
import 'package:provider/provider.dart';

import '../../../settings/constants.dart';
import '../../widgets/monitor_top_graph.dart';
import '../../widgets/user_alert_widget.dart';

class MonitorView extends StatefulWidget {
  const MonitorView({super.key});

  @override
  State<MonitorView> createState() => _MonitorViewState();
}

class _MonitorViewState extends State<MonitorView> {
  late bool isDarkMode;

  @override
  void initState() {
    Provider.of<ClientsProvider>(context, listen: false).getAllClientsDB();
    Provider.of<OperationsProvider>(context, listen: false)
        .getAllOperationsDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allClients = Provider.of<ClientsProvider>(context).allClientsDB;
    allClients.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    final allOps = Provider.of<OperationsProvider>(context).allOperationsDB;
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    return Center(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 30),
                Text('Monitor', style: text32Headline(context)),
              ],
            ),
            const SizedBox(height: 30),
            const MonitorTopGraph(),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        // height: hSize(context),
                        child: Column(children: [
                          const TitleTags(title: 'Alerta de Meta', tags: [
                            '1 dia',
                            '7 dias',
                            '15 dias',
                            '30 dias',
                            '90 dias',
                            '180 dias',
                            '365 dias'
                          ]),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            height: (wSize(context) >= 768)
                                    ? hSize(context)
                                    : hSize(context) * 0.4,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...allClients
                                      .map((e) => UserAlertWidget(client: e))
                                      .toList()
                                ],
                              ),
                            ),
                          ),
                          if (wSize(context) < 768) ...[
                            const SizedBox(height: 30),
                            const TitleTags(title: 'Operaciones', tags: [
                              'Todo',
                              'Pendientes',
                              'Completadas',
                              'Canceladas'
                            ]),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              height: (wSize(context) >= 768)
                                  ? hSize(context)
                                  : hSize(context) * 0.4,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...allOps
                                        .map((e) => OpMonitorWidget(client: e))
                                        .toList()
                                  ],
                                ),
                              ),
                            ),
                          ]
                        ]))),
                if (wSize(context) >= 768)
                  Expanded(
                      flex: 4,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: hSize(context),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              const TitleTags(title: 'Operaciones', tags: [
                                'Todo',
                                'Pendientes',
                                'Completadas',
                                'Canceladas'
                              ]),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: double.infinity,
                                height: (wSize(context) >= 768)
                                    ? hSize(context)
                                    : hSize(context) * 0.4,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...allOps
                                          .map(
                                              (e) => OpMonitorWidget(client: e))
                                          .toList()
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          )))
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    ));
  }
}
