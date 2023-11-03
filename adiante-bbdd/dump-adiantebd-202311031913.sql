-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 82.223.97.161    Database: adiantebd
-- ------------------------------------------------------
-- Server version	5.5.5-10.11.5-MariaDB-1:10.11.5+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_question` bigint(20) NOT NULL,
  `hasIcon` tinyint(1) NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_FK` (`id_question`),
  CONSTRAINT `answer_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,2,0,NULL),(7,2,0,NULL),(8,3,0,NULL),(9,3,0,NULL),(10,4,0,NULL),(11,4,0,NULL),(12,5,0,NULL),(13,5,0,NULL),(14,5,0,NULL),(15,5,0,NULL),(16,7,0,NULL),(17,7,0,NULL),(18,7,0,NULL),(19,7,0,NULL),(20,8,0,NULL),(21,8,0,NULL),(22,8,0,NULL),(23,8,0,NULL),(24,11,0,NULL),(25,11,0,NULL),(26,11,0,NULL),(27,11,0,NULL),(28,15,0,NULL),(29,15,0,NULL),(30,15,0,NULL),(32,19,0,NULL),(33,21,0,0),(34,21,0,0),(35,21,0,0),(36,22,0,0),(37,22,0,0),(38,23,0,0),(39,24,0,0),(40,25,0,0),(45,27,0,0),(46,27,0,0),(48,27,0,0),(49,27,0,0),(50,29,0,0),(51,29,0,0),(52,29,0,0),(55,32,0,0),(56,33,0,0),(57,33,0,0),(58,34,0,0),(59,34,0,0),(60,34,0,0),(61,35,0,0),(62,39,0,0),(63,39,0,0),(64,40,0,0),(72,44,0,0),(73,44,0,0),(74,45,0,0),(75,45,0,0),(76,46,0,0),(77,46,0,0),(78,47,0,0),(79,47,0,0),(80,48,0,0),(81,48,0,0),(82,49,0,0),(83,49,0,0),(84,50,0,0),(85,50,0,0),(86,51,0,0),(87,51,0,0),(88,52,0,0),(89,52,0,0),(90,53,0,0),(91,53,0,0),(92,54,0,0),(93,54,0,0),(94,54,0,0),(95,54,0,0),(96,55,0,0),(97,55,0,0),(98,55,0,0),(99,55,0,0);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_i18n`
--

DROP TABLE IF EXISTS `answer_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_i18n` (
  `id` bigint(20) NOT NULL,
  `id_language` bigint(20) NOT NULL,
  `id_answer` bigint(20) NOT NULL,
  `i18n_value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_i18n_FK` (`id_language`),
  KEY `answer_i18n_FK_1` (`id_answer`),
  CONSTRAINT `answer_i18n_FK` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id`),
  CONSTRAINT `answer_i18n_FK_1` FOREIGN KEY (`id_answer`) REFERENCES `answer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_i18n`
--

LOCK TABLES `answer_i18n` WRITE;
/*!40000 ALTER TABLE `answer_i18n` DISABLE KEYS */;
INSERT INTO `answer_i18n` VALUES (1,1,1,'Muy felíz'),(2,1,2,'Muy bien'),(3,1,3,'Indiferente'),(4,1,4,'Mal'),(5,1,5,'Muy mal'),(6,1,6,'Sí'),(7,1,7,'No'),(8,1,8,'Sí'),(9,1,9,'No'),(10,1,10,'Sí'),(11,1,11,'No'),(12,1,12,'Estoy desanimad@'),(13,1,13,'Estoy cansad@'),(14,1,14,'Estoy enfadad@ '),(15,1,15,'Estoy aburrid@'),(16,1,16,'Apatía'),(17,1,17,'Aislamiento social'),(18,1,18,'Delirios'),(19,1,19,'Abulia'),(20,1,20,'Hacer 5 comidas al día.'),(21,1,21,'Relacionarse con la familia'),(22,1,22,'Practicar deporte'),(23,1,23,'Picotear '),(24,1,24,'Debemos aceptar solo las emociones buenas.'),(25,1,25,'Debemos juzgar las emociones si son malas. '),(26,1,26,'Debemos resolver siempre todas las situaciones.'),(27,1,27,'Todas las emociones son válidas. '),(28,1,28,'La agitación, ritmo cardíaco alto y la respiración acelerada son síntomas de ansiedad. '),(29,1,29,'Consumir alcohol reduce la ansiedad.'),(30,1,30,'c)	Cuando se sufre ansiedad se tiene trastornos del sueño y de alimentación. '),(31,1,32,'Escribe tu respuesta'),(32,1,33,'sdfsdf'),(33,1,34,'sdfsdfsdf'),(34,1,35,'sdfsdf'),(35,1,36,'sdfsdfdsf'),(36,1,37,'sdfsdfsdf'),(37,1,38,''),(38,1,39,'Respuesta'),(39,1,40,'Respuesta'),(44,1,45,'6'),(45,1,46,'9'),(46,1,48,'5'),(47,1,49,'4'),(48,1,50,'5'),(49,1,51,'1'),(50,1,52,'4'),(51,1,55,'mal'),(52,1,56,'sdfsdf'),(53,1,57,'asdasd'),(54,1,58,'asdasd'),(55,1,59,'asdasdasd'),(56,1,60,'asdasd'),(57,1,61,''),(58,1,62,'más de 20'),(59,1,63,'menos de 20'),(60,1,64,'si'),(61,1,72,'Si'),(62,1,73,'No'),(63,1,74,'Si'),(64,1,75,'No'),(65,1,76,'Si'),(66,1,77,'No'),(67,1,78,'Si'),(68,1,79,'No'),(69,1,80,'Si'),(70,1,81,'No'),(71,1,82,'Si'),(72,1,83,'No'),(73,1,84,'Si'),(74,1,85,'No'),(75,1,86,'Si'),(76,1,87,'No'),(77,1,88,'Si'),(78,1,89,'No'),(79,1,90,'Si'),(80,1,91,'No'),(81,1,92,'2'),(82,1,93,'5'),(83,1,94,'4'),(84,1,95,'3'),(85,1,96,'Hacer ejercicio'),(86,1,97,'Picar entre horas'),(87,1,98,'Mantener horarios regulables'),(88,1,99,'Ver la televisión en la cama');
/*!40000 ALTER TABLE `answer_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` bigint(20) NOT NULL,
  `code_name` varchar(4) DEFAULT NULL,
  `culture` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'es','es-ES'),(2,'gl','gl-ES');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_schedule`
--

DROP TABLE IF EXISTS `notification_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program_task` bigint(20) NOT NULL,
  `pattern` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_schedule_FK` (`id_program_task`),
  CONSTRAINT `notification_schedule_FK` FOREIGN KEY (`id_program_task`) REFERENCES `program_task` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_schedule`
--

LOCK TABLES `notification_schedule` WRITE;
/*!40000 ALTER TABLE `notification_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `password` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `aditional_info` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patient_un` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Pruebas','Pruebas','Rua Maior,n3 Salamanca','647222111','$2a$08$uUb99gbakUWKMj9ns9vw/erxM7q.2FvJ6u2c3bCAYKaQvQipujfNW','test2@mail.com',NULL,'2023-03-20 00:00:00','2023-03-20 00:00:00'),(3,'Sergio','Miranda Ruiz','','','d0c1ef17ad6107e723e02b6aa13b1051','sergiomirandaruiz@gmail.com',NULL,'2023-10-12 00:00:00','2023-10-12 00:00:00');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_activity_entry`
--

DROP TABLE IF EXISTS `patient_activity_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_activity_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entry_datetime` datetime DEFAULT NULL,
  `id_patient` bigint(20) DEFAULT NULL,
  `id_task` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_activity_entry_FK` (`id_patient`),
  KEY `patient_activity_entry_FK_1` (`id_task`),
  CONSTRAINT `patient_activity_entry_FK` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_activity_entry_FK_1` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_activity_entry`
--

LOCK TABLES `patient_activity_entry` WRITE;
/*!40000 ALTER TABLE `patient_activity_entry` DISABLE KEYS */;
INSERT INTO `patient_activity_entry` VALUES (347,'2023-10-16 14:44:30',1,1),(348,'2023-10-16 14:44:34',1,1),(349,'2023-10-17 17:02:15',1,1),(350,'2023-10-17 17:02:18',1,74),(351,'2023-10-17 19:44:26',1,1),(352,'2023-10-17 19:44:38',1,1),(353,'2023-10-17 19:44:51',1,7),(354,'2023-10-18 12:38:34',3,1),(355,'2023-10-19 14:04:30',3,1),(356,'2023-10-19 14:07:32',3,59),(357,'2023-10-23 09:32:08',3,1),(358,'2023-10-23 09:32:26',3,74),(359,'2023-10-23 09:33:15',3,1),(360,'2023-10-23 09:33:25',3,1),(361,'2023-10-23 11:53:00',1,1),(362,'2023-10-23 11:53:03',1,1),(363,'2023-10-23 11:53:05',1,1),(364,'2023-10-23 11:53:09',1,74),(366,'2023-10-24 14:22:55',3,105),(367,'2023-10-25 09:18:42',1,1),(368,'2023-10-25 09:18:45',1,74),(369,'2023-10-25 09:27:50',1,1),(370,'2023-10-25 09:27:55',1,74),(371,'2023-10-25 09:36:21',1,1),(372,'2023-10-25 09:36:23',1,74),(373,'2023-10-25 10:15:35',1,1),(374,'2023-10-25 10:15:40',1,74),(375,'2023-10-25 15:42:47',1,112),(376,'2023-10-26 10:19:40',1,1),(377,'2023-10-26 10:19:46',1,74),(378,'2023-10-31 11:11:51',1,1),(379,'2023-10-31 11:12:06',1,7),(380,'2023-11-03 08:14:03',1,1),(381,'2023-11-03 08:14:51',1,7),(382,'2023-11-03 08:45:17',1,1),(383,'2023-11-03 08:45:21',1,74),(384,'2023-11-03 09:19:57',1,1),(385,'2023-11-03 09:20:00',1,74),(392,'2023-11-03 18:03:43',1,1),(393,'2023-11-03 18:04:46',1,1),(394,'2023-11-03 18:10:29',1,1);
/*!40000 ALTER TABLE `patient_activity_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_activity_entry_value`
--

DROP TABLE IF EXISTS `patient_activity_entry_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_activity_entry_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` text NOT NULL,
  `id_activity_entry` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_activity_entry_value_FK` (`id_activity_entry`),
  CONSTRAINT `patient_activity_entry_value_FK` FOREIGN KEY (`id_activity_entry`) REFERENCES `patient_activity_entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_activity_entry_value`
--

LOCK TABLES `patient_activity_entry_value` WRITE;
/*!40000 ALTER TABLE `patient_activity_entry_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_activity_entry_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_follow_up`
--

DROP TABLE IF EXISTS `patient_follow_up`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_follow_up` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_patient` bigint(20) DEFAULT NULL,
  `catchup_comment` text DEFAULT NULL,
  `id_profesional` bigint(20) NOT NULL,
  `comment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_follow_up_FK` (`id_patient`),
  KEY `patient_follow_up_FK_1` (`id_profesional`),
  CONSTRAINT `patient_follow_up_FK` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`),
  CONSTRAINT `patient_follow_up_FK_1` FOREIGN KEY (`id_profesional`) REFERENCES `profesional` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_follow_up`
--

LOCK TABLES `patient_follow_up` WRITE;
/*!40000 ALTER TABLE `patient_follow_up` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_follow_up` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program_map`
--

DROP TABLE IF EXISTS `patient_program_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_program_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_patient` bigint(20) NOT NULL,
  `id_program` bigint(20) NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_program_map_FK` (`id_patient`),
  KEY `patient_program_map_FK_1` (`id_program`),
  CONSTRAINT `patient_program_map_FK` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`),
  CONSTRAINT `patient_program_map_FK_1` FOREIGN KEY (`id_program`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_map`
--

LOCK TABLES `patient_program_map` WRITE;
/*!40000 ALTER TABLE `patient_program_map` DISABLE KEYS */;
INSERT INTO `patient_program_map` VALUES (1,1,1,'2023-05-17 10:23:55',NULL,1),(2,3,1,'2023-10-16 10:23:55',NULL,1);
/*!40000 ALTER TABLE `patient_program_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_scheduled_task`
--

DROP TABLE IF EXISTS `patient_scheduled_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_scheduled_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `id_task` bigint(20) NOT NULL,
  `id_patient_activity_entry` bigint(20) DEFAULT NULL,
  `id_patient` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_task_scheduling_FK` (`id_patient_activity_entry`),
  KEY `patient_task_scheduling_FK_1` (`id_task`),
  KEY `patient_task_scheduling_FK_2` (`id_patient`),
  CONSTRAINT `patient_task_scheduling_FK` FOREIGN KEY (`id_patient_activity_entry`) REFERENCES `patient_activity_entry` (`id`),
  CONSTRAINT `patient_task_scheduling_FK_1` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `patient_task_scheduling_FK_2` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_scheduled_task`
--

LOCK TABLES `patient_scheduled_task` WRITE;
/*!40000 ALTER TABLE `patient_scheduled_task` DISABLE KEYS */;
INSERT INTO `patient_scheduled_task` VALUES (51,'2023-10-24 11:38:00','2023-10-24 11:38:00',105,366,3),(52,'2023-10-24 11:39:00','2023-10-24 11:39:00',106,NULL,1),(53,'2023-10-24 11:39:00','2023-10-24 11:39:00',106,NULL,1),(54,'2023-10-27 20:30:00','2023-10-27 22:30:00',112,375,1),(56,'2023-11-03 08:47:00','2023-11-03 09:48:00',118,NULL,1);
/*!40000 ALTER TABLE `patient_scheduled_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_scoring`
--

DROP TABLE IF EXISTS `patient_scoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_scoring` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scoring` decimal(10,0) DEFAULT NULL,
  `id_patient` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_scoring_FK` (`id_patient`),
  CONSTRAINT `patient_scoring_FK` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_scoring`
--

LOCK TABLES `patient_scoring` WRITE;
/*!40000 ALTER TABLE `patient_scoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_scoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesional`
--

DROP TABLE IF EXISTS `profesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesional` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `surname` varchar(200) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesional`
--

LOCK TABLES `profesional` WRITE;
/*!40000 ALTER TABLE `profesional` DISABLE KEYS */;
INSERT INTO `profesional` VALUES (1,'alex','atn9','test2@mail.com','4xsQ9K2rUs+RerVEWvwKHafAHhKObwX32Fc6Rq/FnQY15QDL+CnP7MwR3LpnfseSERGiVCpxSOS7DPNvh2Sh9u/YK1XVSKx7W+prCs0axl/Glc1cHaaaBOyAmM8jML2o');
/*!40000 ALTER TABLE `profesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (1,'adnt-p1','Programa piloto para el seguimiento de pacientes',1);
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_task`
--

DROP TABLE IF EXISTS `program_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_program` bigint(20) NOT NULL,
  `id_task` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `program_task_FK` (`id_program`),
  CONSTRAINT `program_task_FK` FOREIGN KEY (`id_program`) REFERENCES `program` (`id`) ON DELETE CASCADE,
  CONSTRAINT `program_task_FK_1` FOREIGN KEY (`id`) REFERENCES `task` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_task`
--

LOCK TABLES `program_task` WRITE;
/*!40000 ALTER TABLE `program_task` DISABLE KEYS */;
INSERT INTO `program_task` VALUES (1,1,'1');
/*!40000 ALTER TABLE `program_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_questionnaire` bigint(20) NOT NULL,
  `id_question_type` bigint(20) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_FK` (`id_questionnaire`),
  KEY `question_FK_2` (`id_question_type`),
  CONSTRAINT `question_FK` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaire` (`id`),
  CONSTRAINT `question_FK_2` FOREIGN KEY (`id_question_type`) REFERENCES `question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,1,NULL,NULL),(2,2,1,NULL,NULL),(3,2,1,NULL,NULL),(4,2,1,NULL,NULL),(5,2,3,NULL,NULL),(6,2,2,NULL,NULL),(7,3,1,NULL,NULL),(8,4,1,NULL,NULL),(9,5,2,NULL,NULL),(10,6,2,NULL,NULL),(11,7,1,NULL,NULL),(12,8,2,NULL,NULL),(13,9,2,NULL,NULL),(14,10,2,NULL,NULL),(15,11,2,NULL,NULL),(16,12,2,NULL,NULL),(17,13,2,NULL,NULL),(18,14,2,NULL,NULL),(19,15,2,NULL,NULL),(20,16,2,NULL,NULL),(21,17,1,NULL,NULL),(22,17,3,NULL,NULL),(23,18,2,NULL,NULL),(24,19,1,NULL,NULL),(25,19,1,NULL,NULL),(27,20,3,NULL,NULL),(29,20,1,NULL,NULL),(30,20,2,NULL,NULL),(32,20,2,NULL,NULL),(33,21,1,NULL,NULL),(34,21,3,NULL,NULL),(35,22,2,NULL,NULL),(36,23,2,NULL,NULL),(37,24,2,NULL,NULL),(38,25,2,NULL,NULL),(39,25,3,NULL,NULL),(40,25,1,NULL,NULL),(44,28,1,NULL,NULL),(45,28,1,NULL,NULL),(46,28,1,NULL,NULL),(47,28,1,NULL,NULL),(48,28,1,NULL,NULL),(49,28,1,NULL,NULL),(50,28,1,NULL,NULL),(51,28,1,NULL,NULL),(52,28,1,NULL,NULL),(53,28,1,NULL,NULL),(54,29,1,NULL,NULL),(55,29,3,NULL,NULL),(56,30,2,NULL,NULL),(57,30,2,NULL,NULL);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_i18n`
--

DROP TABLE IF EXISTS `question_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_i18n` (
  `id` bigint(20) NOT NULL,
  `id_language` bigint(20) NOT NULL,
  `id_question` bigint(20) NOT NULL,
  `i18n_value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_i18n_FK` (`id_question`),
  KEY `question_i18n_FK_1` (`id_language`),
  CONSTRAINT `question_i18n_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`),
  CONSTRAINT `question_i18n_FK_1` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_i18n`
--

LOCK TABLES `question_i18n` WRITE;
/*!40000 ALTER TABLE `question_i18n` DISABLE KEYS */;
INSERT INTO `question_i18n` VALUES (1,1,1,'¿Cómo te sientes ?'),(2,1,2,'¿Te sientes nervios@ o en tensión?'),(3,1,3,'¿Estás preocupad@ por algo?'),(4,1,4,'¿Has dormiado mal?'),(5,1,5,'¿Tienes alguno de estos síntomas?'),(6,1,6,'Cuentanos algo más '),(7,1,7,'¿Cuál de los siguientes síntomas es positivo?'),(8,1,8,'¿cuál de los siguientes no es un hábito saludable? '),(12,1,19,'¿Qué estabas haciendo para sentirte así?'),(13,1,44,'¿toma de forma habitual algún medicamento como aspirinas o pastillas para dormir?'),(14,1,45,'¿tiene dificultades para conciliar el sueño?'),(15,1,46,'¿a veces nota que podría perder el control sobre sí mismo/a?'),(16,1,47,'¿tiene poco interés en relacionarse con la gente?'),(17,1,48,'¿ve su futuro con más pesimismo que optimismo?'),(18,1,49,'¿se ha sentido alguna vez inútil o inservible?'),(19,1,50,'¿ve su futuro sin ninguna esperanza?'),(20,1,51,'¿se ha sentido alguna vez tan fracasado/a que solo quería meterse en cama y abandonarlo todo?'),(21,1,52,'¿está deprimido/a ahora?'),(22,1,53,'¿está separado/a, divorciado/a o viudo/a?'),(23,1,54,'¿Cuántas comidas, como mínimo, es recomendable hacer al día?'),(24,1,55,'Marca las opciones que favorecen un estilo de vida saludable.'),(25,1,56,'¿Con quien has hablado?'),(26,1,57,'¿De qué habéis hablado?');
/*!40000 ALTER TABLE `question_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_type`
--

DROP TABLE IF EXISTS `question_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_type` (
  `id` bigint(20) NOT NULL,
  `code_name` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_type`
--

LOCK TABLES `question_type` WRITE;
/*!40000 ALTER TABLE `question_type` DISABLE KEYS */;
INSERT INTO `question_type` VALUES (1,'qt-select-one','This kind of question shows multiple answers. Only is allow to select one question.'),(2,'qt-free-answer','There is no predefined answers. Patient introduces feedback through free text.'),(3,'qt-select-mult','This kind of question shows multiple answers. Only is allow to select one question.');
/*!40000 ALTER TABLE `question_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire`
--

DROP TABLE IF EXISTS `questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `id_questionnaire_type` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionary_FK` (`id_questionnaire_type`),
  CONSTRAINT `questionary_FK` FOREIGN KEY (`id_questionnaire_type`) REFERENCES `questionnaire_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,'q-get-mood','Questionary to get patient mood selecting on single answer',1),(2,'q-anxiety-scale','Questions target to know the patient anxiety level',2),(3,'q-esquizo','¿Qué es la esquizofrenia?',2),(4,'q-reto-1','Estilo de vida saludable',2),(5,'q-reto-2','Tecnica de respiración',2),(6,'q-reto-3','Lista de  emociones ',2),(7,'q-reto-4','Gestionar  emociones ',2),(8,'q-reto-5','Ver una película',2),(9,'q-reto-6','Juego de atención: buscando a Wally',2),(10,'q-reto-7','Lee y ordena el texto',2),(11,'q-reto-8','Síntomas de ansiedad',2),(12,'q-reto-9','Mejorar nuestra autoestima',2),(13,'q-reto-10','Busqueda por internet',2),(14,'q-reto-11','Conocernos mejor',2),(15,'q-freeanswer','Cuestionario con pregunta de respuesta libre.',2),(16,'q-freeanswer-state','¿Qué estabas haciendo para sentirte así?',2),(17,'','',2),(18,'','',2),(19,'','',2),(20,'','',2),(21,'','',2),(22,'','',2),(23,'','',2),(24,'','',2),(25,'','',2),(28,'','',2),(29,'','',2),(30,'','',2);
/*!40000 ALTER TABLE `questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_execution`
--

DROP TABLE IF EXISTS `questionnaire_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_execution` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_questionnaire` bigint(20) NOT NULL,
  `id_patient_activy_entry` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionary_execution_FK` (`id_questionnaire`),
  KEY `questionary_execution_FK_1` (`id_patient_activy_entry`),
  CONSTRAINT `questionary_execution_FK` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaire` (`id`),
  CONSTRAINT `questionary_execution_FK_1` FOREIGN KEY (`id_patient_activy_entry`) REFERENCES `patient_activity_entry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution`
--

LOCK TABLES `questionnaire_execution` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution` DISABLE KEYS */;
INSERT INTO `questionnaire_execution` VALUES (310,1,347),(311,1,348),(312,1,349),(313,15,350),(314,1,351),(315,1,352),(316,2,353),(317,1,354),(318,1,355),(319,3,356),(320,1,357),(321,15,358),(322,1,359),(323,1,360),(324,1,361),(325,1,362),(326,1,363),(327,15,364),(329,1,367),(330,15,368),(331,1,369),(332,15,370),(333,1,371),(334,15,372),(335,1,373),(336,15,374),(337,28,375),(338,1,376),(339,15,377),(340,1,378),(341,2,379),(342,1,380),(343,2,381),(344,1,382),(345,15,383),(346,1,384),(347,15,385),(348,1,392),(349,1,393),(350,1,394);
/*!40000 ALTER TABLE `questionnaire_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_execution_answer`
--

DROP TABLE IF EXISTS `questionnaire_execution_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_execution_answer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_question` bigint(20) NOT NULL,
  `free_answer_value` text DEFAULT NULL,
  `id_answer` bigint(20) DEFAULT NULL,
  `id_questionnaire_execution` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_answer_FK` (`id_question`),
  KEY `patient_answer_FK_1` (`id_answer`),
  KEY `patient_answer_FK_2` (`id_questionnaire_execution`),
  CONSTRAINT `patient_answer_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`),
  CONSTRAINT `patient_answer_FK_1` FOREIGN KEY (`id_answer`) REFERENCES `answer` (`id`),
  CONSTRAINT `patient_answer_FK_2` FOREIGN KEY (`id_questionnaire_execution`) REFERENCES `questionnaire_execution` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution_answer`
--

LOCK TABLES `questionnaire_execution_answer` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution_answer` DISABLE KEYS */;
INSERT INTO `questionnaire_execution_answer` VALUES (424,1,NULL,1,310),(425,1,NULL,2,311),(426,1,NULL,1,312),(427,19,NULL,NULL,313),(428,1,NULL,1,314),(429,1,NULL,5,315),(430,5,NULL,15,316),(431,5,NULL,14,316),(432,4,NULL,10,316),(433,3,NULL,8,316),(434,2,NULL,6,316),(435,6,'Nada',NULL,316),(436,1,NULL,2,317),(437,1,NULL,3,318),(438,7,NULL,18,319),(439,1,NULL,1,320),(440,19,'Test',NULL,321),(441,1,NULL,3,322),(442,1,NULL,3,323),(443,1,NULL,5,324),(444,1,NULL,4,325),(445,1,NULL,2,326),(446,19,'Nada especial',NULL,327),(448,1,NULL,2,329),(449,19,'adasd',NULL,330),(450,1,NULL,1,331),(451,19,'no tengo nada que decir',NULL,332),(452,1,NULL,1,333),(453,19,'asdasd',NULL,334),(454,1,NULL,1,335),(455,19,'esto é unha proba',NULL,336),(456,53,NULL,90,337),(457,52,NULL,89,337),(458,51,NULL,87,337),(459,50,NULL,84,337),(460,49,NULL,83,337),(461,48,NULL,80,337),(462,47,NULL,78,337),(463,46,NULL,77,337),(464,45,NULL,75,337),(465,44,NULL,72,337),(466,1,NULL,3,338),(467,19,'nada',NULL,339),(468,1,NULL,5,340),(469,5,NULL,13,341),(470,5,NULL,14,341),(471,4,NULL,11,341),(472,3,NULL,9,341),(473,2,NULL,7,341),(474,6,'ndamas',NULL,341),(475,1,NULL,5,342),(476,5,NULL,13,343),(477,4,NULL,10,343),(478,3,NULL,9,343),(479,2,NULL,6,343),(480,6,'Respuesta de prueba',NULL,343),(481,1,NULL,1,344),(482,19,'probas',NULL,345),(483,1,NULL,1,346),(484,19,'PROBAS',NULL,347),(485,1,NULL,1,348),(486,1,NULL,1,349),(487,1,NULL,1,350);
/*!40000 ALTER TABLE `questionnaire_execution_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_type`
--

DROP TABLE IF EXISTS `questionnaire_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_type` (
  `id` bigint(20) NOT NULL,
  `code_name` varchar(20) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_type`
--

LOCK TABLES `questionnaire_type` WRITE;
/*!40000 ALTER TABLE `questionnaire_type` DISABLE KEYS */;
INSERT INTO `questionnaire_type` VALUES (1,'qt-dashboard','This kind of questionary is show on the patients dashboard'),(2,'qt-stepper','Questionnaire that shows the different questions step by step');
/*!40000 ALTER TABLE `questionnaire_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `related_answer_task`
--

DROP TABLE IF EXISTS `related_answer_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `related_answer_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_answer` bigint(20) NOT NULL,
  `id_task` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `related_questionary_FK_1` (`id_answer`),
  KEY `related_answer_task_FK` (`id_task`),
  CONSTRAINT `related_answer_task_FK` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `related_questionary_FK_1` FOREIGN KEY (`id_answer`) REFERENCES `answer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_answer_task`
--

LOCK TABLES `related_answer_task` WRITE;
/*!40000 ALTER TABLE `related_answer_task` DISABLE KEYS */;
INSERT INTO `related_answer_task` VALUES (1,4,7),(2,5,7),(3,18,59),(4,20,60),(5,26,63),(6,29,67),(7,1,74),(8,2,74),(9,3,74);
/*!40000 ALTER TABLE `related_answer_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `related_patient_activity_entries`
--

DROP TABLE IF EXISTS `related_patient_activity_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `related_patient_activity_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_patient_activity_entry` bigint(20) NOT NULL,
  `patient_activity_entry` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `related_patient_activity_entries_FK` (`parent_patient_activity_entry`),
  KEY `related_patient_activity_entries_FK_1` (`patient_activity_entry`),
  CONSTRAINT `related_patient_activity_entries_FK` FOREIGN KEY (`parent_patient_activity_entry`) REFERENCES `patient_activity_entry` (`id`),
  CONSTRAINT `related_patient_activity_entries_FK_1` FOREIGN KEY (`patient_activity_entry`) REFERENCES `patient_activity_entry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_patient_activity_entries`
--

LOCK TABLES `related_patient_activity_entries` WRITE;
/*!40000 ALTER TABLE `related_patient_activity_entries` DISABLE KEYS */;
INSERT INTO `related_patient_activity_entries` VALUES (7,347,392),(8,347,394);
/*!40000 ALTER TABLE `related_patient_activity_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `id_task_type` bigint(20) DEFAULT NULL,
  `free_execution` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `mandatory_feedback` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `task_FK` (`id_task_type`),
  CONSTRAINT `task_FK` FOREIGN KEY (`id_task_type`) REFERENCES `task_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'t-get-mood','This task gets patients mood thrugh a questionary',1,1,'2023-03-25 08:23:55','2023-03-25 08:23:55',1),(2,'t-doWorkout','Activity to tell patient to do workout',3,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(3,'t-breakfast','Suggest patient to take the breakfast',3,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(4,'t-challenge','Challenge',2,1,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(5,'t-yoga','Do yoga',4,1,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(6,'t-medication','Remainds patient to takin his medication',3,0,'2023-03-25 08:23:55','2023-03-25 08:23:55',0),(7,'t-cuestionnaire','Request patient to answer questionnaire',1,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(59,'t-esquizo','¿Qué es la esquizofrenia?',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(60,'t-question-1','En este reto, aprenderás algunos factores de protección para tener un estilo de vida más saludable',2,0,'2023-07-12 00:00:00','2023-10-27 14:33:43',0),(61,'t-question-2','Breathing technique',4,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(62,'t-question-3','List of emotions',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(63,'t-question-4','Manage emotions',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(64,'t-question-5','watch a movie',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(65,'t-question-6','Juego de atención: buscando a Wally',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(66,'t-question-7','Lee y ordena el texto',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(67,'t-question-8','Síntomas de ansiedad',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(68,'t-question-9','Mejorar nuestra autoestima',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(69,'t-cocinar','Cocinemos todos juntos',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(70,'t-question-11','Búsquedas por internet',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(71,'t-question-12','Conocernos mejor',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(72,'t-challenge-2','Aprende técnicas para mejorar tus habilidades sociales.',2,0,'2023-07-12 00:00:00','2023-10-27 14:57:18',0),(74,'t-freeanswer-mood','Get free answer',1,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(104,'','Aprende como llevar una higiene dental adecuada.',2,0,'2023-10-23 10:40:33','2023-10-27 14:28:12',0),(105,'','Tes que camiñar 20 minutos',3,0,'2023-10-23 11:39:06','2023-10-23 11:39:06',0),(106,'','sdfdsfds',3,0,'2023-10-23 11:39:49','2023-10-23 11:39:50',0),(112,'','Esta tarea consiste en responder a las preguntas que te planteamos a continuación.',1,0,'2023-10-25 17:36:50','2023-10-25 17:41:28',0),(113,'','<a href=\"https://docs.google.com/forms/d/e/1FAIpQLScw0cNUEodeLQQlyiEW_wXgY3tJAl13jzdYULZS7ZhytnEZqg/viewform\" class=\"btn btn-primary\" target=\"_blank\">Comenzar cuestionario</a>',3,0,'2023-10-25 17:54:26','2023-10-25 17:54:26',0),(114,'','En esta actividad guiada podrás hacer algunos ejercicios de movilidad articular.',4,0,'2023-10-27 14:23:25','2023-10-27 14:23:25',0),(115,'','En esta actividad te proponemos algunos ejercicios para activar tu cuerpo si pasas mucho tiempo sentado.',4,0,'2023-10-27 14:26:05','2023-10-27 14:26:37',0),(116,'','Este ejercicio te ayudará a recuperar tus piernas tras un largo día.',4,0,'2023-10-27 14:27:27','2023-10-27 14:27:27',0),(117,'','prueba',4,0,'2023-10-31 11:22:03','2023-10-31 11:22:03',0),(118,'','pruebas',3,0,'2023-11-03 08:47:16','2023-11-03 08:47:16',0);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_attribute`
--

DROP TABLE IF EXISTS `task_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_attribute` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attribute`
--

LOCK TABLES `task_attribute` WRITE;
/*!40000 ALTER TABLE `task_attribute` DISABLE KEYS */;
INSERT INTO `task_attribute` VALUES (1,'URL'),(3,'LONG_DESC'),(4,'VimeoVideo'),(5,'ImageUri');
/*!40000 ALTER TABLE `task_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_attribute_value`
--

DROP TABLE IF EXISTS `task_attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_attribute_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_task` bigint(20) DEFAULT NULL,
  `id_task_attribute` bigint(20) DEFAULT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_atributte_value_FK` (`id_task`),
  KEY `task_atributte_value_FK_1` (`id_task_attribute`),
  CONSTRAINT `task_atributte_value_FK` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `task_atributte_value_FK_1` FOREIGN KEY (`id_task_attribute`) REFERENCES `task_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attribute_value`
--

LOCK TABLES `task_attribute_value` WRITE;
/*!40000 ALTER TABLE `task_attribute_value` DISABLE KEYS */;
INSERT INTO `task_attribute_value` VALUES (20,59,3,'A continuación, vas a ver un vídeo corto sobre la psicosis. Se habla de los principales síntomas negativos y positivos. Presta atención porque después tendrás que contestar a unas preguntas. Puedes ver el vídeo todas las veces que necesites. '),(22,61,3,'En el reto de hoy, vas a entrenar una técnica de respiración que podrás utilizar en los momentos en los que necesites relajarte. Vas a aprender la técnica del cuadrado. Esta es realizar respiración contando 4 segundos en cada una de las 4 fases:Inhalar 4 s. Retener 4s. Expulsar 4s. Retener 4s'),(33,5,4,'https://player.vimeo.com/video/817607659?badge=0&amp;autopplay=1&amp;autopause=0&amp;player_id=0&amp;app_id=58479'),(34,59,4,'https://player.vimeo.com/video/817607659?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479'),(35,60,4,'https://player.vimeo.com/video/858966971?badge=0&autopause=0&player_id=0&app_id=58479'),(36,72,4,'https://player.vimeo.com/video/873235075?badge=0&autopause=0&quality_selector=1&progress_bar=1&player_id=0&app_id=58479'),(37,72,5,'https://backoffice.alume.org/assets/img/app/72.jpg'),(40,59,5,'https://backoffice.alume.org/assets/img/app/59.jpg'),(41,60,5,'https://backoffice.alume.org/assets/img/app/60.jpg'),(55,104,4,'https://player.vimeo.com/video/875124492?badge=0&autopause=0&quality_selector=1&progress_bar=1&player_id=0&app_id=58479'),(58,104,3,'En el siguiente vídeo te explicamos como debes mantener una correcta higiene dental'),(66,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(67,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(68,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(69,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(70,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(71,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(72,104,5,'https://backoffice.alume.org/assets/img/app/104.jpg'),(73,114,3,'En esta actividad guiada podrás hacer algunos ejercicios de movilidad articular que te ayudará a mantenerte en forma.'),(74,114,4,'https://player.vimeo.com/video/878631863?badge=0&amp;autopause=0&amp;quality_selector=1&amp;player_id=0&amp;app_id=58479'),(75,114,5,'https://backoffice.alume.org/assets/img/app/114.jpg'),(76,115,3,'En esta actividad te proponemos algunos ejercicios para activar tu cuerpo si pasas mucho tiempo sentado.'),(77,115,4,'https://player.vimeo.com/video/878631916?badge=0&autopause=0&quality_selector=1&player_id=0&app_id=58479'),(78,115,5,'https://backoffice.alume.org/assets/img/app/115.jpg'),(79,116,3,'Este ejercicio te ayudará a recuperar tus piernas tras un largo día.'),(80,116,4,'https://player.vimeo.com/video/878631944?badge=0&amp;autopause=0&amp;quality_selector=1&amp;player_id=0&amp;app_id=58479'),(81,116,5,'https://backoffice.alume.org/assets/img/app/116.jpg'),(82,72,3,'En este reto te proponemos una actividad que debes hacer por tu cuenta. Cuando cumplas la misión ');
/*!40000 ALTER TABLE `task_attribute_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_execution_status`
--

DROP TABLE IF EXISTS `task_execution_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_execution_status` (
  `id` bigint(20) NOT NULL,
  `code_name` varchar(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_execution_status`
--

LOCK TABLES `task_execution_status` WRITE;
/*!40000 ALTER TABLE `task_execution_status` DISABLE KEYS */;
INSERT INTO `task_execution_status` VALUES (1,'pending','Task is incomplete but not expired'),(2,'done','Task is completed on time'),(3,'expired','Task is incomplete and scheduled time has expired'),(4,'done-late','Task completed after the scheduled time has expired'),(5,'cancel','Task was cancelled by the profesional');
/*!40000 ALTER TABLE `task_execution_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_i18n`
--

DROP TABLE IF EXISTS `task_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_i18n` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_language` bigint(20) NOT NULL,
  `title_i18n` varchar(200) NOT NULL,
  `description_i18n` text DEFAULT NULL,
  `id_task` bigint(20) NOT NULL,
  `additional_info_i18n` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_i18n_FK` (`id_language`),
  KEY `task_i18n_FK_1` (`id_task`),
  CONSTRAINT `task_i18n_FK` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id`),
  CONSTRAINT `task_i18n_FK_1` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_i18n`
--

LOCK TABLES `task_i18n` WRITE;
/*!40000 ALTER TABLE `task_i18n` DISABLE KEYS */;
INSERT INTO `task_i18n` VALUES (6,1,'Responde al cuestionario','A continuación te vamos a solicitar que respondas a un conjunto de preguntas, para que podamos conocer mejor cómo te encuentras',7,NULL),(7,1,'Responde al cuestionario','A continuación te vamos a solicitar que respondas a un conjunto de preguntas, para que podamos conocer mejor cómo te encuentras',1,NULL),(8,1,'Es hora de sociabilizar','Aprende técnicas para mejorar tus habilidades sociales.',72,'En el siguiente vídeo te damos algunos consejos y te proponemos un reto para mejorar tus habilidades sociales.\n'),(60,1,'¿Qué es la esquizofrenia?','Vas a aprender algunos datos sobre la psicosis. ',59,'<div>A continuaci&oacute;n, vas a ver un v&iacute;deo corto sobre la esquizofrenia. Se habla de los principales s&iacute;ntomas negativos y positivos. Presta atenci&oacute;n porque despu&eacute;s tendr&aacute;s que contestar a unas preguntas.<br><br>Puedes ver el v&iacute;deo todas las veces que necesites. </strong> </div>\n<p><br></p>'),(61,1,'Estilo de vida saludable','En este reto, aprenderás algunos factores de protección para tener un estilo de vida más saludable',60,'<div>En el siguiente v&iacute;deo te vamos a nombrar los factores de protecci&oacute;n para tener un estilo de vida sana.&nbsp;<br><br>Presta atenci&oacute;n para poder responder a la pregunta que se plantee despu&eacute;s.&nbsp;<br><br>Puedes ver el v&iacute;deo varias veces sin problema.</div>\n<p><br></p>'),(73,1,'Cuéntanos algo más','¿Qué estabas haciendo para sentirte así?',74,''),(103,1,'Higiene dental','Aprende como llevar una higiene dental adecuada.',104,'En el siguiente vídeo te explicamos como debes mantener una correcta higiene dental'),(104,1,'Salir a camiñar','Tes que camiñar 20 minutos',105,''),(105,1,'ptruebadsafdsafds','sdfdsfds',106,''),(111,1,'Reliza el siguiente cuestionario','Esta tarea consiste en responder a las preguntas que te planteamos a continuación.',112,''),(112,1,'Realiza el siguiente cuestionario','<a href=\"https://docs.google.com/forms/d/e/1FAIpQLScw0cNUEodeLQQlyiEW_wXgY3tJAl13jzdYULZS7ZhytnEZqg/viewform\" class=\"btn btn-primary\" target=\"_blank\">Comenzar cuestionario</a>',113,''),(113,1,'Movilidad articular','En esta actividad guiada podrás hacer algunos ejercicios de movilidad articular.',114,'En esta actividad guiada podrás hacer algunos ejercicios de movilidad articular que te ayudará a mantenerte en forma.'),(114,1,'¿Pasas mucho tiempo sentado?','En esta actividad te proponemos algunos ejercicios para activar tu cuerpo si pasas mucho tiempo sentado.',115,'En esta actividad te proponemos algunos ejercicios para activar tu cuerpo si pasas mucho tiempo sentado.'),(115,1,'Estira las piernas','Este ejercicio te ayudará a recuperar tus piernas tras un largo día.',116,'Este ejercicio te ayudará a recuperar tus piernas tras un largo día.'),(116,1,'prueba','prueba',117,'prueba'),(117,1,'pruebas','pruebas',118,'');
/*!40000 ALTER TABLE `task_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_questionnaire`
--

DROP TABLE IF EXISTS `task_questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_questionnaire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_task` bigint(20) NOT NULL,
  `id_questionnaire` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_questionary_FK` (`id_task`),
  KEY `task_questionary_FK_1` (`id_questionnaire`),
  CONSTRAINT `task_questionary_FK` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `task_questionary_FK_1` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaire` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_questionnaire`
--

LOCK TABLES `task_questionnaire` WRITE;
/*!40000 ALTER TABLE `task_questionnaire` DISABLE KEYS */;
INSERT INTO `task_questionnaire` VALUES (1,1,1),(2,7,2),(18,59,3),(19,74,15),(22,112,28),(23,60,29),(24,72,30);
/*!40000 ALTER TABLE `task_questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_type`
--

DROP TABLE IF EXISTS `task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type`
--

LOCK TABLES `task_type` WRITE;
/*!40000 ALTER TABLE `task_type` DISABLE KEYS */;
INSERT INTO `task_type` VALUES (1,'tt-questionnaire','This type represents the fulfillment of a specific questionnaire'),(2,'tt-challenge','This type represents an activity proposed by the profesional to patient.'),(3,'tt-completion-check','To include actions like, have breakfast, medication, that need confirmation about their execution'),(4,'tt-guided-activity','All the suggestions to the patient where the professional teaches how to do the activity');
/*!40000 ALTER TABLE `task_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_type_attribute`
--

DROP TABLE IF EXISTS `task_type_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_type_attribute` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) DEFAULT NULL,
  `id_task_type` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_type_atributte_FK_1` (`id_task_type`),
  CONSTRAINT `task_type_atributte_FK_1` FOREIGN KEY (`id_task_type`) REFERENCES `task_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type_attribute`
--

LOCK TABLES `task_type_attribute` WRITE;
/*!40000 ALTER TABLE `task_type_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_type_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_type_attribute_value_i18n`
--

DROP TABLE IF EXISTS `task_type_attribute_value_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_type_attribute_value_i18n` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `value_i18n` varchar(300) NOT NULL,
  `attribute_id` bigint(20) NOT NULL,
  `language_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_type_atribute_value_i18n_FK` (`attribute_id`),
  KEY `task_type_atribute_value_i18n_FK_1` (`language_id`),
  CONSTRAINT `task_type_atribute_value_i18n_FK` FOREIGN KEY (`attribute_id`) REFERENCES `task_type_attribute` (`id`),
  CONSTRAINT `task_type_atribute_value_i18n_FK_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type_attribute_value_i18n`
--

LOCK TABLES `task_type_attribute_value_i18n` WRITE;
/*!40000 ALTER TABLE `task_type_attribute_value_i18n` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_type_attribute_value_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `working_group`
--

DROP TABLE IF EXISTS `working_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `working_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_group`
--

LOCK TABLES `working_group` WRITE;
/*!40000 ALTER TABLE `working_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `working_group_patient`
--

DROP TABLE IF EXISTS `working_group_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `working_group_patient` (
  `id` bigint(20) NOT NULL,
  `id_working_group` bigint(20) NOT NULL,
  `id_patient` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `working_group_patient_FK` (`id_patient`),
  KEY `working_group_patient_FK_1` (`id_working_group`),
  CONSTRAINT `working_group_patient_FK` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`),
  CONSTRAINT `working_group_patient_FK_1` FOREIGN KEY (`id_working_group`) REFERENCES `working_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_group_patient`
--

LOCK TABLES `working_group_patient` WRITE;
/*!40000 ALTER TABLE `working_group_patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_group_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `working_group_profesional`
--

DROP TABLE IF EXISTS `working_group_profesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `working_group_profesional` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_working_group` bigint(20) NOT NULL,
  `id_profesional` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `working_group_profesional_FK` (`id_profesional`),
  KEY `working_group_profesional_FK_1` (`id_working_group`),
  CONSTRAINT `working_group_profesional_FK` FOREIGN KEY (`id_profesional`) REFERENCES `profesional` (`id`),
  CONSTRAINT `working_group_profesional_FK_1` FOREIGN KEY (`id_working_group`) REFERENCES `working_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_group_profesional`
--

LOCK TABLES `working_group_profesional` WRITE;
/*!40000 ALTER TABLE `working_group_profesional` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_group_profesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'adiantebd'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-03 19:14:02
