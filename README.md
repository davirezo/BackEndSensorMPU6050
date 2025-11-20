Monitoramento de Vibração Industrial – ESP32 + MPU6050 + Firebase + Dart + BI

Este projeto implementa um sistema de monitoramento de vibrações em máquinas industriais, utilizando um ESP32 conectado a um sensor MPU6050. As informações coletadas são enviadas para o Firebase Realtime Database, tratadas em uma aplicação Dart, armazenadas também em um banco MySQL e posteriormente analisadas em um dashboard de Business Intelligence (Power BI).

📡 Objetivo do Projeto
Criar uma solução IoT capaz de:
Coletar dados de vibração e aceleração (eixos X, Y e Z)
Detectar vibrações críticas em tempo real
Enviar leituras periódicas ao Firebase
Armazenar dados tratados em um banco MySQL
Gerar análises e indicadores em Power BI
Ajudar na prevenção de falhas em equipamentos industriais


🔧 Tecnologias Utilizadas
Hardware
ESP32
Sensor MPU6050
LED indicador de alerta

Software
Arduino IDE
Firebase Realtime Database
Dart (para processamento dos dados)
MySQL Workbench
Power BI (visualização dos dados)

📈 Arquitetura do Sistema
MPU6050 → ESP32 → Firebase Realtime Database
                                ↓
                             Dart 
                                ↓
                       MySQL / Power BI


O ESP32 faz:
Leitura do sensor
Cálculo da vibração
Detecção de alerta
Envio dos dados a cada 5 segundos

O Dart faz:
Recebimento dos dados (stream realtime)
Tratamento de alertas
Armazenamento no MySQL
Envio para BI

⚙️ Funcionalidades Principais
✔ Leitura dos eixos X, Y e Z
Converte a aceleração para m/s² utilizando o MPU6050.

✔ Cálculo da vibração
Remove a gravidade e obtém a vibração real da máquina.

✔ Detecção de alerta
Gera sinal crítico quando a vibração ultrapassa um limite, por exemplo:
vibração > 90 m/s².

✔ Envio para o Firebase
Os dados enviados incluem:
aceleraçãoX
aceleraçãoY
aceleraçãoZ
vibração
alerta (booleano)
timestamp

✔ Integração com BI
Os dados tratados são exportados para dashboards analíticos no Power BI.

🗃 Modelo de Dados do Firebase
{
  "leituras": {
    "timestamp": {
      "x": 0.12,
      "y": -0.04,
      "z": 9.81,
      "vibracao": 1.23,
      "alerta": false
    }
  }
}

🧪 Como Executar o Projeto
1. Subir o código no ESP32
Instalar dependências (Wire, Adafruit MPU6050, ArduinoJson)
Configurar Wi-Fi
Adicionar suas credenciais do Firebase
Fazer upload via Arduino IDE

2. Rodar a aplicação Dart
Conectar ao Firebase
Iniciar listener em tempo real
Tratar os dados recebidos
Gravar no MySQL

4. Visualizar no BI
Conectar Power BI ao MySQL
Criar gráficos de vibração, alertas e histórico

👨‍🔧 Integrantes do Projeto
Aluno Davi (EU): Hardware e integração do ESP32,  Modelagem de dados, MySQL, Dart
Aluno João Vitor Franco: Hardware e integração do ESP32,  Modelagem de dados, MySQL, Dart
Aluno João Vitor Contin:  Dashboard BI e documentação
Aluno Eduardo: Dashboard BI e documentação


📌 Melhorias Futuras
Criar um aplicativo mobile para monitoramento em tempo real
Implementar machine learning para prever falhas
Integrar múltiplos dispositivos ESP32 em uma mesma planta industrial

## 🔗 Acesso ao Repositório:
https://github.com/davirezo/BackEndSensorMPU6050
