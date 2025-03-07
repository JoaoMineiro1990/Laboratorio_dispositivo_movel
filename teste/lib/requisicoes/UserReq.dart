import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class UserReq {
  final PostgreSQLConnection _connection;

  UserReq(this._connection);

  // Método para buscar os dados atuais do usuário
  Future<Map<String, String>> getUserById(String id) async {
    final result = await _connection.query(
      "SELECT name, email, password FROM users WHERE id = @id",
      substitutionValues: {"id": id},
    );

    if (result.isEmpty) {
      throw Exception("Usuário não encontrado.");
    }

    return {
      "name": result[0][0],
      "email": result[0][1],
      "password": result[0][2],
    };
  }

  // Método para atualizar o usuário
  Future<String> updateUser(
      String id, String newName, String newEmail, String newPassword) async {
    try {
      await _connection.query(
        "UPDATE users SET name = @name, email = @newEmail, password = @newPassword WHERE id = @id",
        substitutionValues: {
          "name": newName,
          "newEmail": newEmail,
          "newPassword": newPassword,
          "id": id,
        },
      );

      return "Usuário atualizado com sucesso!";
    } catch (e) {
      print("Erro ao atualizar usuário: $e");
      return "Erro ao atualizar usuário.";
    }
  }

  Future<String> inserirUsuario(
      String name, String email, String password) async {
    try {
      // Verifica se o email já existe
      if (await _emailExiste(email)) {
        return "Erro: E-mail já cadastrado.";
      }

      final Uuid uuid = Uuid();
      String id;

      // Gera um ID único e verifica se ele já existe no banco
      do {
        id = uuid.v4();
      } while (await _idExiste(id));

      // Insere o novo usuário
      await _connection.query(
        "INSERT INTO users (id, name, email, password) VALUES (@id, @name, @email, @password)",
        substitutionValues: {
          "id": id,
          "name": name,
          "email": email,
          "password": password, // Tratar hash no futuro
        },
      );

      return "Usuário criado com sucesso!";
    } catch (e) {
      print("Erro ao inserir usuário: $e");
      return "Erro ao inserir usuário.";
    }
  }

// Método para verificar se o ID já existe
  Future<bool> _idExiste(String id) async {
    final result = await _connection.query(
      "SELECT id FROM users WHERE id = @id",
      substitutionValues: {"id": id},
    );
    return result.isNotEmpty; // Retorna true se o ID já existir
  }

// Método para verificar se o email já existe
  Future<bool> _emailExiste(String email) async {
    final result = await _connection.query(
      "SELECT email FROM users WHERE email = @email",
      substitutionValues: {"email": email},
    );
    return result.isNotEmpty; // Retorna true se o email já existir
  }
}
