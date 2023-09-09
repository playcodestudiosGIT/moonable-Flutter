import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonable/providers/conf/settings_provider.dart';
import 'package:provider/provider.dart';

class TemplateTheme {
  static ThemeData tema1(context) {
    final themeMode = Provider.of<SettingsProvider>(context).themeMode;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade900,
        brightness: (themeMode == Thememode.dark) ? Brightness.dark : Brightness.light,
      ),
      textTheme: TextTheme(
          displayLarge: GoogleFonts.roboto(),
          headlineLarge: GoogleFonts.lato(fontStyle: FontStyle.italic),
          titleLarge: GoogleFonts.mulish(),
          bodyMedium: GoogleFonts.mulish()),
    );
  }
}
