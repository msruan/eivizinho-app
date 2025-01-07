import 'package:eiviznho/app/config/dependencies.dart';
import 'package:eiviznho/app/data/dtos/alerts/create_alert_dto.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_create/interfaces/alert_create_interface.dart';
import 'package:eiviznho/app/utils/get_current_position.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:june/june.dart';

class DropdownState extends JuneState {
  AlertCategory? selectedValue;
  List<AlertCategory> types = [];

  void updateTypes(List<AlertCategory> typesList) {
    types = typesList;
    selectedValue = null;
    setState();
  }

  void onSelectValue(AlertCategory? newValue) {
    selectedValue = newValue;
    setState();
  }
}

class MediaState extends JuneState {
  List<XFile> selectedMedia = [];

  Future<void> addMedia() async {
    try {
      final result = await ImagePicker().pickMultiImage();
      if (result.isNotEmpty) {
        selectedMedia = [...selectedMedia, ...result].take(5).toList();
        setState();
      }
    } catch (e) {
      throw Exception('Erro no pick da galeria... $e');
    }
  }

  void removeMedia(int index) {
    selectedMedia.removeAt(index);
    setState();
  }

  void clear() {
    selectedMedia.clear();
    setState();
  }
}

class AlertCreateContainer extends StatefulWidget {
  const AlertCreateContainer({super.key});

  @override
  _AlertCreateContainerState createState() => _AlertCreateContainerState();
}

class _AlertCreateContainerState extends State<AlertCreateContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AlertCategoryRepository _alertTypeRepository;
  late AlertRepository _alertRepository;

  late TextEditingController _descriptionController;

  DropdownState dropdownState = June.getState(() => DropdownState());
  MediaState mediaState = June.getState(() => MediaState());

  @override
  void initState() {
    super.initState();
    _alertTypeRepository = injector.get<AlertCategoryRepository>();
    _alertRepository = injector.get<AlertRepository>();
    _descriptionController = TextEditingController();

    _fetchAlertTypes();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    dropdownState.updateTypes([]);
    mediaState.clear();
    super.dispose();
  }

  String? _validatorString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<void> _fetchAlertTypes() async {
    try {
      final result = await _alertTypeRepository.getAllAlertType();
      dropdownState.updateTypes(result);
    } catch (e) {
      dropdownState.updateTypes([]);
    }
  }

  Future<void> _submitForm() async {
    if (!mounted) return;
    FocusScope.of(context).unfocus();

    final description = _descriptionController.text;
    final selectedAlertType = dropdownState.selectedValue;
    final selectedMedia = mediaState.selectedMedia;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Position currentPosition = await getCurrentPosition();

    final requestData = CreateAlertRequestDTO(
      name: description,
      categories: [selectedAlertType!],
      media: selectedMedia,
      location: Location(
          latitude: currentPosition.latitude,
          longitude: currentPosition.longitude),
    );

    await _alertRepository.createAlert(requestData);

    _formKey.currentState?.reset();
    _descriptionController.clear();
    dropdownState.updateTypes([]);
    mediaState.clear();
  }

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => MediaState(),
        builder: (mediaState) => JuneBuilder(
              () => DropdownState(),
              builder: (dropdownState) => AlertCreateInterface(
                textingController: _descriptionController,
                onSubmit: _submitForm,
                dropdownState: dropdownState,
                mediaState: mediaState,
                validator: _validatorString,
                formKey: _formKey,
              ),
            ));
  }
}
