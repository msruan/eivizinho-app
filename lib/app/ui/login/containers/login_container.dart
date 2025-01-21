import 'dart:convert';

import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/login/interfaces/login_interface.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String? baseUrl = dotenv.env['BASE_URL'];

    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('$baseUrl/auth/login');

      final email = _emailController.text;
      final password = _passwordController.text;

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"cpf": email, "password": password}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso!!'),
            backgroundColor: AppColors.green,
            duration: Duration(seconds: 2),
          ),
        );
        if (!mounted) return;

        context.go(Routes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha inválidos!!'),
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
