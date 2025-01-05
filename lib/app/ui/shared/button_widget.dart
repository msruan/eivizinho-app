import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const Button({super.key, required this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.blue,
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
