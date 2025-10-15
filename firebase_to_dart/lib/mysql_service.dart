import 'package:mysql1/mysql1.dart';
import 'package:firebase_to_dart/leitura_sensor.dart';
import 'package:firebase_to_dart/alerta.dart';

class MySQLService {
  late MySqlConnection _connection;

  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'joao2806',
    db: 'sensorvibracao',
  );

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
    } catch (_) {}
    print('🔌 Conexão com MySQL encerrada.');
  }

  Future<void> _ensureConnection() async {
    try {
      await _connection.query('SELECT 1');
    } catch (_) {
      print('⚠️ Conexão MySQL perdida — tentando reconectar...');
      await conectar();
    }
  }

  // -------------------------------
  // 🔧 Verifica se a máquina existe
  // -------------------------------
  Future<void> _verificarOuCriarMaquina(int idMaquina) async {
    await _ensureConnection();
    var resultado = await _connection.query(
      'SELECT id FROM maquinas WHERE id = ?',
      [idMaquina],
    );
    if (resultado.isEmpty) {
      await _connection.query(
        '''
        INSERT INTO maquinas (id, nome, descricao, localizacao)
        VALUES (?, ?, ?, ?)
        ''',
        [idMaquina, 'Máquina $idMaquina', 'Criada automaticamente', 'Não informada'],
      );
      print('🆕 Máquina $idMaquina criada automaticamente.');
    }
  }

  // -------------------------------
  // 🔧 Verifica se o sensor existe
  // -------------------------------
  Future<void> _verificarOuCriarSensor(int idSensor, int idMaquina) async {
    await _ensureConnection();
    var resultado = await _connection.query(
      'SELECT id FROM sensores WHERE id = ?',
      [idSensor],
    );
    if (resultado.isEmpty) {
      await _connection.query(
        '''
        INSERT INTO sensores (id, id_maquina, tipo, descricao)
        VALUES (?, ?, ?, ?)
        ''',
        [idSensor, idMaquina, 'MPU6050', 'Sensor criado automaticamente'],
      );
      print('🆕 Sensor $idSensor (máquina $idMaquina) criado automaticamente.');
    }
  }

  // -------------------------------
  // 📥 Insere leitura
  // -------------------------------
  Future<int?> inserirLeitura(LeituraSensor leitura) async {
    try {
      await _ensureConnection();

      // 🔍 Garante que máquina e sensor existem
      await _verificarOuCriarMaquina(leitura.idMaquina);
      await _verificarOuCriarSensor(leitura.idSensor, leitura.idMaquina);

      final resultado = await _connection.query(
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
      print('📥 Leitura inserida (ID: $idLeitura, Sensor: ${leitura.idSensor}, Máquina: ${leitura.idMaquina})');
      return idLeitura;
    } catch (e) {
      print('❌ Erro ao inserir leitura: $e');
      try {
        await conectar();
        return inserirLeitura(leitura);
      } catch (e2) {
        print('❌ Falha ao reinserir leitura: $e2');
        return null;
      }
    }
  }

  // -------------------------------
  // 🚨 Insere alerta
  // -------------------------------
  Future<void> inserirAlerta(Alerta alerta, int idLeitura) async {
    try {
      await _ensureConnection();
      await _connection.query(
        '''
        INSERT INTO alertas (
          id_leitura,
          nivel,
          mensagem,
          vibracao,
          criado_em
        ) VALUES (?, ?, ?, ?, ?)
        ''',
        [
          idLeitura,
          alerta.nivel,
          alerta.mensagem,
          alerta.leitura.vibracao,
          alerta.leitura.timestamp.toLocal().toString().substring(0, 19),
        ],
      );
      print('🚨 Alerta (${alerta.nivel}) inserido no MySQL!');
    } catch (e) {
      print('❌ Erro ao inserir alerta: $e');
      try {
        await conectar();
        await inserirAlerta(alerta, idLeitura);
      } catch (e2) {
        print('❌ Falha ao reinserir alerta: $e2');
      }
    }
  }
}
