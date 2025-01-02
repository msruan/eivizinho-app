import 'package:eiviznho/app/ui/test_alert_list/view_models/alert_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(
      create: (context) => AlertViewModel(),
    ),
  ];
}
