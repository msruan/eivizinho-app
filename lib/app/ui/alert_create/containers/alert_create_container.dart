import 'package:eiviznho/app/config/dependencies.dart';
import 'package:eiviznho/app/config/exceptions.dart';
import 'package:eiviznho/app/data/dtos/alerts/create_alert_dto.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/alert_create/interfaces/alert_create_interface.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:june/june.dart';

import '../../location_picker/location_picker_screen.dart';

class LocationState extends JuneState {
  LatLng? selectedLocation;
  String? address;

  void updateLocation(LatLng newLocation) async {
    selectedLocation = newLocation;
    address = await _getAddressFromLatLng(newLocation);
    setState();
  }

  void clear() {
    selectedLocation = null;
    address = null;
    setState();
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        geo.Placemark place = placemarks.first;

        return "${place.thoroughfare ?? "Rua desconhecida"}, ${place.subThoroughfare ?? "número desconhecido"}";
      } else {
        return "Endereço não encontrado";
      }
    } catch (e) {
      throw Exception("Erro ao obter endereço: $e");
    }
  }
}

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
      throw InternalSystemException('Erro ao pegar imagens da galeria: $e');
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
  State<AlertCreateContainer> createState() => _AlertCreateContainerState();
}

class _AlertCreateContainerState extends State<AlertCreateContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AlertCategoryRepository _alertTypeRepository;
  late AlertRepository _alertRepository;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;

  DropdownState dropdownState = June.getState(() => DropdownState());
  MediaState mediaState = June.getState(() => MediaState());
  LocationState locationState = June.getState(() => LocationState());

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _alertTypeRepository = injector.get<AlertCategoryRepository>();
    _alertRepository = injector.get<AlertRepository>();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _fetchAlertTypes();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    dropdownState.updateTypes([]);
    locationState.clear();
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

  Future<void> _pickLocation() async {
    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (pickedLocation != null) {
      locationState.updateLocation(pickedLocation);
    } else {
      throw Exception("Nenhuma localização selecionada");
    }
  }

  Future<void> _submitForm() async {
    if (!mounted) return;
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final description = _descriptionController.text;
    final date = _dateController.text;
    final selectedAlertType = dropdownState.selectedValue;
    final selectedMedia = mediaState.selectedMedia;

    final requestData = CreateAlertRequestDTO(
      name: description,
      approximateDtHr: date,
      categories: [selectedAlertType!],
      media: selectedMedia,
      location: Location(
        latitude: locationState.selectedLocation!.latitude,
        longitude: locationState.selectedLocation!.longitude,
      ),
    );

    await _alertRepository.createAlert(requestData);

    if (mounted) {
      context.go(Routes.alertsList);
    }

    _formKey.currentState?.reset();
    _descriptionController.clear();
    _dateController.clear();
    dropdownState.updateTypes([]);
    locationState.clear();
    mediaState.clear();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => MediaState(),
      builder: (mediaState) => JuneBuilder(
        () => DropdownState(),
        builder: (dropdownState) => AlertCreateInterface(
          textingController: _descriptionController,
          dateController: _dateController,
          onSubmit: _submitForm,
          dropdownState: dropdownState,
          mediaState: mediaState,
          locationState: locationState,
          onPickLocation: _pickLocation,
          validator: _validatorString,
          formKey: _formKey,
          isLoading: _isLoading,
        ),
      ),
    );
  }
}
