import 'package:flutter/material.dart';
import 'package:moonable/providers/conf/global_keys_provider.dart';
import 'package:moonable/providers/conf/settings_provider.dart';
import 'package:moonable/router/router.dart';
import 'package:moonable/services/navigator_service.dart';
import 'package:moonable/settings/constants.dart';
import 'package:moonable/ui/widgets/botones/boton_icon_redondo.dart';
import 'package:provider/provider.dart';

class VisitorsLayout extends StatelessWidget {
  final Widget child;
  const VisitorsLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final userScaffoldkey = Provider.of<GlobalKeysProvider>(context).userScaffoldkey;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
        key: userScaffoldkey,
        appBar: AppBar(
          elevation: 10,
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(onTap: () => NavigatorService.navigateTo('/'), child: const Text('Moonable')),
          ),
          actions: [
            BotonRedondoIcono(
                icon: (settingsProvider.themeMode == Thememode.ligth) ? Icons.dark_mode : Icons.light_mode,
                onTap: () {
                  if (settingsProvider.themeMode == Thememode.ligth) {
                    settingsProvider.themeMode = Thememode.dark;
                  } else {
                    settingsProvider.themeMode = Thememode.ligth;
                  }
                }),
            const SizedBox(width: 16),
            if (wSize(context) > 465) ...[
              ElevatedButton(
                onPressed: () => NavigatorService.navigateTo(Flurorouter.register),
                child: const Text('Registro'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => NavigatorService.navigateTo(Flurorouter.login),
                child: const Text('Ingresar'),
              ),
            ],
            if (wSize(context) <= 465) ...[
              IconButton(
                onPressed: () => NavigatorService.navigateTo(Flurorouter.register),
                icon: const Icon(Icons.app_registration),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => NavigatorService.navigateTo(Flurorouter.login),
                icon: const Icon(Icons.login),
              ),
            ],
            const SizedBox(width: 15),
          ],
        ),
        body: child);
  }
}
