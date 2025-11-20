import '../models/alerta.dart';
import '../services/mysql_service.dart';

class AlertaDAO {
  final MySQLService _mysqlService;

  AlertaDAO(this._mysqlService);

  String _fmt(DateTime t) {
    return t.toIso8601String().replaceFirst('T', ' ').substring(0, 19);
  }

Future<int> inserir(Alerta alerta, int idLeitura) async {
  await _mysqlService.ensureConnection();

  var resultado = await _mysqlService.connection.query(
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
      _fmt(alerta.leitura.timestamp),
    ],
  );

  final id = resultado.insertId;
  if (id == null) {
    throw Exception("Insert de alerta não retornou insertId");
  }

    return id;
  }
}