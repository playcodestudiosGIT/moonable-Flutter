import 'package:flutter/material.dart';
import 'package:moonable/api/moonable_api.dart';

import '../models/usuario_model.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigator_service.dart';
import '../services/notificacion_service.dart';
import 'http/auth_response.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  // ignore: unused_field
  late String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  bool isLoading = false;

  // ------ init AuthProvider --------//
  AuthProvider() {
    isAutenticated();
  }

  Future<bool> isAutenticated() async {
    isLoading = true;

    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final resp = await MoonableApi.httpGet('/auth');
      final authResponse = AuthResponse.fromJson(resp);
      user = authResponse.user;
      _token = authResponse.token;
      authStatus = AuthStatus.authenticated;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      NotifServ.showSnackbarError(msg: 'Hubo un problema con tu autenticación', ok: false);
      authStatus = AuthStatus.notAuthenticated;
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  login(BuildContext context, String email, String password) async {
    isLoading = true;
    final data = {'correo': email, 'password': password};

    MoonableApi.post('/auth/login', data).then((json) {

      final authResponse = AuthResponse.fromJson(json);
      if (!authResponse.user.estado) {
        NotifServ.showSnackbarError(msg: 'Un Administrador debe autorizar su registro', ok: false);
        // NavigatorService.replaceTo(Flurorouter.login);
        isLoading = false;
        notifyListeners();
        return;
      }
      user = authResponse.user;
      _token = authResponse.token;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', json['token']);

      MoonableApi.configureDio();
      NavigatorService.navigateTo(Flurorouter.auditorMonitor);
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      NotifServ.showSnackbarError(msg: 'Credenciales Invalidas', ok: false);
      notifyListeners();
    });
  }

  logOut(BuildContext context) {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    NavigatorService.replaceTo(Flurorouter.homeRoute);
    isLoading = false;
    notifyListeners();
  }

  register({required String correo, required String password, required String nombre, required String apellido, String telf = 'no value'}) async {
    isLoading = true;
    notifyListeners();
    final data = {'nombre': nombre, 'apellido': apellido, 'correo': correo, 'password': password, 'telf': telf};
    MoonableApi.post('/usuarios', data).then((json) {
      isLoading = true;
      final authResponse = AuthResponse.fromJson(json);

      Usuario user = authResponse.user;
      _token = authResponse.token;


      if (!user.estado) {
        NotifServ.showSnackbarError(msg: 'Gracias por registrarte, un administrador debe aprobar tu registro', ok: true );
        NavigatorService.navigateTo(Flurorouter.rootRoute);
        isLoading = false;
        notifyListeners();
        return;
      }
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigatorService.navigateTo(Flurorouter.auditorMonitor);
      isLoading = false;
      notifyListeners();
      MoonableApi.configureDio();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
      NotifServ.showSnackbarError( msg: 'Correo ya existe. ir al Log in', ok: false);
    });
  }

  Future<bool> confirmEmail({required String token}) async {
    try {
      final resp = await MoonableApi.post('/auth/confirm/$token', {});
      if (resp['msg'] == 'ok') return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future sendEmailSupport({
    required String nombre,
    required String apellido,
    required String correo,
    required String mensaje,
  }) async {
    final data = {"nombre": nombre, "apellido": apellido, "correo": correo, "mensaje": mensaje};
    try {
      await MoonableApi.post('/usuarios/support', data);
      NotifServ.showSnackbarError(msg: 'Correo enviado a soporte', ok: true);
      return true;
    } catch (e) {
    
      return false;
    }
  }

  Future sendEmailToUser({
    required String nombre,
    required String apellido,
    required String correo,
    required String mensaje,
  }) async {
    final data = {"nombre": nombre, "apellido": apellido, "correo": correo, "mensaje": mensaje};
    try {
      await MoonableApi.post('/usuarios/contact-email', data);
      NotifServ.showSnackbarError(msg: 'Correo enviado a usuario',ok: true);
      return true;
    } catch (e) {
   
      return false;
    }
  }
}
