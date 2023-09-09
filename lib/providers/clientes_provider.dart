import 'package:flutter/widgets.dart';

import '../models/cliente_model.dart';

class ClientesProvider extends ChangeNotifier {
  final List<Cliente> clientes = [];
}
