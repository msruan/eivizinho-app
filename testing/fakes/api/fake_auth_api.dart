import 'package:eiviznho/app/config/api/auth.dart';
import 'package:eiviznho/app/config/exceptions.dart';
import 'package:eiviznho/app/data/dtos/auth/login_dto.dart';
import 'package:eiviznho/app/data/dtos/auth/register_dto.dart';
import 'package:eiviznho/app/domain/entities/user_entity.dart';

class FakeAuthApi extends AuthAPI {
  static final List<User> _users = [];
  static final List<Map<String, String>> _credentials = [];

  static Future<User> registerUser(
      {required RegisterRequestDTO payload}) async {
    final id = (_users.length + 1).toString();
    final newUser = User(
        id: id, name: payload.name, email: payload.email, cpf: payload.cpf);
    _users.add(newUser);

    _credentials.add({payload.email: payload.password});
    _credentials.add({payload.cpf: payload.password});

    return Future.value(newUser);
  }

  static Future<User> login({required LoginRequestDTO payload}) async {
    for (final credential in _credentials) {
      final bool idsMatch =
          credential.keys.toList()[0] == (payload.cpf ?? payload.email);
      final bool passwordsMatch =
          idsMatch && credential.values.toList()[0] == payload.password;
      if (passwordsMatch) {
        return _users.firstWhere(
            (user) => user.email == payload.email || user.cpf == payload.cpf);
      }
    }
    throw APIException("Unauthorized", code: 400);
  }
}
