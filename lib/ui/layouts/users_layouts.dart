import 'package:flutter/material.dart';
import 'package:moonable/providers/conf/global_keys_provider.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../widgets/drawers/custom_drawer.dart';

class UsersLayout extends StatelessWidget {
  final Widget child;
  const UsersLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final userScaffoldkey = Provider.of<GlobalKeysProvider>(context).userScaffoldkey;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        key: userScaffoldkey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          elevation: 10,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              userScaffoldkey.currentState!.openDrawer();
            },
          ),
          title: const Text('Moonable'),
          actions: [
            TextButton.icon(
                label: Text(
                  'Salir',
                  style: text10mini(context),
                ),
                onPressed: () {
                  authProvider.logOut(context);
                },
                icon: const Icon(Icons.exit_to_app)),
            const SizedBox(width: 15),
          ],
        ),
        body: child);
  }
}
