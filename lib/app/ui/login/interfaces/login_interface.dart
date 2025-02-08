import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:eiviznho/app/ui/shared/button_widget.dart';
import 'package:eiviznho/app/ui/shared/auth_text_field.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInterface extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginInterface({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: baseAppBar(title: 'Login'),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
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
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 56.0),
            constraints: BoxConstraints(
              minHeight: screenHeight * 0.4,
              maxHeight: screenHeight * 0.6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildWelcomeText(),
                const SizedBox(height: 8.0),
                _buildRegisterPrompt(context),
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
      'Bem-vindo de volta',
      textAlign: TextAlign.center,
      style: AppTextStyles.titleExtraLarge,
    );
  }

  Widget _buildRegisterPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Não está cadastrado ainda? ',
          style: AppTextStyles.titleExtraSmall,
        ),
        InkWell(
          onTap: () => context.replace(Routes.register),
          child: Text(
            'Registre-se',
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
    return Expanded(
      child: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildInputField(
                  controller: emailController,
                  labelText: 'E-mail',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu e-mail';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
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
                const SizedBox(height: 24.0),
                Spacer(),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Button(
      title: 'Entrar',
      onPress: onLogin,
      backgroundColor: AppColors.green,
    );
  }
}
