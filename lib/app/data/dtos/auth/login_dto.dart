// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:eiviznho/app/domain/entities/user_entity.dart';

class LoginRequestDTO {
  final String? email;
  final String? cpf;
  final String password;

  LoginRequestDTO({
    this.email,
    this.cpf,
    required this.password,
  }) {
    if (email == null && cpf == null) {
      throw ArgumentError.notNull(
          "Null email and CPF passed as argument to LoginRequestDTO");
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> credentials = {
      'password': password,
    };

    if (email != null) {
      credentials.addAll({'email': email});
    } else if (email != null) {
      credentials.addAll({'cpf': cpf});
    }

    return credentials;
  }

  String toJson() => json.encode(toMap());
}

class LoginResponseDTO {
  final String token;
  final User user;

  LoginResponseDTO({
    required this.token,
    required this.user,
  });

  factory LoginResponseDTO.fromMap(Map<String, dynamic> map) {
    return LoginResponseDTO(
      token: map['token']['value'] as String,
      user: User.fromJson(map['user'] as Map<String, dynamic>),
    );
  }

  factory LoginResponseDTO.fromJson(String source) =>
      LoginResponseDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
