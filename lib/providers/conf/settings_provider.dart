import 'package:flutter/material.dart';

enum Thememode { dark, ligth }

class SettingsProvider extends ChangeNotifier {
  Thememode _themeMode = Thememode.dark;

  Thememode get themeMode => _themeMode;
  
  set themeMode(Thememode value) {
      _themeMode = value;
      notifyListeners();
  }
}
