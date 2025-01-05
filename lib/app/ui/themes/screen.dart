import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';

abstract final class AppBaseScreen {
  static final bottomNavigationBar = _BaseScreenBottomNavigationBarWIdget();
  static final appBar = _baseScreenAppBar;
}

AppBar _baseScreenAppBar({required String title}) {
  TextStyle textDecoration = AppTextStyles.titleMedium;
  return AppBar(
    centerTitle: true,
    title: Text(title),
    titleTextStyle: textDecoration,
    backgroundColor: AppColors.backgroundPrimary
  );
}

class _BaseScreenBottomNavigationBarWIdget extends StatefulWidget {
  const _BaseScreenBottomNavigationBarWIdget();

  @override
  State<_BaseScreenBottomNavigationBarWIdget> createState() =>
      _BaseScreenBottomNavigationBarWIdgetState();
}

class _BaseScreenBottomNavigationBarWIdgetState
    extends State<_BaseScreenBottomNavigationBarWIdget> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      backgroundColor: AppColors.backgroundPrimary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.grey,
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
      onTap: (newIndex) {
        setState(() {
          _index = newIndex;
        });
      },
    );
  }
}
