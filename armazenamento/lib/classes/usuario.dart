class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  // Converte o objeto User para JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Cria um User a partir de JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }
}
