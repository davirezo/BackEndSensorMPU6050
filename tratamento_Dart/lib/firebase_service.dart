import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_to_dart/leitura_sensor.dart';
import 'package:firebase_to_dart/alerta.dart';
import 'package:firebase_to_dart/mysql_service.dart';

class FirebaseService {
  final String databaseUrl =
      'https://sensorvibracao-gp4-default-rtdb.firebaseio.com/';
  final String? idToken;

  FirebaseService(this.idToken);

  Future<List<LeituraSensor>> processarLeituras(MySQLService mysqlService) async {
    final url = Uri.parse('$databaseUrl/leituras.json?auth=$idToken');
    final response = await http.get(url);
    List<LeituraSensor> leituras = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.isEmpty) {
        print('⚠️ Nenhuma leitura encontrada.');
        return leituras;
      }

      for (var value in data.values) {
        final leitura = LeituraSensor.fromJson(value);
        final alerta = Alerta.fromLeitura(leitura);

        // ✅ Envia leitura para MySQL
        final idLeitura = await mysqlService.inserirLeitura(leitura);

        // ✅ Se houver alerta, insere também
        if (alerta.nivel != "Normal" && idLeitura != null) {
          await mysqlService.inserirAlerta(alerta, idLeitura);
        }

        leituras.add(leitura);

        if (alerta.nivel != "Normal") {
          print('🚨 ALERTA (${alerta.nivel}) | ${alerta.mensagem}');
          print('→ Vibração: ${leitura.vibracao}');
          print('→ Timestamp: ${leitura.timestamp}');
        } else {
          print('✅ Leitura normal em ${leitura.timestamp}');
        }
      }
    } else {
      print('❌ Erro ao buscar dados: ${response.statusCode}');
    }

    return leituras;
  }
}
