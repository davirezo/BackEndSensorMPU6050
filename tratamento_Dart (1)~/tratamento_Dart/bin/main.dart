import 'package:firebase_to_dart/services/auth_service.dart';
import 'package:firebase_to_dart/services/firebase_service.dart';
import 'package:firebase_to_dart/services/mysql_service.dart';

Future<void> main() async {
  final authService = AuthService();
  print("\n==========================================");
  print('🔑 Autenticando no Firebase...');

  final token = await authService.autenticarComEmailSenha(
    email: 'joao.v.moraes@sou.unifeob.edu.br',
    senha: 'senhasensor#',
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
  final resultado = await firebaseService.processarLeituras(mysqlService);

  final totalLeituras = resultado["leituras"] ?? 0;
  final totalAlertas = resultado["alertas"] ?? 0;

  print('\n📊 Resumo:');
  print("Leituras novas: $totalLeituras");
  print("Alertas gerados: $totalAlertas");

  await mysqlService.desconectar();
  print("==========================================");
}
