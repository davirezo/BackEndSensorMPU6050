class LeituraSensor {
  final int idMaquina;
  final int idSensor;
  final double aceleracaoX;
  final double aceleracaoY;
  final double aceleracaoZ;
  final double giroscopioX;
  final double giroscopioY;
  final double giroscopioZ;
  final double vibracao;
  final DateTime timestamp;

  LeituraSensor({
    required this.idMaquina,
    required this.idSensor,
    required this.aceleracaoX,
    required this.aceleracaoY,
    required this.aceleracaoZ,
    required this.giroscopioX,
    required this.giroscopioY,
    required this.giroscopioZ,
    required this.vibracao,
    required this.timestamp,
  });

  factory LeituraSensor.fromJson(Map<String, dynamic> json) {
    return LeituraSensor(
      idMaquina: (json['id_maquina'] ?? 1).toInt(),
      idSensor: (json['id_sensor'] ?? 1).toInt(),
      aceleracaoX: (json['aceleracao']?['x'] ?? 0).toDouble(),
      aceleracaoY: (json['aceleracao']?['y'] ?? 0).toDouble(),
      aceleracaoZ: (json['aceleracao']?['z'] ?? 0).toDouble(),
      giroscopioX: (json['giroscopio']?['x'] ?? 0).toDouble(),
      giroscopioY: (json['giroscopio']?['y'] ?? 0).toDouble(),
      giroscopioZ: (json['giroscopio']?['z'] ?? 0).toDouble(),
      vibracao: (json['vibracao'] ?? 0).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  @override
  String toString() {
    return 'LeituraSensor(maquina: $idMaquina, sensor: $idSensor, acel: [$aceleracaoX, $aceleracaoY, $aceleracaoZ], '
        'giro: [$giroscopioX, $giroscopioY, $giroscopioZ], '
        'vibração: $vibracao, timestamp: $timestamp)';
  }
}
