import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_to_dart/leitura_sensor.dart';

class FirebaseService {
  final String baseUrl = 'https://sensorvibracao-gp4-default-rtdb.firebaseio.com';
  final String authToken;

  FirebaseService(this.authToken);

  Future<List<LeituraSensor>> lerLeituras() async {
    final url = Uri.parse('$baseUrl/leituras.json?auth=$authToken');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200 && response.body != 'null') {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<LeituraSensor> leituras = [];

        data.forEach((key, value) {
          try {
            leituras.add(LeituraSensor.fromJson(value));
          } catch (e) {
            print('⚠️ Erro ao converter leitura $key: $e');
          }
        });

        print('✅ ${leituras.length} leituras carregadas do Firebase.');
        return leituras;
      } else {
        print('❌ Erro ao buscar dados: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erro na conexão com Firebase: $e');
    }

    return [];
  }
}