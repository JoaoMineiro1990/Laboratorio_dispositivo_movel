import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class GeladeiraReq {
  final PostgreSQLConnection _connection;
  final Uuid _uuid = Uuid();
  GeladeiraReq(this._connection);
  Future<bool> _geladeiraIdExiste(String id) async {
    final result = await _connection.query(
      "SELECT id FROM refrigerators WHERE id = @id",
      substitutionValues: {"id": id},
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getGeladeirasDoUsuario(
      String userId) async {
    try {
      final result = await _connection.query(
        "SELECT r.id, r.name, r.description "
        "FROM refrigerators r "
        "JOIN user_refrigerators ur ON r.id = ur.refrigerator_id "
        "WHERE ur.user_id = @userId",
        substitutionValues: {"userId": userId},
      );

      return result
          .map((row) => {
                "id": row[0],
                "name": row[1],
                "description": row[2],
              })
          .toList();
    } catch (e) {
      print("Erro ao buscar geladeiras: $e");
      throw Exception("Erro ao buscar geladeiras.");
    }
  }

  Future<String> inserirGeladeira(
      String name, String description, String userId) async {
    try {
      String novoId;

      do {
        novoId = _uuid.v4();
      } while (await _geladeiraIdExiste(novoId));

      await _connection.query(
        "INSERT INTO refrigerators (id, name, description, user_id) VALUES (@id, @name, @description, @userId)",
        substitutionValues: {
          "id": novoId,
          "name": name,
          "description": description,
          "userId": userId, 
        },
      );

      await _connection.query(
        "INSERT INTO user_refrigerators (user_id, refrigerator_id) VALUES (@userId, @refrigeratorId)",
        substitutionValues: {
          "userId": userId,
          "refrigeratorId": novoId,
        },
      );

      return "Geladeira adicionada com sucesso!";
    } catch (e) {
      print("Erro ao inserir geladeira: $e");
      return "Erro ao inserir geladeira.";
    }
  }

  Future<String> atualizarGeladeira(
      String id, String newName, String newDescription, String userId) async {
    try {
      final result = await _connection.query(
        "SELECT id FROM refrigerators WHERE id = @id AND user_id = @userId",
        substitutionValues: {"id": id, "userId": userId},
      );

      if (result.isEmpty) {
        return "Erro: Geladeira não encontrada ou sem permissão para atualizar.";
      }

      await _connection.query(
        "UPDATE refrigerators SET name = @newName, description = @newDescription WHERE id = @id",
        substitutionValues: {
          "id": id,
          "newName": newName,
          "newDescription": newDescription,
        },
      );

      return "Geladeira atualizada com sucesso!";
    } catch (e) {
      print("Erro ao atualizar geladeira: $e");
      return "Erro ao atualizar geladeira.";
    }
  }

  Future<Map<String, String>> getGeladeiraPorId(String id) async {
    try {
      final result = await _connection.query(
        "SELECT name, description FROM refrigerators WHERE id = @id",
        substitutionValues: {"id": id},
      );

      if (result.isEmpty) {
        throw Exception("Geladeira não encontrada.");
      }

      return {
        "name": result[0][0],
        "description": result[0][1],
      };
    } catch (e) {
      print("Erro ao buscar geladeira: $e");
      throw Exception("Erro ao buscar geladeira.");
    }
  }

  Future<String> deletarGeladeira(String id, String userId) async {
    try {
      print("Verificando geladeira com ID: $id e UserID: $userId");

      final result = await _connection.query(
        "SELECT id FROM refrigerators WHERE id = @id AND user_id = @userId",
        substitutionValues: {"id": id, "userId": userId},
      );

      print("Resultado da verificação: $result");

      if (result.isEmpty) {
        return "Erro: Geladeira não encontrada ou sem permissão para deletar.";
      }

      await _connection.query(
        "DELETE FROM user_refrigerators WHERE refrigerator_id = @id",
        substitutionValues: {"id": id},
      );
      print("Referências removidas da tabela user_refrigerators.");

      await _connection.query(
        "DELETE FROM products WHERE refrigerator_id = @id",
        substitutionValues: {"id": id},
      );
      print("Produtos deletados com sucesso!");

      await _connection.query(
        "DELETE FROM refrigerators WHERE id = @id",
        substitutionValues: {"id": id},
      );

      print("Geladeira deletada com sucesso!");

      return "Geladeira deletada com sucesso!";
    } catch (e) {
      print("Erro ao deletar geladeira: $e");
      return "Erro ao deletar geladeira.";
    }
  }
  Future<Map<String, String>> carregarDadosGeladeira(String id) async {
    try {
      final dados = await getGeladeiraPorId(id);
      return {
        "name": dados["name"]!,
        "description": dados["description"]!,
      };
    } catch (e) {
      print("Erro ao carregar geladeira: $e");
      throw Exception("Erro ao carregar geladeira: $e");
    }
  }

  Future<String> deletarGeladeiraComMensagem(String id, String userId) async {
    final resultado = await deletarGeladeira(id, userId);
    if (resultado.contains("sucesso")) {
      return "Geladeira deletada com sucesso!";
    } else {
      return "Erro ao deletar geladeira.";
    }
  }

  Future<String> compartilharGeladeira(
      String userId, String refrigeratorId) async {
    try {
      final existe = await _connection.query(
        "SELECT 1 FROM user_refrigerators WHERE user_id = @userId AND refrigerator_id = @refrigeratorId",
        substitutionValues: {
          "userId": userId,
          "refrigeratorId": refrigeratorId
        },
      );

      if (existe.isNotEmpty) {
        return "Erro: Geladeira já compartilhada com este usuário.";
      }

      await _connection.query(
        "INSERT INTO user_refrigerators (user_id, refrigerator_id) VALUES (@userId, @refrigeratorId)",
        substitutionValues: {
          "userId": userId,
          "refrigeratorId": refrigeratorId
        },
      );

      return "Geladeira compartilhada com sucesso!";
    } catch (e) {
      print("Erro ao compartilhar geladeira: $e");
      return "Erro ao compartilhar geladeira.";
    }
  }

  Future<List<Map<String, dynamic>>> getGeladeirasPessoais(
      String userId) async {
    try {
      print(
          "Iniciando a consulta para buscar as geladeiras pessoais do usuário: $userId");

      final result = await _connection.query(
        """
      SELECT r.id, r.name, r.description
      FROM refrigerators r
      JOIN (
        SELECT ur.refrigerator_id
        FROM user_refrigerators ur
        GROUP BY ur.refrigerator_id
        HAVING COUNT(ur.user_id) = 1
      ) pessoais ON r.id = pessoais.refrigerator_id
      WHERE r.user_id = @userId
      """,
        substitutionValues: {"userId": userId},
      );

      print("Consulta executada com sucesso, resultado: $result");

      return result
          .map((row) => {
                "id": row[0],
                "name": row[1],
                "description": row[2],
              })
          .toList();
    } catch (e) {
      print("Erro ao buscar geladeiras pessoais: $e");
      throw Exception("Erro ao buscar geladeiras pessoais.");
    }
  }

  Future<List<Map<String, dynamic>>> getGeladeirasCompartilhadas(
      String userId) async {
    try {
      print(
          "Iniciando a consulta para buscar as geladeiras compartilhadas do usuário: $userId");

      final result = await _connection.query(
        """
      SELECT r.id, r.name, r.description
      FROM refrigerators r
      JOIN (
        SELECT ur.refrigerator_id
        FROM user_refrigerators ur
        GROUP BY ur.refrigerator_id
        HAVING COUNT(ur.user_id) > 1
      ) compartilhadas ON r.id = compartilhadas.refrigerator_id
      JOIN user_refrigerators ur ON ur.refrigerator_id = r.id
      WHERE ur.user_id = @userId
      """,
        substitutionValues: {"userId": userId},
      );

      print("Consulta executada com sucesso, resultado: $result");

      return result
          .map((row) => {
                "id": row[0],
                "name": row[1],
                "description": row[2],
              })
          .toList();
    } catch (e) {
      print("Erro ao buscar geladeiras compartilhadas: $e");
      throw Exception("Erro ao buscar geladeiras compartilhadas.");
    }
  }
}
