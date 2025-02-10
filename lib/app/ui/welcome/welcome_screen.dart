import 'package:eiviznho/app/config/assets.dart';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

//TODO: Responsiveness. In any screen resolution less than 412px the app breaks. And also on horizontal orientation
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const slogan = 'Todos pela segurança';
    const presentationText =
        'Emita alertas e deixe seus vizinhos saberem o que está acontecendo.\nTorne sua cidade mais segura.';
    const buttonAuxiliarText = 'Vamos fazer isso juntos?';

    final logoDecoration = GoogleFonts.kodchasan(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1);

    final subTitleDecoration = GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );

    final paragraphDecoration = GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textSecondary,
    );

    final smallTextDecoration = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.textSecondary,
    );

    final buttonTextDecoration = GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    Widget logo = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 15),
          child: Column(
            spacing: 20,
            children: [
              Text(
                'ei, VIZINHO!',
                style: logoDecoration,
              ),
              Image.asset(Assets.welcome),
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.grey,
        )
      ],
    );

    Widget presentation = Column(
      spacing: 24,
      children: [
        Text(
          slogan,
          style: subTitleDecoration,
        ),
        Text(
          presentationText,
          style: paragraphDecoration,
          textAlign: TextAlign.center,
        )
      ],
    );

    Widget footer = Column(
      spacing: 20,
      children: [
        Text(
          buttonAuxiliarText,
          style: smallTextDecoration,
        ),
        ElevatedButton(
          onPressed: () => context.go(Routes.home),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(101, 172, 172, 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            minimumSize: const Size.fromHeight(50), //////// HERE
          ),
          child: Text(
            'Começar',
            style: buttonTextDecoration,
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 46,
              children: [logo, presentation, footer],
            ),
          ),
        ),
      ),
    );
  }
}
