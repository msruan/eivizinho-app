import 'package:eiviznho/app/ui/shared/screen_footer.widget.dart';
import 'package:eiviznho/app/ui/shared/screen_header.widget.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.forum_rounded,
            ),
            label: "Notificações",
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
      ),
    );
  }
}
