import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:eiviznho/app/routing/routes.dart';

import 'package:go_router/go_router.dart';

class MainLayout extends StatefulWidget {
  final String title;
  final Widget content;

  const MainLayout({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    final hasAppBar = widget.title != '';
    final List<Widget> appBar = [];
    if (hasAppBar) {
      appBar.add(baseAppBar(title: widget.title));
    }
    return SafeArea(
      child: Column(
        children: [
          ...appBar,
          Expanded(child: widget.content),
          _MainLayoutBottomBar()
        ],
      ),
    );
    // return Scaffold(
    //   appBar: hasAppBar ? baseAppBar(title: widget.title) : null,
    //   body: SafeArea(child: widget.content),
    //   bottomNavigationBar: _MainLayoutBottomBar(),
    // );
  }
}

//Todo: I seek something about parentKey...
class _MainLayoutBottomBar extends StatefulWidget {
  const _MainLayoutBottomBar({super.key});

  @override
  State<_MainLayoutBottomBar> createState() => _MainLayoutBottomBarState();
}

class _MainLayoutBottomBarState extends State<_MainLayoutBottomBar> {
  int currentIndex = 1;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.replace(Routes.notifications);
        break;
      case 1:
        context.replace(Routes.home);
        break;
      default:
        context.replace(Routes.alertsList);
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Todo: make sure the order of routes equals to icons order
    const icons = [
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
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.blueGrey,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.grey,
      items: icons,
      onTap: changeTab,
    );
  }
}
