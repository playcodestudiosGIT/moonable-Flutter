import 'package:flutter/material.dart';
import 'package:moonable/providers/auth_provider.dart';
import 'package:moonable/router/router.dart';
import 'package:moonable/services/navigator_service.dart';
import 'package:moonable/settings/constants.dart';
import 'package:moonable/ui/widgets/menus/custom_menu_item.dart';
import 'package:moonable/ui/widgets/menus/text_separador_menu.dart';
import 'package:provider/provider.dart';

import '../../../providers/conf/global_keys_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final globalKeys = Provider.of<GlobalKeysProvider>(context, listen: false);
    final userScaffoldkey = globalKeys.userScaffoldkey;
    final authProvider = Provider.of<AuthProvider>(context);
    Function closeDrawer = globalKeys.userScaffoldkey.currentState!.closeDrawer;
    return Container(
      width: 250,
      height: hSize(context),
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Text('Moonable', style: text32Headline(context)),
              ),
              const Spacer(),
              Container(
                  margin: const EdgeInsets.all(4),
                  child: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => {userScaffoldkey.currentState!.closeDrawer()},
                  )),
            ],
          ),
          const SizedBox(height: 48),
          Column(
            children: [
              const CircleAvatar(radius: 30),
              const SizedBox(height: 10),
              Text('${authProvider.user!.nombre} ${authProvider.user!.apellido}'),
              const SizedBox(height: 30),
              TextButton.icon(
                  onPressed: () {
                    NavigatorService.navigateTo(Flurorouter.auditorPerfil);
                    closeDrawer();
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'))
            ],
          ),
          const SizedBox(height: 48),
          const SeparadorMenuTexto(text: 'Inicio'),
          CustomMenuItem(
            text: 'Monitor',
            onPressed: () {
              closeDrawer();
              NavigatorService.navigateTo(Flurorouter.auditorMonitor);
            },
            width: 100,
            padding: 10,
            icon: Icons.monitor_heart,
          ),
          const SizedBox(height: 48),
          if (authProvider.user!.rol == 'ADMIN_ROLE') ...[
            const SeparadorMenuTexto(text: 'ADMIN'),
            CustomMenuItem(
              text: 'Clientes',
              onPressed: () {
                closeDrawer();
                NavigatorService.navigateTo(Flurorouter.adminClients);
              },
              width: 100,
              padding: 10,
              icon: Icons.business_center,
            ),
            CustomMenuItem(
              text: 'Operaciones',
              onPressed: () {
                closeDrawer();
                NavigatorService.navigateTo(Flurorouter.adminOperations);
              },
              width: 100,
              padding: 10,
              icon: Icons.money_outlined,
            ),
            const SeparadorMenuTexto(text: 'CARGAR DATA'),
            CustomMenuItem(
              text: 'Cargar Clientes',
              onPressed: () {
                closeDrawer();
                NavigatorService.navigateTo(Flurorouter.uploadClients);
              },
              width: 100,
              padding: 10,
              icon: Icons.group_add_rounded,
            ),
            CustomMenuItem(
              text: 'Cargar Operaciones',
              onPressed: () {
                closeDrawer();
                NavigatorService.navigateTo(Flurorouter.uploadOp);
              },
              width: 100,
              padding: 10,
              icon: Icons.add_chart,
            ),
            const SizedBox(height: 48),
            const SeparadorMenuTexto(text: 'ACCIONES'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton.icon(
                onPressed: () => authProvider.logOut(context),
                icon: const Icon(Icons.logout),
                label: Text(
                  'Salir',
                  style: text10mini(context),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ]
        ],
      ),
    );
  }
}
