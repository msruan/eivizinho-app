import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/domain/usecases/get_alerts_usecases.dart';
import 'package:eiviznho/app/ui/screens/AlertList/alert_list_injection.dart';
import 'package:eiviznho/app/ui/screens/AlertList/interfaces/alert_list_interface.dart';
import 'package:flutter/material.dart';

class AlertListContainer extends StatefulWidget {
  const AlertListContainer({super.key});

  @override
  State<AlertListContainer> createState() => _AlertListContainerState();
}

class _AlertListContainerState extends State<AlertListContainer> {
  late GetAlertsUsecases _getAlertsUsecases;

  List<AlertEntity> alerts = [];
  List<AlertEntity> fetchedAlerts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getAlertsUsecases = alertListInject.get<GetAlertsUsecases>();

    _fetchAlerts();
  }

  Future<void> _fetchAlerts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _getAlertsUsecases.execute();
      setState(() {
        alerts = result;
        fetchedAlerts = result;
      });
    } catch (e) {
      setState(() {
        alerts = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertListInterface(
      alerts: alerts,
      isLoading: isLoading,
    );
  }
}
