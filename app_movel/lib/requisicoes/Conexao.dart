import 'package:postgres/postgres.dart';

class Conexao {
  static PostgreSQLConnection? _connection;

  static Future<PostgreSQLConnection> getConnection() async {
    if (_connection == null || _connection!.isClosed) {
      _connection = PostgreSQLConnection(
        "192.168.0.203",
        5432, 
        "gerencias", 
        username: "postgres",
        password: "84139532",
      );

      await _connection!.open();
      print("Conexão com PostgreSQL aberta com sucesso!");
    }
    return _connection!;
  }

  static Future<void> closeConnection() async {
    if (_connection != null && !_connection!.isClosed) {
      await _connection!.close();
      print("Conexão com PostgreSQL fechada.");
    }
  }
}
