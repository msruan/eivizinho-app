import 'package:eiviznho/app/ui/shared/base_screen.widget.dart';
import 'package:eiviznho/app/ui/alert_list/components/alert_item.dart';
import 'package:eiviznho/app/ui/test_alert_list/view_models/alert_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertListScreen2 extends StatefulWidget {
  const AlertListScreen2({
    super.key,
  });

  @override
  State<AlertListScreen2> createState() => _AlertListScreen2State();
}

class _AlertListScreen2State extends State<AlertListScreen2> {
  @override
  void initState() {
    super.initState();

    // Chama o método fetchUser quando a tela é inicializada
    Future.microtask(() {
      Provider.of<AlertViewModel>(context, listen: false).fetchAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AlertViewModel>(context);

    return BaseScreen(
      title: "Alertas",
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 46),
          child: Column(
            children: [
              Expanded(
                child: viewModel.alerts == null
                    ? const Center(child: CircularProgressIndicator())
                    : viewModel.alerts!.isEmpty
                        ? const Center(child: Text("Nenhum alerta encontrado!"))
                        : ListView.builder(
                            padding: const EdgeInsets.only(top: 45),
                            itemCount: viewModel.alerts!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child:
                                    AlertItem(alert: viewModel.alerts![index]),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
