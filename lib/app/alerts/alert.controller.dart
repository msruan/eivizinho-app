import 'package:eiviznho/app/alerts/alert.model.dart';
// import 'package:http/http.dart' as http;

class AlertController {
  Future<List<Alert>> getAll() async {
    List<Alert> alerts = [
      Alert("Furto", "Crime ocorreu por volta das 15hrs", DateTime.now(),
          'Morada nova'),
      Alert("Roubo", "Suspeito fugiu do local", DateTime.now(), 'Irmã Dulce')
    ];
    return alerts;
  }

  Future<Alert> create() async {
    return Alert("Furto", "Crime ocorreu por volta das 15hrs",DateTime.now(), 'Ininga');
  }
}
