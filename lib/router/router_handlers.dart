import 'package:fluro/fluro.dart';
import 'package:moonable/ui/views/admin/clientes_admin_view.dart';
import 'package:moonable/ui/views/admin/operations_admin_view.dart';
import 'package:moonable/ui/views/auditor/monitor_view.dart';
import 'package:moonable/ui/views/auditor/perfil_auditor_view.dart';
import 'package:moonable/ui/views/login/login_view.dart';
import 'package:moonable/ui/views/login/register_view.dart';
import 'package:moonable/ui/views/system/home_view.dart';

import '../ui/views/admin/load_clients_view.dart';
import '../ui/views/admin/load_operations_view.dart';

class VisitorHandlers {
  // ---
  static Handler home = Handler(handlerFunc: (context, params) {
    final page = params['page']!.first;
    // Provider.of<SideBarProvider>(context!, listen: false).setCurrentPageUrl(Flurorouter.rootRoute);
    if (page == '/') {
      return const HomeView();
    }
    if (page == 'auditor') {
      return const PerfilAuditorView();
    }
    if (page == 'home') {
      return const HomeView();
    }
    if (page == 'auth') {
      return const LoginView();
    }
    if (page.isEmpty) {
      return const HomeView();
    }
    return null;
  });
  // ---
  // ---
  static Handler login = Handler(handlerFunc: (context, params) {
    return const LoginView();
  });
  // ---
  // ---
  static Handler register = Handler(handlerFunc: (context, params) {
    return const RegisterView();
  });
  // ---
}

class AuditorAuthHandlers {
  // ---
  static Handler auditorPerfil = Handler(handlerFunc: (context, params) {
    return const PerfilAuditorView();
  });
  // ---
  // ---
  static Handler auditorMonitor = Handler(handlerFunc: (context, params) {
    return const MonitorView();
  });
  // ---
}

class AdminAuthHandlers {
  // ---
  static Handler adminClients = Handler(handlerFunc: (context, params) {
    return const ClientsAdminView();
  });
  // ---
  // ---
  static Handler adminOperations = Handler(handlerFunc: (context, params) {
    return const OperationsAdminView();
  });
  static Handler uploadClients = Handler(handlerFunc: (context, params) {
    return const LoadClientsView();
  });
  static Handler uploadOp = Handler(handlerFunc: (context, params) {
    return const LoadOperationsView();
  });
  // ---
}
