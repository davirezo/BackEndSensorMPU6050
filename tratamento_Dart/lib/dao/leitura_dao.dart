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

  Future<bool> existe(int idSensor, DateTime timestamp) async {
    await _mysqlService.ensureConnection();
    var result = await _mysqlService.connection.query(
      'SELECT id FROM leituras WHERE id_sensor = ? AND timestamp = ? LIMIT 1',
      [idSensor, timestamp.toLocal().toString().substring(0, 19)],
    );
    return result.isNotEmpty;
  }

  Future<int?> inserir(LeituraSensor leitura) async {
    await _mysqlService.ensureConnection();

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
        leitura.timestamp.toLocal().toString().substring(0, 19),
        leitura.vibracao,
        leitura.aceleracaoX,
        leitura.aceleracaoY,
        leitura.aceleracaoZ,
        leitura.giroscopioX,
        leitura.giroscopioY,
        leitura.giroscopioZ,
      ],
    );

    final idLeitura = resultado.insertId;
    print('📥 Leitura inserida (ID: $idLeitura, Sensor: ${leitura.idSensor})');
    return idLeitura;
  }
}
