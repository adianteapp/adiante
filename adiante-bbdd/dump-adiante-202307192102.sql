-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: adiante-dev
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
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_FK` (`id_question`),
  CONSTRAINT `answer_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,2,0,NULL),(7,2,0,NULL),(8,3,0,NULL),(9,3,0,NULL),(10,4,0,NULL),(11,4,0,NULL),(12,5,0,NULL),(13,5,0,NULL),(14,5,0,NULL),(15,5,0,NULL),(16,7,0,NULL),(17,7,0,NULL),(18,7,0,NULL),(19,7,0,NULL),(20,8,0,NULL),(21,8,0,NULL),(22,8,0,NULL),(23,8,0,NULL),(24,11,0,NULL),(25,11,0,NULL),(26,11,0,NULL),(27,11,0,NULL),(28,15,0,NULL),(29,15,0,NULL),(30,15,0,NULL);
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
INSERT INTO `answer_i18n` VALUES (1,1,1,'Muy felíz'),(2,1,2,'Muy bien'),(3,1,3,'Indiferente'),(4,1,4,'Mal'),(5,1,5,'Muy mal'),(6,1,6,'Sí'),(7,1,7,'No'),(8,1,8,'Sí'),(9,1,9,'No'),(10,1,10,'Sí'),(11,1,11,'No'),(12,1,12,'Estoy desanimad@'),(13,1,13,'Estoy cansad@'),(14,1,14,'Estoy enfadad@ '),(15,1,15,'Estoy aburrid@'),(16,1,16,'Apatía'),(17,1,17,'Aislamiento social'),(18,1,18,'Delirios'),(19,1,19,'Abulia'),(20,1,20,'Hacer 5 comidas al día.'),(21,1,21,'Relacionarse con la familia'),(22,1,22,'Practicar deporte'),(23,1,23,'Picotear '),(24,1,24,'Debemos aceptar solo las emociones buenas.'),(25,1,25,'Debemos juzgar las emociones si son malas. '),(26,1,26,'Debemos resolver siempre todas las situaciones.'),(27,1,27,'Todas las emociones son válidas. '),(28,1,28,'La agitación, ritmo cardíaco alto y la respiración acelerada son síntomas de ansiedad. '),(29,1,29,'Consumir alcohol reduce la ansiedad.'),(30,1,30,'c)	Cuando se sufre ansiedad se tiene trastornos del sueño y de alimentación. ');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_activity_entry`
--

LOCK TABLES `patient_activity_entry` WRITE;
/*!40000 ALTER TABLE `patient_activity_entry` DISABLE KEYS */;
INSERT INTO `patient_activity_entry` VALUES (1,'2023-03-26 21:11:09',1,1),(19,'2023-03-27 07:16:42',1,1),(21,'2023-03-27 07:37:47',1,1),(22,'2023-03-27 07:42:30',1,1),(23,'2023-03-27 07:46:56',1,1),(24,'2023-03-27 08:54:28',1,1),(25,'2023-03-28 16:02:07',1,1),(26,'2023-03-28 16:10:03',1,1),(27,'2023-03-28 16:15:59',1,1),(28,'2023-04-14 17:14:59',1,1),(29,'2023-04-14 21:02:54',1,1),(30,'2023-04-21 16:42:44',1,1),(31,'2023-04-22 10:25:26',1,1),(32,'2023-04-22 10:25:26',1,1),(33,'2023-04-22 10:37:08',1,1),(34,'2023-04-22 10:47:53',1,1),(35,'2023-04-22 20:01:36',1,1),(36,'2023-04-22 22:36:57',1,1),(37,'2023-04-23 10:23:31',1,1),(38,'2023-04-23 11:18:36',1,1),(39,'2023-04-23 11:20:13',1,1),(40,'2023-04-23 11:21:58',1,1),(41,'2023-04-23 11:22:49',1,1),(42,'2023-04-23 11:30:22',1,1),(43,'2023-04-23 11:33:38',1,1),(44,'2023-04-23 11:35:30',1,1),(45,'2023-04-23 11:36:27',1,1),(46,'2023-04-23 11:41:15',1,1),(47,'2023-04-23 17:02:52',1,1),(48,'2023-04-24 21:17:12',1,1),(49,'2023-04-24 21:17:12',1,1),(50,'2023-04-24 21:17:12',1,1),(51,'2023-04-24 21:17:17',1,1),(52,'2023-04-24 21:17:20',1,1),(53,'2023-04-24 21:17:21',1,1),(54,'2023-04-24 21:17:23',1,1),(55,'2023-04-24 21:17:24',1,1),(56,'2023-04-24 21:17:32',1,1),(57,'2023-05-12 23:00:28',1,1),(58,'2023-06-12 18:12:31',1,1),(59,'2023-06-12 18:13:08',1,1),(60,'2023-06-12 18:15:06',1,1),(61,'2023-06-12 18:16:32',1,1),(62,'2023-06-12 18:18:07',1,1),(63,'2023-06-12 18:20:29',1,1),(64,'2023-06-12 18:20:43',1,1),(65,'2023-06-12 18:22:35',1,1),(66,'2023-06-12 22:24:10',1,1),(73,'2023-06-19 21:06:45',1,7),(74,'2023-06-19 23:14:43',1,3),(75,'2023-06-21 17:49:34',1,1),(76,'2023-06-21 18:43:15',1,1),(77,'2023-06-21 18:46:39',1,1),(78,'2023-06-21 18:56:26',1,1),(79,'2023-06-21 18:57:27',1,1),(80,'2023-06-23 18:07:45',1,1),(81,'2023-06-23 18:10:16',1,1),(82,'2023-06-23 18:10:28',1,1),(83,'2023-06-23 18:12:46',1,1),(84,'2023-06-23 18:13:04',1,1),(85,'2023-06-23 18:14:11',1,1),(86,'2023-06-23 18:16:01',1,1),(87,'2023-06-23 18:16:31',1,1),(88,'2023-06-23 18:18:55',1,1),(89,'2023-06-23 18:21:32',1,1),(90,'2023-06-23 18:21:38',1,1),(91,'2023-06-23 18:24:17',1,1),(92,'2023-06-23 18:24:40',1,1),(93,'2023-06-24 15:18:12',1,1),(94,'2023-06-25 11:10:40',1,1),(95,'2023-06-25 11:11:11',1,1),(96,'2023-06-25 11:45:57',1,1),(97,'2023-06-25 11:46:16',1,1),(98,'2023-06-25 11:46:28',1,1),(99,'2023-06-25 11:48:53',1,1),(100,'2023-06-25 11:48:55',1,1),(101,'2023-06-25 11:48:56',1,1),(102,'2023-06-25 11:49:54',1,1),(103,'2023-06-25 11:55:09',1,1),(104,'2023-06-25 11:58:13',1,1),(105,'2023-06-25 11:59:05',1,1),(106,'2023-06-25 11:59:25',1,1),(107,'2023-06-25 11:59:45',1,1),(108,'2023-06-25 12:01:40',1,1),(109,'2023-06-25 12:04:17',1,1),(110,'2023-06-25 12:04:23',1,1),(111,'2023-06-25 12:04:32',1,1),(112,'2023-06-25 12:05:19',1,1),(113,'2023-06-25 12:08:30',1,1),(114,'2023-06-25 12:09:23',1,1),(115,'2023-06-25 12:11:22',1,1),(116,'2023-06-25 12:12:01',1,1),(117,'2023-06-25 12:12:24',1,1),(118,'2023-06-25 12:12:42',1,1),(119,'2023-06-25 15:42:13',1,1),(120,'2023-06-25 15:43:11',1,1),(121,'2023-06-25 15:48:56',1,1),(122,'2023-06-25 15:58:33',1,1),(123,'2023-06-25 15:58:47',1,1),(124,'2023-06-25 15:59:04',1,1),(125,'2023-06-25 16:00:27',1,1),(126,'2023-06-25 16:00:54',1,1),(127,'2023-06-25 16:06:11',1,1),(128,'2023-06-25 16:08:03',1,1),(129,'2023-06-25 16:13:39',1,1),(130,'2023-06-25 16:15:02',1,1),(131,'2023-06-25 16:36:52',1,1),(132,'2023-06-25 17:03:34',1,1),(133,'2023-06-25 17:32:45',1,1),(134,'2023-06-25 17:36:36',1,1),(135,'2023-06-25 17:43:52',1,1),(136,'2023-06-25 17:47:24',1,1),(137,'2023-06-25 17:56:45',1,1),(138,'2023-06-25 17:57:55',1,1),(139,'2023-06-25 18:08:53',1,1),(140,'2023-06-25 18:17:02',1,1),(141,'2023-06-25 18:17:43',1,1),(142,'2023-06-25 18:32:49',1,1),(143,'2023-06-25 18:34:49',1,1),(144,'2023-06-25 18:37:54',1,1),(145,'2023-06-25 18:42:46',1,1),(146,'2023-06-25 18:44:32',1,1),(147,'2023-06-25 19:19:47',1,1),(148,'2023-06-25 19:25:35',1,1),(149,'2023-06-25 19:31:41',1,1),(150,'2023-06-25 19:32:00',1,7),(151,'2023-06-25 19:32:00',1,7),(152,'2023-06-25 19:32:56',1,7),(153,'2023-06-25 19:33:23',1,7),(154,'2023-06-25 19:37:39',1,1),(155,'2023-06-25 19:38:16',1,7),(156,'2023-06-25 19:42:06',1,1),(157,'2023-06-25 19:42:19',1,7),(158,'2023-06-25 19:44:16',1,1),(159,'2023-06-25 19:45:12',1,1),(160,'2023-06-25 19:45:48',1,1),(161,'2023-06-25 19:46:24',1,7),(162,'2023-06-25 19:47:20',1,1),(163,'2023-06-25 19:47:51',1,7),(164,'2023-07-02 11:47:51',1,6),(165,'2023-07-04 16:59:43',1,1),(166,'2023-07-05 18:54:21',1,3),(167,'2023-07-05 18:54:21',1,3),(169,'2023-07-05 18:57:51',1,3),(170,'2023-07-05 19:23:30',1,3),(171,'2023-07-06 15:41:12',1,6),(172,'2023-07-06 15:41:54',1,2),(173,'2023-07-06 15:42:47',1,1),(174,'2023-07-06 15:43:03',1,7),(175,'2023-07-06 16:51:40',1,6),(176,'2023-07-06 18:19:42',1,1),(177,'2023-07-06 18:20:00',1,7),(178,'2023-07-06 18:22:17',1,1),(179,'2023-07-06 18:27:35',1,1),(180,'2023-07-06 18:27:41',1,1),(181,'2023-07-06 18:27:53',1,7),(182,'2023-07-06 18:28:03',1,6),(183,'2023-07-06 18:30:26',1,1),(184,'2023-07-06 18:30:31',1,1),(185,'2023-07-06 18:30:44',1,1),(186,'2023-07-06 18:31:09',1,7),(187,'2023-07-06 18:31:31',1,3),(188,'2023-07-11 10:53:26',1,1),(189,'2023-07-11 10:53:28',1,1),(190,'2023-07-11 10:53:30',1,1),(191,'2023-07-11 10:53:37',1,7),(192,'2023-07-12 10:37:13',1,37),(193,'2023-07-12 10:37:37',1,1),(194,'2023-07-12 10:37:43',1,1),(195,'2023-07-12 10:37:46',1,1),(196,'2023-07-12 10:37:59',1,7),(197,'2023-07-12 10:46:37',1,1),(198,'2023-07-12 10:46:39',1,1),(199,'2023-07-12 11:16:32',1,1),(200,'2023-07-12 11:16:35',1,1),(201,'2023-07-12 11:16:37',1,1),(202,'2023-07-12 11:18:43',1,1),(203,'2023-07-19 18:21:54',1,1),(204,'2023-07-19 18:22:27',1,7),(205,'2023-07-19 18:25:33',1,1),(206,'2023-07-19 18:25:38',1,1),(207,'2023-07-19 18:31:43',1,1),(208,'2023-07-19 18:31:48',1,1),(209,'2023-07-19 18:32:14',1,7),(210,'2023-07-19 18:40:25',1,1),(211,'2023-07-19 18:40:31',1,1),(212,'2023-07-19 18:41:01',1,7),(213,'2023-07-19 18:41:07',1,1),(214,'2023-07-19 18:41:57',1,2),(215,'2023-07-19 18:48:09',1,67),(216,'2023-07-19 18:48:22',1,6),(217,'2023-07-19 18:50:02',1,6);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_scheduled_task`
--

LOCK TABLES `patient_scheduled_task` WRITE;
/*!40000 ALTER TABLE `patient_scheduled_task` DISABLE KEYS */;
INSERT INTO `patient_scheduled_task` VALUES (1,'2023-07-13 10:00:00','2023-07-13 12:00:00',1,NULL,1),(2,'2023-07-13 10:00:00','2023-07-13 10:00:00',6,NULL,1),(3,'2023-07-14 10:00:00','2023-07-14 11:00:00',6,NULL,1),(4,'2023-07-14 10:00:00','2023-07-14 13:00:00',6,NULL,1),(5,'2023-07-15 10:00:00','2023-07-15 13:00:00',6,NULL,1),(6,'2023-07-16 10:00:00','2023-07-16 13:00:00',6,NULL,1),(7,'2023-07-17 10:00:00','2023-07-17 13:00:00',2,NULL,1),(8,'2023-07-17 10:00:00','2023-07-17 22:00:00',6,217,1),(9,'2023-07-15 10:00:00','2023-07-15 13:00:00',7,NULL,1),(10,'2023-07-15 17:00:00','2023-07-15 18:00:00',2,NULL,1),(11,'2023-07-13 10:00:00','2023-07-13 12:00:00',3,NULL,1),(12,'2023-07-14 10:00:00','2023-07-14 11:00:00',3,NULL,1),(13,'2023-07-10 10:00:00','2023-07-10 13:00:00',3,NULL,1),(14,'2023-07-10 10:00:00','2023-07-10 13:00:00',3,NULL,1),(17,'2023-07-09 10:00:00','2023-07-09 21:00:00',3,NULL,1),(18,'2023-07-12 10:00:00','2023-07-12 21:00:00',37,NULL,1);
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
  `order` int(11) DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_FK` (`id_questionnaire`),
  KEY `question_FK_2` (`id_question_type`),
  CONSTRAINT `question_FK` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaire` (`id`),
  CONSTRAINT `question_FK_2` FOREIGN KEY (`id_question_type`) REFERENCES `question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,1,NULL,NULL),(2,2,1,NULL,NULL),(3,2,1,NULL,NULL),(4,2,1,NULL,NULL),(5,2,3,NULL,NULL),(6,2,2,NULL,NULL),(7,3,1,NULL,NULL),(8,4,1,NULL,NULL),(9,5,2,NULL,NULL),(10,6,2,NULL,NULL),(11,7,1,NULL,NULL),(12,8,2,NULL,NULL),(13,9,2,NULL,NULL),(14,10,2,NULL,NULL),(15,11,2,NULL,NULL),(16,12,2,NULL,NULL),(17,13,2,NULL,NULL),(18,14,2,NULL,NULL);
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
INSERT INTO `question_i18n` VALUES (1,1,1,'¿Cómo te sientes ?'),(2,1,2,'¿Te sientes nervios@ o en tensión?'),(3,1,3,'¿Estás preocupad@ por algo?'),(4,1,4,'¿Has dormiado mal?'),(5,1,5,'¿Tienes alguno de estos síntomas?'),(6,1,6,'Cuentanos algo más '),(7,1,7,'¿cuál de los siguientes síntomas es positivo?'),(8,1,8,'¿cuál de los siguientes no es un hábito saludable? '),(9,1,9,'Escribe cómo te sientes ahora que has aprendido esta técnica de respiración. '),(10,1,10,'A continuación, debes escribir una lista con todas las emociones que conoces. '),(11,1,11,'¿cuál de las siguientes afirmaciones es verdadera?'),(12,1,12,'Escribe un resumen de la película aquí'),(13,1,13,'Escribe un comentario acerca de la dificultad de la actividad anterior. '),(14,1,14,'Escribe un comentario relacionado con el texto que has leído. '),(15,1,15,'Marca la opción falsa'),(16,1,16,'. Debes escribir por lo menos 10, ¡cuántas más mejor!'),(17,1,17,'Pega aqui los enlaces.'),(18,1,18,'Escribe cómo te sientes ahora que conoces mejor a tu educador/a.');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,'q-get-mood','Questionary to get patient mood selecting on single answer',1),(2,'q-anxiety-scale','Questions target to know the patient anxiety level',2),(3,'q-reto','¿QUÉ ES LA ESQUIZOFRENIA?',2),(4,'q-reto-1','Estilo de vida saludable',2),(5,'q-reto-2','Tecnica de respiración',2),(6,'q-reto-3','Lista de  emociones ',2),(7,'q-reto-4','Gestionar  emociones ',2),(8,'q-reto-5','Ver una película',2),(9,'q-reto-6','Juego de atención: buscando a Wally',2),(10,'q-reto-7','Lee y ordena el texto',2),(11,'q-reto-8','Síntomas de ansiedad',2),(12,'q-reto-9','Mejorar nuestra autoestima',2),(13,'q-reto-10','Busqueda por internet',2),(14,'q-reto-11','Conocernos mejor',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution`
--

LOCK TABLES `questionnaire_execution` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution` DISABLE KEYS */;
INSERT INTO `questionnaire_execution` VALUES (11,1,19),(13,1,21),(14,1,22),(15,1,23),(16,1,24),(17,1,25),(18,1,26),(19,1,27),(20,1,28),(21,1,29),(22,1,30),(23,1,32),(24,1,31),(25,1,33),(26,1,34),(27,1,35),(28,1,36),(29,1,37),(30,1,38),(31,1,39),(32,1,40),(33,1,41),(34,1,42),(35,1,43),(36,1,44),(37,1,45),(38,1,46),(39,1,47),(40,1,50),(41,1,49),(42,1,48),(43,1,51),(44,1,52),(45,1,53),(46,1,54),(47,1,55),(48,1,56),(49,1,57),(50,1,58),(51,1,59),(52,1,60),(53,1,61),(54,1,62),(55,1,63),(56,1,64),(57,1,65),(58,1,66),(65,2,73),(66,1,75),(67,1,76),(68,1,77),(69,1,78),(70,1,79),(71,1,80),(72,1,81),(73,1,82),(74,1,83),(75,1,84),(76,1,85),(77,1,86),(78,1,87),(79,1,88),(80,1,89),(81,1,90),(82,1,91),(83,1,92),(84,1,93),(85,1,94),(86,1,95),(87,1,96),(88,1,97),(89,1,98),(90,1,99),(91,1,100),(92,1,101),(93,1,102),(94,1,103),(95,1,104),(96,1,105),(97,1,106),(98,1,107),(99,1,108),(100,1,109),(101,1,110),(102,1,111),(103,1,112),(104,1,113),(105,1,114),(106,1,115),(107,1,116),(108,1,117),(109,1,118),(110,1,119),(111,1,120),(112,1,121),(113,1,122),(114,1,123),(115,1,124),(116,1,125),(117,1,126),(118,1,127),(119,1,128),(120,1,129),(121,1,130),(122,1,131),(123,1,132),(124,1,133),(125,1,134),(126,1,135),(127,1,136),(128,1,137),(129,1,138),(130,1,139),(131,1,140),(132,1,141),(133,1,142),(134,1,143),(135,1,144),(136,1,145),(137,1,146),(138,1,147),(139,1,148),(140,1,149),(141,2,150),(142,2,151),(143,2,152),(144,2,153),(145,1,154),(146,2,155),(147,1,156),(148,2,157),(149,1,158),(150,1,159),(151,1,160),(152,2,161),(153,1,162),(154,2,163),(155,1,165),(156,1,173),(157,2,174),(158,1,176),(159,2,177),(160,1,178),(161,1,179),(162,1,180),(163,2,181),(164,1,183),(165,1,184),(166,1,185),(167,2,186),(168,1,188),(169,1,189),(170,1,190),(171,2,191),(172,1,193),(173,1,194),(174,1,195),(175,2,196),(176,1,197),(177,1,198),(178,1,199),(179,1,200),(180,1,201),(181,1,202),(182,1,203),(183,2,204),(184,1,205),(185,1,206),(186,1,207),(187,1,208),(188,2,209),(189,1,210),(190,1,211),(191,2,212),(192,1,213),(193,2,215);
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
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution_answer`
--

LOCK TABLES `questionnaire_execution_answer` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution_answer` DISABLE KEYS */;
INSERT INTO `questionnaire_execution_answer` VALUES (1,1,NULL,1,11),(2,1,NULL,1,13),(3,1,NULL,1,14),(4,1,NULL,1,15),(5,1,NULL,1,16),(6,1,NULL,1,17),(7,1,NULL,1,18),(8,1,NULL,1,19),(9,1,NULL,1,20),(10,1,NULL,1,21),(11,1,NULL,1,22),(12,1,NULL,1,24),(13,1,NULL,1,23),(14,1,NULL,1,25),(15,1,NULL,1,26),(16,1,NULL,1,27),(17,1,NULL,1,28),(18,1,NULL,1,29),(19,1,NULL,1,30),(20,1,NULL,1,31),(21,1,NULL,1,32),(22,1,NULL,1,33),(23,1,NULL,1,34),(24,1,NULL,1,35),(25,1,NULL,1,36),(26,1,NULL,1,37),(27,1,NULL,1,38),(28,1,NULL,1,39),(29,1,NULL,1,40),(30,1,NULL,1,42),(31,1,NULL,1,41),(32,1,NULL,1,43),(33,1,NULL,1,44),(34,1,NULL,1,45),(35,1,NULL,1,46),(36,1,NULL,1,47),(37,1,NULL,1,48),(38,1,NULL,1,49),(39,1,NULL,1,50),(40,1,NULL,1,51),(41,1,NULL,1,52),(42,1,NULL,1,53),(43,1,NULL,1,54),(44,1,NULL,1,55),(45,1,NULL,1,56),(46,1,NULL,1,57),(47,1,NULL,1,58),(55,2,NULL,7,65),(56,3,NULL,8,65),(57,4,NULL,10,65),(58,5,NULL,12,65),(59,5,NULL,13,65),(60,5,NULL,14,65),(61,6,'Respuesta libre del paciente',NULL,65),(62,1,NULL,1,66),(63,1,NULL,4,67),(64,1,NULL,4,68),(65,1,NULL,2,69),(66,1,NULL,4,70),(67,1,NULL,5,71),(68,1,NULL,5,72),(69,1,NULL,5,73),(70,1,NULL,5,74),(71,1,NULL,5,75),(72,1,NULL,5,76),(73,1,NULL,5,77),(74,1,NULL,5,78),(75,1,NULL,4,79),(76,1,NULL,5,80),(77,1,NULL,4,81),(78,1,NULL,5,82),(79,1,NULL,5,83),(80,1,NULL,5,84),(81,1,NULL,5,85),(82,1,NULL,5,86),(83,1,NULL,5,87),(84,1,NULL,5,88),(85,1,NULL,5,89),(86,1,NULL,5,90),(87,1,NULL,5,91),(88,1,NULL,4,92),(89,1,NULL,4,93),(90,1,NULL,5,94),(91,1,NULL,5,95),(92,1,NULL,5,96),(93,1,NULL,5,97),(94,1,NULL,5,98),(95,1,NULL,5,99),(96,1,NULL,5,100),(97,1,NULL,5,101),(98,1,NULL,4,102),(99,1,NULL,5,103),(100,1,NULL,5,104),(101,1,NULL,5,105),(102,1,NULL,5,106),(103,1,NULL,5,107),(104,1,NULL,5,108),(105,1,NULL,5,109),(106,1,NULL,5,110),(107,1,NULL,5,111),(108,1,NULL,5,112),(109,1,NULL,5,113),(110,1,NULL,5,114),(111,1,NULL,5,115),(112,1,NULL,5,116),(113,1,NULL,5,117),(114,1,NULL,5,118),(115,1,NULL,5,119),(116,1,NULL,5,120),(117,1,NULL,5,121),(118,1,NULL,5,122),(119,1,NULL,5,123),(120,1,NULL,5,124),(121,1,NULL,5,125),(122,1,NULL,5,126),(123,1,NULL,5,127),(124,1,NULL,5,128),(125,1,NULL,5,129),(126,1,NULL,5,130),(127,1,NULL,5,131),(128,1,NULL,5,132),(129,1,NULL,5,133),(130,1,NULL,5,134),(131,1,NULL,5,135),(132,1,NULL,5,136),(133,1,NULL,5,137),(134,1,NULL,5,138),(135,1,NULL,5,139),(136,1,NULL,5,140),(137,2,NULL,6,141),(138,3,NULL,9,141),(139,4,NULL,10,141),(140,6,NULL,NULL,141),(141,5,NULL,12,141),(142,5,NULL,13,141),(143,5,NULL,14,141),(144,2,NULL,6,142),(145,3,NULL,9,142),(146,4,NULL,10,142),(147,6,NULL,NULL,142),(148,5,NULL,12,142),(149,5,NULL,13,142),(150,5,NULL,14,142),(151,2,NULL,6,143),(152,3,NULL,9,143),(153,4,NULL,10,143),(154,6,NULL,NULL,143),(155,5,NULL,12,143),(156,5,NULL,13,143),(157,5,NULL,14,143),(158,2,NULL,6,144),(159,3,NULL,9,144),(160,4,NULL,10,144),(161,6,NULL,NULL,144),(162,5,NULL,12,144),(163,5,NULL,13,144),(164,5,NULL,14,144),(165,1,NULL,5,145),(166,2,NULL,6,146),(167,3,NULL,8,146),(168,4,NULL,10,146),(169,6,NULL,NULL,146),(170,5,NULL,12,146),(171,5,NULL,13,146),(172,1,NULL,5,147),(173,2,NULL,6,148),(174,3,NULL,9,148),(175,4,NULL,10,148),(176,6,NULL,NULL,148),(177,5,NULL,13,148),(178,1,NULL,2,149),(179,1,NULL,5,150),(180,1,NULL,5,151),(181,2,NULL,6,152),(182,3,NULL,8,152),(183,4,NULL,10,152),(184,6,NULL,NULL,152),(185,5,NULL,12,152),(186,5,NULL,13,152),(187,1,NULL,5,153),(188,2,NULL,6,154),(189,3,NULL,8,154),(190,4,NULL,10,154),(191,6,NULL,NULL,154),(192,5,NULL,12,154),(193,5,NULL,14,154),(194,1,NULL,5,155),(195,1,NULL,5,156),(196,2,NULL,6,157),(197,3,NULL,8,157),(198,4,NULL,10,157),(199,6,NULL,NULL,157),(200,5,NULL,12,157),(201,5,NULL,13,157),(202,1,NULL,5,158),(203,2,NULL,6,159),(204,3,NULL,9,159),(205,4,NULL,10,159),(206,6,NULL,NULL,159),(207,5,NULL,12,159),(208,1,NULL,3,160),(209,1,NULL,2,161),(210,1,NULL,5,162),(211,2,NULL,6,163),(212,3,NULL,8,163),(213,4,NULL,10,163),(214,6,NULL,NULL,163),(215,5,NULL,12,163),(216,5,NULL,13,163),(217,1,NULL,3,164),(218,1,NULL,4,165),(219,1,NULL,5,166),(220,2,NULL,6,167),(221,3,NULL,8,167),(222,4,NULL,10,167),(223,6,NULL,NULL,167),(224,5,NULL,12,167),(225,5,NULL,13,167),(226,1,NULL,1,168),(227,1,NULL,2,169),(228,1,NULL,5,170),(229,2,NULL,7,171),(230,3,NULL,9,171),(231,4,NULL,11,171),(232,5,NULL,13,171),(233,6,NULL,NULL,171),(234,1,NULL,4,172),(235,1,NULL,1,173),(236,1,NULL,5,174),(237,2,NULL,7,175),(238,3,NULL,9,175),(239,4,NULL,11,175),(240,5,NULL,15,175),(241,6,NULL,NULL,175),(242,1,NULL,1,176),(243,1,NULL,2,177),(244,1,NULL,4,178),(245,1,NULL,1,179),(246,1,NULL,1,180),(247,1,NULL,3,181),(248,1,NULL,5,182),(249,5,NULL,14,183),(250,4,NULL,11,183),(251,3,NULL,9,183),(252,2,NULL,7,183),(253,6,NULL,NULL,183),(254,1,NULL,1,184),(255,1,NULL,1,185),(256,1,NULL,1,186),(257,1,NULL,5,187),(258,5,NULL,15,188),(259,4,NULL,11,188),(260,3,NULL,9,188),(261,2,NULL,7,188),(262,6,NULL,NULL,188),(263,1,NULL,1,189),(264,1,NULL,5,190),(265,5,NULL,15,191),(266,4,NULL,10,191),(267,3,NULL,8,191),(268,2,NULL,6,191),(269,6,NULL,NULL,191),(270,1,NULL,1,192),(271,5,NULL,15,193),(272,4,NULL,10,193),(273,3,NULL,9,193),(274,2,NULL,7,193),(275,6,NULL,NULL,193);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_answer_task`
--

LOCK TABLES `related_answer_task` WRITE;
/*!40000 ALTER TABLE `related_answer_task` DISABLE KEYS */;
INSERT INTO `related_answer_task` VALUES (1,4,2),(2,5,7),(3,18,59),(4,20,60),(5,26,63),(6,29,67);
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'t-get-mood','This task gets patients mood thrugh a questionary',1,1,'2023-03-25 08:23:55','2023-03-25 08:23:55',1),(2,'t-doWorkout','Activity to tell patient to do workout',3,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(3,'t-breakfast','Suggest patient to take the breakfast',3,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(4,'t-challenge','Challenge',2,1,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(5,'t-yoga','Do yoga',4,1,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(6,'t-medication','Remainds patient to takin his medication',3,0,'2023-03-25 08:23:55','2023-03-25 08:23:55',0),(7,'t-cuestionnaire','Request patient to answer questionnaire',1,0,'2023-05-17 10:23:55','2023-05-17 10:23:55',0),(20,'t-breakfast-fruit','Remember to eat fruit and cereals for breakfast',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(21,'t-brush-teeth','Remember to brush your teeth after every meal',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(22,'t-put-clothes','Remember that you have to take off your pajamas and put on street clothes.',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(23,'t-leave-home','Remember to leave home',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(24,'t-diet','Remember to have a balanced diet',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(25,'t-read','You have to order the text to be able to read it and answer the questions that are asked.',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(26,'t-pending-challenges','Remember that you have pending challenges',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(27,'t-song','Remember to listen to a song',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(28,'t-organize','Organize your week to meet your goals',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(29,'t-family','Remember spending time with family',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(30,'t-write','Write a journal of important things that happened to you today.',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(31,'t-shower','Remember to shower',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(32,'t-dinner','Remember to eat dinner',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(33,'t-sleep','Remember sleep',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(34,'t-video','Remember watch video',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(35,'t-sport','Remember to do sport',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(36,'t-bus-stop','Remember to leave home to the nearest bus stop',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(37,'t-socialize','Remember that you have to socialize',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(38,'t-portal','Remember to go down to the portal at least and use the stairs.',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(39,'t-organize-room','Remember to organize the room',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(40,'t-change-clothes','Remember to change your clothes',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(41,'t-play-1','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(42,'t-play-2','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(43,'t-play-3','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(44,'t-play-4','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(45,'t-play-5','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(46,'t-play-6','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(47,'t-play-7','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(48,'t-play-8','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(49,'t-play-9','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(50,'t-play-10','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(51,'t-play-11','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(52,'t-play-12','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(53,'t-play-13','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(54,'t-play-14','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(55,'t-play-15','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(56,'t-play-16','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(57,'t-play-17','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(58,'t-play-18','remember to disconnect',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(59,'t-question','Learning about schizophrenia',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(60,'t-question-1','Healthy life style',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(61,'t-question-2','Breathing technique',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(62,'t-question-3','List of emotions',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(63,'t-question-4','Manage emotions',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(64,'t-question-5','watch a movie',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(65,'t-question-6','Juego de atención: buscando a Wally',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(66,'t-question-7','Lee y ordena el texto',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(67,'t-question-8','Síntomas de ansiedad',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(68,'t-question-9','Mejorar nuestra autoestima',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(69,'t-cocinar','Cocinemos todos juntos',3,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(70,'t-question-11','Búsquedas por internet',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(71,'t-question-12','Conocernos mejor',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0),(72,'t-challenge-2','Send whatsapp',2,0,'2023-07-12 00:00:00','2023-07-12 00:00:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attribute`
--

LOCK TABLES `task_attribute` WRITE;
/*!40000 ALTER TABLE `task_attribute` DISABLE KEYS */;
INSERT INTO `task_attribute` VALUES (1,'URL'),(3,'LONG_DESC'),(4,'VIDEO'),(5,'ImageUri');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attribute_value`
--

LOCK TABLES `task_attribute_value` WRITE;
/*!40000 ALTER TABLE `task_attribute_value` DISABLE KEYS */;
INSERT INTO `task_attribute_value` VALUES (1,37,1,'https://instagram.es'),(2,41,1,'https://www.cokitos.com/memory-de-colores/play/'),(3,42,1,'https://www.cokitos.com/memoria-de-motos-iguales/play/'),(4,43,1,'https://www.cokitos.com/colorear-numeros-pares-e-impares/play/'),(5,44,1,'https://www.cokitos.com/color-pixel-pintar-por-numeros/play/'),(6,45,1,'https://www.cokitos.com/domino-contra-ordenador/play/'),(7,46,1,'https://www.epasatiempos.es/buscar-diferencias.php?df=539'),(8,47,1,'https://www.epasatiempos.es/buscar-diferencias.php?df=538'),(9,48,1,'https://www.epasatiempos.es/buscar-diferencias.php?df=470'),(10,49,1,'https://www.epasatiempos.es/buscar-diferencias.php?df=466'),(11,50,1,'https://www.epasatiempos.es/puzzles-encajar-piezas.php?pz=2a4ef56bb618.72'),(12,51,1,'https://www.epasatiempos.es/puzzles-encajar-piezas.php?pz=0d5ea4710e87.70'),(13,52,1,'https://www.epasatiempos.es/puzzles-encajar-piezas.php?pz=0fbce3e884be.72'),(14,53,1,'https://www.epasatiempos.es/juego-smarty-bubbles.php'),(15,54,1,'https://www.epasatiempos.es/sopas-de-letras-con-imagenes.php?sl=163'),(16,55,1,'https://www.epasatiempos.es/juego-fruita-crush.php'),(17,56,1,'https://www.epasatiempos.es/juego-reconocimiento-visual-aleatorio.php'),(18,57,1,'https://www.epasatiempos.es/sopas-de-letras-con-imagenes.php?sl=150'),(19,58,1,'https://www.epasatiempos.es/sopas-de-letras-con-imagenes.php?sl=146'),(20,59,3,'A continuación, vas a ver un vídeo corto sobre la psicosis. Se habla de los principales síntomas negativos y positivos. Presta atención porque después tendrás que contestar a unas preguntas. Puedes ver el vídeo todas las veces que necesites. '),(21,60,3,'En el siguiente vídeo te vamos a nombrar los factores de protección para tener un estilo de vida sana. Presta atención para poder responder a la pregunta que se plantee después. Puedes ver el vídeo varias veces sin problema. *texto del vídeo: los 7 puntos para llevar una vida sana: 1. Evita picotear y haz 5 comidas al día; 2. Realiza actividades que te gusten; 3. Ve a la cama solo a dormir; 4. Relaciónate con amigos y familia; 5. Practica algún deporte; 6. Mantén horarios regulares; y 7. Realiza actividades que te resulten relajantes. *  '),(22,61,3,'En el reto de hoy, vas a entrenar una técnica de respiración que podrás utilizar en los momentos en los que necesites relajarte. Vas a aprender la técnica del cuadrado. Esta es realizar respiración contando 4 segundos en cada una de las 4 fases:Inhalar 4 s. Retener 4s. Expulsar 4s. Retener 4s'),(23,62,3,' Para poder gestionar las emociones que sentimos debemos aprender a identificarlas: ¿cómo me siento en este momento? Para ello, demos conocer cómo se llaman las emociones. Recuerda que no hay emociones buenas y malas, solo emociones.   '),(24,63,3,'Cuando sucede algo inesperado o novedoso es importante preguntarnos ¿cómo me siento? Sabiendo cómo nos sentimos podremos saber cómo actuar ante ese sentimiento. A continuación, te dejamos un vídeo y una pregunta que tendrás que contestar. *texto del vídeo: cuando sucede una situación novedosa debemos preguntarnos “¿Cómo me siento?”. No hay emociones buenas y malas, solo son emociones y debemos aceptarlas todas sin juzgarnos por sentirnos así. Después, tenemos que trabajar esa emoción e intentar comprender por qué nos sentimos así. Si existe alguna forma de resolver la situación, lo hacemos. Si no, aceptamos la situación y esa emoción.*  '),(25,64,3,'Durante el día de hoy, intenta ver una película entera y realizar un resumen sobre ella. Tendrás que enviar el resumen antes de que acabe el día para poder completar el reto.En caso de que no se te ocurra ninguna, te dejamos una lista de películas a continuación '),(26,65,3,'En la siguiente imagen, aparece un personaje muy popular que tienes que identificar. Esto ayuda a focalizar nuestra atención durante unos minutos. Cuando lo encuentres: haz una captura, márcalo y envíalo por WhatsApp. '),(27,66,3,'Ahora va a aparecer un texto desordenado. Tienes que leerlo y ordenarlo para que la historia tenga sentido. Después escribe un pequeño resumen. '),(28,67,3,'A continuación, vas a ver un vídeo con algunos de los síntomas que aparecen cuando sufrimos ansiedad. Es importante prestar atención al vídeo para aprender a identificar este estado. Después, contesta a la pregunta que se plantee.*texto vídeo: ¿Sabes cuáles son los síntomas característicos de la ansiedad? Normalmente empieza con una sensación de agitación lo cual hace que aumente el ritmo cardíaco, una respiración acelerada, sudoración, sensación de cansancio y nos cuesta concentrarnos. Esto provoca problemas de sueño, gastrointestinales y de alimentación. Pide ayuda enseguida y mantente activo para prevenir la ansiedad. Además, evita consumir sustancias tóxicas porque pueden empeorar los síntomas.  '),(29,68,3,'Para poder completar este reto tienes que pensar en todas tus habilidades, capacidades y características positivas tuyas. Pueden ser tanto físicas como psicológicas. '),(30,69,3,'A la hora acordada, te llamaremos para realizar una videollamada y cocinar juntos la siguiente receta: espaguetis con verduras y atún.Ingredientes: -Espaguetis -Atún -Cebolla -Calabacín -Tomate.(se pueden crear varios retos con varias recetas).'),(31,70,3,'Tienes que buscar vídeos que hablen de los siguientes temas: -Hacer una tortilla de patata.-	Poner una rueda del coche.-Chistes.-Vender en wallapop.-Ropa de hombre'),(32,71,3,'Para conocer mejor a una persona podemos enseñarle cosas que nos gustan y así encontramos gustos en común. Esto facilita la comunicación con las otras personas. Por ello, hoy tienes que enviar tres canciones que te gusten mucho a tu educador/a por WhatsApp. Además, tendrás que hablarle de tu prenda de vestir favorita.  ');
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
  `additional_info_i18n` text COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_i18n_FK` (`id_language`),
  KEY `task_i18n_FK_1` (`id_task`),
  CONSTRAINT `task_i18n_FK` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id`),
  CONSTRAINT `task_i18n_FK_1` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_i18n`
--

LOCK TABLES `task_i18n` WRITE;
/*!40000 ALTER TABLE `task_i18n` DISABLE KEYS */;
INSERT INTO `task_i18n` VALUES (1,1,'Haz este ejercicio','Camina 5km a buen ritmo. Tú puedes!',2,NULL),(2,1,'Toma el desayuno','Es la hora del desayuno. Toma tu ración de cereales y de fruta para empezar el día con energía',3,NULL),(3,1,'Sube un comentario a tu red social preferida','Comparte con tus amig@s una foto de un lugar por donde te guste pasear',4,NULL),(4,1,'Practica esta técnica de relajación: Yoga','Vamos a tratar ayudarte a relajarte, a través de la práctica de yoga.  A continuación te explicamos paso a paso como empezar con ello',5,NULL),(5,1,'Es hora de tomar la medicación','Tienes que tomar x dosis de x medicamento.',6,NULL),(6,1,'Responde al cuestionario','A continuación te vamos a solicitar que respondas a un conjunto de preguntas, para que podamos conocer mejor cómo te encuentras',7,NULL),(7,1,'Responde al cuestionario','A continuación te vamos a solicitar que respondas a un conjunto de preguntas, para que podamos conocer mejor cómo te encuentras',1,NULL),(8,1,'Envía un mensaje de buenos días por WhatsApp','Tienes que mandar un mensaje de \"Buenos días\" a la educadora cuando te despiertes.',72,NULL),(11,1,'Desayunar','El desayuno es la comida más importante del día. Toma tu ración de fruta y cereales para empezar el día con mucha energía. ',20,NULL),(12,1,'Lavar los dientes','Una buena higiene nos aporta bienestar. Lávate los dientes tras cada comida. ',21,NULL),(13,1,'Cambiarse de ropa','Es hora de quitarse el pijama y ponerse ropa de calle. ',22,NULL),(17,1,'Salir de casa','La actividad física siempre es una buena opción. Si te aburres en casa, sal un poquito. ',23,NULL),(18,1,'Es hora de comer','Una dieta equilibrada nos ayuda a mantener la energía todo el día y a mantenernos sanos. ',24,NULL),(19,1,'Pequeña lectura de información','Tienes que ordenar el texto para poder leerlo y contestar a las preguntas que se te plantean. ',25,NULL),(22,1,'Es momento de hacer los retos','No olvides que tienes una lista de retos esperándote. ',26,NULL),(24,1,'Escucha alguna canción','La música siempre es una buena opción para subirnos el ánimo. Escucha alguna canción que te guste. ',27,NULL),(25,1,'Hacer una lista de tareas','Organiza tu semana para poder cumplir tus objetivos. Escribe tus prioridades. ',28,NULL),(28,1,'Pasar tiempo con la familia.','Cuidar a nuestros seres queridos es importante. Pasa un rato hablando con ellos.',29,NULL),(31,1,'Escribe cómo te fue el día','Escribe un diario de cosas importantes que te hayan pasado hoy. Aunque sea una línea.',30,NULL),(32,1,'Es hora de la ducha','La higiene es muy importante para llevar una vida equilibrada. Una ducha antes de dormir es muy relajante. ',31,NULL),(33,1,'Cenar','Toca reponer fuerzas para descansar mejor. ',32,NULL),(34,1,'Dormir','Dormir 8 horas diarias es importante para nuestra salud. Descansa bien.',33,NULL),(35,1,'Vídeo para aprender técnicas de respiración','Accede al vídeo y sigue las instrucciones',34,NULL),(36,1,'Actividad física','¿haces deporte conmigo? Busca tu espacio, ponte ropa cómoda y dale al play. ',35,NULL),(37,1,'Acude a la parada del autobús','Para evitar estar en casa todo el día, sal hasta la parada de autobús más cercana ',36,NULL),(38,1,'Hablar con otras personas','¡Es tu hora de socializar! Habla con una persona y hazle una pregunta de interés. Puedes hacerlo de forma virtual o en persona. ',37,NULL),(39,1,'Bajar al portal','Bajar al portal	¡Hoy toca salir de casa! Baja hasta el portal por lo menos y usa las escaleras. 	',38,NULL),(40,1,'Ordenar nuestro espacio','Hoy toca poner un poco de orden a nuestra habitación. Intenta recoger tu ropa, hacer la cama, lavar los platos… ',39,NULL),(41,1,'Cambiarse de ropa','No podemos estar todo el día en pijama. Cámbiate el pijama y ponte algo de ropa que te guste. ',40,NULL),(42,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',41,NULL),(43,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',42,NULL),(44,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',43,NULL),(45,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',44,NULL),(46,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',45,NULL),(47,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',46,NULL),(48,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',47,NULL),(49,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',48,NULL),(50,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',49,NULL),(51,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',50,NULL),(52,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',51,NULL),(53,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',52,NULL),(54,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',53,NULL),(55,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',54,NULL),(56,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',55,NULL),(57,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',56,NULL),(58,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',57,NULL),(59,1,'Es hora de desconectar','Dale al link y juega un rato. ¡Son muy divertidos!',58,NULL),(60,1,'¿QUÉ ES LA ESQUIZOFRENIA?','Vas a aprender algunos datos sobre la psicosis. ',59,'A continuación, vas a ver un vídeo corto sobre la psicosis. Se habla de los principales síntomas negativos y positivos. Presta atención porque después tendrás que contestar a unas preguntas. Puedes ver el vídeo todas las veces que necesites. '),(61,1,'Estilo de vida saludable','En este reto, aprenderás algunos factores de protección para tener un estilo de vida más saludable',60,'En el siguiente vídeo te vamos a nombrar los factores de protección para tener un estilo de vida sana. Presta atención para poder responder a la pregunta que se plantee después. Puedes ver el vídeo varias veces sin problema. *texto del vídeo: los 7 puntos para llevar una vida sana: 1. Evita picotear y haz 5 comidas al día; 2. Realiza actividades que te gusten; 3. Ve a la cama solo a dormir; 4. Relaciónate con amigos y familia; 5. Practica algún deporte; 6. Mantén horarios regulares; y 7. Realiza actividades que te resulten relajantes. *  '),(62,1,'Técnica de respiración ','Vas a entrenar una técnica de respiración',61,'En el reto de hoy, vas a entrenar una técnica de respiración que podrás utilizar en los momentos en los que necesites relajarte. Vas a aprender la técnica del cuadrado. Esta es realizar respiración contando 4 segundos en cada una de las 4 fases:Inhalar 4 s. Retener 4s. Expulsar 4s. Retener 4s'),(63,1,'Lista de  emociones ','En este reto vas a aprender a gestionar tus emociones. ',62,' Para poder gestionar las emociones que sentimos debemos aprender a identificarlas: ¿cómo me siento en este momento? Para ello, demos conocer cómo se llaman las emociones. Recuerda que no hay emociones buenas y malas, solo emociones.   '),(64,1,'Gestionar emociones','En este reto vas a aprender a gestionar tus emociones. ',63,'Cuando sucede algo inesperado o novedoso es importante preguntarnos ¿cómo me siento? Sabiendo cómo nos sentimos podremos saber cómo actuar ante ese sentimiento. A continuación, te dejamos un vídeo y una pregunta que tendrás que contestar. *texto del vídeo: cuando sucede una situación novedosa debemos preguntarnos “¿Cómo me siento?”. No hay emociones buenas y malas, solo son emociones y debemos aceptarlas todas sin juzgarnos por sentirnos así. Después, tenemos que trabajar esa emoción e intentar comprender por qué nos sentimos así. Si existe alguna forma de resolver la situación, lo hacemos. Si no, aceptamos la situación y esa emoción.*  '),(65,1,'Ver una película','Ver una película	En este reto tendrás que ver una película que te guste.	Durante el día de hoy, intenta ver una película entera y realizar un resumen sobre ella. Tendrás que enviar el resumen antes de que acabe el día para poder completar el reto. ',64,'Durante el día de hoy, intenta ver una película entera y realizar un resumen sobre ella. Tendrás que enviar el resumen antes de que acabe el día para poder completar el reto.En caso de que no se te ocurra ninguna, te dejamos una lista de películas a continuación '),(66,1,'Juego de atención: buscando a Wally','En la siguiente imagen, aparece un personaje muy popular que tienes que identificar. Esto ayuda a focalizar nuestra atención durante unos minutos. Cuando lo encuentres: haz una captura, márcalo y envíalo por WhatsApp. ',65,'En la siguiente imagen, aparece un personaje muy popular que tienes que identificar. Esto ayuda a focalizar nuestra atención durante unos minutos. Cuando lo encuentres: haz una captura, márcalo y envíalo por WhatsApp. '),(67,1,'Lee y ordena el texto','',66,'Ahora va a aparecer un texto desordenado. Tienes que leerlo y ordenarlo para que la historia tenga sentido. Después escribe un pequeño resumen. '),(68,1,'Síntomas de ansiedad','En el reto de hoy vamos a hablar de la ansiedad y de sus síntomas más característicos. ',67,'A continuación, vas a ver un vídeo con algunos de los síntomas que aparecen cuando sufrimos ansiedad. Es importante prestar atención al vídeo para aprender a identificar este estado. Después, contesta a la pregunta que se plantee.*texto vídeo: ¿Sabes cuáles son los síntomas característicos de la ansiedad? Normalmente empieza con una sensación de agitación lo cual hace que aumente el ritmo cardíaco, una respiración acelerada, sudoración, sensación de cansancio y nos cuesta concentrarnos. Esto provoca problemas de sueño, gastrointestinales y de alimentación. Pide ayuda enseguida y mantente activo para prevenir la ansiedad. Además, evita consumir sustancias tóxicas porque pueden empeorar los síntomas.  '),(69,1,'Mejorar nuestra autoestima','En el reto de hoy vas a hablar de las características positivas que te hacen destacar en comparación con los demás. ',68,'Para poder completar este reto tienes que pensar en todas tus habilidades, capacidades y características positivas tuyas. Pueden ser tanto físicas como psicológicas. '),(70,1,'Cocinemos todos juntos','En el reto de hoy tienes que prepararte para cocinar.',69,'A la hora acordada, te llamaremos para realizar una videollamada y cocinar juntos la siguiente receta: espaguetis con verduras y atún.Ingredientes: -Espaguetis -Atún -Cebolla -Calabacín -Tomate.(se pueden crear varios retos con varias recetas).'),(71,1,'Búsquedas por internet','En el reto de hoy te proponemos buscar información por tiktok',70,'Tienes que buscar vídeos que hablen de los siguientes temas: -Hacer una tortilla de patata.-	Poner una rueda del coche.-Chistes.-Vender en wallapop.-Ropa de hombre'),(72,1,'En el reto de hoy tienes que conocer mejor los gustos y preferencias de tu educador/a de referencia','Para conocer mejor a una persona podemos enseñarle cosas que nos gustan y así encontramos gustos en común. Esto facilita la comunicación con las otras personas. Por ello, hoy tienes que enviar tres canciones que te gusten mucho a tu educador/a por WhatsApp. Además, tendrás que hablarle de tu prenda de vestir favorita.  ',71,'Para conocer mejor a una persona podemos enseñarle cosas que nos gustan y así encontramos gustos en común. Esto facilita la comunicación con las otras personas. Por ello, hoy tienes que enviar tres canciones que te gusten mucho a tu educador/a por WhatsApp. Además, tendrás que hablarle de tu prenda de vestir favorita.  ');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_questionnaire`
--

LOCK TABLES `task_questionnaire` WRITE;
/*!40000 ALTER TABLE `task_questionnaire` DISABLE KEYS */;
INSERT INTO `task_questionnaire` VALUES (1,1,1),(2,7,2),(3,67,2);
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
-- Dumping routines for database 'adiante-dev'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-19 21:03:40
