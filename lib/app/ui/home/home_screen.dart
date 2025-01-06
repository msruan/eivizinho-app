import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: const Placeholder(
        fallbackHeight: 120,
        fallbackWidth: 120,
      )),
      // bottomNavigationBar: AppBaseScreen.bottomNavigationBar,
    );
  }
}
