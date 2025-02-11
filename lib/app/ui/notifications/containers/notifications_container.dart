import 'dart:async';
import 'dart:convert';

import 'package:eiviznho/app/config/dependencies.dart';
import 'package:eiviznho/app/data/repositories/notifications/notifications_repository.dart';
import 'package:eiviznho/app/domain/entities/notification_entity.dart';
import 'package:eiviznho/app/ui/notifications/components/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class NotificationsContent extends StatefulWidget {
  const NotificationsContent({super.key});

  @override
  NotificationContentState createState() => NotificationContentState();
}

class NotificationContentState extends State<NotificationsContent> {
  late NotificationsRepository _notificationsRepository;

  StreamSubscription<SSEModel>? _sseSubscription;

  late List<AppNotification> messages = [];
  // final String uid = 'cliente-1234'; // UID único do cliente

  String uid = Uuid().v4(); // UID único do cliente
  final String? baseUrl = dotenv.env['BASE_URL'];

  @override
  void initState() {
    super.initState();

    _notificationsRepository = injector.get<NotificationsRepository>();

    _startConnection();
    
  }

  void _startConnection() {
    _notificationsRepository.getAllNotifications().then((value) {
      setState(() {
        messages = value;
      });
    });
    _subscribeToChannel();
    _connectToSse();
  }

  /// 🔹 Faz a inscrição no canal "users"
  Future<void> _subscribeToChannel() async {
    uid = Uuid().v4();

    final response = await http.post(
      Uri.parse('$baseUrl/__transmit/subscribe'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'channel': 'notification/ola', 'uid': uid}),
    );

    if (response.statusCode == 204) {
      print('✅ Inscrito no canal "users"');
    } else {
      print('❌ Erro ao se inscrever: ${response.toString()}');
      print('❌ ${response.statusCode}');
    }
  }

  /// 🔹 Conecta ao servidor SSE e começa a ouvir os eventos.
  void _connectToSse() {
    if (baseUrl == null) {
      print('❌ Erro ao se conectar: BASE_URL não definida');
      return;
    }

    if (_sseSubscription != null) {
      _sseSubscription?.resume();
    }

    final String url =
        '$baseUrl/__transmit/events?uid=$uid'; // Incluindo o UID na URL

    print('🔌 Conectando a $url');

    _sseSubscription = SSEClient.subscribeToSSE(
      url: url,
      header: {
        "Accept": "text/event-stream",
        "Cache-Control": "no-cache",
      }, // Adicione os cabeçalhos necessários aqui, se houver
      method: SSERequestType.GET,
    ).listen(
        (event) {
          // Adiciona a mensagem recebida na lista
          print(
              "#############################################################33");
          try {
            if (event.data != null) {
              final data = jsonDecode(event.data!);

              final notification = AppNotification.fromJson(data["payload"]);
              setState(() {
                messages.add(notification);
                _notificationsRepository.saveNotification(notification);
              });
            }
          } catch (e) {
            print('deu erro $e');
          }
        },
        onError: (error) {
          print('Erro ao receber eventos: $error');
        },
        cancelOnError: true,
        onDone: () {
          print('Conexão encerrada');
        });
  }

  @override
  void dispose() {
    _sseSubscription
        ?.cancel(); // Cancela a inscrição SSE quando o widget for descartado
    super.dispose();

    print('🔌 Conexão encerrada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: NotificationItem(
                name: messages[index].name,
                category: messages[index].category,
                date: messages[index].date),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Envia uma mensagem para o canal "users"
              _sseSubscription?.cancel();
              _subscribeToChannel();
              _connectToSse();
            },
            child: Text('Atualizar'),
          ),
        ),
      ),
    );
  }
}
