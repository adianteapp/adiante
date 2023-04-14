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
  `value` text COLLATE latin1_spanish_ci NOT NULL,
  `id_question` bigint(20) NOT NULL,
  `i18n_key` bigint(20) NOT NULL,
  `hasIcon` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_FK` (`id_question`),
  KEY `answer_FK_1` (`i18n_key`),
  CONSTRAINT `answer_FK` FOREIGN KEY (`id_question`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `answer_FK_1` FOREIGN KEY (`i18n_key`) REFERENCES `translations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'getmood-q1-a1',1,4,1),(2,'getmood-q1-a2',1,5,1),(3,'getmood-q1-a3',1,6,1),(4,'getmood-q1-a4',1,7,1),(5,'getmood-q1-a5',1,8,1);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_activity_entry`
--

LOCK TABLES `patient_activity_entry` WRITE;
/*!40000 ALTER TABLE `patient_activity_entry` DISABLE KEYS */;
INSERT INTO `patient_activity_entry` VALUES (1,'2023-03-26 21:11:09',1,1),(19,'2023-03-27 07:16:42',1,1),(21,'2023-03-27 07:37:47',1,1),(22,'2023-03-27 07:42:30',1,1),(23,'2023-03-27 07:46:56',1,1),(24,'2023-03-27 08:54:28',1,1),(25,'2023-03-28 16:02:07',1,1),(26,'2023-03-28 16:10:03',1,1),(27,'2023-03-28 16:15:59',1,1);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_map`
--

LOCK TABLES `patient_program_map` WRITE;
/*!40000 ALTER TABLE `patient_program_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program_map` ENABLE KEYS */;
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
-- Table structure for table `patient_task_scheduling`
--

DROP TABLE IF EXISTS `patient_task_scheduling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_task_scheduling` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `id_task` bigint(20) NOT NULL,
  `id_patient_activity_entry` bigint(20) DEFAULT NULL,
  `id_patient` bigint(20) NOT NULL,
  `id_task_status` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_task_scheduling_FK` (`id_patient_activity_entry`),
  KEY `patient_task_scheduling_FK_1` (`id_task`),
  KEY `patient_task_scheduling_FK_2` (`id_patient`),
  KEY `patient_task_scheduling_FK_3` (`id_task_status`),
  CONSTRAINT `patient_task_scheduling_FK` FOREIGN KEY (`id_patient_activity_entry`) REFERENCES `patient_activity_entry` (`id`),
  CONSTRAINT `patient_task_scheduling_FK_1` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `patient_task_scheduling_FK_2` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id`),
  CONSTRAINT `patient_task_scheduling_FK_3` FOREIGN KEY (`id_task_status`) REFERENCES `task_execution_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_task_scheduling`
--

LOCK TABLES `patient_task_scheduling` WRITE;
/*!40000 ALTER TABLE `patient_task_scheduling` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_task_scheduling` ENABLE KEYS */;
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
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_task`
--

LOCK TABLES `program_task` WRITE;
/*!40000 ALTER TABLE `program_task` DISABLE KEYS */;
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
  `value` text COLLATE latin1_spanish_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `id_questionnaire` bigint(20) NOT NULL,
  `i18n_key` bigint(20) NOT NULL,
  `id_question_type` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_FK` (`id_questionnaire`),
  KEY `question_FK_1` (`i18n_key`),
  KEY `question_FK_2` (`id_question_type`),
  CONSTRAINT `question_FK` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaire` (`id`),
  CONSTRAINT `question_FK_1` FOREIGN KEY (`i18n_key`) REFERENCES `translations` (`id`),
  CONSTRAINT `question_FK_2` FOREIGN KEY (`id_question_type`) REFERENCES `question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'Get patient mood',1,1,3,1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
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
  `i18n_key` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `id_questionnaire_type` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionary_FK` (`id_questionnaire_type`),
  CONSTRAINT `questionary_FK` FOREIGN KEY (`id_questionnaire_type`) REFERENCES `questionnaire_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,'q-get-mood','Questionary to get patient mood selecting on single answer','2',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution`
--

LOCK TABLES `questionnaire_execution` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution` DISABLE KEYS */;
INSERT INTO `questionnaire_execution` VALUES (11,1,19),(13,1,21),(14,1,22),(15,1,23),(16,1,24),(17,1,25),(18,1,26),(19,1,27);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_execution_answer`
--

LOCK TABLES `questionnaire_execution_answer` WRITE;
/*!40000 ALTER TABLE `questionnaire_execution_answer` DISABLE KEYS */;
INSERT INTO `questionnaire_execution_answer` VALUES (1,1,NULL,1,11),(2,1,NULL,1,13),(3,1,NULL,1,14),(4,1,NULL,1,15),(5,1,NULL,1,16),(6,1,NULL,1,17),(7,1,NULL,1,18),(8,1,NULL,1,19);
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
INSERT INTO `questionnaire_type` VALUES (1,'qt-dashboard','This kind of questionary is show on the patients dashboard');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_answer_task`
--

LOCK TABLES `related_answer_task` WRITE;
/*!40000 ALTER TABLE `related_answer_task` DISABLE KEYS */;
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
  `i18n_key` bigint(20) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `mandatory_feedback` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `task_FK` (`id_task_type`),
  KEY `task_FK_1` (`i18n_key`),
  CONSTRAINT `task_FK` FOREIGN KEY (`id_task_type`) REFERENCES `task_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_FK_1` FOREIGN KEY (`i18n_key`) REFERENCES `translations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'t-01-get-mood','This task gets patients mood thrugh a questionary',1,1,1,'2023-03-25 08:23:55','2023-03-25 08:23:55',1);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_atributte`
--

DROP TABLE IF EXISTS `task_atributte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_atributte` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `i18n_key` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_atributte_FK` (`i18n_key`),
  CONSTRAINT `task_atributte_FK` FOREIGN KEY (`i18n_key`) REFERENCES `translations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_atributte`
--

LOCK TABLES `task_atributte` WRITE;
/*!40000 ALTER TABLE `task_atributte` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_atributte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_atributte_value`
--

DROP TABLE IF EXISTS `task_atributte_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_atributte_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_task` bigint(20) DEFAULT NULL,
  `id_task_atributte` bigint(20) DEFAULT NULL,
  `value` text COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_atributte_value_FK` (`id_task`),
  KEY `task_atributte_value_FK_1` (`id_task_atributte`),
  CONSTRAINT `task_atributte_value_FK` FOREIGN KEY (`id_task`) REFERENCES `task` (`id`),
  CONSTRAINT `task_atributte_value_FK_1` FOREIGN KEY (`id_task_atributte`) REFERENCES `task_atributte` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_atributte_value`
--

LOCK TABLES `task_atributte_value` WRITE;
/*!40000 ALTER TABLE `task_atributte_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_atributte_value` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `task_execution_status` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_questionnaire`
--

LOCK TABLES `task_questionnaire` WRITE;
/*!40000 ALTER TABLE `task_questionnaire` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type`
--

LOCK TABLES `task_type` WRITE;
/*!40000 ALTER TABLE `task_type` DISABLE KEYS */;
INSERT INTO `task_type` VALUES (1,'tt-questionnaire','This type represents the fulfillment of a specific questionnaire'),(2,'tt-challenge','This type represents an activity proposed by the profesional to patient.'),(3,'tt-scheduled-activy','To include actions like, have breakfast, meet with the alume professionals');
/*!40000 ALTER TABLE `task_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_type_atributte`
--

DROP TABLE IF EXISTS `task_type_atributte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_type_atributte` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `i18n_key` bigint(20) DEFAULT NULL,
  `id_task_type` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_type_atributte_FK` (`i18n_key`),
  KEY `task_type_atributte_FK_1` (`id_task_type`),
  CONSTRAINT `task_type_atributte_FK` FOREIGN KEY (`i18n_key`) REFERENCES `translations` (`id`),
  CONSTRAINT `task_type_atributte_FK_1` FOREIGN KEY (`id_task_type`) REFERENCES `task_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type_atributte`
--

LOCK TABLES `task_type_atributte` WRITE;
/*!40000 ALTER TABLE `task_type_atributte` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_type_atributte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
  `id` bigint(20) NOT NULL,
  `code_name` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_un` (`code_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (2,'q-getmood'),(3,'q-getmood-q1'),(4,'q-getmood-q1-a1'),(5,'q-getmood-q1-a2'),(6,'q-getmood-q1-a3'),(7,'q-getmood-q1-a4'),(8,'q-getmood-q1-a5'),(1,'t-getmood');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations_i18n`
--

DROP TABLE IF EXISTS `translations_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations_i18n` (
  `id` bigint(20) NOT NULL,
  `id_language` bigint(20) NOT NULL,
  `id_translation` bigint(20) NOT NULL,
  `i18n_value` text COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `translations_i18n_FK` (`id_language`),
  KEY `translations_i18n_FK_1` (`id_translation`),
  CONSTRAINT `translations_i18n_FK` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id`),
  CONSTRAINT `translations_i18n_FK_1` FOREIGN KEY (`id_translation`) REFERENCES `translations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations_i18n`
--

LOCK TABLES `translations_i18n` WRITE;
/*!40000 ALTER TABLE `translations_i18n` DISABLE KEYS */;
INSERT INTO `translations_i18n` VALUES (1,1,1,'Tarea para conocer el estado de ánimo'),(2,1,2,'Cuerstionaro para conocer el estado de ánimo'),(3,1,3,'¿Cómo te sientes ?'),(4,1,4,'Muy felíz'),(5,1,5,'Muy bien'),(6,1,6,'Indiferente'),(7,1,7,'Mal'),(8,1,8,'Muy mal');
/*!40000 ALTER TABLE `translations_i18n` ENABLE KEYS */;
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

-- Dump completed on 2023-04-10 23:28:54
