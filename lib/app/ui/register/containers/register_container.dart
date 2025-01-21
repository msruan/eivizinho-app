import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/register/interfaces/register_interface.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterContainer extends StatefulWidget {
  const RegisterContainer({super.key});

  @override
  _RegisterContainerState createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrado com sucesso!!'),
          backgroundColor: AppColors.green,
        ),
      );

      context.go(Routes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Preencha todos os campos!!'),
            backgroundColor: AppColors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegisterInterface(
      formKey: _formKey,
      nameController: _nameController,
      cpfController: _cpfController,
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      onRegister: _onRegister,
    );
  }
}
