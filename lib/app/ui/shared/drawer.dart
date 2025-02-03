import 'package:eiviznho/app/config/assets.dart';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              accountName: Text('Entrar ou criar conta'),
              accountEmail: Text('Desbloqueie o alerta de incidentes'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(Assets.noProfile),
              ),
            ),
            onTap: () => context.push(Routes.register),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('Zaun'),
          // )
        ],
      ),
    );
  }
}
