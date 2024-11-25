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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (6,'G31C','All Kinds of Garments','4f9f5879-ed2a-4f4f-8ee9-4ee98cd2bb23_garments.svg','Garment'),(7,'DEDA','Many Kins of Fabric','12a4085d-26ef-404d-b0e4-ac0834886251_fabric.svg','Fabric '),(8,'3G12','High Quality Yarn ','b3f03af0-8f3a-41e3-8d33-1340ba1552f7_yarn.svg','Yarn'),(9,'31FE','Hugh Collection of Home Textiles','ae373b3e-212b-4777-96ca-3b715a932aa2_home-textile.svg','Home Textiles'),(10,'A32B',' All Kinds of Clothing Accessory','bee3c459-1b84-4b97-843e-f9dca1aa76d7_clothing.svg','Clothing Accessory'),(11,'AFEB','Organic & Conventional Cotton  Fibre & FeedStock','f6d2d1a8-3a84-4566-90d8-ba3fbe721513_feedstock.svg','Fibre & FeedStock'),(12,'02F2','High-Quality Leather & Footwear','03224947-56ab-41e5-ad60-fa2d62a2cbfb_footwear.svg','Leather & Footwear'),(13,'2G0F','Many kinds of Fashion Accessory','70110064-2bcf-4d4d-94af-c256352648b6_fashion-accessary.svg','Fashion Accessory');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `bussiness` varchar(255) DEFAULT NULL,
  `progress` varchar(255) DEFAULT NULL,
  `sale` double NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (4,'Bangladesh ','Row Metarials&Garment','50',800000,'Rich'),(5,'	India','Fabric ','35',400000,'Good'),(6,'China','Yarn','40',650000,'Rich'),(7,'HONG KONG','Row Metarials&Fiber','45',380000,'Rich'),(8,'USA','Fabric ','50',850000,'Rich'),(9,'TORONTO','Garment','55',450000,'Good'),(10,' NEW YORK','Home Textiles','60',850000,'Rich'),(11,'SECAUCUS','Clothing Accessory','65',850000,'Rich'),(12,' Japan','Garment','70',530000,'Good');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `organigation` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `country_obj_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKrfbvkrffamfql7cjmen8v976v` (`email`),
  KEY `FKhrruqdhcwnatqblne73cwcb36` (`country_obj_id`),
  CONSTRAINT `FKhrruqdhcwnatqblne73cwcb36` FOREIGN KEY (`country_obj_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'GARDENA, CA 90248USA','Mr Tony','2024-09-30 02:51:15.301067','tony@fang-fashion.com','Mr Tony','FASHION LIFE/FANG','+115423','2024-09-30 02:51:15.301067',8),(2,'KAZUKO OTAKE ','SHO HARASAKI','2024-11-22 03:42:25.364519','r.otake@mamafactory.jp','SHO HARASAKI','MAMA FACTORY OTAKE CO.LTD.','+81 90 8496 5344','2024-11-22 03:42:25.366519',12),(3,'House 5/C, Road 01,\nMohammadpur','Nafiz Shahriar Nirjash','2024-11-22 03:49:40.263631','nafizshahriar@gmail.com','Nafiz Shahriar Nirjash','IDB-BIsEW','+88021255555','2024-11-22 03:49:40.267630',4);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_items`
--

DROP TABLE IF EXISTS `inventory_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock` bigint NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `ware_house_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9qhblf3mc4r22jajlv4w6sstt` (`product_id`),
  KEY `FKm75avxhur1gw9guj9tilobrv1` (`ware_house_id`),
  CONSTRAINT `FK9qhblf3mc4r22jajlv4w6sstt` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKm75avxhur1gw9guj9tilobrv1` FOREIGN KEY (`ware_house_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_items`
--

LOCK TABLES `inventory_items` WRITE;
/*!40000 ALTER TABLE `inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `delivery_date` date DEFAULT NULL,
  `order_date` datetime(6) NOT NULL,
  `quantity` bigint NOT NULL,
  `status` varchar(255) NOT NULL,
  `total_price` double NOT NULL,
  `customer_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9xiqncq3lfs899jmdi8hndr5l` (`customer_id`),
  KEY `FKocimc7dtr037rh4ls4l95nlfi` (`product_id`),
  CONSTRAINT `FK9xiqncq3lfs899jmdi8hndr5l` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `FKocimc7dtr037rh4ls4l95nlfi` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,'2024-10-31','2024-09-29 20:56:36.987000',150,'Shipped',22500,1,4),(2,'2024-11-20','2024-09-29 20:59:50.971000',50,'Shipped',7500,2,4),(3,'2024-10-17','2024-09-30 17:33:11.174000',50,'Shipped',17500,2,6),(4,'2024-11-29','2024-09-30 22:50:13.688000',100,'Shipped',90000,3,9),(5,'2024-10-31','2024-09-30 22:53:18.952000',200,'Shipped',92000,3,8),(6,'2024-10-18','2024-09-30 23:21:07.249000',100,'Shipped',35000,3,7),(7,'2024-10-31','2024-09-30 23:42:04.314000',230,'Pending',80500,3,7),(8,'2024-10-18','2024-10-01 00:05:36.793000',200,'Shipped',200000,2,10),(9,'2024-10-31','2024-10-16 18:06:54.238000',150,'Shipped',150000,2,14);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dalivary_date` date DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `due` double NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `paid` double NOT NULL,
  `price` double NOT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `quantity` int NOT NULL,
  `tax` double NOT NULL,
  `total_price` double NOT NULL,
  `sub_categories_id` bigint DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `sizes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKklfbf25x7jf9pg19jhojq5pg2` (`sub_categories_id`),
  KEY `FK6i174ixi9087gcvvut45em7fd` (`supplier_id`),
  CONSTRAINT `FK6i174ixi9087gcvvut45em7fd` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  CONSTRAINT `FKklfbf25x7jf9pg19jhojq5pg2` FOREIGN KEY (`sub_categories_id`) REFERENCES `sub_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (3,'2024-10-31','We are a professional manufacturer and exporter and our expertise is in Girl Unicorn Onesie . \nThese Wrap yourself with our exquisite Girl Unicorn...',0,'c2b6bc7d-f820-4756-ac31-3311a2607bf5_24218606_2_girl-unicorn-onesie-supplier.webp','Girl Unicorn Onesie',52500,200,'uqvxu','2024-09-27',250,5,52500,2,15,'Xsmall,Small,Medium'),(4,'2024-10-24','We introduce our company as a well renowned maker and exporter of Kid\'s Formal Shorts . We have achieved expertise in catering to the requirements...',0,'5ef636ed-89c5-4616-8edd-b10bd39455b4_24221923_0_twill-short-frt-removebg-preview.webp','Kid\'s Formal Shorts',15900,150,'wwrsw','2024-09-28',100,6,15900,2,14,'Xsmall,Small,Medium'),(5,'2024-11-01','We introduce our self as a pioneer in the field of Women\'s Long Denim Skirt . Our Customizable Women\'s Long Denim Skirt with Front pocket and Slit...',0,'228836dc-5364-4ec6-bc06-76592ff4a039_24220755_0_10.webp','Women\'s Long Denim Skirt',155250,900,'ywjv5','2024-09-28',150,15,155250,4,17,'Medium,Large,Xlarge'),(6,'2024-10-31','We are a top-ranking company which is specialized in Kids Wool Half-Sleeve Knee-Length Dress . A perfect fusion of classic elegance and...',0,'42ac1ffb-93e6-4658-be0f-ee9558ddf223_24218604_0_651d4f60-e205-4d98-a5b2-b632-3d5478a1.webp',' Kids Wool Half-Sleeve Knee-Length Dress',261625,350,'pu67q','2024-09-28',650,15,261625,2,15,'Xsmall,Small,Medium'),(7,'2024-11-29','We introduce our company as a well renowned maker and exporter of Kids Stylish Sweater . We offer kids\' sweaters made from a variety of materials...',0,'6c62644f-53e7-4cda-92b3-fcfb87121089_24221245_7_kids-stylish-sweater.webp','Kids Stylish Sweater',265650,350,'puujo','2024-09-28',690,10,265650,2,14,'Xsmall,Small,Medium'),(8,'2024-11-28','We get huge pleasure and pride in introducing our company as one of the leading manufacturers & exporters of Men\'s Gym Half-sleeve T-shirts.',0,'f4940112-8da9-4c86-bfda-729c6512051d_23217766_1_58.webp','Men\'s Gym Half-sleeve T-shirts Supplier',241500,460,'9vnhv','2024-09-30',500,5,241500,3,15,'Xsmall,Small,Medium'),(9,'2024-09-30','We take immense pleasure and pride in introducing our company as one of the leading manufacturers &amp; exporters of Men Stylish Sweater . We...',-5000,'39eeb2f9-41f2-4eec-9aaf-ecf4b7265dc3_23217766_1_58_59 (1).webp','Men Stylish Sweater',490000,900,'9vrzq','2024-09-29',500,10,495000,3,14,'Xsmall,Small,Medium'),(10,'2024-11-01','Our company excels in the manufacturing of Knitted Jacquard Fabric. Our exquisite Luxury Embroidered Jacquard is a unique weaving technique that integrates intricate patterns directly into the material...',-15000,'114bed77-b439-4426-9dcd-dbd74af21eed_23217916_0_2.webp','Knitted Jacquard Fabric',100000,1000,'xp4th','2024-11-10',100,15,115000,5,15,'Large'),(11,'2024-11-01','We are considered as one of the most remarkable and renowned manufacturer &amp; exporter of Dyed Warp Polyester Fabric . This enables us to cater...',0,'cb8ac4c8-5058-4317-b446-181249660141_16121030_2_poyerster-fabric-400-gsm-dyed-wrap-supplier.webp','Dyed Warp Polyester Fabric',68750,2.5,'jzup4','2024-11-10',25000,10,68750,5,17,'Kg'),(12,'2024-11-01','We are reckoned as an established manufacturer and exporter of Woolen Blends for knitting purpose. We would like to sell yarn in dyed pattern...',0,'72d662f5-341d-4513-af56-7dd86f6c7fde_24222610_0_spun-polyester-yarn.webp','Woolen Blends : Dyed, Knitting, 10-80, Wool, Linen, Polyester, Cotton',1058400,900,'poquw','2024-10-04',980,20,1058400,8,17,'Kg'),(13,'2024-11-01','Riding on unfathomable volumes of industrial expertise, we are providing a broad array of Silk Yarn .',0,'436e7ee6-ec52-4ae8-8d4f-d345c0df5e1a_1361213_1_20131004075055063238_2.webp','Silk Yarn',585000,750,'5ompx','2024-10-04',650,20,585000,8,14,'Kg'),(14,'2024-11-01','We are manufacturer &amp; exporter of FSC BCI Bamboo Cotton Yarn made out of 70% Bamboo 30% Cotton / 50% Bamboo / 50% Cotton. Can supply these...',0,'8152651e-bada-47fd-baf7-efca6b0d4dc2_20181741_0_bamboo-yarn.webp','FSC BCI Bamboo Cotton Yarn',1008000,1000,'ppvh5','2024-10-04',960,5,1008000,8,15,'Kg'),(15,'2024-11-12','We introduce our self as a pioneer in the field of Womens Floral Print Co-ord Set. Elevate your look with our stunning 100% Viscose black floral print co-ord set.',0,'b3212d43-1716-4ba3-9b87-d94b64afd498_upload.jpg','Women Floral Print Co-ord Set',26250,250,'5iwjt','2024-11-12',100,5,26250,4,17,'free'),(17,NULL,'We use the latest technology for production of Polypropylene Non Woven Spun Bond Fabric and enables the homogeneous distribution of fabric to...',0,'7665e8e5-0598-416b-aea5-b2c8818ca9af_upload.jpg','Polypropylene Non Woven Spun Bond Fabric',414000,180,'7mysm','2024-11-26',2000,15,414000,6,15,'Kg'),(18,NULL,'Our company excels in the manufacturing of Thermal Bonded Nonwoven Fabric . We have achieved expertise in catering to the requirements of our...',0,'c789f7df-c10a-4400-baec-6aafdfbd870b_upload.jpg','Thermal Bonded Nonwoven Fabric',6300,120,'6hp79','2024-11-26',50,5,6300,6,15,'KG'),(19,NULL,'We are a top-ranking company which is specialized in Twill Woven Fabric . Our products are high in demand due to their premium quality, seamless...',0,'5726b1cf-72fe-4a77-9eeb-8ad1fb8e45d2_upload.jpg','Twill Woven Fabric',40700,185,'pjs79','2024-11-26',200,10,40700,7,15,'INR/Meters'),(20,NULL,'We are a well established and well known exporter of Organic Cotton Fabric . We offer organic cotton fabric in greige, dyed, and bleached options...',0,'36d43531-2f1b-4000-99eb-79360df1d4d5_upload.jpg','Organic Cotton Fabric',35420,220,'o7h8n','2024-11-26',140,15,35420,7,17,'Container'),(21,NULL,'We are one of the most trusted names in the industry engaged in supplying and exporting a comprehensive range of Acrylic Carpet yarn . These',0,'e45b269e-a785-4de8-86b2-36e08d97f179_upload.jpg','Acrylic Carpet yarn',33522.5,530,'titmv','2024-11-26',55,15,33522.5,23,14,'container'),(22,NULL,'We are considered as one of the most remarkable and renowned manufacturer &amp; exporter of Polyester Yarn for weaving. Pattern is raw white in...',-2685,'17861aee-0e19-4a16-8f18-cd7a3f3bf2bb_upload.jpg','Polyester Yarn : Raw White, For weaving, 30/2, 100% Polyester',3930,252,'mrun9','2024-11-26',25,5,6615,23,15,'Container'),(23,NULL,'We get huge pleasure and pride in introducing our company as one of the leading manufacturers &amp; exporters of Cotton KW-Carded Weaving Yarn ....',-10000,'9e92c135-aff8-4269-b933-3872fb996e99_upload.jpg','Cotton KW-Carded Weaving Yarn',19900,650,'87nxj','2024-11-26',40,15,29900,24,15,'container'),(24,NULL,'We get huge pleasure and pride in introducing our company as one of the leading manufacturers &amp; exporters of Natural Greige Abaca Yarn . We...',-9375,'48d24171-ecf1-48d2-bdea-7e97a2744bb8_upload.jpg','Natural Greige Abaca Yarn',150000,850,'il59r','2024-11-26',150,25,159375,24,15,'KG'),(25,NULL,'We get huge pleasure and pride in introducing our company as one of the leading manufacturers &amp; exporters of Terry Towels . Our products are...',0,'e269823e-225d-49bc-bcc9-493ec9aa7f12_upload.jpg','Terry Towels',292500,500,'l7lhj','2024-11-26',500,17,292500,25,17,'Piece'),(26,NULL,'With the involvement of modish technology, latest machinery and advanced tools in all our processes, we are occupied in offering  Bamboo Bath...',0,'231cadc5-d51f-4c97-b783-4201ca98b355_upload.jpg','Bamboo Bath Towels Wholesale',5670000,900,'t7pho','2024-11-26',6000,5,5670000,25,17,'Piece'),(27,NULL,'Our expert craftsmen design these Bedroom Bed Sheets  from best quality fabrics at our modern machining facility. Our sheets are made available to...',0,'10e7419e-bc0e-437c-ac46-83620c7bb926_upload.jpg','Bedroom Bed Sheets',110250,1050,'kin9i','2024-11-26',100,5,110250,26,15,'Set'),(28,NULL,'We get huge pleasure and pride in introducing our company as one of the leading manufacturers &amp; exporters of Bed Linen . This information...',0,'04e0354d-5b81-4c86-b1f3-93bf5e251dfc_upload.jpg','Bed Linen',945000,300,'xtwu5','2024-11-26',3000,5,945000,26,15,'Meter'),(29,NULL,'Our company is a renowned supplier of Printed Pot Holders . Our offered products are known for their creative designs, easy cleaning, water...',0,'8cfe57c0-f1c0-4f33-98f5-ff26c822e02b_upload.jpg','Printed Pot Holders',78750,150,'sqmyk','2024-11-26',500,5,78750,27,15,'Piece'),(30,NULL,'We are engaged in providing an extensive array of Table Covers . Our products are availed in different of designs and patterns as per the...',-5000,'5a99042a-6707-4597-81b7-5ab098ebbee1_upload.jpg','Table Covers',520000,500,'o5n7m','2024-11-26',1000,5,525000,27,15,'Piece'),(31,NULL,'We are regarded as an established manufacturer and exporter of Nylon Zippers . Available in all size. Production Capacity: 20000 pieces MOQ:...',0,'08d9600b-8227-4b39-88af-833600189493_upload.jpg','Zipper : garment / bags / shoes/home textile / etc.., 3, 5, 6, 8, 9, 10, Nylon, Plastic, Metal',5250,0.2,'hwpjl','2024-11-26',25000,5,5250,29,15,'Piece'),(32,NULL,'We are an efficient producer and exporter of Polyester Viscose Cords . We have constructed a wide and well functional infrastructural unit that...',0,'7167a0dc-c409-4472-b27e-9b74e65c6a64_upload.jpg','Polyester Viscose Cords',210000,40,'li785','2024-11-26',5000,5,210000,29,15,'Meter'),(33,NULL,'Our company is a trustworthy and a secure supplier of Jacquard Ribbon . These products are ideally used for various decorative and packaging...',0,'9fd4d3fd-3c6d-4658-a93d-7ffb730105e7_upload.jpg','Jacquard Ribbon',63000,120,'zqpj6','2024-11-26',500,5,63000,28,15,'Meter'),(34,NULL,'We are an established firm engaged in exporting Natural Abaca Rope . Natural Abaca rope available, ideal for home textiles, bags, and furniture....',0,'65b31b16-df7f-40f0-bd12-dbcbe0d62b8f_upload.jpg','Natural Abaca Rope',672000,60,'45y9o','2024-11-26',10000,12,672000,28,15,'KG'),(35,NULL,'Our company excels in the manufacturing of Recycled Pre &amp; Post Cotton Fiber Process . We offer recycled pre and post-cotton fiber in greige,...',0,'a149ed54-a0a3-4be2-abf0-dd3f086c148b_upload.jpg','Recycled Pre & Post Cotton Fiber Process',3937500,150000,'suxoj','2024-11-26',25,5,3937500,32,17,'Tons'),(36,NULL,'Our company is a trustworthy and a dependable supplier of Organic &amp; Conventional Cotton Fibre . We offer organic and conventional cotton fiber...',0,'c4ef8181-6bf7-479a-845c-4c971d86af7c_upload.jpg','Organic & Conventional Cotton Fibre',6450000,250000,'kxwyl','2024-11-26',20,29,6450000,32,17,'Ton'),(37,NULL,'We are offering our clients a wide variety of Polyester Staple Fibre (tow &amp; tops, common and anti pilling), white or dope dyed (any colors...',0,'9d6a88d5-5121-4b7f-8862-cf97ba35b0c9_upload.jpg','Polyester Staple Fibre PSF',27840000,2000000,'xrz59','2024-11-26',12,16,27840000,31,15,'Kg'),(38,NULL,'Our company is a trustworthy and a secure supplier of Bi-component Fibre waste . We offered these waste in length of 6.35 mm and size will be 3...',0,'3fe5f18b-b102-4525-9e38-b456ed028b1e_upload.jpg','Bi-component Fibre waste',2760000,120,'m8pqs','2024-11-26',20000,15,2760000,31,15,'KG'),(39,NULL,'We are a prominent company offering a wide assortment of PET Chips. Our team develops these products in compliance with industry laid parameters and prevailing market demands. These products can be customized as per',-6000,'105481d2-778c-4f8c-a493-b2212ed565a2_upload.jpg','PET Chips',170000,8000,'6lt4v','2024-11-26',20,10,176000,30,15,'container'),(40,NULL,'Our company is a trustworthy and a dependable supplier of PET Flakes . We can supply this PET Flakes which is use for various purposes like...',0,'cef3fbdf-762d-44aa-8154-bc94589fc63d_upload.jpg','PET Flakes',6300000,3000000,'n7h4r','2024-11-26',2,5,6300000,30,15,'Metric Ton'),(41,NULL,'We are regarded as an established manufacturer and exporter of Leather Fashion Coats for women. Made of fine quality sheep Leather ...',0,'007a7518-2972-4cd9-9414-5be1537cdb7b_upload.jpg','Leather coats : For Women, Plus Size, Breathable, Eco-Friendly',577500,10500,'kksm8','2024-11-26',50,10,577500,35,15,'Picec'),(42,NULL,'We are manufacturer and exporter of Leather Jackets in pure leather material for men and women. MOQ: 200 Pieces Export Market: Western Europe ...',0,'fe529ef2-283f-47fb-a91e-b1e5c42b31c8_upload.jpg','Leather garment : Men, Ladies, Pure leather',1443750,5500,'wn9lm','2024-11-26',250,5,1443750,35,15,'Piece'),(43,NULL,'Our company is a renowned supplier of Microfiber Synthetic Leather is the best material to replace genuine leather used in military, furniture,...',0,'f61236b7-00c1-4e72-b190-d1e52e5ce079_upload.jpg',' Synthetic/Artificial leather : Anti-Mildew,Elastic',682500,650,'sj8n7','2024-11-26',1000,5,682500,34,15,'Meter'),(44,NULL,'Our comapny is leading comapny in wet blue leather manifacturing. We can deliver any parts of the world.Prices are negotiable. If you have any...',0,'88966d64-3e6b-4c5c-bae1-a517f071170f_upload.jpg','Abrasion-Resistant',840000,800,'6unvt','2024-11-26',1000,5,840000,34,15,'Piece'),(45,NULL,'We get huge pleasure and pride in introducing our company as one of the leading manufacturers &amp; exporters of Ladies Stylish Sandal . Roman or...',0,'8936b714-31f8-4f03-94ff-fbfc9aed59fa_upload.jpg','Ladies Stylish Sandal',22000,200,'otntu','2024-11-26',100,10,22000,33,15,'Pairs'),(46,NULL,'Being the reputed domain in this field, our organization is highly dedicated towards offering a distinguished range of Stylish Shoes to our...',0,'837e0510-c5d5-4d95-85aa-5fbc4b90e122_upload.jpg','Stylish Shoes',472500,450,'7xvmz','2024-11-26',1000,5,472500,33,15,'Piece'),(47,NULL,'We are an established firm engaged in exporting Fashion Women Printing Scarf with dots hot. Size: 115 * 175 cm',0,'ad1e9485-ba98-4bd7-9287-87e86e9f7753_upload.jpg','Scarves : 65%viscose+35%polyester , Printed',5880000,700,'jw5r8','2024-11-26',8000,5,5880000,37,15,'Pieces'),(48,NULL,'We are counted in the league of distinguished and renowned manufacturer and exporter of Sustainable Hand Crochet Bags. At present, we are offering bags made from various materials including Woolen,',0,'3b818b63-2d40-4665-84dc-e380c2296006_upload.jpg','Sustainable Hand Crochet Bags Supplier',373750,650,'zrxww','2024-11-26',500,15,373750,37,15,'Piece'),(49,NULL,'We introduce our self as a pioneer in the field of Men Stylish Tie . Our aim is to successfully carry out business relations with all the major...',0,'676e7a2d-d673-45ca-9824-a13b7dfe53cb_upload.jpg','Men Stylish Tie',27500,50,'iqu7q','2024-11-26',500,10,27500,36,17,'Piece'),(50,NULL,'We are a prominent wholesaler &amp; exporter of Men\'s Belt. Material: Hand made Leather belt MOQ: 240 Pieces Production capacity: 25000 Pieces...',0,'79efbf57-bc55-4701-b471-10376dda274b_upload.jpg','HANDMADE LEATHER BELT',131250,500,'y7riy','2024-11-26',250,5,131250,36,14,'Piece');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `sale_date` date DEFAULT NULL,
  `total_price` double NOT NULL,
  `customer_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd94vrikapjd2ews1k4lb71sfg` (`customer_id`),
  KEY `FKkxc13g7l4ioljxqyoo15nh051` (`product_id`),
  CONSTRAINT `FKd94vrikapjd2ews1k4lb71sfg` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `FKkxc13g7l4ioljxqyoo15nh051` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (27,150,150,'2024-10-15',22500,1,4),(28,150,50,'2024-10-15',7500,2,4),(29,900,100,'2024-10-15',90000,3,9),(30,350,50,'2024-10-15',17500,2,6),(31,460,200,'2024-10-15',92000,3,8),(32,350,100,'2024-10-15',35000,3,7),(33,750,100,'2024-10-15',75000,3,13),(34,1000,150,'2024-10-17',150000,2,14);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `product_category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdf169oghv4ymrk63rlxhjed7b` (`product_category_id`),
  CONSTRAINT `FKdf169oghv4ymrk63rlxhjed7b` FOREIGN KEY (`product_category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (2,'Kid\'s Wear',6),(3,'Men\'s Wear',6),(4,'Women\'s Wear',6),(5,'Knitted Fabric',7),(6,'Nonwoven Fabric',7),(7,'Woven Fabric',7),(8,'Blended Yarn',8),(23,'Synthetic/Regenerated Yarn',8),(24,'Natural Yarn',8),(25,'Bathroom Furnishing',9),(26,'Bedroom Furnishing',9),(27,'Kitchen Linen',9),(28,'Packaging Trims & Accessories',10),(29,'Sewing Trims & Accessories',10),(30,'FeedStock',11),(31,'Manmade',11),(32,'Natural',11),(33,'Footwear',12),(34,'Raw & Finished Leather',12),(35,'Leather products',12),(36,'Men\'s Accessories ',13),(37,'Women\'s Accessories ',13);
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `to_do_task`
--

DROP TABLE IF EXISTS `to_do_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `to_do_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `status` enum('COMPLETED','PENDING','RUNNING') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `to_do_task`
--

LOCK TABLES `to_do_task` WRITE;
/*!40000 ALTER TABLE `to_do_task` DISABLE KEYS */;
INSERT INTO `to_do_task` VALUES (32,'make an appointment','PENDING'),(33,'Merying with BMG','PENDING');
/*!40000 ALTER TABLE `to_do_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_logged_out` bit(1) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKj8rfw4x0wjjyibfqq566j4qng` (`user_id`),
  CONSTRAINT `FKj8rfw4x0wjjyibfqq566j4qng` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (60,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3Mjk4NzA0NzUsImV4cCI6MTcyOTk1Njg3NX0.WHJXo580jSv-jJxSNtaTjh0ihu9Nv52k9-sCTuXoC2Fy5LDAY2WFQDedZMO0ZIuj',25),(61,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3Mjk4NzE1MzEsImV4cCI6MTcyOTk1NzkzMX0.u1aO9soC7I9Zp7CqwtX2Du6PbjgjHXHzah2sdDIUt5wkWZjSb2Y4tMHzeCQ3X01h',26),(62,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3Mjk4NzE1NzEsImV4cCI6MTcyOTk1Nzk3MX0.jNv1JNB15bTeCUGK5A0xdDl74bnx3wz8EaTDWX_oyMD6xgLCxT7mxP3bdmx6KBW2',26),(63,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhcm1hbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTcyOTg3MTcxMiwiZXhwIjoxNzI5OTU4MTEyfQ.gVhEVMdv0tYqDBddEjOMs_WjIDKsZ24ykXGZyLrNlePvzZqtNb74C0XHcAvX46zm',27),(64,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhcm1hbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTcyOTg3MTgxMSwiZXhwIjoxNzI5OTU4MjExfQ.RmK-hXPhQLDtsqZ_r6NjxLhV1nJswV8omBLt2AFHSEv5awQef6Dvg8Tt_eULF727',27),(65,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzI5ODcyMDMxLCJleHAiOjE3Mjk5NTg0MzF9.I-qxqdrTjD8d5_K3ZebhZrCo93YP1zJGc7laOsGJvE_a7rRY46Et58wicCbuoWQa',25),(66,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzI5ODczNzI5LCJleHAiOjE3Mjk5NjAxMjl9.SAKwZdZuSRO8eSRTAVmme5NMzMHEPwyn4HjDPBtqF6rhwo1FeR-5fWHfgHkC29tl',25),(67,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIxMzAybmV5YW11bGlzbGFtbmlyb2JAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3Mjk4NzM5NTYsImV4cCI6MTcyOTk2MDM1Nn0.sv-7sVRJPwMsjXImZNilQG1Tgp3J4qRfGB8zxfK8_nmExVrUGQqfw3PqV4CIzLhX',28),(68,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIxMzAybmV5YW11bGlzbGFtbmlyb2JAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3Mjk4NzQwOTYsImV4cCI6MTcyOTk2MDQ5Nn0.w304gTFEjeWIxg8bPtsO2yS1blR9laaLH2jrMEZX64W2pYnMaPxb_K36WjMW2EvI',28),(69,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhcm1hbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTcyOTg3NDEyNiwiZXhwIjoxNzI5OTYwNTI2fQ.nPTHBy4elSu7F9CFZXuxY1Q6pnvQgv-x_xRKLOB1T9clhL1P-Z1tr2GfIK_SedeD',27),(70,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzI5ODc0MTY1LCJleHAiOjE3Mjk5NjA1NjV9.pkZ8LBsQz7hQo20RIiY-f9oSxgyIBRKJnRpQCDoKutF3iccXBqKlj37zhRYVQept',26),(71,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3Mjk4NzQyMDEsImV4cCI6MTcyOTk2MDYwMX0.WfUJypsJOFsYknoLzPtY4LJ8QLiyVntoVXiXiUAhiF_-p5gg4-aAEdJWo3xZN0wS',26),(72,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhcm1hbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTcyOTg3NDU1NCwiZXhwIjoxNzI5OTYwOTU0fQ.xUSLJpiptCq69pe5rtwXQDLgbCe3gh2tgmPliArx0PIGr22-W5Yl9kokIfGOm20u',27),(73,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzI5ODc0NjY4LCJleHAiOjE3Mjk5NjEwNjh9.Rb37gx3jNmVyAblUJKiPWGhDTRh6tpZ8tTuvLThyobJH4oDvTnET7_BakEnPwqEh',25),(74,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMTUyNDMxLCJleHAiOjE3MzEyMzg4MzF9.XYc1EY5MnWiv1g-si1a94nX1wDfh3rQF_H2n-SLqXLtDsSbD56v6tdQcBYgUnPcD',25),(75,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMjQwMTgyLCJleHAiOjE3MzEzMjY1ODJ9.MfOf0vT5Lrp-F-aIwY0oidF_Af9jldfX7zae0O5Hb7V2AIpoZIOHFmqGtei0EOEp',25),(76,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzEyNDI5MTcsImV4cCI6MTczMTMyOTMxN30.pO7a9IUCOVuDDijpyHjrDzHu3WsfKctC6cCSw1nG57QCiG3YXR1JpmN3olK5QYQD',26),(77,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMjQyOTYwLCJleHAiOjE3MzEzMjkzNjB9.uaBrEC5VUzqmr4kmY6bj04EHLzps3UktaRov0eVcxXWcYF4flfna78nV82DEY1hA',25),(78,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMjcxNjA3LCJleHAiOjE3MzEzNTgwMDd9.2w-Sui-5WVhv09PQ84SkLtHVEC8Xa42540-kE3HxGKyZhdT8trYhDVBIGrCulsa7',25),(79,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMjcxNjA4LCJleHAiOjE3MzEzNTgwMDh9.JoEaQnwID32TmminBJoBR6kjVn-nUp21FLiIvrHgkihQ_YlUdEN32Ted8G8bN3n3',25),(80,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMjcyMjg2LCJleHAiOjE3MzEzNTg2ODZ9.wqraoF7PwMfLfBozJwqBAxn7k0qkjZ9k6BRhx7e8M_TVvGLWW6cXkpYd4zOU9pyf',25),(81,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMzQzMTY1LCJleHAiOjE3MzE0Mjk1NjV9.DcxJV7mXNYPKPi313gIRG54Vz1sq71U37WXKGdjd2Vs2COR12Hsbb0iOeLAlT-nv',25),(82,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMzQzMjExLCJleHAiOjE3MzE0Mjk2MTF9.c2E7vpQ3USIPzgUPUhTmZWiMMuoK_iJwzspmqozEDJ5lHsEVQHIB-EYQVeev29lR',25),(83,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMzQ2MjYzLCJleHAiOjE3MzE0MzI2NjN9.jEG2T6rzi_IpCkhLl8zik0cPWUkKfcgi68XpCFuF3qLNd-nouTVUdispOce37laG',25),(84,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMzQ3MTE2LCJleHAiOjE3MzE0MzM1MTZ9.XWt7V9sviJaqWfJ4zLYUmVmYCKQ7GFBvN_cmV7A19H_NpV0DV7DzsZm39IL2fdBO',25),(104,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMzU3NDY5LCJleHAiOjE3MzE0NDM4Njl9.85r8P8h03wCdfOQ_2Tb-nUcuqUwNRh3FkIjQmVugROSbiz7cNxIns6ZoMRmi7P1o',25),(105,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxMzU3NjU4LCJleHAiOjE3MzE0NDQwNTh9.MJuNBbz8XimBTQRbCF5cHxzNz3eIQE7wz2QQRU_md7fBsIYRCv66bgS-mCS3POU8',25),(106,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXNpbUBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTczMTQyNDk5NSwiZXhwIjoxNzMxNTExMzk1fQ.Y3IFHmTeZUR7_xFD6w4o4JAsdA6Ov18BKCfNL3IQ-rQ8d37wvcWlfc-OYv4268iy',45),(107,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXNpbUBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTczMTQyNTE4OSwiZXhwIjoxNzMxNTExNTg5fQ.ESQPPmZdH02zzkK6WcDNZ3nYYWxUqsQMDxri7IUMyo31NUHc2IWPuRkJgTvwhyMj',45),(108,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXNpbUBnbWFpbC5jb20iLCJyb2xlIjoiQURNSU4iLCJpYXQiOjE3MzE0MjUyNTUsImV4cCI6MTczMTUxMTY1NX0.kwSuvei0rK2B8PyaEQxnjGgLzfDqK4hu8VD_pZmHqOJPMKEU1xSde_3RifnHQyV_',45),(109,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxNDI2NzkxLCJleHAiOjE3MzE1MTMxOTF9.hvrxueHxKNcw0MVyZhn5pT9RQwj4jxJxVrFxbs1A_wFpGCvBmVXp4ZfZK47OZ192',25),(110,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxNDMwMzc0LCJleHAiOjE3MzE1MTY3NzR9.G0kmuZnxqQKMsk3C_M00ITy1GodkJ6VRwoKdKZPnA4I-G6LH6D4giTlkHzXcVog2',25),(111,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxNDMxODMzLCJleHAiOjE3MzE1MTgyMzN9.S43n3hks2LklSb8DFJmhLF3wqdWfaTkXjlFiavPNu0jaUmpBoXItOvwWLnF9zbOr',25),(112,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJyYWp1QGdtYWlsLmNvbSIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNzMxNDQ2Mjg0LCJleHAiOjE3MzE1MzI2ODR9.T85KbDu9SSWnJxfY1CQeWsTd3cTcs0vXq_sYHCF0myREq0KY_c5ugIQa1H4fAYna',46),(113,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXNpZkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTczMTQ0OTEwNCwiZXhwIjoxNzMxNTM1NTA0fQ.qZf61Wbyust_0-IwQaBLd_dxSvjFH9JNvZi2Y63xSNWWIU3DC0kgoJmyywNx-SOv',47),(114,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJmd2VrbWVmZm1AYmhiLmprbmRzIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzE0NDkyMDEsImV4cCI6MTczMTUzNTYwMX0.hMPpLsV-NQFzJ3uxe6WmpNPvCwn11Ta1YaPDhOwitaZGUx-htojcXwTTbVfUVHfZ',48),(115,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxNDQ5MjY1LCJleHAiOjE3MzE1MzU2NjV9.lwJj_xZ_0PehOrQjYI9lPM2oL3dYlhszyP4zq4Ml8MWaEzd9G_WVGRx_bS0UQX3e',25),(116,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxNDUzMTI5LCJleHAiOjE3MzE1Mzk1Mjl9.7ymOi-tVbI5KJL7JGkaUIZiaLqOK6d126i0VymxO7pFCv4dkePfQs3zU0m27yW0H',25),(117,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMxNTEwMDcwLCJleHAiOjE3MzE1OTY0NzB9.mE82xuDABQBwJB3IOBDygfX4WbnflDUpEmoHNeAhBCwbkMhfcY2npkPdQXEm5txm',25),(118,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMDM1MjU2LCJleHAiOjE3MzIxMjE2NTZ9.ZVZzZ7maFr9E3O7hljmw9rW_T6gq9_PRAh4vkQtK36WuN_KEkjGCo01FjiUhvLh9',25),(119,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMDUyMTU3LCJleHAiOjE3MzIxMzg1NTd9.BT_4ZvWK9PO_QiCwHYHW9fuz6mdhsckT6DiOLTGWSFOpBdU5GCs2krKWQavUoKzC',25),(120,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMDU1MDIyLCJleHAiOjE3MzIxNDE0MjJ9.hdC0okJVd1rS3yPNTKQlx8X-7Znc3x4vDyOX8GzedgbVziq8rodVBOAEwcBzfmI0',25),(121,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMDU1NzQ4LCJleHAiOjE3MzIxNDIxNDh9.h4CRvRVWYoaxQMz7MuyqOfqBzZiciRgdub_7xiIvxdPp-ix_1YtCgsEw4j4jdYtU',25),(122,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMDU3MTYxLCJleHAiOjE3MzIxNDM1NjF9.hRYy-vbSxb1g_6lRmMbOT6lqJWE-aUnwrzjEbw-PmNtSmnKKm6ZfBBHfv9MlIc46',25),(123,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMDYxMDM4LCJleHAiOjE3MzIxNDc0Mzh9.1PqcqZUQrmizQitfH9u4yQobLoFfEti1z-fk20U1Kw9YEpJQdqChH8a90EYO3T0-',25),(124,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTI2NDI1LCJleHAiOjE3MzIyMTI4MjV9.uaS8ZZ93LZbrTsBxk3iXYBiaU8SphY3da8vcVUB5Isgpz9xi9la_1g-ZzfPY2_pl',25),(125,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTM1MDY4LCJleHAiOjE3MzIyMjE0Njh9.pUNpfBq56h-AcJiVxC8aus8c2crAl69U5KsnUCfqEEHDRcBQUctNUIdG4HdTa6IY',25),(126,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTM1ODE0LCJleHAiOjE3MzIyMjIyMTR9.anzZM_yCzT5vE6f792khmUC253RS5CT31VbqnuQ6XJUTux4FZg3HyzKDyXNVy1NK',25),(127,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTQxMTQ4LCJleHAiOjE3MzIyMjc1NDh9.tMy0sn07RYOgvK04_j6saKV0UBqmVzc1E_JkXFJj0NmN3L8NTqYDz7kd49poa5wU',25),(128,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTQxNDA1LCJleHAiOjE3MzIyMjc4MDV9.2lnS-UwZ36tvHF3K1PLrHW5zYSJwK1tQijsBjmEAnmgotq9vwGKJ8yGtwVEf9QKR',25),(129,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTQyMDY5LCJleHAiOjE3MzIyMjg0Njl9.IZ3uRyD0S7PJavlMDFz0Fv2Gxlg3bImfI4Pvp6DHVbatxSJ1LYTtWpMG2o7lumU2',25),(130,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTQzNTIwLCJleHAiOjE3MzIyMjk5MjB9.Q-Bxk1JWer9uCck1dh-tIPzTN6MzOPmsG3IABcqjf8pnAQDKSAEq5nWmNLSs_st8',25),(131,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMTQ0MTU3LCJleHAiOjE3MzIyMzA1NTd9.fvJgozGMuBhaIgScicmIlSPMq3G0nqdgoq7r3Q6JQNIWfUkJFIJKg0M_uUfnr8dm',25),(132,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMjEzNTYyLCJleHAiOjE3MzIyOTk5NjJ9.Iko3HvP34NidwDzWX6KdyC2l6lOYaReAThwLLpZwwrohN4oYxBfPhw9p0k85xhY2',25),(133,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzIyMzI1NTcsImV4cCI6MTczMjMxODk1N30.HDK01Ob0qFltVu8RoVt0xzPEhAz0AtPVu_SsOBzOcjl74ZiTeIt5WfzmDqs3P3my',26),(134,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzIyMzI3NjksImV4cCI6MTczMjMxOTE2OX0.30BPnYrNgdLo3AR0wqbtStW-nRb1b2U5_dAbjm505tsAMyFfUle7mIkOttLT1190',26),(135,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzIyMzMxNjgsImV4cCI6MTczMjMxOTU2OH0.5zsJBAf6GIakbbOaQutB5LwGb34D1tMFbe5vvAgk2jrld6tiNPQHSUELNwsw7CnT',26),(136,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzIyMzM3NTcsImV4cCI6MTczMjMyMDE1N30.0mfh-3Rn1QJwVqd1203wpgMN-K1TA9_8m0MoxH_0UHWqoQsImhngZxD4mvlDT2J-',26),(137,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzIyMzQwNTcsImV4cCI6MTczMjMyMDQ1N30.sXNFpm6pvNTCWhr_fjAOP3y2RE7EIHmuX6m-NWmO2kSHDzHBcoAZ-pZH03mLrgEQ',26),(138,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhcm1hbkBnbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTczMjIzNDQzNywiZXhwIjoxNzMyMzIwODM3fQ.nTrkK3QC_yPFSDMZKlIBI3v4AUg_X45Vza-vjDxUgvHATXvCgxIGeriZuQA0bdoV',27),(139,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMjM0NDczLCJleHAiOjE3MzIzMjA4NzN9.iBMfdnkUHcwY--xSPXTPV80NRSz328qoprGE4ktOTyx4jnezGdNBRYIv2U4xuJhd',25),(140,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMjk2MTgwLCJleHAiOjE3MzIzODI1ODB9.OrHocI8ttCAviEca8HycVMwmsqtd5dIYUPxhU87kWLVm4hxVMrxjnWSqNnYSI74b',25),(141,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzA2OTk2LCJleHAiOjE3MzIzOTMzOTZ9.hWulNrXP6wk-rUYqAD5C37kklWmOBKcf4rVVGIvlbNSx5mMpgkMbJfNfB1NPisE0',25),(142,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzA3NjQxLCJleHAiOjE3MzIzOTQwNDF9.siuFE5vOdRcvLfGntblusObiu_FbsHt-jjFripq8TEEnKZg8QcbZuGyaxSQfsN5k',25),(143,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzEwNzkzLCJleHAiOjE3MzIzOTcxOTN9.LNStlCSdhZn9OJxHHtZW_DyEeqasSiBFJY4hfHtGuWaWmVTdGbsQ_CExo8CHLNfH',25),(144,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzEwODQxLCJleHAiOjE3MzIzOTcyNDF9.XBRqE1e3mq7FruLBllyHh1u_z_5KFDX3CUC3FDXVT_4-wVK8PRQ3-g6H1mPH7xsF',25),(145,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzEwOTczLCJleHAiOjE3MzIzOTczNzN9.ci_jy8-zjMgnB4dL-o9hupZ7IFdDU9z608AwyKpM4hU0Ud_kWyHA_vBLFw_XwQ7F',25),(146,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzExMjAyLCJleHAiOjE3MzIzOTc2MDJ9.lwgGiBZJZDExUEOl5kdzjmDYI99jgOcrfEMP6HLA8RCNuyLBOxCArBPYojmBd9rI',25),(147,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzExMjg1LCJleHAiOjE3MzIzOTc2ODV9.7nyWmWN_brAVBA80IeiERwTCFz6ZmrhRT74I6krWM3iX1sd8EljOCtaIpdtxJciy',25),(148,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzExNDAyLCJleHAiOjE3MzIzOTc4MDJ9.3D504UbcN6FjUcQ2DDVKkTlcNKNSNMBuJ7xJX7uvohCd6i_J4HbSd1MqSn_iCnU_',25),(149,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzEyNzExLCJleHAiOjE3MzIzOTkxMTF9.m2WtvhXwwYsf51R8FWi-PUksCFw1N5vm5lLA7QqFa5FouNAdtG2Eu0l_k6bzkf8i',25),(150,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzEyOTY5LCJleHAiOjE3MzIzOTkzNjl9.uRyNFW6AMDlpd-EI5Hvc3O6RMldw-nQ7HtA3iHjVE70g1lFvpm3FhoWp1ThMx_VT',25),(151,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXNpbUBnbWFpbC5jb20iLCJyb2xlIjoiQURNSU4iLCJpYXQiOjE3MzIzMTM1OTIsImV4cCI6MTczMjM5OTk5Mn0.Q99mNJBiVUFwxRoDSIrDS-20VCEVTY9WIZeFiq2JfeyqeSt1zcxOM4GTMZJKiBIT',45),(152,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzEzOTI5LCJleHAiOjE3MzI0MDAzMjl9.Tls9nZEkeUCQj4gsX0xXC_dV3xJ7HHtfu6K_jj7MRymScvyDIHafn24eVPyB9JbB',25),(153,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgxMDg2LCJleHAiOjE3MzI0Njc0ODZ9.Almf59DYqgI-65q_bPPcLZOU56l0Nkz_4pq6Foa23DAl0YYs3wkBPp_36rhZnatj',25),(154,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgxMTMzLCJleHAiOjE3MzI0Njc1MzN9.4R08CHAIYwnvvY9CJskeghPBZGBPbRb1KkQF3mJlZAPYJXkuWRuoRt7mYLMvyk73',25),(155,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgxMzM3LCJleHAiOjE3MzI0Njc3Mzd9.Xu9920altRSwkSEaXcNkbPcl6iipN0sarqzAkFUPiUQnifDLfrOtgGGNZBWjpsZ8',25),(156,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgxMzYyLCJleHAiOjE3MzI0Njc3NjJ9.RVuVXf8p1VjyUOb6Qfm-FpywgSten4_k7YDWBa5xnrecyUyA5rh4bPmezc1b74Uw',25),(157,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgyMzI3LCJleHAiOjE3MzI0Njg3Mjd9.OWf1h-2-ZrHZGforLLpbbp7hLA5VmRrKcW67SyaS0-9-_1Uo9li0fnGk-ZMyBvXp',25),(158,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgyNDAwLCJleHAiOjE3MzI0Njg4MDB9.GfbJTDhsG_yQNltQvIh24Q-sRyN6fUmRYvl1sy_4epUlCYfrw3GWk1Cw4BAI-D_s',25),(159,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzIzODI1MTIsImV4cCI6MTczMjQ2ODkxMn0.Ct03Kya9qJwD-VXA2SuRlIonmIWuDiK3t3BP6ZZOLuo_QzzjZihAk0rVgp-qOUAd',26),(160,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIxMzAybmV5YW11bGlzbGFtbmlyb2JAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyMzgyNTMxLCJleHAiOjE3MzI0Njg5MzF9.TRKqjqpp23zrT1F585anJIii1AUPckSxOY9bHGn9E0yxQbfhbfujFHvsjifd3l8g',28),(161,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Njc4MDksImV4cCI6MTczMjU1NDIwOX0.z_Z3DlOGhCUHNawuO3sVS_eYeCL46J_QfC7j_8sR17OLJJRh8Wo1q3FpLfLicZJl',26),(162,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Njc4MzgsImV4cCI6MTczMjU1NDIzOH0.R6jihtWcxj0S851xIwBoAJbEmAFMlISMWRlU0MLRGISyjsDtqqVMUfu2aK67yXkj',26),(163,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Njc5NTAsImV4cCI6MTczMjU1NDM1MH0.r0EyIDmTNfawLedWsruRiOsl8O8cEvF3TgXjjrrbevo3XLC4Is6JpXN_ZK9L9ZZZ',26),(164,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Njg5MDAsImV4cCI6MTczMjU1NTMwMH0.cXr5ZLzQAOXN-SIymuq3I1_yNWn_dMGKAaLkrcA1k5Pzhp95aZd01BZtPlr4iKUW',26),(165,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzAxNzQsImV4cCI6MTczMjU1NjU3NH0.TomWer1SbZH2B9Jg7yFU_af6S2yxD5Pm8rBcBfDzqOv5LZijFJglQ13zj8gS53ve',26),(166,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzE1MjAsImV4cCI6MTczMjU1NzkyMH0.019ZORZumy7DyZkHi2xtGzHxu8Q1ikNOYxIZ0jFGHpEsBt043rHROCs6tJG9Pa7F',26),(167,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzE5NjUsImV4cCI6MTczMjU1ODM2NX0.cqAj_wpW4unnQeVa7LzBWk3BfWRCzTE--4LmLHoP0TI4FqmtzFqSTDs9URedw0eL',26),(168,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzIxMjksImV4cCI6MTczMjU1ODUyOX0.GwEMwiErRnfNHLuhq82yL3TnQRIGjkQiglXagZXU_ZXm0qiqYVRjB8zSxf-Qj-KG',26),(169,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzIxNjUsImV4cCI6MTczMjU1ODU2NX0.HaROhkWguCf0oIiIA-cAfNbsGCB4i-6DLkKq25N_ct8dvjwbsjHfbUNc_DzQ4z_F',26),(170,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzIzMTUsImV4cCI6MTczMjU1ODcxNX0.itEjEaHwRX56b90iJbh9Daiw9b77I4OAQwjRnPou95nW8LVt5UfawujdbQMCQmN3',26),(171,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzIzNDMsImV4cCI6MTczMjU1ODc0M30.oecIOZsQfHZRPjE2Tb27A6RMXzQSvdNb8UZDYn2XOb1IgZufBYfJwBLvM8Dk5nN_',26),(172,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzIzNzYsImV4cCI6MTczMjU1ODc3Nn0.wkEWTdQxOju6UL2KT3cZPZrSIAPn2PjFDfaMkRykB_QOOqV-aVrZzlBfJPxTTgae',26),(173,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzIzOTAsImV4cCI6MTczMjU1ODc5MH0.MeVcb3Dje9MaMhY0b--NmzeUuBoIKiCtsqfpPgpJiM34Nuh3R7b0f9dVmqvVSIQt',26),(174,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzI0MTUsImV4cCI6MTczMjU1ODgxNX0.bH7pZ0p7AsUhfqh9UpKQm-F5GIY1gwlVwQn8Nb9JHxX3FdZLza8sJwLeg_SnNfhf',26),(175,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzI0NTAsImV4cCI6MTczMjU1ODg1MH0.QkpKmjjaJ76Cphgzlq54cx1LyOmO0-WVJBhP1rhp8M6b8MCuHNaWq3V7SLbPCQEW',26),(176,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzI0ODcsImV4cCI6MTczMjU1ODg4N30.VgekrBEQM8oSMfCbim5CeZX33KcwaEwGBqHEl8YRPuDfsjiEmvZYoJSdFBno3PBr',26),(177,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzI2OTEsImV4cCI6MTczMjU1OTA5MX0.PgTzOftOHSV--sGeY8j8gR0C1kjv7Rnz_1h4Lam3GZ0ryrVh9BpIEAtYaiGe67va',26),(178,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzI3OTMsImV4cCI6MTczMjU1OTE5M30.LOuw7iMJJBtwuzxNguAD8VG6u-wvkF6XIjsg_cMYkBZb1M9riJ0otEZfezctPC67',26),(179,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzI5ODMsImV4cCI6MTczMjU1OTM4M30.dhKnAS-m3-pHN1s5XOYyg1xWwj-yp5P9y_4YJEeN-hCrqWl97hlERrczUC4844Vt',26),(180,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzMwMjQsImV4cCI6MTczMjU1OTQyNH0.fq3kbwlJNaP24ExcYSogIDRnCFUwcBPdsbNMK52Jqp0kyl1caaYO_8cyoKiIOSj4',26),(181,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzMyNTgsImV4cCI6MTczMjU1OTY1OH0.Gkc4vr1sdsee4fA9QHdJJeyYYoVKYsNQiKruwhrikyAADnVLzVC_lvg68U3JADOa',26),(182,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzQ4MjQsImV4cCI6MTczMjU2MTIyNH0.JNAJrXkB0nFsVoBpEzxS9689BwJi0aEKFi5bMfcLhpRwV6dELabLr9FOmy_44bCg',26),(183,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzQ4NDcsImV4cCI6MTczMjU2MTI0N30.TY9mtiI2_0xymvlg5d6Jf_bBDSIj1WEOaRYWh1bp2lVJZkxgmFg63KSKAMCfG7n8',26),(184,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzUyMDUsImV4cCI6MTczMjU2MTYwNX0.J3pJhNSNRYTKA4Kn4cmlMBw3dGNm8PhJmk_G8332bfCXK7YTeGpsTezrasoCMJhO',26),(185,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzUzNDQsImV4cCI6MTczMjU2MTc0NH0.RCgyD32lKjE2p_3hLx7JFwunS3uO9cOaLLGsVEXcJFmPZWmWVYopaPR5UtoSNuvb',26),(186,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDc1NjM2LCJleHAiOjE3MzI1NjIwMzZ9.30oN5cc71S2EBGjdGVhXkyYUoA66936NE8csoxR9aToA7M_52JFrxc1B82LGhdoZ',25),(187,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzU5MTAsImV4cCI6MTczMjU2MjMxMH0.sjtXFXnj0LM8sdyUaohcchMFBVZ6NiEs1IPwahN5N_hyB54cAGmthShAnv6SqUoY',26),(188,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzYwNDUsImV4cCI6MTczMjU2MjQ0NX0.Yu134LDHs7M6FIeOdxsqY9zU5CDn3FMaDIibd4cHno5WwouWTsUraLI4Cqc90nIM',26),(189,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzY0NjEsImV4cCI6MTczMjU2Mjg2MX0.kzR0M-uAslBwW-bTiPTP-2GVftesQCOnEQLzczjowhYxMHRquHV1DZtZlxDYh5js',26),(190,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzY1MjUsImV4cCI6MTczMjU2MjkyNX0.alYSw-fzUVXFU9VNX5sad2G9myNwQh3d-AmE-aBqcbDjOVZJ6W_AT5kZBhl3Wzkz',26),(191,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzY3MTYsImV4cCI6MTczMjU2MzExNn0.v7fPkt30qrPIh6qKvnKKS8MKHAUoDPU1IiixHj7sqUxD3REIACByB6RXVrYOsWe7',26),(192,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzcyNzksImV4cCI6MTczMjU2MzY3OX0.Hv4AYFw6f17lYJpnCHHfO9RuH6nuRT1PO3NKMP5Ia_elW4-qfpnqDOVFo2mU4MmB',26),(193,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzczMDksImV4cCI6MTczMjU2MzcwOX0.UJ_DtxDqKYpbGeZWNDqzs1EHHIrSeA31hoYrqlnYZNFuoRKSCVPpJB8PlsSjAPyp',26),(194,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Nzc2NTEsImV4cCI6MTczMjU2NDA1MX0.buc9Ossv8yfHpfXmM00sUaDVkLLDNEdPN6TOpDtEpmozMJTH_8uACOosH_Sfl_-N',26),(195,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Nzc4MzUsImV4cCI6MTczMjU2NDIzNX0._DirZCCF3RXrLIRzH9Ff5BdJLQr4Cw-oT8qYjd6CKJ8IntbJaCrV60aHlTJSq4s9',26),(196,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDc3OTQ1LCJleHAiOjE3MzI1NjQzNDV9.Kl2-T5ZqnGZ4rHX2QwaGnqSYNGA5BCbuWjw3lK-iQP25UItY73nP_ED9EjfIl551',25),(197,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzgxMzgsImV4cCI6MTczMjU2NDUzOH0.6ARdHO0FZ5J1krNHkDxvtbWebbRquMQ0s3P3dCtlV-6AX77gj-Vut_1atlSIQ25x',26),(198,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDc4MTg4LCJleHAiOjE3MzI1NjQ1ODh9.id_W95_s42sG68sg0oGBoGnPqVnRZzxXBXuzugYMyVjd2vSK4_579oyWxY_pfpWY',25),(199,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzgyOTUsImV4cCI6MTczMjU2NDY5NX0.PC2t_vSI4SFk53VzxvxObpQs9arPAukSDFxWauyXKKPOcjZiFo_IKiIFh27kBTTN',26),(200,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDc4MzE5LCJleHAiOjE3MzI1NjQ3MTl9.MsTE2WO_rT-R4ONcEN_dtfHkTpQBrbUfD6go92D3s22JP8un38p0W03FSfhaujLs',25),(201,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDc4Mzc5LCJleHAiOjE3MzI1NjQ3Nzl9.O3tG6CNze19pb8VDsCWxZ3awbye4gzpu6_dg7M_5wkgOvaelHKtKrI2j0YLP_RqM',25),(202,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzgzOTcsImV4cCI6MTczMjU2NDc5N30.w2ESzBz9ik5GcHbgbU4NW3_0J0UQs3o6Uf73N9fGOHnKR0MJi5h-T7_Xv109pRqb',26),(203,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Nzg0NTksImV4cCI6MTczMjU2NDg1OX0.Crqn2KLLRySKAgYZLcFKZ2L1fM68ClR4Xal054KGpERNzowWCIqjmlKE1jZc8kxR',26),(204,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDc4NzI0LCJleHAiOjE3MzI1NjUxMjR9.p2NWmkjicYlqpikNUYWM40Mu4tAmxZweWUXeN2v4CquahDpUTwMo3UPD_Q0o409v',25),(205,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Nzg3ODUsImV4cCI6MTczMjU2NTE4NX0.HJtUQP2fo_nPe3zT3YU2f8KhIZcAzjca40PWL82zdr-0Zlt7FXtRM8-CZHFwXMfV',26),(206,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Nzg4NzAsImV4cCI6MTczMjU2NTI3MH0._-bBbbrRzxm_JsoUbgT-aaPM0vSga8EGAYOCeklTgf0Bg6NaLLqtz2sS-ANzbe4_',26),(207,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzkyMDEsImV4cCI6MTczMjU2NTYwMX0.YKaQshevMwkqOhynZ5O1RDR0uczvBWhR7jlqCo8ttnGQXtNF3-wrEU_RRvaSYh6g',26),(208,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzkyMDEsImV4cCI6MTczMjU2NTYwMX0.YKaQshevMwkqOhynZ5O1RDR0uczvBWhR7jlqCo8ttnGQXtNF3-wrEU_RRvaSYh6g',26),(209,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0NzkyMTcsImV4cCI6MTczMjU2NTYxN30.A2SgCCOBtxXKWqzuvnxXz3hjy4hMGC9hNk_hhRpEwnbH-Wyxk3wIW-s6CebXcLiB',26),(210,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0Nzk5OTUsImV4cCI6MTczMjU2NjM5NX0.JH2rE6wQC5wv6UlDm8SkavzCHGvlM8hNWYXzX9V4mUh6elmEDiqYa4yfg9FA1BYO',26),(211,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODAwMTMsImV4cCI6MTczMjU2NjQxM30.hFV1ZiSkPi-vABPR8-BAId9jTjrPmG6lt2oGOtl-RoGkPtnSI1lqRLRYG0OmCfo4',26),(212,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODAyNzIsImV4cCI6MTczMjU2NjY3Mn0.d6l9tvBxZegrRWqPpIn6gDspuFKKjqLkvSEkRi_kcuDGzq0uc1zSB3usNxrXzs2e',26),(213,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODAzMTUsImV4cCI6MTczMjU2NjcxNX0.tIOE6Nz3RnQ2dLKJcXDQszOSarfaotzN_EAGCJNFYgnDzBNvULKK7zXALRoNJ_rR',26),(214,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODAzNDcsImV4cCI6MTczMjU2Njc0N30.MpVQijjYfoFyej3xjN6WoQ50N5wthau9PxkA39eSXcEiVhEQN9VdECyFtOuU86r5',26),(215,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODAzNTUsImV4cCI6MTczMjU2Njc1NX0.4dsoCEpq12XTtgQqO7ptjQHNCT7lixeMBzdFRK6edm67UccuokHCRKY2sUY6RnEU',26),(216,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDgwNDIwLCJleHAiOjE3MzI1NjY4MjB9.6H4d47b29IWVeTD-kAqE9bRVGA89zQO_87-bUDkddku4pzJGiv1rBoyg5OeQLb8d',25),(217,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODA3OTYsImV4cCI6MTczMjU2NzE5Nn0.BxEUq3V-vn2h5UlDjbtBSnKparPhpDZw-r9Lusba7KsCybj_9RfiOqfWToS6GFPD',26),(218,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODE1ODgsImV4cCI6MTczMjU2Nzk4OH0.Dlir00FgBy9aHWY2WLsfhUJXjYhkVYtw5XeJsZ6cQFAUjTnPRKcc4sZ_G_MYhZxW',26),(219,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODE2NDUsImV4cCI6MTczMjU2ODA0NX0.UGqKh8Vhpl9nEvvpGqIbvkQ7mhEfj55JzbU70oUiCdZ9AfsvgTFTxHK01SleE0Za',26),(220,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDgxNzQyLCJleHAiOjE3MzI1NjgxNDJ9.m1KK6v-KWSUpH8sr7jibN3qhcAjogwbKeXqrHD528cWXKXDYaNjxUZ00znZU9LgF',25),(221,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODE3NzcsImV4cCI6MTczMjU2ODE3N30.Yep6XOIsUFQ2tws8VCo382mir2UFbeQxyDbLY1vDUKNIr6eKveDf6tyss-Q509un',26),(222,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODE4MTksImV4cCI6MTczMjU2ODIxOX0.BAbZbjGE_E_qvC6--KX6yw1eXPtwY3skBzumYM-4ZffXA4oDtsEMLM6UH0Vd2Kyj',26),(223,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI0ODIxMTgsImV4cCI6MTczMjU2ODUxOH0.BVYR3hDdFDneZNyn7wEuukjnjwONZyA2CvcLomCrUidDwW5k7eSoDuCy4CfxqhBt',26),(224,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNDgyMTMzLCJleHAiOjE3MzI1Njg1MzN9.d_QRb67Vr_ZTrwrZH1a4FhHJgj_6cMxkhdGsZAFslNGH7udhvCLI9VOC7T2j8OMO',25),(225,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ4NDIyLCJleHAiOjE3MzI2MzQ4MjJ9.JEUVBAb-XhQz_CJ92bzWuywGKhXpdP6H9NYRRnW9NTNu7lws9ezxzg6S-kW7VpYW',25),(226,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ4NDQwLCJleHAiOjE3MzI2MzQ4NDB9.daoq2-Fai7NB-as51eknLJuA-S1m0tQHVUDU9CH5EDr8dG27XIKTwesL2vAtWnz5',25),(227,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ4NDY5LCJleHAiOjE3MzI2MzQ4Njl9.TiaJbPXDfjO-_wsiRnMx2KTt1wThp0s8qvpUZUQd44ojAFQbiP8VfcCRuPWfa9Il',25),(228,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5MDc3LCJleHAiOjE3MzI2MzU0Nzd9.MgL5VLazVlEyPJbxUcZa030sPNOkrwQjYtLfNVyjSuNtVc9qA4QXt8f9q4J0OXL0',25),(229,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5MjQzLCJleHAiOjE3MzI2MzU2NDN9.wVfghTEaYI3hIv0OZGi8ZhznxfP1ukokgmCB9SSLRk-NLEbVVITism2l4HDhOmrG',25),(230,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5Mjc0LCJleHAiOjE3MzI2MzU2NzR9._dz2-BJx1Hr_QxMoSixCcG2E9hfi58vypQd_rQbWMnApwsk2NKZYYcQyUlcq9Dxc',25),(231,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5NDAxLCJleHAiOjE3MzI2MzU4MDF9.w_TP1hQXYxsCvZbYHf_R-HlR_-UaqnESRhaXWmGPnC0VS6sJjvuqHhVX6NEPd5TQ',25),(232,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5NDY4LCJleHAiOjE3MzI2MzU4Njh9.Fjzqn0pBct1Rw3NnFw3663UKZzaQNg4L1klG_4G5JurlGrGJkbDSPuULLnoINfWQ',25),(233,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5NTg0LCJleHAiOjE3MzI2MzU5ODR9.PErI41Y1bBFvv9lJFJnx6gZJJck5nCZtmb0tGhLSzH6FgL-T9SJmySOsyoCELPzi',25),(234,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5ODUxLCJleHAiOjE3MzI2MzYyNTF9.6AVKe7MdEQnc1mLgG642_oIhn7gRcbrn3LXbicE0nkWoTtkn-XojjC6drMMgktX-',25),(235,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTQ5ODk4LCJleHAiOjE3MzI2MzYyOTh9.1VdFTj0joNpD48Pl8StZmW4cp7d9775Po_IY_THrXfqOcVhFyF-rUidoXdcic8J-',25),(236,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwMTQ1LCJleHAiOjE3MzI2MzY1NDV9.FWviwtSjd4z5sFxOonR6eptu-rEYO2QU8LemIx82n5-ju49edIXrB3XzSxXDAsSx',25),(237,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwMTY0LCJleHAiOjE3MzI2MzY1NjR9.ENP1I1jlkZiRH9G56Dy-yOaPYU3zWC2B8I_Ticb9MZ5JaNoaa4caxcjL2LCduCu-',25),(238,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwNDE4LCJleHAiOjE3MzI2MzY4MTh9.AuLDuHrqBydGO9CqWCO6NiAz2JkKwxDJlO91SQVl5sFTNw-qNjuzZW9kD4VNfLc8',25),(239,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwNzUzLCJleHAiOjE3MzI2MzcxNTN9.CwiSgrSzkvec9DoeeuS-AaUUYGuBy6QNgVcwkMYdvtWiWKVTkuE_c0jZtmuLwTC8',25),(240,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwNzgxLCJleHAiOjE3MzI2MzcxODF9.kOpMca6RrmkVRDb7qecTAmopHRvfiBBZLcbNsrEdgdeEt03gwuAdTbjcT4vbkKL9',25),(241,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwODA4LCJleHAiOjE3MzI2MzcyMDh9.rLN9FR7FtS4fZ5G3oO9SMVafwmCzwO0V7-dS1FXligyaVKRoPM8cJIvAwhpHVU_z',25),(242,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUwODM0LCJleHAiOjE3MzI2MzcyMzR9.UIb0mcS27XzzYYZjTNQUIxtf6TtohrI1yH82zFs6buq0ryWnziaKvjbdXh21gVef',25),(243,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxNDQwLCJleHAiOjE3MzI2Mzc4NDB9.dHRcrAnt4YCgfFoYSKnd_MwNxLhpGikSBLKvcJ7wVtHcMfDahmFlo2BpV4v59okd',25),(244,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxNDg1LCJleHAiOjE3MzI2Mzc4ODV9.ep5_FJyvn4EkyAiIBVWhD4Ref6hHpOwb4ahEYGeigm9hwjfV-fUiXPMTrM5IY79f',25),(245,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxNTE3LCJleHAiOjE3MzI2Mzc5MTd9.7-u6lhBNQspioxJtI48Px4EIbRKGuT3roVZ11Xr2UhE7YFgRQ5s6vyvE4xS3hMNX',25),(246,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxNTQyLCJleHAiOjE3MzI2Mzc5NDJ9.cz4TZMBZmztWYkFY6epV5DfFnXYO3-xM1ScRmx69350GpdNH_OMbn0ZPUOqDKizh',25),(247,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxNjg5LCJleHAiOjE3MzI2MzgwODl9.-PvcP3sQdiV347-_qzLiATx1TDhr51rIOnp0qWQyRkp0I9AudQqVXpUpCEkXqBrh',25),(248,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxNzExLCJleHAiOjE3MzI2MzgxMTF9.dPG_YtcRwOsFognipM0qkRzDVdsNamLjY2XKjK89aizPChD1CiJ0gXg4tk63BTea',25),(249,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxODQ4LCJleHAiOjE3MzI2MzgyNDh9.V458TKFv9tdUuC7M7h30swv-HpyxwlLyTlacEksrJ8qaIu8GzzcYrivguk1u0wek',25),(250,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NTE5MjYsImV4cCI6MTczMjYzODMyNn0.uSWS-INdcrwqlZAoHvXdoF3ftWN8HcDaz4tb21ck3rFcOWmLzoT_-5RdI69J_Cbe',26),(251,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUxOTQzLCJleHAiOjE3MzI2MzgzNDN9.EcLrFfJ7NhyyAIClJmUShZ_AtvmRnMszrJJz8VNyYFpH9_VavpyTZAcf3BdsWKEt',25),(252,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyMTgyLCJleHAiOjE3MzI2Mzg1ODJ9.W4fS2l4t7YC3lCN7gYhH9ivCEkl8OBzH9Qya_30HwnhlWOOEEQWBuUjnwlvlPaSP',25),(253,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyMTkyLCJleHAiOjE3MzI2Mzg1OTJ9.ghXgrt0pYIOOGMoxsJZf7e5PN6C8sdv6itFJqCJfkx4Hh5js3JGCu4XDyf9zqawA',25),(254,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyMjQwLCJleHAiOjE3MzI2Mzg2NDB9.eOV7ZMj8wUjgWHLKw1X72MefC3_3A2u8GOM3oYgwlBFFDI2ckhSe9oBgHOwioZS1',25),(255,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyMzI3LCJleHAiOjE3MzI2Mzg3Mjd9.rfzH1L1BQI6xKxJ3tuHByFpscI2fuUQydh3CU8cPrWdtXEjvP6hI0eSxtQZvblXp',25),(256,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NTIzNTgsImV4cCI6MTczMjYzODc1OH0.9JAqUfhoQsYchHSP5B90v4SPPW-3lZNaeeiTbG9GiTKeXzZc2vfn8hqvWAinRn5v',26),(257,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyMzgxLCJleHAiOjE3MzI2Mzg3ODF9.8twoud7jNWvbewBkgP06IWIHUcXx_L_xZ9F-KuMtu-5R6yMrBCrFpgi9Q-6fv8An',25),(258,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NTI2MTUsImV4cCI6MTczMjYzOTAxNX0.8PqGt6QvmCD1pF3k8KrNrMF35-SrE7oVIQQfe_uuEAjX1U7QfjiQOYkcF4XFTKac',26),(259,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyNjI4LCJleHAiOjE3MzI2MzkwMjh9.RQukZ3tlU5vawPA_9eUIoLOJD4-RboeOVgxMiG3IVb-7hPwXRRDBlpS42QFpqrl0',25),(260,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyNjU4LCJleHAiOjE3MzI2MzkwNTh9.Hus8pbAivZ1SFlKLKw6oBitl2BDFjm6c5dY3ZoUln2gPRWc8jLGNC55fEWYg9Yla',25),(261,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyNzQyLCJleHAiOjE3MzI2MzkxNDJ9.tVHADLIyeyv5Hl2bbrf6UlK4jCviuFl2DNFuaFUMbeFJlwpmT1UwjQ882ev7ILRy',25),(262,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyODI2LCJleHAiOjE3MzI2MzkyMjZ9.CvOz6o6GUzNhOokobPY3Zxn4NX1Gl2UOuEKBhwYZwaOhOcxwuJuylrWDF8IZaGUI',25),(263,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NTI4NTQsImV4cCI6MTczMjYzOTI1NH0.yJinTfJezZ1lWBqqF1DF8E6_mO2Hh0Zgku01oxXjXqJtSRKLOIAG4prNeg83UzkO',26),(264,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUyODgzLCJleHAiOjE3MzI2MzkyODN9.DBUHAQJ2GrvXed74kA7dbTWqAH_JgmSw-jzdC3PEI_Ewav6R9uoiCSMsqF2YdkfU',25),(265,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTUzMDQ0LCJleHAiOjE3MzI2Mzk0NDR9.kssYWwbK5M44RpjCfj3ABnBbL_eSpxKmfBmhEdXeC9cuWSebF4_gWIaz6jyjkzYh',25),(266,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NTMxMTAsImV4cCI6MTczMjYzOTUxMH0.aI5TSlucmvRjtADMajHWbrajz9wcS4dScoFz7dZyBnIokBInw7AhTFRekMC2CclH',26),(267,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTU5NjYzLCJleHAiOjE3MzI2NDYwNjN9.LdnkVUGUxhfgaulmSMU0p1VAe4Q4_AxIwhUDhUgIwLQjo5ZaNKV2-dSz_aTsHLHY',25),(268,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTYwMDczLCJleHAiOjE3MzI2NDY0NzN9.5H7qJ5WsLjTb3MOX_0QNvWKYbaJzfvLwYLzQhyBIMQbCGqCYdznAixRY7ZHnDujV',25),(269,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTYwNzAyLCJleHAiOjE3MzI2NDcxMDJ9.vp-vr2Ud1MuOACuJSZIYVCzNwI4omoBkaSpOTsCo2cFCV_AgsgNpfE9A8zCEMJ8u',25),(270,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTYwNzM5LCJleHAiOjE3MzI2NDcxMzl9.Cqrwkzv8mcQC1dRkLAUgb4vZ4d0crmvT2RqtJTvojdS1l6aTgzvUBx5FBr22H9lF',25),(271,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTY0MTE4LCJleHAiOjE3MzI2NTA1MTh9.SA1esZ3pc9Oyr5ML9cnGZaRAy28Nb5b83GuzLGhRl-MhHwmc9wDDSIhIPmepjkgo',25),(272,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTY0MjczLCJleHAiOjE3MzI2NTA2NzN9._aNYXxiOY-I0mIbYPCQwU6qzNhy6R6NqEfzVgL_gETiyGIK6tzqXEKD6dcOesTbm',25),(273,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTY0NjQzLCJleHAiOjE3MzI2NTEwNDN9.s2eRShwPf9_rt8Pcz4JaWNYJFZ_PUFNrLBdjHjngleIda1_jceMlRfgx_eEU0Gz1',25),(274,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTY0OTIxLCJleHAiOjE3MzI2NTEzMjF9.qjx2ojJexWsjwpypjeLRsae5P3wf510_WbdAVtPU37iG7XE2RLnSxdbD_o_loTlz',25),(275,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTY1NDc5LCJleHAiOjE3MzI2NTE4Nzl9.QKpIghHtoUmvh7UG6UC0R83mJMnxo5kj5wOe4BkhxWOnLpqA-TgyowRe5Rz3nahY',25),(276,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTcwMjc2LCJleHAiOjE3MzI2NTY2NzZ9.yUDbAtgJnxskTLk_FzdBMpCJKdmiCCa0T5gSpHN9LGcp1_zEQBbd4dEZdl42gDvG',25),(277,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTcwNTQyLCJleHAiOjE3MzI2NTY5NDJ9.aFEw2s-kVE39vJSj8FB-QZIWHIdxSeN4oYxVW6b5S_SlQXIjmwZj-mmWh4fC1JEK',25),(278,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTcxMTExLCJleHAiOjE3MzI2NTc1MTF9.FFfodOPwm0UF1c_hXWbFGs6eXSJO6UEFqrL_u6iKiQZE4pEPjLuReynuRpRp7Q_3',25),(279,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTcxNDgxLCJleHAiOjE3MzI2NTc4ODF9.IfU3R0u83ZP8-kRLuJdrrFsl42Si_OAAEjsEUJFBFgXqS8aZsvAQu-h9aS2To6CA',25),(280,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NzMwODcsImV4cCI6MTczMjY1OTQ4N30.I9-jJYclnCXhw_skZsjhwlGqew6ebHGjnWSV2J49iks7foJ4ylwvE-lHR8R78NUa',26),(281,_binary '','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NzM3MDcsImV4cCI6MTczMjY2MDEwN30.gUr6NxA_7XhKIsIUCOa_x7l5UcC9v9Odgn9njk1_TfL5izNrdhduELN8kKlqVf-P',26),(282,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJuYXlhbXVsaXNsYW1AZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzMyNTczODAyLCJleHAiOjE3MzI2NjAyMDJ9.ILbJv9eaPEiJzVp9x8S9uwlK6i6MOtkDy0E1Ud1-XWfQsGAo6HqAUHl8NCEbaKMQ',25),(283,_binary '\0','eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzaGFiYWJAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MzI1NzM4MjEsImV4cCI6MTczMjY2MDIyMX0.XQl3TAlEGgOhJVNVAfiHfssmjwy5UzjtokY8WOKgd5AdSkX8ufi5JS9r8wxuBvM2',26);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (14,'Cash',100000,'2024-10-03 05:12:00.504542'),(15,'Payoneer',150000,'2024-10-03 05:13:35.452673'),(17,'Bank Payment',4500000,'2024-10-03 05:16:01.540722');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `capacity` bigint NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (7,150000,'+880 2 9897759','Gazipur, Gazipur, Bangladesh\nNIPPON EXPRESS (BANGLADESH) LTD.','Mawna warehouse'),(8,100000,'+880231546154','House 5/C, Road 01,PCCL Housing Limited,Mohammadpur, Dhaka','Mohammodpur warehouse'),(9,250000,'+88026651565','5/11 Bohoddarhat,Chattogram,Chattogram','Chattogram Warehouse'),(10,100000,'+88096582525','D/522,Sonkor,Dhanmodi,Dhaka','Dhanmondhi warehouse'),(12,150000,'+8803553456','59/A, Kadamtoli, Sylhet','Sylet WareHouse');
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-26  4:34:47
