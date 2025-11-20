import '../services/mysql_service.dart';

class SensorDAO {
  final MySQLService _mysqlService;

  SensorDAO(this._mysqlService);

  Future<void> verificarOuCriar(int idSensor, int idMaquina) async {
    await _mysqlService.ensureConnection();
    var resultado = await _mysqlService.connection.query(
      'SELECT id FROM sensores WHERE id = ?',
      [idSensor],
    );

    if (resultado.isEmpty) {
      await _mysqlService.connection.query(
        '''
        INSERT INTO sensores (id, id_maquina, tipo, descricao)
        VALUES (?, ?, ?, ?)
        ''',
        [idSensor, idMaquina, 'MPU6050', 'Sensor criado automaticamente'],
      );
      print('🆕 Sensor $idSensor (máquina $idMaquina) criado automaticamente.');
    }
  }
}
