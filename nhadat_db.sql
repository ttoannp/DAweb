CREATE DATABASE  IF NOT EXISTS `nhadat_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nhadat_db`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nhadat_db
-- ------------------------------------------------------
-- Server version	9.2.0

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
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (5,'Biệt phủ'),(2,'Chung cư'),(3,'Đất nền'),(1,'Nhà ở'),(4,'Văn phòng'),(6,'Villa');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `listing_id` int NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `listing_id` (`listing_id`),
  CONSTRAINT `images_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (4,6,'/uploads/84f71dcb-0223-4d7e-8f9f-276ae371d015_tải xuống.jpg'),(5,7,'/uploads/538d1443-6e4a-496b-a7c8-f728f4acde41_tải xuống (1).jpg'),(6,3,'/uploads/01c4f5f9-2241-4f49-b115-833d95788cdd_tải xuống (2).jpg'),(7,2,'/uploads/d3f9d0c8-92bf-49ef-a38a-061093411fef_tải xuống (3).jpg'),(8,1,'/uploads/60df0a41-d110-4166-9e7a-c7227fc12f6e_tải xuống (4).jpg'),(9,8,'/uploads/b5bddcb4-fdbb-4c6d-aeab-451855cce229_mau-nha-cap-3-thiet-ke-dep-nhat-nam-31.jpg'),(11,10,'/uploads/b35f4969-5b48-4e29-bf7d-22b61bdf69ef_images.jpg'),(15,14,'/uploads/bafa1479-488a-4a30-bf2f-52d7178f67e7_mau-nha-2-tang-dep_0.jpg'),(16,15,'/uploads/4bf10b83-7d4c-4a70-ad41-08653133bb4f_mau-nha-2-tang-dep_0.jpg');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listings`
--

DROP TABLE IF EXISTS `listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` bigint NOT NULL,
  `area` float DEFAULT NULL,
  `location_id` int NOT NULL,
  `category_id` int NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `listings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `listings_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `listings_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listings`
--

LOCK TABLES `listings` WRITE;
/*!40000 ALTER TABLE `listings` DISABLE KEYS */;
INSERT INTO `listings` VALUES (1,2,'Bán nhà mặt tiền trung tâm Hải Châu','Nhà đẹp 3 tầng, gần chợ Hàn',4500000000,120,1,1,'approved','2025-08-02 22:11:38'),(2,2,'Căn hộ chung cư 2PN gần biển','Căn hộ cao cấp, view biển, đầy đủ nội thất',2100000000,75,3,2,'approved','2025-08-02 22:11:38'),(3,2,'Đất nền Thanh Khê giá rẻ','Khu vực dân cư đông đúc, gần trường học',1800000000,90,2,3,'approved','2025-08-02 22:11:38'),(6,2,'Nhà hai tấm biệt thự villa','Nhà ở ven biển, view đẹp, đầy đủ nội thất',17000000000,300,6,1,'approved','2025-08-03 01:30:46'),(7,2,'Chung cư cao cấp SunPonTe','Chung cư có 2 phòng ngủ',200000000,49.9,7,2,'approved','2025-08-03 02:05:01'),(8,3,'Nhà mặt phố ','Nhà thoáng mát , có bể bơi',5000000000,250,8,1,'approved','2025-08-03 03:14:14'),(10,3,'Nhà siêu to , rộng rãi','Nhà đẹp có gara ô tô , vườn rỗng rãi',5000000000,300,10,1,'approved','2025-08-03 03:17:16'),(14,6,'bán nhà ở đẹp sang gì gì đó','không',5000000000000,300,16,1,'approved','2025-08-03 11:53:26'),(15,2,'bán nhà đẹp sang sang gì đó','không',5000000000000,300,17,1,'rejected','2025-08-03 11:56:28');
/*!40000 ALTER TABLE `listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `province` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Đà Nẵng','Hải Châu','Hòa Thuận Đông','123 Lê Duẩn'),(2,'Đà Nẵng','Thanh Khê','Thanh Khê Đông','45 Nguyễn Văn Linh'),(3,'Đà Nẵng','Ngũ Hành Sơn','Mỹ An','78 Trần Bạch Đằng'),(4,'Đà Nẵng','Cẩm Lệ ','Hòa Xuân','102 Phan Văn Thụ'),(5,'Đà Nẵng','Cẩm Lệ ','Hòa Xuân','102 Phan Văn Thụ'),(6,'Đà Nẵng','Cẩm Lệ ','Hòa Xuân','102 Phan Văn Thụ'),(7,'Đà Nẵng','Cẩm Lệ ','Hòa Thuận Đông','18 Trung Lương 18'),(8,'Đà Nẵng','Ngũ Hành Sơn','Hòa Hải','19 Ngũ Hành Sơn'),(9,'Đà Nẵng','Ngũ Hành Sơn','Hòa Hải','19 Ngũ Hành Sơn'),(10,'Đà Nẵng','Cẩm Lệ ','Hòa Xuân','100 Lê Kim Lân'),(11,'Đà Nẵng','Hòa Vang',NULL,NULL),(12,'Quảng Nam',NULL,NULL,NULL),(13,'Đà Nẵng','Hòa Vang','123','123'),(14,'Đà Nẵng','Hải Châu','1','1'),(15,'Đà Nẵng','Cẩm Lệ ','1','1'),(16,'Đà Nẵng','Hải Châu','Hòa Hải','102 Phan Văn Thụ'),(17,'Đà Nẵng','Hải Châu','Hòa Hải','102 Phan Văn Thụ'),(18,'Huế',NULL,NULL,NULL),(19,'Huế','Phú Xuân',NULL,NULL);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('admin','user') COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin1','123456','Admin Đà Nẵng 1','0912345678','admin@danang.vn','admin','2025-08-02 22:11:38'),(2,'user1','1234567','Nguyễn Văn A','0911222333','nguyenvana@gmail.com','user','2025-08-02 22:11:38'),(3,'user2','123456','Trần Thái T','0702315244','thaitoan19825@gmail.com','user','2025-08-03 00:05:26'),(4,'user3','123456','Trần Trung H','0839506777','hieudt247@gmail.com','user','2025-08-03 03:35:22'),(5,'user4','123456','Nguyễn Tuấn P','0979520852','nguyentuanp@gmail.com','user','2025-08-03 03:37:06'),(6,'user27','123456','Nguyễn Phương Anh','0123456789','npa@gmail.com','user','2025-08-03 11:42:46'),(7,'user028','123456','1','1','12@gmail.com','user','2025-08-03 11:44:56');
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

-- Dump completed on 2025-08-03 16:12:55
