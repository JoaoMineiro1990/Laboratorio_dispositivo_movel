import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class GeladeiraReq {
  final PostgreSQLConnection _connection;
  final Uuid _uuid = Uuid();
  GeladeiraReq(this._connection);

  // Método para verificar se o ID da geladeira já existe
  Future<bool> _geladeiraIdExiste(String id) async {
    final result = await _connection.query(
      "SELECT id FROM refrigerators WHERE id = @id",
      substitutionValues: {"id": id},
    );
    return result.isNotEmpty;
  }

  // Método para inserir uma nova geladeira
  Future<String> inserirGeladeira(
      String name, String description, String userId) async {
    try {
      String novoId;

      // Gera um ID único que não existe no banco
      do {
        novoId = _uuid.v4();
      } while (await _geladeiraIdExiste(novoId));

      await _connection.query(
        "INSERT INTO refrigerators (id, name, description, user_id) VALUES (@id, @name, @description, @userId)",
        substitutionValues: {
          "id": novoId, // ID gerado automaticamente e validado
          "name": name,
          "description": description,
          "userId": userId,
        },
      );
      return "Geladeira adicionada com sucesso!";
    } catch (e) {
      print("Erro ao inserir geladeira: $e");
      return "Erro ao inserir geladeira.";
    }
  }

  // Método para atualizar uma geladeira
  Future<String> atualizarGeladeira(
      String id, String newName, String newDescription, String userId) async {
    try {
      // Verifica se a geladeira existe e pertence ao usuário
      final result = await _connection.query(
        "SELECT id FROM refrigerators WHERE id = @id AND user_id = @userId",
        substitutionValues: {"id": id, "userId": userId},
      );

      if (result.isEmpty) {
        return "Erro: Geladeira não encontrada ou sem permissão para atualizar.";
      }

      // Atualiza os dados da geladeira
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

  // Método para obter os dados de uma geladeira pelo ID
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

      // Verifica se a geladeira pertence ao usuário
      final result = await _connection.query(
        "SELECT id FROM refrigerators WHERE id = @id AND user_id = @userId",
        substitutionValues: {"id": id, "userId": userId},
      );

      print("Resultado da verificação: $result");

      if (result.isEmpty) {
        return "Erro: Geladeira não encontrada ou sem permissão para deletar.";
      }

      // Deleta os produtos relacionados
      await _connection.query(
        "DELETE FROM products WHERE refrigerator_id = @id",
        substitutionValues: {"id": id},
      );
      print("Produtos deletados com sucesso!");

      // Deleta a geladeira
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

  // Carrega os dados de uma geladeira pelo ID
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

// Deleta a geladeira e retorna o resultado
  Future<String> deletarGeladeiraComMensagem(String id, String userId) async {
    final resultado = await deletarGeladeira(id, userId);
    if (resultado.contains("sucesso")) {
      return "Geladeira deletada com sucesso!";
    } else {
      return "Erro ao deletar geladeira.";
    }
  }
}
