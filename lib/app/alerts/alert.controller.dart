import 'package:eiviznho/app/alerts/alert.model.dart';
import 'package:http/http.dart' as http;

class AlertController {
  Future<List<Alert>> getAll() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    List<Alert> alerts = [
      Alert("Furto", "Crime ocorreu por volta das 15hrs"),
      Alert("Roubo", "Suspeito fugiu do local")
    ];
    return alerts;
  }
}
