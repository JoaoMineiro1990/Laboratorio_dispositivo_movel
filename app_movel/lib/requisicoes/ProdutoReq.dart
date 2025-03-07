import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class Produtoreq {
  final PostgreSQLConnection _connection;

  Produtoreq(this._connection);
  Future<List<Map<String, dynamic>>> getProdutosPorGeladeira(
      String refrigeratorId) async {
    try {
      final result = await _connection.query(
        "SELECT id, name, expiration_date, quantidade FROM products WHERE refrigerator_id = @refrigeratorId",
        substitutionValues: {"refrigeratorId": refrigeratorId},
      );

      return result
          .map((row) => {
                "id": row[0],
                "name": row[1],
                "expiration_date": row[2],
                "quantidade": row[3],
              })
          .toList();
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      throw Exception("Erro ao buscar produtos.");
    }
  }

  Future<String> deletarProduto(String productId) async {
    try {
      await _connection.query(
        "DELETE FROM products WHERE id = @productId",
        substitutionValues: {"productId": productId},
      );
      return "Produto deletado com sucesso!";
    } catch (e) {
      print("Erro ao deletar produto: $e");
      return "Erro ao deletar produto.";
    }
  }

  Future<String> inserirProduto(String name, String expirationDate,
      String refrigeratorId, String userId, String quantidade) async {
    try {
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

      final Uuid uuid = Uuid();
      String id;

      do {
        id = uuid.v4();
      } while (await _idProdutoExiste(id));

      await _connection.query(
        "INSERT INTO products (id, name, expiration_date, quantidade, refrigerator_id) VALUES (@id, @name, @expirationDate, @quantidade, @refrigeratorId)",
        substitutionValues: {
          "id": id,
          "name": name,
          "expirationDate": expirationDate,
          "quantidade": quantidade, 
          "refrigeratorId": refrigeratorId,
        },
      );

      return "Produto adicionado com sucesso!";
    } catch (e) {
      print("Erro ao inserir produto: $e");
      return "Erro ao inserir produto.";
    }
  }

  Future<bool> _idProdutoExiste(String id) async {
    final result = await _connection.query(
      "SELECT id FROM products WHERE id = @id",
      substitutionValues: {"id": id},
    );
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>> getProdutoPorId(String productId) async {
    try {
      final result = await _connection.query(
        "SELECT name, expiration_date, quantidade FROM products WHERE id = @productId",
        substitutionValues: {"productId": productId},
      );

      if (result.isEmpty) {
        throw Exception("Produto não encontrado.");
      }

      return {
        "name": result[0][0],
        "expiration_date": result[0][1],
        "quantidade": result[0][2], 
      };
    } catch (e) {
      print("Erro ao buscar produto: $e");
      throw Exception("Erro ao buscar produto.");
    }
  }

  Future<String> atualizarProduto(String productId, String newName,
      String newExpirationDate, String newQuantidade) async {
    try {
      final verificaProduto = await _connection.query(
        "SELECT id, name, expiration_date, quantidade FROM products WHERE id = @productId",
        substitutionValues: {"productId": productId},
      );

      if (verificaProduto.isEmpty) {
        return "Erro: Produto não encontrado.";
      }
      final produtoAtual = verificaProduto[0];
      final nomeAtual = produtoAtual[1];
      final dataAtual = produtoAtual[2];
      final quantidadeAtual = produtoAtual[3];

      if (newName == nomeAtual &&
          newExpirationDate == dataAtual &&
          newQuantidade == quantidadeAtual) {
        return "Nenhuma alteração feita";
      }

      if (newQuantidade.isEmpty) {
        newQuantidade = '0.00';
      }

      await _connection.query(
        "UPDATE products SET name = @newName, expiration_date = @newExpirationDate, quantidade = @newQuantidade WHERE id = @productId",
        substitutionValues: {
          "productId": productId,
          "newName": newName,
          "newExpirationDate": newExpirationDate,
          "newQuantidade": newQuantidade,
        },
      );

      return "Produto atualizado com sucesso!";
    } catch (e) {
      print("Erro ao atualizar produto: $e");
      return "Erro ao atualizar produto.";
    }
  }
}
