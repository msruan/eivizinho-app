import 'package:eiviznho/app/ui/alert_create/components/field_box_widget.dart';
import 'package:eiviznho/app/ui/alert_create/components/image_input.widget.dart';
import 'package:eiviznho/app/ui/alert_create/components/text_input_widget.dart';
import 'package:eiviznho/app/ui/alert_create/containers/alert_create_container.dart';
import 'package:eiviznho/app/ui/shared/button_widget.dart';
import 'package:eiviznho/app/ui/shared/dropdown_widget.dart';
import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:flutter/material.dart';

class AlertCreateInterface extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DropdownState dropdownState;
  final TextEditingController textingController;
  final MediaState mediaState;
  final VoidCallback onSubmit;
  final Function(String) validator;
  final bool isLoading;

  const AlertCreateInterface({
    super.key,
    required this.formKey,
    required this.dropdownState,
    required this.mediaState,
    required this.onSubmit,
    required this.validator,
    required this.textingController,
    required this.isLoading,
  });

  Widget _buildMainContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldBox(
                title: 'Tipo de acidente',
                inputWidget: Dropdown(
                  selectedValue: dropdownState.selectedValue,
                  hintText: 'Selecione o tipo de incidente',
                  items: dropdownState.types,
                  onChanged: (newTypeSelected) =>
                      dropdownState.onSelectValue(newTypeSelected),
                  itemLabelBuilder: (type) => type.name,
                ),
              ),
              FieldBox(
                title: 'Descrição',
                inputWidget: TextInput(
                  validator: validator,
                  controller: textingController,
                  hintText: 'Descreva o que aconteceu...',
                ),
              ),
              FieldBox(
                title: 'Anexos',
                inputWidget: ImageInput(
                  selectedMedia: mediaState.selectedMedia,
                  onPickGalleryImage: () async {
                    await mediaState.addMedia();
                  },
                  onRemoveImage: (index) => mediaState.removeMedia(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(title: 'Criar alerta'),
      body: Column(
        children: [
          _buildMainContent(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Button(
              onPress: onSubmit,
              title: 'ENVIAR',
              isLoading: isLoading,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
