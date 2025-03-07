import 'package:postgres/postgres.dart';

class Conexao {
  static PostgreSQLConnection? _connection;

  // Método para obter ou inicializar a conexão
  static Future<PostgreSQLConnection> getConnection() async {
    if (_connection == null || _connection!.isClosed) {
      _connection = PostgreSQLConnection(
        "192.168.0.203", // IP do banco
        5432, // Porta padrão do PostgreSQL
        "gerencias", // Nome do banco de dados
        username: "postgres",
        password: "84139532",
      );

      await _connection!.open();
      print("Conexão com PostgreSQL aberta com sucesso!");
    }
    return _connection!;
  }

  // Método para fechar a conexão
  static Future<void> closeConnection() async {
    if (_connection != null && !_connection!.isClosed) {
      await _connection!.close();
      print("Conexão com PostgreSQL fechada.");
    }
  }
}
