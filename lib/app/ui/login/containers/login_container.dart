import 'dart:convert';

import 'package:eiviznho/app/config/auth_manager.dart';
import 'package:eiviznho/app/config/env.dart';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/login/interfaces/login_interface.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final authManager = AuthManager();
    final String? baseUrl = Enviroment.baseUrl();

    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('$baseUrl/auth/login');

      final email = _emailController.text;
      final password = _passwordController.text;

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody is Map<String, dynamic> &&
            responseBody.containsKey('token')) {
          final token = responseBody['token'];
          await authManager.storeToken(token["value"]);

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

        context.go(Routes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'E-mail ou senha inválidos! ${debug(response.statusCode)} - ${debug(response.body)}'),
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
