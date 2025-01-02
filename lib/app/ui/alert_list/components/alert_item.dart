import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertItem extends StatelessWidget {
  final AlertEntity alert;

  final Map<String, IconData> alertIcons = {
    'Arrombamento': Icons.lock,
    'Incêndio': Icons.local_fire_department_rounded,
    'Acidente': Icons.local_hospital,
    'Assalto': Icons.warning_rounded,
  };

  AlertItem({required this.alert, super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(alert.dtHr);
    final time = DateFormat('HH:mm').format(alert.dtHr);

    final icon = alertIcons[alert.category] ?? Icons.warning_rounded;

    return Container(
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Column(
              children: [
                Icon(icon, color: AppColors.textPrimary, size: 24),
                Text(
                  alert.category,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                alert.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
