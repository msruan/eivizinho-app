import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';

AppBar baseAppBar({required String title}) {
  TextStyle textDecoration = AppTextStyles.titleLarge;
  return AppBar(
    centerTitle: true,
    title: Text(title),
    titleTextStyle: textDecoration,
    backgroundColor: Colors.white,
  );
}
