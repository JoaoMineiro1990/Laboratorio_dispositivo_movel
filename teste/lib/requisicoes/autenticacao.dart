import 'package:postgres/postgres.dart';

class Autenticacao {
  final PostgreSQLConnection _connection;

  Autenticacao(this._connection);

  Future<String> autenticarUsuario(String email, String senha) async {
    try {
      // 1. Verifica se o email existe
      final emailExiste = await _connection.query(
        "SELECT id FROM users WHERE email = @email",
        substitutionValues: {"email": email},
      );

      if (emailExiste.isEmpty) {
        return "email não cadastrado";
      }

      // 2. Verifica se a senha está correta
      final resultado = await _connection.query(
        "SELECT id FROM users WHERE email = @email AND password = @senha",
        substitutionValues: {
          "email": email,
          "senha": senha, // Lembre-se de tratar a senha (hash) no futuro!
        },
      );

      if (resultado.isEmpty) {
        return "email ou senha incorretos";
      }

      return "true"; // Usuário autenticado com sucesso
    } catch (e) {
      print("Erro na autenticação: $e");
      return "Erro ao autenticar";
    }
  }
}
