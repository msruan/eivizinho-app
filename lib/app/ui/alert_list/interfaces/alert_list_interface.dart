import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_list/components/alert_details.dart';
import 'package:eiviznho/app/ui/alert_list/components/alert_item.dart';
import 'package:eiviznho/app/ui/shared/base_list_widget.dart';
import 'package:flutter/material.dart';

class AlertListInterface extends StatelessWidget {
  final bool isLoading;
  final List<Alert> alerts;
  final Function handleRefresh;

  const AlertListInterface(
      {super.key,
      required this.isLoading,
      required this.alerts,
      required this.handleRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: BaseList<Alert>(
          isLoading: isLoading,
          emptyMessage: "Nenhum alerta encontrado!",
          data: alerts,
          itemBuilder: (alert) => AlertItem(
            alert: alert,
            alertDialog: AlertDetails(
              alert: alert,
            ),
          ),
        ),
        onRefresh: () => handleRefresh());
  }
}
