import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moonable/api/moonable_api.dart';
import 'package:moonable/router/router.dart';
import 'package:moonable/services/navigator_service.dart';
import 'package:moonable/services/notificacion_service.dart';
import 'package:moonable/settings/theme_data.dart';
import 'package:moonable/ui/layouts/users_layouts.dart';
import 'package:moonable/ui/layouts/visitors_layouts.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/conf/global_keys_provider.dart';
import 'providers/conf/settings_provider.dart';
import 'providers/forms/login_form_provider.dart';
import 'providers/forms/register_form_provider.dart';
import 'providers/list_clients_provider.dart';
import 'providers/list_operations_provider.dart';
import 'services/local_storage.dart';

void main() async {
  await LocalStorage.configurePrefs();
  MoonableApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalKeysProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(create: (_) => ListOperationsProvider()),
        ChangeNotifierProvider(create: (_) => ListClientsProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moonable',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigatorService.navigatorKey,
      theme: TemplateTheme.tema1(context),
      scrollBehavior: MyCustomScrollBehavior(),
      scaffoldMessengerKey: NotifServ.msgKey,
      builder: ((_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.checking) {
          return const Center(child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator()));
        }
        if (authProvider.authStatus == AuthStatus.notAuthenticated) {
          return VisitorsLayout(
            child: child!,
          );
        } else {
          return UsersLayout(child: child!);
        }
      }),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
