import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_to_dart/models/leitura_sensor.dart';
import 'package:firebase_to_dart/models/alerta.dart';
import 'package:firebase_to_dart/services/mysql_service.dart';
import 'package:firebase_to_dart/dao/leitura_dao.dart';
import 'package:firebase_to_dart/dao/alerta_dao.dart';

class FirebaseService {
  final String databaseUrl =
      'https://sensorvibracao-gp4-default-rtdb.firebaseio.com/';
  final String? idToken;

  FirebaseService(this.idToken);

  Future<Map<String, int>> processarLeituras(MySQLService mysqlService) async {
    final url = Uri.parse('$databaseUrl/leituras.json?auth=$idToken');
    final response = await http.get(url);

    final leituraDao = LeituraDAO(mysqlService);
    final alertaDao = AlertaDAO(mysqlService);

    final idsInseridos = <int>[];
    int novas = 0;
    int alertas = 0;

    final ultimoTimestamp = await leituraDao.buscarUltimoTimestamp();

    if (response.statusCode != 200) {
      print('Erro ao buscar dados do Firebase: ${response.statusCode}');
      return {"leituras": 0, "alertas": 0};
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.isEmpty) {
      print('Nenhuma leitura encontrada.');
      return {"leituras": 0, "alertas": 0};
    }

    for (var value in data.values) {
      final leitura = LeituraSensor.fromJson(value);

      if (ultimoTimestamp != null &&
          leitura.timestamp.isBefore(ultimoTimestamp)) {
        continue;
      }

      final idLeitura = await leituraDao.inserir(leitura);

      if (idLeitura != null) {
        novas++;
        idsInseridos.add(idLeitura);

        final alerta = Alerta.fromLeitura(leitura);
        if (alerta.nivel != "Normal") {
          await alertaDao.inserir(alerta, idLeitura);
          alertas++;
        }
      }
    }

    // impressão única
    if (idsInseridos.isNotEmpty) {
      print("📥 ${idsInseridos.length} leituras inseridas "
          "(ID: ${idsInseridos.first} ao ${idsInseridos.last})");
    }

    return {
      "leituras": novas,
      "alertas": alertas,
    };
  }
}