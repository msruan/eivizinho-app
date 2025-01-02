import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_list/components/alert_item.dart';
import 'package:eiviznho/app/ui/shared/base_list.widget.dart';
import 'package:eiviznho/app/ui/shared/base_screen.widget.dart';
import 'package:flutter/material.dart';

class AlertListInterface extends StatelessWidget {
  final bool isLoading;
  final List<AlertEntity> alerts;

  const AlertListInterface({
    super.key,
    required this.isLoading,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Alertas",
      content: BaseList<AlertEntity>(
        isLoading: isLoading,
        emptyMessage: "Nenhum alerta encontrado!",
        data: alerts,
        itemBuilder: (alert) => AlertItem(alert: alert),
      ),
    );
  }
}
