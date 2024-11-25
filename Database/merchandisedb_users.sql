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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','USER') DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `is_lock` bit(1) DEFAULT NULL,
  `cell` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (25,'nayamulislam@gmail.com','99f6e2a0-d236-475d-bb6d-f0a46a444f8d_VIP-33770.jpg','Neyamul Islam','$2a$10$2pFN/68GxCB87g35v/iba.AwgG7cV8V7Alo.KIPw.dvTwv8Wjaf/S','ADMIN',_binary '',_binary '','+880523123211','Mohammodpur, Dhaka','1994-01-02','Male'),(26,'shabab@gmail.com','bfba2630-123a-4d44-9bea-764b4fb297a8_4RQ1v2yp_400x400.jpg','Shabab Ahamed','$2a$10$gRw.9D9jbxrygd8K9mgaa.KB5dI8275w9QbZ0dYnLOkxK32pJyV26','USER',_binary '',_binary '','+882564115656','kallanpur, Dhaka','1997-09-18','Male'),(27,'arman@gmail.com','df115e45-5046-494f-b40e-7843d84e26e6_my-passport-photo.jpg','Arman Biswas','$2a$10$XzQ31DSx1T9cbxlYxVl5XOLRsvNEhBgygGPgdD5V5tfoVqO1WZy3i','USER',_binary '',_binary '','+88052652414','Framget, Dhaka','2000-12-19','Male'),(28,'1302neyamulislamnirob@gmail.com','9cf82698-bea5-49f5-87bf-94832a99a6cd_IMG_20220127_163119.jpg','Neyamul Nirob','$2a$10$LEtcpCFy17ITwZR1LZhpbO8nhxZietfdwpdzdvIJu79/XWexyo/0e','ADMIN',_binary '',_binary '','+88026356511','Mohammodpur, Dhaka','1995-02-03','Male'),(45,'nasim@gmail.com','2a3f455d-c014-48e4-aab3-34f71d0e032f_upload.jpg','Nasimul Islam','$2a$10$dPOL1PlPgqhdLHyqDCBzDuBOelWFdGWxJ/fAPhltTe7X1k.0QGxOC','ADMIN',_binary '',_binary '','+880111122233','Shylet, Bangladesh','2000-03-31','Male'),(46,'raju@gmail.com','ae80cef2-dbb3-4a1c-bfb3-e0e7a7438207_upload.jpg','Raju Ahamed','$2a$10$uU/30LiJioxWxtS2hqzJpOhwLc2FMHQYXQyVguNA3otEh6kHZ83Sq','USER',_binary '',_binary '','+880111222333','Ajimpur, Dhaka, Bangladesh','1995-11-13','Male'),(47,'nasif@gmail.com','13b787e3-384d-4e57-9c23-1031c794828c_upload.jpg','Nasif Shariar','$2a$10$BdUrP1wjX6gapwGlBS.Lq.w9Vz6gCF6nJ3sPSPEJeExupzPP9ZxN6','USER',_binary '\0',_binary '','+88011122233','Framget, Dhaka, Bangladesh','2024-11-13','Male'),(48,'fwekmeffm@bhb.jknds','18416a69-ce8b-45db-b25a-47c2fb1de671_upload.jpg','gvb dn ','$2a$10$u0cdnghwsMrwXtZPVufkf.QMD84qpXNU0GdxeFpTCq50gh6EktqLm','USER',_binary '\0',_binary '','+85222020','fdhfh','1994-11-13','Male');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
