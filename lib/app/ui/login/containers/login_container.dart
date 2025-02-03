import 'dart:convert';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/login/interfaces/login_interface.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final storage = FlutterSecureStorage();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> storeToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  Future<void> _login() async {
    final String? baseUrl = dotenv.env['BASE_URL'];

    if (baseUrl == null || baseUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Base URL não definida no .env!'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('$baseUrl/auth/login');
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"email": email, "password": password}),
        );

        print('Corpo da resposta: ${response.body}');
        print('Status Code: ${response.statusCode}');

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);

          if (responseBody is Map<String, dynamic> && responseBody.containsKey('token')) {
            final token = responseBody['token'];
            await storeToken(token["value"]);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login realizado com sucesso!!'),
                backgroundColor: AppColors.green,
                duration: Duration(seconds: 2),
              ),
            );

            FocusScope.of(context).unfocus();
            context.go(Routes.home);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Token não encontrado na resposta!'),
                backgroundColor: AppColors.red,
              ),
            );
          }
        } else {
          // Erro 422 - Mostrando a mensagem de erro detalhada
          final responseBody = jsonDecode(response.body);

          if (responseBody['errors'] != null) {
            final errorMessage = responseBody['errors'][0]['message'];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: AppColors.red,
              ),
            );
          } else {
            // Caso o erro não tenha uma estrutura específica de "errors"
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Erro desconhecido ao tentar fazer login.'),
                backgroundColor: AppColors.red,
              ),
            );
          }
        }
      } catch (e) {
        print('Erro durante o login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao conectar com a API: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginInterface(
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      onLogin: _login,
    );
  }
}
