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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-26  4:32:22
