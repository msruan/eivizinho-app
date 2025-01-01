import 'package:eiviznho/app/ui/styles/colors.dart';
import 'package:eiviznho/app/ui/styles/text.styles.dart';
import 'package:flutter/material.dart';

AppBar screenHeader({required String title}) {
  TextStyle textDecoration = AppTextStyles.titleSmall;
  return AppBar(
    centerTitle: true,
    title: Text(title),
    titleTextStyle: textDecoration,
    backgroundColor: AppColors.backgroundSecondary,
  );
}
