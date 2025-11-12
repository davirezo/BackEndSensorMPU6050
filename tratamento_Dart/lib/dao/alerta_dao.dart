import '../models/alerta.dart';
import '../services/mysql_service.dart';

class AlertaDAO {
  final MySQLService _mysqlService;

  AlertaDAO(this._mysqlService);

  Future<void> inserir(Alerta alerta, int idLeitura) async {
    await _mysqlService.ensureConnection();

    await _mysqlService.connection.query(
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
  }
}
