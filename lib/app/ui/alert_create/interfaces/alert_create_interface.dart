import 'package:date_field/date_field.dart';
import 'package:eiviznho/app/ui/alert_create/components/field_box_widget.dart';
import 'package:eiviznho/app/ui/alert_create/components/image_input.widget.dart';
import 'package:eiviznho/app/ui/alert_create/components/text_input_widget.dart';
import 'package:eiviznho/app/ui/alert_create/containers/alert_create_container.dart';
import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:eiviznho/app/ui/shared/button_widget.dart';
import 'package:eiviznho/app/ui/shared/dropdown_widget.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:june/june.dart';

class AlertCreateInterface extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DropdownState dropdownState;
  final TextEditingController textingController;
  final TextEditingController dateController;
  final MediaState mediaState;
  final LocationState locationState;
  final VoidCallback onSubmit;
  final VoidCallback onPickLocation;
  final Function(String) validator;
  final bool isLoading;

  const AlertCreateInterface(
      {super.key,
      required this.formKey,
      required this.dropdownState,
      required this.mediaState,
      required this.locationState,
      required this.onSubmit,
      required this.onPickLocation,
      required this.validator,
      required this.textingController,
      required this.isLoading,
      required this.dateController});

  Widget _buildTypeOfAccident() {
    return FieldBox(
      title: 'Tipo de acidente',
      inputWidget: Dropdown(
        selectedValue: dropdownState.selectedValue,
        hintText: 'Selecione o tipo de incidente',
        items: dropdownState.types,
        onChanged: (newTypeSelected) =>
            dropdownState.onSelectValue(newTypeSelected),
        itemLabelBuilder: (type) => type.name,
      ),
    );
  }

  Widget _buildDescription() {
    return FieldBox(
      title: 'Descrição',
      inputWidget: TextInput(
        validator: validator,
        controller: textingController,
        hintText: 'Descreva o que aconteceu...',
      ),
    );
  }

  Widget _buildLocationButton(BuildContext context) {
    return FieldBox(
      title: 'Localização',
      inputWidget: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(color: AppColors.backgroundSecondary, width: 1),
        ),
        onPressed: onPickLocation,
        child: Row(
          children: [
            Expanded(
              child: Text(
                locationState.address ?? "Selecionar localização",
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.location_on,
              color: AppColors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    return FieldBox(
      title: 'Data aproximada',
      inputWidget: DateTimeFormField(
        mode: DateTimeFieldPickerMode.dateAndTime,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          labelText: 'Selecione uma data',
          labelStyle: Theme.of(context).textTheme.bodySmall,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.backgroundSecondary,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.green,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.backgroundSecondary,
              width: 1,
            ),
          ),
        ),
        firstDate: DateTime.now().add(const Duration(days: 10)),
        lastDate: DateTime.now().add(const Duration(days: 40)),
        initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
        onChanged: (DateTime? value) {
          if (value != null) {
            dateController.text = value.toIso8601String();
          }
        },
      ),
    );
  }

  Widget _buildAttachments() {
    return FieldBox(
      title: 'Anexos',
      inputWidget: ImageInput(
        selectedMedia: mediaState.selectedMedia,
        onPickGalleryImage: () async {
          await mediaState.addMedia();
        },
        onRemoveImage: (index) => mediaState.removeMedia(index),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypeOfAccident(),
              const SizedBox(
                height: 15,
              ),
              _buildDescription(),
              const SizedBox(
                height: 15,
              ),
              _buildDate(context),
              const SizedBox(
                height: 15,
              ),
              JuneBuilder(
                () => locationState,
                builder: (locationState) => _buildLocationButton(context),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildAttachments(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Button(
        backgroundColor: AppColors.primaryBlue,
        onPress: onSubmit,
        title: 'ENVIAR',
        isLoading: isLoading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(title: 'Criar alerta'),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: _buildMainContent(context)),
          SafeArea(child: _buildSubmitButton()),
        ],
      ),
    );
  }
}
