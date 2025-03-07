import 'package:postgres/postgres.dart';

class Autenticacao {
  final PostgreSQLConnection _connection;

  Autenticacao(this._connection);

  Future<String> autenticarUsuario(String email, String senha) async {
    try {
      final emailExiste = await _connection.query(
        "SELECT id FROM users WHERE email = @email",
        substitutionValues: {"email": email},
      );

      if (emailExiste.isEmpty) {
        return "email não cadastrado";
      }

      final resultado = await _connection.query(
        "SELECT id FROM users WHERE email = @email AND password = @senha",
        substitutionValues: {
          "email": email,
          "senha": senha,
        },
      );

      if (resultado.isEmpty) {
        return "email ou senha incorretos";
      }

      return "true"; 
    } catch (e) {
      print("Erro na autenticação: $e");
      return "Erro ao autenticar";
    }
  }
}
