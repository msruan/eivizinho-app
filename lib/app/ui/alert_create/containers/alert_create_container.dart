// ignore_for_file: avoid_print
import 'package:eiviznho/app/data/repositories/alert_type/alert_type_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_type_entity.dart';
import 'package:eiviznho/app/ui/alert_create/alert_create_injection.dart';
import 'package:eiviznho/app/ui/alert_create/interfaces/alert_create_interface.dart';
import 'package:flutter/material.dart';
import 'package:june/june.dart';

class DropdownState extends JuneState {
  AlertType? selectedValue;
  List<AlertType> types = [];
}

class FormInfoState extends JuneState {
  String? description;
}

class AlertCreateContainer extends StatefulWidget {
  const AlertCreateContainer({super.key});

  @override
  State<AlertCreateContainer> createState() => _AlertCreateContainerState();
}

class _AlertCreateContainerState extends State<AlertCreateContainer> {
  late AlertTypeRepository _alertTypeRepository;

  @override
  void initState() {
    super.initState();
    _alertTypeRepository = alertTypeInject.get<AlertTypeRepository>();
    _fetchAlertTypes();
  }

  Future<void> _fetchAlertTypes() async {
    DropdownState dropdownState = June.getState(() => DropdownState());

    try {
      final result = await _alertTypeRepository.getAllAlertType();
      dropdownState
        ..types = result
        ..setState();
    } catch (e) {
      dropdownState
        ..types = []
        ..setState();
    }
  }

  Future<void> _submitForm(
      FormInfoState formState, DropdownState dropdownState) async {
    final description = formState.description;
    final selectedAlertType = dropdownState.selectedValue;

    if (description == null ||
        description.isEmpty ||
        selectedAlertType == null) {
      print('Form com campo nulo...');
      return;
    }

    print('Alerta criado!!');
    print('Tipo de alerta: ${selectedAlertType.name}');
    print('Descrição: $description');
  }

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => FormInfoState(),
      builder: (formState) {
        return AlertCreateInterface(
          formState: formState,
          onSubmit: () {
            final dropdownState =
                June.getState<DropdownState>(() => DropdownState());
            _submitForm(formState, dropdownState);
          },
        );
      },
    );
  }
}
