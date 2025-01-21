import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:eiviznho/app/ui/shared/button_widget.dart';
import 'package:eiviznho/app/ui/shared/auth_text_field.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterInterface extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;

  const RegisterInterface({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.cpfController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: baseAppBar(title: 'Cadastro'),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.gray,
              border: Border(
                top: BorderSide(
                    color: AppColors.backgroundSecondary, width: 0.5),
                bottom: BorderSide(
                    color: AppColors.backgroundSecondary, width: 0.5),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 56.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeText(),
                const SizedBox(height: 8.0),
                _buildLoginPrompt(context),
                const SizedBox(height: 48.0),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Cadastre-se',
      textAlign: TextAlign.center,
      style: AppTextStyles.titleExtraLarge,
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Já tem uma conta? ',
          style: AppTextStyles.titleExtraSmall,
        ),
        InkWell(
          onTap: () => context.go(Routes.login),
          child: Text(
            'Faça login',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.green,
              letterSpacing: -1.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            buildInputField(
              controller: nameController,
              labelText: 'Nome',
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira seu nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            buildInputField(
              controller: cpfController,
              labelText: 'CPF',
              isCPFField: true,
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira seu CPF';
                } else if (!RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$')
                    .hasMatch(value)) {
                  return 'Insira um CPF válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            buildInputField(
              controller: emailController,
              labelText: 'E-mail',
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira seu e-mail';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Por favor, insira um e-mail válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            buildInputField(
              controller: passwordController,
              labelText: 'Senha',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira sua senha';
                } else if (value.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            buildInputField(
              controller: confirmPasswordController,
              labelText: 'Confirmar senha',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirme sua senha';
                } else if (value != passwordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Button(
      title: 'Cadastrar',
      onPress: onRegister,
      backgroundColor: AppColors.green,
    );
  }
}
