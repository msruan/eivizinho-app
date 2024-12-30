import 'package:flutter/material.dart';

BottomNavigationBar screenFooter = BottomNavigationBar(
  backgroundColor: Colors.blueGrey,
  type: BottomNavigationBarType.shifting,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.forum_rounded,
      ),
      label: "Notifications",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.warning_rounded,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.list_rounded,
      ),
      label: "Alertas",
    ),
  ],
);
