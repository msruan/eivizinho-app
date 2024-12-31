class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String cpf;
  final String dtNasc;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cpf,
    required this.dtNasc,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        cpf = json['cpf'] as String,
        dtNasc = json['dtNasc'] as String;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'cpf': cpf,
      'dtNasc': dtNasc,
    };
  }
}
