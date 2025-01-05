import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';

InputBorder _buildInputBorder(Color color, BorderRadius borderRadius) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: borderRadius,
  );
}

class TextInput<T extends Object> extends StatelessWidget {
  final Function(String) validator;
  final String? hintText;
  final TextEditingController controller;

  const TextInput({
    super.key,
    required this.controller,
    this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value!),
      maxLines: 8,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        enabledBorder:
            _buildInputBorder(AppColors.backgroundSecondary, borderRadius),
        focusedBorder: _buildInputBorder(AppColors.textPrimary, borderRadius),
        errorBorder: _buildInputBorder(Colors.red, borderRadius),
        focusedErrorBorder: _buildInputBorder(Colors.red, borderRadius),
      ),
    );
  }
}
