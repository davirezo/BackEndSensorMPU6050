import 'package:firebase_to_dart/auth_service.dart';
import 'package:firebase_to_dart/firebase_service.dart';
import 'package:firebase_to_dart/leitura_sensor.dart';
import 'package:firebase_to_dart/mysql_service.dart';

Future<void> main() async {
  final authService = AuthService();

  print('🔑 Autenticando anonimamente no Firebase...');
  final token = await authService.autenticarAnonimamente();

  if (token == null) {
    print('❌ Falha na autenticação. Encerrando o programa.');
    return;
  }

  final firebaseService = FirebaseService(token);
  final mysqlService = MySQLService();

  print('🔌 Conectando ao MySQL...');
  await mysqlService.conectar();

  print('📡 Lendo dados do Firebase Realtime Database...');
  final List<LeituraSensor> leituras = await firebaseService.processarLeituras(mysqlService);

  print('\n📊 Leituras recebidas:');
  for (var leitura in leituras) {
    print(leitura);
  }

  await mysqlService.desconectar();
}
