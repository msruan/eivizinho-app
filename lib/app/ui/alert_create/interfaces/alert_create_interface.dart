import 'package:eiviznho/app/ui/alert_create/containers/alert_create_container.dart';
import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:flutter/material.dart';
import '../components/dropdown.dart';

class AlertCreateInterface extends StatelessWidget {
  final FormInfoState formState;
  final VoidCallback onSubmit;

  const AlertCreateInterface({
    super.key,
    required this.formState,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(title: 'Criar alerta'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dropdown(),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              onChanged: (value) => formState.description = value,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: AppBaseScreen.bottomNavigationBar,
    );
  }
}
