import '../services/mysql_service.dart';

class MaquinaDAO {
  final MySQLService _mysqlService;

  MaquinaDAO(this._mysqlService);

  Future<void> verificarOuCriar(int idMaquina) async {
    await _mysqlService.ensureConnection();
    var resultado = await _mysqlService.connection.query(
      'SELECT id FROM maquinas WHERE id = ?',
      [idMaquina],
    );

    if (resultado.isEmpty) {
      await _mysqlService.connection.query(
        '''
        INSERT INTO maquinas (id, nome, descricao, localizacao)
        VALUES (?, ?, ?, ?)
        ''',
        [idMaquina, 'Máquina $idMaquina', 'Criada automaticamente', 'Não informada'],
      );
      print('🆕 Máquina $idMaquina criada automaticamente.');
    }
  }
}
