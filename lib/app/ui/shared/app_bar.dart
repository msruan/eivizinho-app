import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';

AppBar baseAppBar({required String title}) {
  TextStyle textDecoration = AppTextStyles.titleSmall;
  return AppBar(
    centerTitle: true,
    title: Text(title),
    titleTextStyle: textDecoration,
    backgroundColor: AppColors.backgroundSecondary,
  );
}
