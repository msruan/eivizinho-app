// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:eiviznho/app/domain/entities/user_entity.dart';

class RegisterRequestDTO {
  final String name;
  final String email;
  final String cpf;
  final String password;
  final String passwordConfirmation;

  RegisterRequestDTO({
    required this.name,
    required this.email,
    required this.cpf,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': name,
      'email': email,
      'cpf': cpf,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }

  String toJson() => json.encode(toMap());
}

class RegisterResponseDTO {
  final User user;

  RegisterResponseDTO({
    required this.user,
  });

  factory RegisterResponseDTO.fromMap(Map<String, dynamic> map) {
    return RegisterResponseDTO(
      user: User.fromJson(map),
    );
  }

  factory RegisterResponseDTO.fromJson(String source) =>
      RegisterResponseDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
