import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String name;
  final String category;
  final DateTime date;

  const NotificationItem({
    super.key,
    required this.name,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone de alerta
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child:
                Icon(Icons.warning_rounded, size: 32.0, color: Colors.black87),
          ),

          // Texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  name,
                  style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Data e hora
          Row(
            children: [
              const Icon(Icons.access_time, size: 16.0, color: Colors.black54),
              const SizedBox(width: 4.0),
              Text(
                '${date.toLocal().hour}:${date.toLocal().minute}',
                style: const TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
