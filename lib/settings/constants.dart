import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/models/operation_model.dart';

//Colors

Color primary(context) => Theme.of(context).colorScheme.primary;
Color secondary(context) => Theme.of(context).colorScheme.secondary;
Color tertiary(context) => Theme.of(context).colorScheme.tertiary;
Color bgColor(context) => Theme.of(context).colorScheme.background;
Color textColor(context) =>
    Theme.of(context).primaryTextTheme.bodyMedium!.color!;

// Textos

TextStyle text45DisplayM(context) => Theme.of(context).textTheme.displayLarge!;
TextStyle text32Headline(context) => Theme.of(context).textTheme.headlineLarge!;
TextStyle text22Title(context) => Theme.of(context).textTheme.titleLarge!;
TextStyle text14BodyM(context) => Theme.of(context).textTheme.bodyMedium!;
TextStyle text14BodyMOp(context) => Theme.of(context)
    .textTheme
    .bodyMedium!
    .copyWith(color: Colors.grey);
TextStyle text10mini(context) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10);
TextStyle text10miniOp(context) => Theme.of(context)
    .textTheme
    .bodyMedium!
    .copyWith(fontSize: 10, color: Colors.grey);

// Setting Variables

// Env Variables
double wSize(context) => MediaQuery.of(context).size.width;
double hSize(context) => MediaQuery.of(context).size.height;

final operationDummy = Operation(
  assetType: '',
  client: '',
  createdAt: DateTime.now(),
  estado: true,
  exchangeRate: 0,
  percent: 0,
  platform: '',
  uid: '',
  updatedAt: DateTime.now(),
  ibanWallet: '',
  fiatAmount: 0,
  fiatType: '',
  dueDate: DateTime.now(),
);

final clienteDummy = Client(
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  estado: true,
  uid: '',
  businessName: '',
  firstName: '',
  lastName: '',
  ibanWallet: [],
  operations: [],
  tier: 'Tier - 0',
  tierStatus: 'Pending',
  clientType: '',
  registryDate: '',
  countryResidency: '',
  nationality: '',
  birth: '',
  documentNumber: '',
  expirationDate: DateTime.now().toString(),
  residenceLand: '',
  nationalityLand: '',
  userAge: '',
  auxRiesgo: '',
);
