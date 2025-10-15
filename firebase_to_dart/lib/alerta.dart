import 'package:firebase_to_dart/leitura_sensor.dart';

class Alerta {
  final String nivel;
  final String mensagem;
  final LeituraSensor leitura;

  Alerta({
    required this.nivel,
    required this.mensagem,
    required this.leitura,
  });

  factory Alerta.fromLeitura(LeituraSensor leitura) {
    String nivel;
    String mensagem;

    if (leitura.vibracao >= 95) {
      nivel = "Vermelho";
      mensagem = "🚨 Vibração muito alta!";
    } else if (leitura.vibracao >= 93) {
      nivel = "Laranja";
      mensagem = "⚠️ Vibração alta!";
    } else if (leitura.vibracao >= 91) {
      nivel = "Amarelo";
      mensagem = "⚠️ Vibração moderada.";
    } else {
      nivel = "Normal";
      mensagem = "Sem alerta.";
    }

    return Alerta(nivel: nivel, mensagem: mensagem, leitura: leitura);
  }

  Map<String, dynamic> toJson() {
    return {
      'nivel': nivel,
      'mensagem': mensagem,
      'timestamp': leitura.timestamp,
      'vibracao': leitura.vibracao,
      'aceleracao_x': leitura.aceleracaoX,
      'aceleracao_y': leitura.aceleracaoY,
      'aceleracao_z': leitura.aceleracaoZ,
      'giroscopio_x': leitura.giroscopioX,
      'giroscopio_y': leitura.giroscopioY,
      'giroscopio_z': leitura.giroscopioZ,
    };
  }
}
