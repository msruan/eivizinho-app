import 'package:eiviznho/app/shared/screen_footer.widget.dart';
import 'package:eiviznho/app/shared/screen_header.widget.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget content;
  final String title;
  const BaseScreen({required this.title, required this.content, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: content,
        ),
      ),
      appBar: screenHeader(title: title),
      bottomNavigationBar: screenFooter,
    );
  }
}
