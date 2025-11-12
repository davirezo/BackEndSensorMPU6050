import 'package:firebase_to_dart/services/auth_service.dart';
import 'package:firebase_to_dart/services/firebase_service.dart';
import 'package:firebase_to_dart/services/mysql_service.dart';
import 'package:firebase_to_dart/models/leitura_sensor.dart';
// ignore: unused_import
import 'package:firebase_to_dart/models/alerta.dart';

Future<void> main() async {
  final authService = AuthService();
  print('🔑 Autenticando anonimamente no Firebase...');
final token = await authService.autenticarComEmailSenha(
  email: '######',
  senha: '#######',
);

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
