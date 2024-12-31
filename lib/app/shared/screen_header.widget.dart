import 'package:eiviznho/app/styles/colors.dart';
import 'package:eiviznho/app/styles/text.styles.dart';
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
