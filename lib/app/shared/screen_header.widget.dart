import 'package:eiviznho/app/text.styles.dart';
import 'package:flutter/material.dart';

AppBar screenHeader({required String title}) {
  TextStyle titleDecoration = H1;
  return AppBar(
    title: Text(title),
    titleTextStyle: titleDecoration,
  );
}
