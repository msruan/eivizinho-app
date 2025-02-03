import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AlertDetails extends StatelessWidget {
  final Alert alert;
  AlertDetails({super.key, required this.alert});

  final Map<String, IconData> alertIcons = {
    'Arrombamento': Icons.lock,
    'Incêndio': Icons.local_fire_department_rounded,
    'Acidente': Icons.local_hospital,
    'Assalto': Icons.warning_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final icon = alertIcons[alert.category.name] ?? Icons.warning_rounded;
    final date = DateFormat('dd/MM/yyyy').format(alert.dtHr);
    final time = DateFormat('HH:mm').format(alert.dtHr);

    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.close,
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 22, right: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 18,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withAlpha(15),
                        child:
                            Icon(icon, color: AppColors.textPrimary, size: 18),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.category.name,
                          style: AppTextStyles.titleExtraSmall,
                          textAlign: TextAlign.left,
                        ),
                        Text('$time • $date')
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  alert.description,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Placeholder(
                    fallbackHeight: 102,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Relatado por Asa',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
