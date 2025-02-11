import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/themes/alert_categories.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertItem extends StatelessWidget {
  final Alert alert;
  final Widget alertDialog;

  const AlertItem({required this.alert, required this.alertDialog, super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(alert.dtHr);
    final time = DateFormat('HH:mm').format(alert.dtHr);

    final icon = AlertCategoriesTheme.getByName(alert.category.name).icon;
    final color = AlertCategoriesTheme.getGravityColor(alert.category.gravity);

    return InkWell(
      onTap: () => showDialog(
          context: context, builder: (BuildContext context) => alertDialog),
      child: Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Icon(icon, color: color, size: 24),
                  Text(
                    alert.category.name,
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
      ),
    );
  }
}
