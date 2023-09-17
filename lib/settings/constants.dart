import 'package:flutter/material.dart';

//Colors

Color primary(context) => Theme.of(context).colorScheme.primary;
Color secondary(context) => Theme.of(context).colorScheme.secondary;
Color tertiary(context) => Theme.of(context).colorScheme.tertiary;
Color bgColor(context) => Theme.of(context).colorScheme.background;
Color textColor(context) => Theme.of(context).primaryTextTheme.bodyMedium!.color!;

// Textos

TextStyle text45DisplayM(context) => Theme.of(context).textTheme.displayLarge!;
TextStyle text32Headline(context) => Theme.of(context).textTheme.headlineLarge!;
TextStyle text22Title(context) => Theme.of(context).textTheme.titleLarge!;
TextStyle text14BodyM(context) => Theme.of(context).textTheme.bodyMedium!;
TextStyle text14BodyMOp(context) => Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white.withOpacity(0.5));
TextStyle text10mini(context) => Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10);
TextStyle text10miniOp(context) => Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10, color: Colors.white.withOpacity(0.5));

// Setting Variables

// Env Variables
double wSize(context) => MediaQuery.of(context).size.width;
double hSize(context) => MediaQuery.of(context).size.height;
