import 'package:eiviznho/app/utils/is_cpf_valid.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Insira seu nome';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Insira seu e-mail';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Por favor, insira um e-mail válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Insira sua senha';
  } else if (value.length < 8) {
    return 'A senha deve ter pelo menos 8 caracteres';
  }
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Confirme sua senha';
  } else if (value != password) {
    return 'As senhas não coincidem';
  }
  return null;
}

String? validateCPF(String? value) {
  if (value == null || value.isEmpty) {
    return 'Insira seu CPF';
  }

  String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

  if (cleanedValue.length != 11 ||
      RegExp(r'^(\d)\1{10}$').hasMatch(cleanedValue) ||
      !isValidCPF(cleanedValue)) {
    return 'Insira um CPF válido';
  }

  return null;
}
