#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <addons/TokenHelper.h> // para debug do token (opcional)
#include <addons/RTDBHelper.h>  // ajuda a lidar com dados RTDB

Adafruit_MPU6050 mpu;

// ======= CONFIGURAÇÕES DE WIFI =======
#define WIFI_SSID "Joao Vitor"
#define WIFI_PASSWORD "joao2806"

// ======= CONFIGURAÇÕES DO FIREBASE =======
#define FIREBASE_PROJECT_URL "https://sensorvibracao-gp4-default-rtdb.firebaseio.com/"
#define API_KEY "vpre3Zbzs3vmbTfr78YzckgIyqJBP1lnlU257O7g" // usando a mesma secret key para simplificar

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// ======= NTP (para data e hora) =======
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", -3 * 3600, 60000);

// ======= VARIÁVEIS DO SENSOR =======
const int ledPin = 13;
bool vibracaoCritica = false;
unsigned long ledTimer = 0;
bool ledState = false;
int blinkCount = 0;

void setup() {
  Serial.begin(115200);
  pinMode(ledPin, OUTPUT);

  // ---- Conectar Wi-Fi ----
  Serial.print("Conectando ao WiFi");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\n✅ WiFi conectado!");
  Serial.println(WiFi.localIP());

  // ---- Configuração do Firebase ----
  config.database_url = FIREBASE_PROJECT_URL;
  config.signer.tokens.legacy_token = API_KEY; // usa token simples (modo teste)

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  Serial.println("✅ Firebase conectado!");

  // ---- Inicializar NTP ----
  timeClient.begin();
  timeClient.update();

  // ---- Inicializar MPU6050 ----
  if (!mpu.begin()) {
    Serial.println("❌ Não foi possível encontrar o MPU6050!");
    while (1) delay(10);
  }

  mpu.setAccelerometerRange(MPU6050_RANGE_2_G);
  mpu.setGyroRange(MPU6050_RANGE_250_DEG);
  mpu.setFilterBandwidth(MPU6050_BAND_5_HZ);

  Serial.println("✅ MPU6050 iniciado com sucesso!");
  delay(1000);
}

void loop() {
  timeClient.update();

  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);

  // Aceleração em m/s²
  float ax = a.acceleration.x * 9.80665;
  float ay = a.acceleration.y * 9.80665;
  float az = a.acceleration.z * 9.80665;

  // Giroscópio em °/s
  float gx = g.gyro.x;
  float gy = g.gyro.y;
  float gz = g.gyro.z;

  // Vibração
  float acc_total = sqrt(ax * ax + ay * ay + az * az);
  float vibracao = abs(acc_total - 9.80665);

  // Exibir dados no Serial
  Serial.printf("Aceleração [m/s²] X: %.2f, Y: %.2f, Z: %.2f | Giroscópio [°/s] X: %.2f, Y: %.2f, Z: %.2f | Vibração: %.2f\n",
                ax, ay, az, gx, gy, gz, vibracao);

  // Piscar LED se vibração for crítica
  if (vibracao > 90.00 && !vibracaoCritica) {
    vibracaoCritica = true;
    ledTimer = millis();
    blinkCount = 0;
    ledState = false;
    Serial.println("⚠️ Vibração crítica detectada!");
  }

  if (vibracaoCritica) {
    if (millis() - ledTimer >= 50) {
      ledTimer = millis();
      ledState = !ledState;
      digitalWrite(ledPin, ledState ? HIGH : LOW);

      if (!ledState) blinkCount++;
      if (blinkCount >= 2) {
        vibracaoCritica = false;
        digitalWrite(ledPin, LOW);
      }
    }
  } else {
    digitalWrite(ledPin, LOW);
  }

  // ----- TIMESTAMP COMPLETO -----
  time_t rawTime = timeClient.getEpochTime();
  struct tm *timeInfo = localtime(&rawTime);
  char formattedTime[25];
  strftime(formattedTime, sizeof(formattedTime), "%Y-%m-%d %H:%M:%S", timeInfo);

  String timestamp = String(formattedTime);
  String path = "/leituras/" + String(millis());

  // ----- Enviar ao Firebase -----
  FirebaseJson json;
  json.set("id_maquina", 1);
  json.set("id_sensor", 1);
  json.set("timestamp", timestamp);
  json.set("aceleracao/x", ax);
  json.set("aceleracao/y", ay);
  json.set("aceleracao/z", az);
  json.set("giroscopio/x", gx);
  json.set("giroscopio/y", gy);
  json.set("giroscopio/z", gz);
  json.set("vibracao", vibracao);

  if (Firebase.RTDB.setJSON(&fbdo, path.c_str(), &json)) {
    Serial.println("✅ Dados enviados ao Firebase!");
  } else {
    Serial.print("❌ Erro: ");
    Serial.println(fbdo.errorReason());
  }

  delay(5000);
}