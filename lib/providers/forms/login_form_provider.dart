import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class LoginFormProvider extends ChangeNotifier {
  String email = '';
  String pass = '';

  setEmail(String value) {
    email = value;
  }

  setPassword(String value) {
    pass = value;
  }

  Future<bool> validateForm({required BuildContext context, required bool isValid}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.login(context, email, pass);
    notifyListeners();
    return true;
  }
}
