import 'package:flutter/material.dart';
import 'package:moonable/api/moonable_api.dart';
import 'package:provider/provider.dart';

import '../models/usuario_model.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigator_service.dart';
import '../services/notificacion_service.dart';
import 'conf/global_keys_provider.dart';
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
      user = authResponse.usuario;
      _token = authResponse.token;
      authStatus = AuthStatus.authenticated;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      NotifServ.showSnackbarError('Hubo un problema con tu autenticación', Colors.red);
      authStatus = AuthStatus.notAuthenticated;
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  login( BuildContext context, String email, String password) async {
    isLoading = true;
    final data = {'correo': email, 'password': password};

    MoonableApi.post('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      if (!authResponse.usuario.estado) {
        NotifServ.showSnackbarError('Un Administrador debe autorizar su registro', Colors.red);
        // NavigatorService.replaceTo(Flurorouter.login);
        isLoading = false;
        notifyListeners();
        return;
      }
      user = authResponse.usuario;
      _token = authResponse.token;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', json['token']);

      MoonableApi.configureDio();
      NavigatorService.navigateTo(Flurorouter.auditorMonitor);
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      NotifServ.showSnackbarError('Credenciales Invalidas', Colors.red);
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

      Usuario user = authResponse.usuario;
      _token = authResponse.token;
      print(user.estado);

      if (!user.estado) {
        NotifServ.showSnackbarError('Gracias por registrarte, un administrador debe aprobar tu registro', Colors.green);
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
      NotifServ.showSnackbarError('Correo ya existe. ir al Log in', Colors.red);
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
      NotifServ.showSnackbarError('Correo enviado a soporte', Colors.green);
      return true;
    } catch (e) {
      print(e);
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
      NotifServ.showSnackbarError('Correo enviado a usuario', Colors.green);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
