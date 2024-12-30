import 'package:eiviznho/app/alerts/alert.controller.dart';
import 'package:eiviznho/app/alerts/alert.model.dart';
import 'package:flutter/material.dart';

class AlertsListContainer extends StatefulWidget {
  const AlertsListContainer({super.key});

  @override
  State<AlertsListContainer> createState() => _AlertsListContainerState();
}

class _AlertsListContainerState extends State<AlertsListContainer> {
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
        itemBuilder: (context, index) => Text(_alerts[index].description),
      ),
    );
  }
}
