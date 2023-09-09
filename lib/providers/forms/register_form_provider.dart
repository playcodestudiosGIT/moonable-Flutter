import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class RegisterFormProvider extends ChangeNotifier {


  String email = '';
  String nombre = '';
  String apellido = '';
  String password1 = '';
  String password2 = '';

  setEmail(value) {
    email = value;
    ChangeNotifier();
  }

  setNombre(value) {
    nombre = value;
    ChangeNotifier();
  }

  setApellido(value) {
    apellido = value;
    ChangeNotifier();
  }

  setPassword1(value) {
    password1 = value;
    ChangeNotifier();
  }

  setPassword2(value) {
    password2 = value;
    ChangeNotifier();
  }

  Future<bool> validateForm({required BuildContext context, required bool isValid}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.register(correo: email, password: password1, nombre: nombre, apellido: apellido);
    notifyListeners();
    return true;
  }

}
