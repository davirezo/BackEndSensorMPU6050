-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: sensorvibracao
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alertas`
--

DROP TABLE IF EXISTS `alertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alertas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_leitura` int NOT NULL,
  `vibracao` float NOT NULL,
  `nivel` varchar(20) NOT NULL,
  `mensagem` varchar(100) NOT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_leitura` (`id_leitura`),
  CONSTRAINT `alertas_ibfk_1` FOREIGN KEY (`id_leitura`) REFERENCES `leituras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alertas`
--

LOCK TABLES `alertas` WRITE;
/*!40000 ALTER TABLE `alertas` DISABLE KEYS */;
INSERT INTO `alertas` VALUES (1,14,91.1565,'Amarelo','⚠️ Vibração moderada.','2025-10-24 20:15:53'),(2,16,91.365,'Amarelo','⚠️ Vibração moderada.','2025-10-24 19:54:49'),(3,17,94.5359,'Laranja','⚠️ Vibração alta!','2025-10-15 20:22:02'),(4,25,106.534,'Vermelho','? Vibração muito alta!','2025-10-15 20:22:13'),(5,27,185.264,'Vermelho','? Vibração muito alta!','2025-10-31 20:40:16'),(6,29,105.176,'Vermelho','? Vibração muito alta!','2025-10-15 20:22:18'),(7,31,183.768,'Vermelho','? Vibração muito alta!','2025-10-31 20:40:22'),(8,33,97.8002,'Vermelho','? Vibração muito alta!','2025-10-15 20:22:23'),(9,35,193.621,'Vermelho','? Vibração muito alta!','2025-10-31 20:40:27'),(10,39,122.748,'Vermelho','? Vibração muito alta!','2025-10-31 20:40:32'),(11,42,103.456,'Vermelho','? Vibração muito alta!','2025-10-31 20:40:37'),(12,45,98.1947,'Vermelho','? Vibração muito alta!','2025-10-31 20:40:44'),(13,55,92.3597,'Amarelo','⚠️ Vibração moderada.','2025-10-31 20:41:10'),(14,66,91.3074,'Amarelo','⚠️ Vibração moderada.','2025-10-24 20:17:33'),(15,96,91.4024,'Amarelo','⚠️ Vibração moderada.','2025-10-24 20:19:08'),(16,113,94.2538,'Laranja','⚠️ Vibração alta!','2025-10-24 20:20:00'),(17,116,91.4171,'Amarelo','⚠️ Vibração moderada.','2025-10-24 20:20:11'),(18,144,95.3063,'Vermelho','? Vibração muito alta!','2025-10-24 20:21:40'),(19,292,91.4036,'Amarelo','⚠️ Vibração moderada.','2025-10-31 20:52:23'),(20,302,95.4352,'Vermelho','? Vibração muito alta!','2025-10-31 20:52:49'),(21,527,92.3196,'Amarelo','⚠️ Vibração moderada.','2025-10-31 21:11:19'),(22,579,91.4969,'Amarelo','⚠️ Vibração moderada.','2025-10-31 21:15:55'),(23,1125,93.3252,'Laranja','⚠️ Vibração alta!','2025-10-31 22:05:06'),(24,1544,91.4127,'Amarelo','⚠️ Vibração moderada.','2025-10-31 22:42:07'),(25,1566,91.3463,'Amarelo','⚠️ Vibração moderada.','2025-10-31 22:44:02'),(26,1831,93.2813,'Laranja','⚠️ Vibração alta!','2025-10-31 23:07:19'),(27,1914,92.3291,'Amarelo','⚠️ Vibração moderada.','2025-10-31 23:14:37'),(28,2026,92.369,'Amarelo','⚠️ Vibração moderada.','2025-10-31 23:24:29'),(29,2095,92.34,'Amarelo','⚠️ Vibração moderada.','2025-10-31 23:30:34'),(30,2163,93.2371,'Laranja','⚠️ Vibração alta!','2025-10-31 23:36:31'),(31,2190,93.276,'Laranja','⚠️ Vibração alta!','2025-10-31 23:38:53'),(32,2192,93.3499,'Laranja','⚠️ Vibração alta!','2025-10-31 23:39:04'),(33,2252,92.2358,'Amarelo','⚠️ Vibração moderada.','2025-10-31 23:44:20'),(34,2343,128.041,'Vermelho','? Vibração muito alta!','2025-11-06 21:11:46'),(35,2353,96.6858,'Vermelho','? Vibração muito alta!','2025-11-06 21:13:18'),(36,2386,92.9635,'Amarelo','⚠️ Vibração moderada.','2025-11-06 21:19:11'),(37,2460,93.271,'Laranja','⚠️ Vibração alta!','2025-10-31 23:53:29'),(38,2494,92.3509,'Amarelo','⚠️ Vibração moderada.','2025-10-31 23:56:28'),(39,2529,91.2883,'Amarelo','⚠️ Vibração moderada.','2025-10-31 23:59:32'),(40,2541,91.2073,'Amarelo','⚠️ Vibração moderada.','2025-11-01 00:00:35'),(41,2556,92.4172,'Amarelo','⚠️ Vibração moderada.','2025-11-01 00:01:54'),(42,2571,93.365,'Laranja','⚠️ Vibração alta!','2025-11-01 00:03:13'),(43,2636,93.451,'Laranja','⚠️ Vibração alta!','2025-11-01 00:08:55'),(44,2653,92.3607,'Amarelo','⚠️ Vibração moderada.','2025-11-01 00:10:23'),(45,2660,93.2591,'Laranja','⚠️ Vibração alta!','2025-11-01 00:11:00'),(46,2699,92.3001,'Amarelo','⚠️ Vibração moderada.','2025-11-01 00:14:25'),(47,2701,93.3318,'Laranja','⚠️ Vibração alta!','2025-11-01 00:14:36'),(48,2906,94.2708,'Laranja','⚠️ Vibração alta!','2025-11-01 00:32:33'),(49,2989,92.3958,'Amarelo','⚠️ Vibração moderada.','2025-11-01 00:39:50'),(50,3001,93.4436,'Laranja','⚠️ Vibração alta!','2025-11-01 00:40:53'),(51,3191,92.3009,'Amarelo','⚠️ Vibração moderada.','2025-11-01 00:57:33'),(52,3264,93.3909,'Laranja','⚠️ Vibração alta!','2025-11-01 01:03:57'),(53,3288,92.36,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:06:03'),(54,3322,91.4028,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:09:02'),(55,3358,92.2884,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:12:11'),(56,3360,91.4081,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:12:21'),(57,3381,91.4145,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:14:12'),(58,3384,91.3493,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:14:28'),(59,3454,95.243,'Vermelho','? Vibração muito alta!','2025-11-01 01:20:36'),(60,3466,91.3727,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:21:40'),(61,3574,92.412,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:31:09'),(62,3634,91.3135,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:36:25'),(63,3671,91.2705,'Amarelo','⚠️ Vibração moderada.','2025-11-01 01:39:41'),(64,4028,92.3871,'Amarelo','⚠️ Vibração moderada.','2025-11-01 02:11:07'),(65,4084,95.2744,'Vermelho','? Vibração muito alta!','2025-11-01 02:16:02'),(66,4132,93.418,'Laranja','⚠️ Vibração alta!','2025-11-01 02:20:19'),(67,4134,93.3452,'Laranja','⚠️ Vibração alta!','2025-11-01 02:20:30'),(68,4148,93.5,'Laranja','⚠️ Vibração alta!','2025-11-10 21:19:37'),(69,4692,114.143,'Vermelho','? Vibração muito alta!','2025-11-16 15:44:35'),(70,5695,97.0224,'Vermelho','? Vibração muito alta!','2025-11-17 20:38:27');
/*!40000 ALTER TABLE `alertas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-20 12:02:23
