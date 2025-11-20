import '../models/leitura_sensor.dart';
import '../services/mysql_service.dart';
import 'maquina_dao.dart';
import 'sensor_dao.dart';

class LeituraDAO {
  final MySQLService _mysqlService;
  final MaquinaDAO _maquinaDAO;
  final SensorDAO _sensorDAO;

  LeituraDAO(this._mysqlService)
      : _maquinaDAO = MaquinaDAO(_mysqlService),
        _sensorDAO = SensorDAO(_mysqlService);

  String _fmt(DateTime t) {
    return t.toIso8601String().replaceFirst('T', ' ').substring(0, 19);
  }

  Future<DateTime?> buscarUltimoTimestamp() async {
    await _mysqlService.ensureConnection();
    var result = await _mysqlService.connection
        .query('SELECT MAX(timestamp) AS ts FROM leituras');
    if (result.isEmpty) return null;
    return result.first['ts'];
  }

  Future<bool> existe(int idSensor, DateTime timestamp) async {
    await _mysqlService.ensureConnection();
    var result = await _mysqlService.connection.query(
      'SELECT id FROM leituras WHERE id_sensor = ? AND timestamp = ? LIMIT 1',
      [idSensor, _fmt(timestamp)],
    );
    return result.isNotEmpty;
  }

  Future<int?> inserir(LeituraSensor leitura) async {
    await _mysqlService.ensureConnection();

    final ultimo = await buscarUltimoTimestamp();
    if (ultimo != null) {
      if (leitura.timestamp.isBefore(ultimo)) return null;
      if (leitura.timestamp.isAtSameMomentAs(ultimo)) return null;
    }

    if (await existe(leitura.idSensor, leitura.timestamp)) return null;

    await _maquinaDAO.verificarOuCriar(leitura.idMaquina);
    await _sensorDAO.verificarOuCriar(leitura.idSensor, leitura.idMaquina);

    var resultado = await _mysqlService.connection.query(
      '''
      INSERT INTO leituras (
        id_sensor,
        timestamp,
        vibracao,
        aceleracao_x,
        aceleracao_y,
        aceleracao_z,
        giroscopio_x,
        giroscopio_y,
        giroscopio_z
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''',
      [
        leitura.idSensor,
        _fmt(leitura.timestamp),
        leitura.vibracao,
        leitura.aceleracaoX,
        leitura.aceleracaoY,
        leitura.aceleracaoZ,
        leitura.giroscopioX,
        leitura.giroscopioY,
        leitura.giroscopioZ,
      ],
    );

    return resultado.insertId;
  }
}