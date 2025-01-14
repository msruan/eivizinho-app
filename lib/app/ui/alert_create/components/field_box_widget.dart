import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/widgets.dart';

class FieldBox extends StatelessWidget {
  final String title;
  final Widget inputWidget;
  const FieldBox({super.key, required this.title, required this.inputWidget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: 4.0),
          inputWidget,
          SizedBox(height: 10.0)
        ],
      ),
    );
  }
}
