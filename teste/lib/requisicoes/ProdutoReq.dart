import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class Produtoreq {
  final PostgreSQLConnection _connection;

  Produtoreq(this._connection);

  // Função para retornar os produtos de uma geladeira
  Future<List<Map<String, dynamic>>> getProdutosPorGeladeira(
      String refrigeratorId) async {
    try {
      final result = await _connection.query(
        "SELECT id, name, expiration_date FROM products WHERE refrigerator_id = @refrigeratorId",
        substitutionValues: {"refrigeratorId": refrigeratorId},
      );

      return result
          .map((row) => {
                "id": row[0],
                "name": row[1],
                "expiration_date": row[2],
              })
          .toList();
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      throw Exception("Erro ao buscar produtos.");
    }
  }

  // Função para inserir um novo produto
  Future<String> inserirProduto(String name, String expirationDate,
      String refrigeratorId, String userId) async {
    try {
      // Verifica se a geladeira pertence ao usuário
      final verificaGeladeira = await _connection.query(
        "SELECT id FROM refrigerators WHERE id = @refrigeratorId AND user_id = @userId",
        substitutionValues: {
          "refrigeratorId": refrigeratorId,
          "userId": userId,
        },
      );

      if (verificaGeladeira.isEmpty) {
        return "Erro: Você não tem permissão para adicionar produtos nesta geladeira.";
      }

      // Verifica se o produto já existe na geladeira
      final produtoExiste = await _connection.query(
        "SELECT id FROM products WHERE name = @name AND refrigerator_id = @refrigeratorId",
        substitutionValues: {
          "name": name,
          "refrigeratorId": refrigeratorId,
        },
      );

      if (produtoExiste.isNotEmpty) {
        return "Erro: Produto já existe nesta geladeira.";
      }

      // Gera um ID único e verifica se ele já existe no banco
      final Uuid uuid = Uuid();
      String id;

      do {
        id = uuid.v4();
      } while (await _idProdutoExiste(id));

      // Insere o produto
      await _connection.query(
        "INSERT INTO products (id, name, expiration_date, refrigerator_id) VALUES (@id, @name, @expirationDate, @refrigeratorId)",
        substitutionValues: {
          "id": id,
          "name": name,
          "expirationDate": expirationDate,
          "refrigeratorId": refrigeratorId,
        },
      );

      return "Produto adicionado com sucesso!";
    } catch (e) {
      print("Erro ao inserir produto: $e");
      return "Erro ao inserir produto.";
    }
  }

// Método para verificar se o ID do produto já existe
  Future<bool> _idProdutoExiste(String id) async {
    final result = await _connection.query(
      "SELECT id FROM products WHERE id = @id",
      substitutionValues: {"id": id},
    );
    return result.isNotEmpty; // Retorna true se o ID já existir
  }

  // Método para buscar as informações de um produto pelo ID
  Future<Map<String, dynamic>> getProdutoPorId(String productId) async {
    try {
      final result = await _connection.query(
        "SELECT name, expiration_date FROM products WHERE id = @productId",
        substitutionValues: {"productId": productId},
      );

      if (result.isEmpty) {
        throw Exception("Produto não encontrado.");
      }

      return {
        "name": result[0][0],
        "expiration_date": result[0][1],
      };
    } catch (e) {
      print("Erro ao buscar produto: $e");
      throw Exception("Erro ao buscar produto.");
    }
  }

  // Método para atualizar um produto
  Future<String> atualizarProduto(
      String productId, String newName, String newExpirationDate) async {
    try {
      // Verifica se o produto existe
      final verificaProduto = await _connection.query(
        "SELECT id FROM products WHERE id = @productId",
        substitutionValues: {"productId": productId},
      );

      if (verificaProduto.isEmpty) {
        return "Erro: Produto não encontrado.";
      }

      // Atualiza o produto
      await _connection.query(
        "UPDATE products SET name = @newName, expiration_date = @newExpirationDate WHERE id = @productId",
        substitutionValues: {
          "productId": productId,
          "newName": newName,
          "newExpirationDate": newExpirationDate,
        },
      );

      return "Produto atualizado com sucesso!";
    } catch (e) {
      print("Erro ao atualizar produto: $e");
      return "Erro ao atualizar produto.";
    }
  }
}
