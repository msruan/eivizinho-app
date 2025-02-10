import 'package:eiviznho/app/config/api/auth.dart';
import 'package:eiviznho/app/data/dtos/auth/login_dto.dart';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/login/interfaces/login_interface.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // late User? loggedUser;

      try {
        await AuthAPI.login(
            payload: LoginRequestDTO(password: password, email: email));
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('E-mail ou senha inválidos! ${debug(e)}'),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso!!'),
          backgroundColor: AppColors.green,
          duration: Duration(seconds: 2),
        ),
      );

      FocusScope.of(context).unfocus();
      context.go(Routes.home);
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
