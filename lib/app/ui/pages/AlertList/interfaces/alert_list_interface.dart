import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/shared/base_screen.widget.dart';
import 'package:eiviznho/app/ui/pages/AlertList/components/alert_item.dart';
import 'package:flutter/material.dart';

class AlertListInterface extends StatelessWidget {
  final List<AlertEntity> alerts;
  final bool isLoading;

  const AlertListInterface({
    super.key,
    required this.alerts,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
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
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator())
                    : alerts.isEmpty
                        ? const Center(child: Text("Nenhum alerta encontrado!"))
                        : ListView.builder(
                            padding: const EdgeInsets.only(top: 45),
                            itemCount: alerts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                child: AlertItem(alert: alerts[index]),
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
