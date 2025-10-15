class LeituraSensor {
  final double aceleracaoX;
  final double aceleracaoY;
  final double aceleracaoZ;
  final double giroscopioX;
  final double giroscopioY;
  final double giroscopioZ;
  final double vibracao;
  final DateTime timestamp;

  LeituraSensor({
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

  Map<String, dynamic> toMap() {
    return {
      'aceleracao_x': aceleracaoX,
      'aceleracao_y': aceleracaoY,
      'aceleracao_z': aceleracaoZ,
      'giroscopio_x': giroscopioX,
      'giroscopio_y': giroscopioY,
      'giroscopio_z': giroscopioZ,
      'vibracao': vibracao,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'LeituraSensor(acel: [$aceleracaoX, $aceleracaoY, $aceleracaoZ], '
        'giro: [$giroscopioX, $giroscopioY, $giroscopioZ], '
        'vibração: $vibracao, timestamp: $timestamp)';
  }
}
