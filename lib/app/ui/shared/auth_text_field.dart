import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget buildInputField({
  required TextEditingController controller,
  required String labelText,
  required bool obscureText,
  bool isCPFField = false,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    controller: controller,
    inputFormatters:
        isCPFField ? [MaskTextInputFormatter(mask: '###.###.###-##')] : [],
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
          color: AppColors.backgroundSecondary, fontWeight: FontWeight.w100),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.backgroundSecondary,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.green,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.backgroundSecondary,
          width: 1,
        ),
      ),
    ),
    obscureText: obscureText,
    validator: validator,
  );
}
