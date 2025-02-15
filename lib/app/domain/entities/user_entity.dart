class User {
  final String id;
  final String name;
  final String email;
  final String cpf;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['fullName'] as String,
        email = json['email'] as String,
        cpf = json['cpf'] as String;
}
