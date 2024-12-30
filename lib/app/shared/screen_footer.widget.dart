import 'package:flutter/material.dart';

BottomNavigationBar screenFooter = BottomNavigationBar(
  backgroundColor: Colors.pink,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add_ic_call_outlined,
      ),
      label: "Call",
    ),
  ],
);
