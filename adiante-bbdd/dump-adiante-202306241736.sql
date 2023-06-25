-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: adiante
-- ------------------------------------------------------
-- Server version	5.5.5-10.9.3-MariaDB

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
  PRIMARY KEY (`id`),
  KEY `answer_FK` (`id_question`),
  CONSTRAINT `answer_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,1,1),(2,1,1),(3,1,1),(4,1,1),(5,1,1),(6,2,0),(7,2,0),(8,3,0),(9,3,0),(10,4,0),(11,4,0),(12,5,0),(13,5,0),(14,5,0),(15,5,0);
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
  `i18n_value` text COLLATE latin1_spanish_ci NOT NULL,
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
INSERT INTO `answer_i18n` VALUES (1,1,1,'Muy felíz'),(2,1,2,'Muy bien'),(3,1,3,'Indiferente'),(4,1,4,'Mal'),(5,1,5,'Muy mal'),(6,1,6,'Sí'),(7,1,7,'No'),(8,1,8,'Sí'),(9,1,9,'No'),(10,1,10,'Sí'),(11,1,11,'No'),(12,1,12,'Estoy desanimad@'),(13,1,13,'Estoy cansad@'),(14,1,14,'Estoy enfadad@ '),(15,1,15,'Estoy aburrid@');
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
  `code_name` varchar(4) COLLATE latin1_spanish_ci DEFAULT NULL,
  `culture` varchar(10) COLLATE latin1_spanish_ci DEFAULT NULL,
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
  `name` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `surname` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `address` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `password` text COLLATE latin1_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `aditional_info` text COLLATE latin1_spanish_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patient_un` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Miguel','Andrade','Rua Maior,n3 Salamanca','647222111','$2a$08$uUb99gbakUWKMj9ns9vw/erxM7q.2FvJ6u2c3bCAYKaQvQipujfNW','test2@mail.com',NULL,'2023-03-20 00:00:00','2023-03-20 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_activity_entry`
--

LOCK TABLES `patient_activity_entry` WRITE;
/*!40000 ALTER TABLE `patient_activity_entry` DISABLE KEYS */;
INSERT INTO `patient_activity_entry` VALUES (1,'2023-03-26 21:11:09',1,1),(19,'2023-03-27 07:16:42',1,1),(21,'2023-03-27 07:37:47',1,1),(22,'2023-03-27 07:42:30',1,1),(23,'2023-03-27 07:46:56',1,1),(24,'2023-03-27 08:54:28',1,1),(25,'2023-03-28 16:02:07',1,1),(26,'2023-03-28 16:10:03',1,1),(27,'2023-03-28 16:15:59',1,1),(28,'2023-04-14 17:14:59',1,1),(29,'2023-04-14 21:02:54',1,1),(30,'2023-04-21 16:42:44',1,1),(31,'2023-04-22 10:25:26',1,1),(32,'2023-04-22 10:25:26',1,1),(33,'2023-04-22 10:37:08',1,1),(34,'2023-04-22 10:47:53',1,1),(35,'2023-04-22 20:01:36',1,1),(36,'2023-04-22 22:36:57',1,1),(37,'2023-04-23 10:23:31',1,1),(38,'2023-04-23 11:18:36',1,1),(39,'2023-04-23 11:20:13',1,1),(40,'2023-04-23 11:21:58',1,1),(41,'2023-04-23 11:22:49',1,1),(42,'2023-04-23 11:30:22',1,1),(43,'2023-04-23 11:33:38',1,1),(44,'2023-04-23 11:35:30',1,1),(45,'2023-04-23 11:36:27',1,1),(46,'2023-04-23 11:41:15',1,1),(47,'2023-04-23 17:02:52',1,1),(48,'2023-04-24 21:17:12',1,1),(49,'2023-04-24 21:17:12',1,1),(50,'2023-04-24 21:17:12',1,1),(51,'2023-04-24 21:17:17',1,1),(52,'2023-04-24 21:17:20',1,1),(53,'2023-04-24 21:17:21',1,1),(54,'2023-04-24 21:17:23',1,1),(55,'2023-04-24 21:17:24',1,1),(56,'2023-04-24 21:17:32',1,1),(57,'2023-05-12 23:00:28',1,1),(58,'2023-06-12 18:12:31',1,1),(59,'2023-06-12 18:13:08',1,1),(60,'2023-06-12 18:15:06',1,1),(61,'2023-06-12 18:16:32',1,1),(62,'2023-06-12 18:18:07',1,1),(63,'2023-06-12 18:20:29',1,1),(64,'2023-06-12 18:20:43',1,1),(65,'2023-06-12 18:22:35',1,1),(66,'2023-06-12 22:24:10',1,1),(73,'2023-06-19 21:06:45',1,7),(74,'2023-06-19 23:14:43',1,3),(75,'2023-06-21 17:49:34',1,1),(76,'2023-06-21 18:43:15',1,1),(77,'2023-06-21 18:46:39',1,1),(78,'2023-06-21 18:56:26',1,1),(79,'2023-06-21 18:57:27',1,1),(80,'2023-06-23 18:07:45',1,1),(81,'2023-06-23 18:10:16',1,1),(82,'2023-06-23 18:10:28',1,1),(83,'2023-06-23 18:12:46',1,1),(84,'2023-06-23 18:13:04',1,1),(85,'2023-06-23 18:14:11',1,1),(86,'2023-06-23 18:16:01',1,1),(87,'2023-06-23 18:16:31',1,1),(88,'2023-06-23 18:18:55',1,1),(89,'2023-06-23 18:21:32',1,1),(90,'2023-06-23 18:21:38',1,1),(91,'2023-06-23 18:24:17',1,1),(92,'2023-06-23 18:24:40',1,1),(93,'2023-06-24 15:18:12',1,1);
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
  `value` text COLLATE latin1_spanish_ci NOT NULL,
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
  `catchup_comment` text COLLATE latin1_spanish_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_map`
--

LOCK TABLES `patient_program_map` WRITE;
/*!40000 ALTER TABLE `patient_program_map` DISABLE KEYS */;
INSERT INTO `patient_program_map` VALUES (1,1,1,'2023-05-17 10:23:55',NULL,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_scheduled_task`
--

LOCK TABLES `patient_scheduled_task` WRITE;
/*!40000 ALTER TABLE `patient_scheduled_task` DISABLE KEYS */;
INSERT INTO `patient_scheduled_task` VALUES (1,'2023-05-15 10:00:00','2023-05-15 12:00:00',1,NULL,1),(2,'2023-05-15 10:00:00','2023-05-15 10:00:00',6,NULL,1),(3,'2023-05-16 10:00:00','2023-05-16 11:00:00',6,NULL,1),(4,'2023-05-17 10:00:00','2023-05-17 13:00:00',6,NULL,1),(5,'2023-05-18 10:00:00','2023-05-18 13:00:00',6,NULL,1),(6,'2023-05-19 10:00:00','2023-05-19 13:00:00',6,NULL,1),(7,'2023-05-20 10:00:00','2023-05-20 13:00:00',6,NULL,1),(8,'2023-05-21 10:00:00','2023-05-21 13:00:00',6,NULL,1),(9,'2023-05-17 10:00:00','2023-05-17 13:00:00',7,NULL,1),(10,'2023-05-17 17:00:00','2023-05-17 18:00:00',2,NULL,1),(11,'2023-05-15 10:00:00','2023-05-15 12:00:00',3,NULL,1),(12,'2023-05-16 10:00:00','2023-05-16 11:00:00',3,NULL,1),(13,'2023-05-17 10:00:00','2023-05-17 13:00:00',3,NULL,1),(14,'2023-05-18 10:00:00','2023-05-18 13:00:00',3,NULL,1),(15,'2023-05-19 10:00:00','2023-05-19 13:00:00',3,NULL,1),(16,'2023-05-20 10:00:00','2023-05-20 13:00:00',3,NULL,1),(17,'2023-05-21 10:00:00','2023-05-21 13:00:00',3,NULL,1);
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
  `name` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `surname` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `email` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `password` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesional`
--

LOCK TABLES `profesional` WRITE;
/*!40000 ALTER TABLE `profesional` DISABLE KEYS */;
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `description` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
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
  `id_task` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  KEY `question_FK` (`id_questionnaire`),
  KEY `question_FK_2` (`id_question_type`),
  CONSTRAINT `question_FK` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaire` (`id`),
  CONSTRAINT `question_FK_2` FOREIGN KEY (`id_question_type`) REFERENCES `question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,1),(2,2,1),(3,2,1),(4,2,1),(5,2,3),(6,2,2);
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
  `i18n_value` text COLLATE latin1_spanish_ci NOT NULL,
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
INSERT INTO `question_i18n` VALUES (1,1,1,'¿Cómo te sientes ?'),(2,1,2,'¿Te sientes nervios@ o en tensión?'),(3,1,3,'¿Estás preocupad@ por algo?'),(4,1,4,'¿Has dormiado mal?'),(5,1,5,'¿Tienes alguno de estos síntomas?'),(6,1,6,'Cuentanos algo más ');
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `description` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `description` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `id_questionnaire_type` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionary_FK` (`id_questionnaire_type`),
  CONSTRAINT `questionary_FK` FOREIGN KEY (`id_questionnaire_type`) REFERENCES `questionnaire_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,'q-get-mood','Questionary to get patient mood selecting on single answer',1),(2,'q-anxiety-scale','Questions target to know the patient anxiety level',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution`
--

LOCK TABLES `questionnaire_execution` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution` DISABLE KEYS */;
INSERT INTO `questionnaire_execution` VALUES (11,1,19),(13,1,21),(14,1,22),(15,1,23),(16,1,24),(17,1,25),(18,1,26),(19,1,27),(20,1,28),(21,1,29),(22,1,30),(23,1,32),(24,1,31),(25,1,33),(26,1,34),(27,1,35),(28,1,36),(29,1,37),(30,1,38),(31,1,39),(32,1,40),(33,1,41),(34,1,42),(35,1,43),(36,1,44),(37,1,45),(38,1,46),(39,1,47),(40,1,50),(41,1,49),(42,1,48),(43,1,51),(44,1,52),(45,1,53),(46,1,54),(47,1,55),(48,1,56),(49,1,57),(50,1,58),(51,1,59),(52,1,60),(53,1,61),(54,1,62),(55,1,63),(56,1,64),(57,1,65),(58,1,66),(65,2,73),(66,1,75),(67,1,76),(68,1,77),(69,1,78),(70,1,79),(71,1,80),(72,1,81),(73,1,82),(74,1,83),(75,1,84),(76,1,85),(77,1,86),(78,1,87),(79,1,88),(80,1,89),(81,1,90),(82,1,91),(83,1,92),(84,1,93);
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
  `free_answer_value` text COLLATE latin1_spanish_ci DEFAULT NULL,
  `id_answer` bigint(20) DEFAULT NULL,
  `id_questionnaire_execution` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_answer_FK` (`id_question`),
  KEY `patient_answer_FK_1` (`id_answer`),
  KEY `patient_answer_FK_2` (`id_questionnaire_execution`),
  CONSTRAINT `patient_answer_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`),
  CONSTRAINT `patient_answer_FK_1` FOREIGN KEY (`id_answer`) REFERENCES `answer` (`id`),
  CONSTRAINT `patient_answer_FK_2` FOREIGN KEY (`id_questionnaire_execution`) REFERENCES `questionnaire_execution` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution_answer`
--

LOCK TABLES `questionnaire_execution_answer` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution_answer` DISABLE KEYS */;
INSERT INTO `questionnaire_execution_answer` VALUES (1,1,NULL,1,11),(2,1,NULL,1,13),(3,1,NULL,1,14),(4,1,NULL,1,15),(5,1,NULL,1,16),(6,1,NULL,1,17),(7,1,NULL,1,18),(8,1,NULL,1,19),(9,1,NULL,1,20),(10,1,NULL,1,21),(11,1,NULL,1,22),(12,1,NULL,1,24),(13,1,NULL,1,23),(14,1,NULL,1,25),(15,1,NULL,1,26),(16,1,NULL,1,27),(17,1,NULL,1,28),(18,1,NULL,1,29),(19,1,NULL,1,30),(20,1,NULL,1,31),(21,1,NULL,1,32),(22,1,NULL,1,33),(23,1,NULL,1,34),(24,1,NULL,1,35),(25,1,NULL,1,36),(26,1,NULL,1,37),(27,1,NULL,1,38),(28,1,NULL,1,39),(29,1,NULL,1,40),(30,1,NULL,1,42),(31,1,NULL,1,41),(32,1,NULL,1,43),(33,1,NULL,1,44),(34,1,NULL,1,45),(35,1,NULL,1,46),(36,1,NULL,1,47),(37,1,NULL,1,48),(38,1,NULL,1,49),(39,1,NULL,1,50),(40,1,NULL,1,51),(41,1,NULL,1,52),(42,1,NULL,1,53),(43,1,NULL,1,54),(44,1,NULL,1,55),(45,1,NULL,1,56),(46,1,NULL,1,57),(47,1,NULL,1,58),(55,2,NULL,7,65),(56,3,NULL,8,65),(57,4,NULL,10,65),(58,5,NULL,12,65),(59,5,NULL,13,65),(60,5,NULL,14,65),(61,6,'Respuesta libre del paciente',NULL,65),(62,1,NULL,1,66),(63,1,NULL,4,67),(64,1,NULL,4,68),(65,1,NULL,2,69),(66,1,NULL,4,70),(67,1,NULL,5,71),(68,1,NULL,5,72),(69,1,NULL,5,73),(70,1,NULL,5,74),(71,1,NULL,5,75),(72,1,NULL,5,76),(73,1,NULL,5,77),(74,1,NULL,5,78),(75,1,NULL,4,79),(76,1,NULL,5,80),(77,1,NULL,4,81),(78,1,NULL,5,82),(79,1,NULL,5,83),(80,1,NULL,5,84);
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `description` varchar(300) COLLATE latin1_spanish_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_answer_task`
--

LOCK TABLES `related_answer_task` WRITE;
/*!40000 ALTER TABLE `related_answer_task` DISABLE KEYS */;
INSERT INTO `related_answer_task` VALUES (1,4,2),(2,5,7);
/*!40000 ALTER TABLE `related_answer_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `description` text COLLATE latin1_spanish_ci DEFAULT NULL,
  `id_task_type` bigint(20) DEFAULT NULL,
  `free_execution` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `mandatory_feedback` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `task_FK` (`id_task_type`),
  CONSTRAINT `task_FK` FOREIGN KEY (`id_task_type`) REFERENCES `task_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'t-get-mood','This task gets patients mood thrugh a questionary',1,1,'2023-03-25 08:23:55','2023-03-25 08:23:55',1),(2,'t-doWorkout','Activity to tell patient to do workout',3,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(3,'t-breakfast','Suggest patient to take the breakfast',3,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(4,'t-challenge','Challenge',2,1,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(5,'t-yoga','Do yoga',4,1,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(6,'t-medication','Remainds patient to takin his medication',3,0,'2023-03-25 08:23:55','2023-03-25 08:23:55',0),(7,'t-cuestionnaire','Request patient to answer questionnaire',1,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0);
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attribute`
--

LOCK TABLES `task_attribute` WRITE;
/*!40000 ALTER TABLE `task_attribute` DISABLE KEYS */;
INSERT INTO `task_attribute` VALUES (1,'URL');
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
  `value` text COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_atributte_value_FK` (`id_task`),
  KEY `task_atributte_value_FK_1` (`id_task_attribute`),
  CONSTRAINT `task_atributte_value_FK` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `task_atributte_value_FK_1` FOREIGN KEY (`id_task_attribute`) REFERENCES `task_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attribute_value`
--

LOCK TABLES `task_attribute_value` WRITE;
/*!40000 ALTER TABLE `task_attribute_value` DISABLE KEYS */;
INSERT INTO `task_attribute_value` VALUES (1,6,1,'https://instagram.es');
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `description` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
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
  `title_i18n` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `description_i18n` text COLLATE latin1_spanish_ci DEFAULT NULL,
  `id_task` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_i18n_FK` (`id_language`),
  KEY `task_i18n_FK_1` (`id_task`),
  CONSTRAINT `task_i18n_FK` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id`),
  CONSTRAINT `task_i18n_FK_1` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_i18n`
--

LOCK TABLES `task_i18n` WRITE;
/*!40000 ALTER TABLE `task_i18n` DISABLE KEYS */;
INSERT INTO `task_i18n` VALUES (1,1,'Haz este ejercicio','Camina 5km a buen ritmo. Tú puedes!',2),(2,1,'Toma el desayuno','Es la hora del desayuno. Toma tu ración de cereales y de fruta para empezar el día con energía',3),(3,1,'Sube un comentario a tu red social preferida','Comparte con tus amig@s una foto de un lugar por donde te guste pasear',4),(4,1,'Practica esta técnica de relajación: Yoga','Vamos a tratar ayudarte a relajarte, a través de la práctica de yoga.  A continuación te explicamos paso a paso como empezar con ello',5),(5,1,'Toma tu medicación','Es la hora de tomar tu medicación, asegúrate que sigues la pauta que te ha recomendado tú médico',6),(6,1,'Responde al cuestionario','A continuación te vamos a solicitar que respondas a un conjunto de preguntas, para que podamos conocer mejor cómo te encuentras',7),(7,1,'Responde al cuestionario','A continuación te vamos a solicitar que respondas a un conjunto de preguntas, para que podamos conocer mejor cómo te encuentras',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_questionnaire`
--

LOCK TABLES `task_questionnaire` WRITE;
/*!40000 ALTER TABLE `task_questionnaire` DISABLE KEYS */;
INSERT INTO `task_questionnaire` VALUES (1,1,1),(2,7,2);
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `description` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type`
--

LOCK TABLES `task_type` WRITE;
/*!40000 ALTER TABLE `task_type` DISABLE KEYS */;
INSERT INTO `task_type` VALUES (1,'tt-questionnaire','This type represents the fulfillment of a specific questionnaire'),(2,'tt-challenge','This type represents an activity proposed by the profesional to patient.'),(3,'tt-scheduled-activy','To include actions like, have breakfast, meet with the alume professionals'),(4,'tt-guided-activity','All the suggestions to the patient where the professional teaches how to do the activity');
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
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
  `value_i18n` varchar(300) COLLATE latin1_spanish_ci NOT NULL,
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
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
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
-- Dumping routines for database 'adiante'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-24 17:36:56
