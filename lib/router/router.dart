import 'package:fluro/fluro.dart';
import 'no_page_handler.dart';
import 'router_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

//root
  // static String root = '/';
  static String rootRoute = '/:page';
  static String homeRoute = '/home';
  static String authRoute = '/auth';


  static String auditorPerfil = '/auditor/profile';
  static String auditorMonitor = '/auditor/monitor';

  static String adminClients = '/admin/clients';
  static String adminOperations = '/admin/operations';
  static String uploadClients = '/admin/uploadClients';
  static String uploadOp = '/admin/uploadOp';
  static String login = '/auth/login';
  static String register = '/auth/register';



  static void configureRoutes() {
// def de rutas
    router.define(
      rootRoute,
      handler: VisitorHandlers.home,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      homeRoute,
      handler: VisitorHandlers.home,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      authRoute,
      handler: VisitorHandlers.home,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );

    router.define(
      auditorPerfil,
      handler: AuditorAuthHandlers.auditorPerfil,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      auditorMonitor,
      handler: AuditorAuthHandlers.auditorMonitor,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      adminClients,
      handler: AdminAuthHandlers.adminClients,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      adminOperations,
      handler: AdminAuthHandlers.adminOperations,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      uploadClients,
      handler: AdminAuthHandlers.uploadClients,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      uploadOp,
      handler: AdminAuthHandlers.uploadOp,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      login,
      handler: VisitorHandlers.login,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    router.define(
      register,
      handler: VisitorHandlers.register,
      transitionType: TransitionType.none,
      transitionDuration: const Duration(milliseconds: 100),
    );
    // 404 System
    router.notFoundHandler = NoPageHandler.noPageFound;
  }
}
