-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: merchandisedb
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `country_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKq5uvp89ra4ksaty5ghyaw4kjr` (`email`),
  KEY `FKn1iyuiw0xgggncfk4joxfx9y` (`country_id`),
  CONSTRAINT `FKn1iyuiw0xgggncfk4joxfx9y` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (14,'B-52, Sector-2, Noida-201301,\nUttar Pradesh, INDIA','Mr. Vimal Singha','2024-09-28 14:52:48.802892','manglamapparels@gmail.com','Manglam Apparels Pvt. Ltd','+91-0120 4320133','Germents','2024-09-30 18:09:28.072413','Mrs. Anjana Singhal',5),(15,'The NoName Company\n4400 GLF, Gardenia, Kalindi Hills\nSector 49, Faridabad\nHaryana 121001 India','Mr Asok Mahata','2024-09-28 16:28:26.744591','hello@nonameglobal.com','The NoName Company','+91-9717 508 508','Germents','2024-09-28 18:06:15.049428','Mr Asok Mahata',5),(17,'7-1-17, Daikaidori, Hyogo, Kobe 652-0803, Japan','Akashi-shi','2024-10-01 00:21:20.739476','akashi-shi@gmail.com','TOMOE SANGYO CO., LTD','+81-78-576-1088','Row Metaril&chemical','2024-10-01 00:21:20.739476','Akashi-shi',12),(20,'Streathut,USA','Lony Star','2024-11-26 04:11:14.454213','lony@gmail.com','LifeFesion','+1152522','Active','2024-11-26 04:11:14.456212','Lony Star ',8),(21,'Whung,Japan','Kung Chu','2024-11-26 04:12:43.652390','khun@gmail.com','Xart Cot','+2586522','Active','2024-11-26 04:12:43.652390','Kung Chu',12);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-26  4:32:24
