import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_list/alert_list_injection.dart';
import 'package:eiviznho/app/ui/alert_list/interfaces/alert_list_interface.dart';
import 'package:flutter/material.dart';

class AlertListContainer extends StatefulWidget {
  const AlertListContainer({super.key});

  @override
  State<AlertListContainer> createState() => _AlertListContainerState();
}

class _AlertListContainerState extends State<AlertListContainer> {
  late AlertRepository _alertRepository;

  List<AlertEntity> alerts = [];
  List<AlertEntity> fetchedAlerts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _alertRepository = alertListInject.get<AlertRepository>();

    _fetchAlerts();
  }

  Future<void> _fetchAlerts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _alertRepository.getAllAlerts();
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
