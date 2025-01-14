import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';

InputBorder _buildInputBorder(Color color, BorderRadius borderRadius) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: borderRadius,
  );
}

class TextInput<T> extends StatelessWidget {
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
          enabledBorder:
              _buildInputBorder(AppColors.backgroundSecondary, borderRadius),
          focusedBorder: _buildInputBorder(AppColors.textPrimary, borderRadius),
          errorBorder: _buildInputBorder(AppColors.red, borderRadius),
          focusedErrorBorder: _buildInputBorder(AppColors.red, borderRadius),
          errorStyle: TextStyle(color: AppColors.red, fontSize: 12)),
    );
  }
}
