import 'package:eiviznho/app/ui/alert_list/containers/alert_list_container.dart';

import 'package:flutter/material.dart';

class AlertListScreen extends StatelessWidget {
  const AlertListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertListContainer(),
    );
  }
}
// floatingActionButton: FloatingActionButton(
//         onPressed: () => context.go(Routes.createAlert),
//         child: const Icon(Icons.add),
//       ),
