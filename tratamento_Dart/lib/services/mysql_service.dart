import 'package:mysql1/mysql1.dart';

class MySQLService {
  late MySqlConnection _connection;

  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'senha0785',
    db: 'sensorvibracao',
  );

  MySqlConnection get connection => _connection;

  Future<void> conectar() async {
    try {
      _connection = await MySqlConnection.connect(settings);
      print('✅ Conectado ao MySQL com sucesso!');
    } catch (e) {
      print('❌ Erro ao conectar ao MySQL: $e');
      rethrow;
    }
  }

  Future<void> desconectar() async {
    try {
      await _connection.close();
      print('🔌 Conexão com MySQL encerrada.');
    } catch (_) {}
  }

  Future<void> ensureConnection() async {
    try {
      await _connection.query('SELECT 1');
    } catch (_) {
      print('⚠️ Conexão perdida, reconectando...');
      await conectar();
    }
  }
}
