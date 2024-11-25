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
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `ware_house_id` bigint DEFAULT NULL,
  `catagory_name` varchar(255) DEFAULT NULL,
  `quantity` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKeuiihog7wq4cu7nvqu7jx57d2` (`product_id`),
  KEY `FK3x8qdgc25qum6we9ot0bhbnb8` (`ware_house_id`),
  CONSTRAINT `FK3x8qdgc25qum6we9ot0bhbnb8` FOREIGN KEY (`ware_house_id`) REFERENCES `warehouses` (`id`),
  CONSTRAINT `FKeuiihog7wq4cu7nvqu7jx57d2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,'2024-09-29 00:00:00.000000','2024-09-29 15:37:38.374450',3,7,NULL,0),(2,'2024-09-29 00:00:00.000000','2024-09-29 15:38:18.914262',4,7,NULL,0),(3,'2024-09-29 00:00:00.000000','2024-09-29 15:46:21.692890',5,8,NULL,0),(4,'2024-09-29 00:00:00.000000','2024-09-29 15:47:54.050771',6,9,NULL,0),(7,'2024-09-29 00:00:00.000000','2024-09-29 18:58:21.265558',8,10,NULL,0),(15,'2024-10-01 00:39:47.048089','2024-10-01 00:39:47.048089',10,12,NULL,0),(19,'2024-10-01 00:57:45.006884','2024-10-01 00:57:45.006884',11,10,NULL,0),(21,'2024-10-01 01:09:51.559287','2024-10-01 01:09:51.559287',10,12,NULL,0),(22,'2024-10-01 01:17:09.042165','2024-10-01 01:17:09.042165',11,9,NULL,0),(23,'2024-10-17 01:35:59.240322','2024-10-17 01:35:59.242323',12,10,NULL,0),(24,'2024-10-17 01:36:31.785882','2024-10-17 01:36:31.785882',13,8,NULL,0),(25,'2024-10-17 01:36:53.528819','2024-10-17 01:36:53.528819',14,12,NULL,0);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-26  4:32:22
