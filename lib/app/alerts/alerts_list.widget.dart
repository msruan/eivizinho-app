import 'package:eiviznho/app/alerts/alert.controller.dart';
import 'package:eiviznho/app/alerts/alert.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertsListWidget extends StatefulWidget {
  const AlertsListWidget({super.key});

  @override
  State<AlertsListWidget> createState() => _AlertsListWidgetState();
}

class _AlertsListWidgetState extends State<AlertsListWidget> {
  late Future<List<Alert>> futureAlerts;

  @override
  void initState() {
    super.initState();
    futureAlerts = AlertController().getAll();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder<List<Alert>>(
      future: futureAlerts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AlertListView(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

class AlertListView extends StatelessWidget {
  final List<Alert> _alerts;

  const AlertListView(this._alerts, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          final alert = _alerts[index];
          return AlertItem(alert: alert);
        },
      ),
    );
  }
}

class AlertItem extends StatelessWidget {
  final Alert alert;
  const AlertItem({required this.alert, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(alert.dt_hr);

    return Container(
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.warning, color: Colors.amber, size: 24),
              Text(alert.type)
            ],
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(alert.description)),
          Column(
            children: [
              Text(formattedDate),
              Icon(Icons.location_on, color: Colors.black, size: 24)
            ],
          )
        ],
      ),
    );
  }
}
