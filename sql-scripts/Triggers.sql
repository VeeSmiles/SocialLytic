CREATE DATABASE  IF NOT EXISTS `social_media_analytics` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `social_media_analytics`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: social_media_analytics
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `CommentID` int NOT NULL AUTO_INCREMENT,
  `PostID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `CommentText` text NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CommentID`),
  KEY `PostID` (`PostID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,2,1,'Nice post!','2024-11-23 10:20:27'),(2,3,3,'Tell me about it!!','2024-11-23 10:20:27'),(3,6,1,'Hey there.','2024-11-23 10:20:27'),(4,1,2,'Beautiful! Where was this taken?','2024-11-23 10:20:27'),(5,3,3,'Tried it, love it.','2024-11-23 10:20:27'),(6,5,3,'This video tutorial was super helpful, thank you!','2024-11-23 10:20:27'),(7,4,4,'Yeah; they\'re really cool','2024-11-23 10:20:27'),(8,2,5,'Plug the shop kindly!','2024-11-23 10:20:27');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engagement`
--

DROP TABLE IF EXISTS `engagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `engagement` (
  `EngagementID` int NOT NULL AUTO_INCREMENT,
  `PostID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `EngagementType` enum('Like','Share','Comment') DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`EngagementID`),
  KEY `UserID` (`UserID`),
  KEY `PostID` (`PostID`),
  CONSTRAINT `engagement_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `engagement_ibfk_2` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engagement`
--

LOCK TABLES `engagement` WRITE;
/*!40000 ALTER TABLE `engagement` DISABLE KEYS */;
INSERT INTO `engagement` VALUES (1,2,1,'Like','2024-11-23 10:20:27'),(2,3,1,'Comment','2024-11-23 10:20:27'),(3,1,2,'Like','2024-11-23 10:20:27'),(4,4,2,'Share','2024-11-23 10:20:27'),(5,5,3,'Comment','2024-11-23 10:20:27'),(6,2,3,'Like','2024-11-23 10:20:27'),(7,3,4,'Share','2024-11-23 10:20:27'),(8,6,5,'Like','2024-11-23 10:20:27'),(9,4,6,'Like','2024-11-23 10:20:27'),(10,1,6,'Comment','2024-11-23 10:20:27');
/*!40000 ALTER TABLE `engagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `PostID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Content` text NOT NULL,
  `ContentType` enum('Text','Image','Video') DEFAULT NULL,
  `Hashtags` varchar(255) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PostID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'Welcome to my page guys!','Text','#FirstPost','2024-11-23 10:20:27'),(2,2,'Check out this amazing sunset!','Image','#Nature #Sunset','2024-11-23 10:20:27'),(3,3,'Here\'s a quick video tutorial for beginners.','Video','#Tutorial #Video','2024-11-23 10:20:27'),(4,1,'Loving the new tiktok features!','Text','#AppFeatures #Tech','2024-11-23 10:20:27'),(5,4,'Finally on holiday!','Text',NULL,'2024-11-23 10:20:27'),(6,5,'The weather today is quite unfriendly.','Text',NULL,'2024-11-23 10:20:27'),(7,6,'Love the new perfume in the market.','Text','#Scents','2024-11-23 10:20:27');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Zue15','Zuena Kiplagat','zue@gmail.com','Female',21,'USA','2024-11-23 10:20:27'),(2,'joe','Joseph Smith','joe@gmail.com','Male',30,'South Africa','2024-11-23 10:20:27'),(3,'Vee','Vivian Ndung\'u','vee@gmail.com','Female',20,'Canada','2024-11-23 10:20:27'),(4,'Mikey','Michael Stower','mike@gmail.com','Male',29,'Kenya','2024-11-23 10:20:27'),(5,'Wamboi','Beatrice Wamboi','wamboi@gmail.com','Female',19,'UK','2024-11-23 10:20:27'),(6,'ian2','Ian Peter','ian@gmail.com','Male',36,'Nigeria','2024-11-23 10:20:27'),(7,'Abby','Abigail Kirimi','abby@gmail.com','Female',20,'Australia','2024-11-23 10:20:27'),(8,'james','John James','james@gmail.com','Male',16,'USA','2024-11-23 10:20:27'),(9,'Abbie','Abigail Kagoiza','abbie@gmail.com','Female',22,'Kenya','2024-11-23 10:20:27');
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

-- Dump completed on 2024-11-23 16:01:37
