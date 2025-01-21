import 'package:eiviznho/app/config/api/auth.dart';
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

  Future<void> _onRegister() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      
      await AuthAPI.registerUser(
        fullName: _nameController.text,
        cpf: _cpfController.text,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrado com sucesso!'),
          backgroundColor: AppColors.green,
        ),
      );
      // ignore: use_build_context_synchronously
      context.go(Routes.login);
    } catch (e) {
      String errorMessage = 'Erro ao registrar usuário. Tente novamente.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _cpfController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
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
