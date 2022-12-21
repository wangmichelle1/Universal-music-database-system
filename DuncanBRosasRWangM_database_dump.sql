-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: music
-- ------------------------------------------------------
-- Server version	8.0.29

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

-- create the database
DROP DATABASE IF EXISTS music;
CREATE DATABASE music;
USE music;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `albumId` int NOT NULL AUTO_INCREMENT,
  `album_name` varchar(64) NOT NULL,
  `release_year` year DEFAULT NULL,
  `artistId` int NOT NULL,
  PRIMARY KEY (`albumId`),
  KEY `album_artist_fk` (`artistId`),
  CONSTRAINT `album_artist_fk` FOREIGN KEY (`artistId`) REFERENCES `artist` (`artistId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'Fearless',2006,1),(2,'Sour',2021,2),(3,'On the Run',2007,3),(4,'Scorpion',2018,4),(5,'Unorthodox Jukebox',2012,5),(6,'Teenage Dream',2010,6),(7,'Purpose',2015,7);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_genre`
--

DROP TABLE IF EXISTS `album_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_genre` (
  `albumId` int NOT NULL,
  `album_genre_name` varchar(64) NOT NULL,
  PRIMARY KEY (`albumId`,`album_genre_name`),
  CONSTRAINT `album_genre_pk` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_genre`
--

LOCK TABLES `album_genre` WRITE;
/*!40000 ALTER TABLE `album_genre` DISABLE KEYS */;
INSERT INTO `album_genre` VALUES (1,'Country'),(1,'Pop'),(2,'Pop'),(3,'Country'),(3,'Mandopop'),(4,'Pop'),(4,'R&B'),(5,'Pop'),(5,'R&B'),(5,'Reggae'),(6,'Pop'),(7,'Hip-Hop'),(7,'Pop'),(7,'Rap');
/*!40000 ALTER TABLE `album_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_review`
--

DROP TABLE IF EXISTS `album_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_review` (
  `album_rating` decimal(2,1) DEFAULT NULL,
  `album_review_desc` varchar(400) DEFAULT NULL,
  `userId` int NOT NULL,
  `albumId` int NOT NULL,
  PRIMARY KEY (`userId`,`albumId`),
  KEY `album_review_fk2` (`albumId`),
  CONSTRAINT `album_review_fk1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `album_review_fk2` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_review`
--

LOCK TABLES `album_review` WRITE;
/*!40000 ALTER TABLE `album_review` DISABLE KEYS */;
INSERT INTO `album_review` VALUES (8.5,'I love Olivia Rodrigos Sour Album. Her\nsongs are all so impactful and it helps me so much when I am practicing for my upcoming tennis \nmatches. The words being her songs mean so much to me and is so relatable.',1,2),(8.0,'The Teenage Dream album of Katy Perry brings me back good memories as I remember those songs \nbeing played when I used to go to camp over the summer. It brought me back times when I did not have to stress\nand had a care free life.',2,6),(5.0,NULL,3,7),(8.0,NULL,4,3);
/*!40000 ALTER TABLE `album_review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `num_album_reviews_a` AFTER INSERT ON `album_review` FOR EACH ROW BEGIN
	UPDATE database_user SET num_of_album_review = num_of_album_review + 1 WHERE userId = new.userId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `num_album_reviews_b` AFTER DELETE ON `album_review` FOR EACH ROW BEGIN
	UPDATE database_user SET num_of_album_review = num_of_album_review - 1 WHERE userId = old.userId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artistId` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(64) NOT NULL,
  PRIMARY KEY (`artistId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'Taylor Swift'),(2,'Olivia Rodrigo'),(3,'Jay Chou'),(4,'Drake'),(5,'Bruno Mars'),(6,'Katy Perry'),(7,'Justin Bieber');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_review`
--

DROP TABLE IF EXISTS `artist_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_review` (
  `artist_rating` decimal(2,1) DEFAULT NULL,
  `artist_review_desc` varchar(400) DEFAULT NULL,
  `userId` int NOT NULL,
  `artistId` int NOT NULL,
  PRIMARY KEY (`userId`,`artistId`),
  KEY `artist_review_fk2` (`artistId`),
  CONSTRAINT `artist_review_fk1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `artist_review_fk2` FOREIGN KEY (`artistId`) REFERENCES `artist` (`artistId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_review`
--

LOCK TABLES `artist_review` WRITE;
/*!40000 ALTER TABLE `artist_review` DISABLE KEYS */;
INSERT INTO `artist_review` VALUES (8.5,'Jay Chou\nis a Taiwanese artist whose songs tell stories that are definitely relatable to me. He has a mix \nof fast-paced, happy songs as well as slow, lonely songs. I highly recommend listening to him \nif you are into mandarin songs.',1,3),(9.8,'Taylor Swift is a country, pop artist who I have listened\nto since my childhood. I love all her songs and albums and her as a person.',2,1),(4.0,NULL,3,7),(9.5,NULL,4,2);
/*!40000 ALTER TABLE `artist_review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `num_artist_reviews_a` AFTER INSERT ON `artist_review` FOR EACH ROW BEGIN
	UPDATE database_user SET num_of_artist_review = num_of_artist_review + 1 WHERE userId = new.userId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `num_artist_reviews_b` AFTER DELETE ON `artist_review` FOR EACH ROW BEGIN
	UPDATE database_user SET num_of_artist_review = num_of_artist_review - 1 WHERE userId = old.userId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `database_user`
--

DROP TABLE IF EXISTS `database_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `num_of_artist_review` int DEFAULT '0',
  `num_of_album_review` int DEFAULT '0',
  `num_of_song_review` int DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_user`
--

LOCK TABLES `database_user` WRITE;
/*!40000 ALTER TABLE `database_user` DISABLE KEYS */;
INSERT INTO `database_user` VALUES (1,'wangmichelle123',5,8,2),(2,'jlin884',0,4,8),(3,'naomiosaka12',4,3,2),(4,'rfederer18',0,2,0);
/*!40000 ALTER TABLE `database_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song` (
  `songId` int NOT NULL AUTO_INCREMENT,
  `song_name` varchar(64) DEFAULT NULL,
  `musical_key` varchar(10) DEFAULT NULL,
  `song_length` time DEFAULT NULL,
  `song_language` varchar(64) DEFAULT NULL,
  `song_genre_name` varchar(64) DEFAULT NULL,
  `albumId` int DEFAULT NULL,
  PRIMARY KEY (`songId`),
  KEY `album_fk` (`albumId`),
  CONSTRAINT `album_fk` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'Hey Stephen','F# major','00:04:14','English','Country',1),(2,'Jealousy,Jealousy','Bb minor','00:02:53',NULL,'Pop',NULL),(3,'Blue and White Porcelain','F# major','00:04:07','Mandarin','Mandopop',3),(4,'Fifteen','G major','00:04:54','English','Country',NULL),(5,'Survival','A minor','00:02:16','English',NULL,NULL),(6,'Treasure','Eb major','00:02:58','English','Pop',NULL),(7,'Last Friday Night','D# minor',NULL,NULL,'Pop',6),(8,'Love Yourself','E major','00:03:54','English','Pop',NULL);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song_review`
--

DROP TABLE IF EXISTS `song_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song_review` (
  `song_rating` decimal(2,1) DEFAULT NULL,
  `song_review_desc` varchar(400) DEFAULT NULL,
  `userId` int NOT NULL,
  `songId` int NOT NULL,
  PRIMARY KEY (`userId`,`songId`),
  KEY `song_review_fk2` (`songId`),
  CONSTRAINT `song_review_fk1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `song_review_fk2` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song_review`
--

LOCK TABLES `song_review` WRITE;
/*!40000 ALTER TABLE `song_review` DISABLE KEYS */;
INSERT INTO `song_review` VALUES (9.2,'Hey Stephen by Taylor Swift is such an amazing\nsong about having a crush on a guy but not telling him. I highly recommend it.',1,1),(8.0,'Treasure by\nBruno Mars is always a song that makes me happy and hypes me up.',2,6),(9.0,'Last Friday Night \nby Katy Perry is another hype song that helps me become energetic if I ever feel down',3,7),(6.0,NULL,4,8);
/*!40000 ALTER TABLE `song_review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `num_song_reviews_a` AFTER INSERT ON `song_review` FOR EACH ROW BEGIN
	UPDATE database_user SET num_of_song_review = num_of_song_review + 1 WHERE userId = new.userId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `num_song_reviews_b` AFTER DELETE ON `song_review` FOR EACH ROW BEGIN
	UPDATE database_user SET num_of_song_review = num_of_song_review - 1 WHERE userId = old.userId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `streaming_service`
--

DROP TABLE IF EXISTS `streaming_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streaming_service` (
  `service_name` varchar(64) NOT NULL,
  PRIMARY KEY (`service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streaming_service`
--

LOCK TABLES `streaming_service` WRITE;
/*!40000 ALTER TABLE `streaming_service` DISABLE KEYS */;
INSERT INTO `streaming_service` VALUES ('Amazon Music Unlimited'),('Apple Music'),('Spotify'),('Tidal'),('Youtube Music');
/*!40000 ALTER TABLE `streaming_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_searches_al_review`
--

DROP TABLE IF EXISTS `user_searches_al_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_searches_al_review` (
  `userId` int NOT NULL,
  `albumId` int NOT NULL,
  PRIMARY KEY (`userId`,`albumId`),
  KEY `user_searches_al_r_f2` (`albumId`),
  CONSTRAINT `user_searches_al_r_f1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_searches_al_r_f2` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_searches_al_review`
--

LOCK TABLES `user_searches_al_review` WRITE;
/*!40000 ALTER TABLE `user_searches_al_review` DISABLE KEYS */;
INSERT INTO `user_searches_al_review` VALUES (4,1),(1,3),(2,3),(1,4),(2,4),(2,5),(3,5);
/*!40000 ALTER TABLE `user_searches_al_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_searches_album`
--

DROP TABLE IF EXISTS `user_searches_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_searches_album` (
  `userId` int NOT NULL,
  `albumId` int NOT NULL,
  PRIMARY KEY (`userId`,`albumId`),
  KEY `user_searches_al_f2` (`albumId`),
  CONSTRAINT `user_searches_al_f1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_searches_al_f2` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_searches_album`
--

LOCK TABLES `user_searches_album` WRITE;
/*!40000 ALTER TABLE `user_searches_album` DISABLE KEYS */;
INSERT INTO `user_searches_album` VALUES (2,3),(3,3),(1,4),(4,4),(1,5),(4,5),(1,7),(3,7);
/*!40000 ALTER TABLE `user_searches_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_searches_ar_review`
--

DROP TABLE IF EXISTS `user_searches_ar_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_searches_ar_review` (
  `userId` int NOT NULL,
  `artistId` int NOT NULL,
  PRIMARY KEY (`userId`,`artistId`),
  KEY `user_searches_ar_f2` (`artistId`),
  CONSTRAINT `user_searches_ar_f1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_searches_ar_f2` FOREIGN KEY (`artistId`) REFERENCES `artist` (`artistId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_searches_ar_review`
--

LOCK TABLES `user_searches_ar_review` WRITE;
/*!40000 ALTER TABLE `user_searches_ar_review` DISABLE KEYS */;
INSERT INTO `user_searches_ar_review` VALUES (1,1),(3,1),(4,1),(1,2),(2,2),(1,3),(3,6),(3,7);
/*!40000 ALTER TABLE `user_searches_ar_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_searches_artist`
--

DROP TABLE IF EXISTS `user_searches_artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_searches_artist` (
  `userId` int NOT NULL,
  `artistId` int NOT NULL,
  PRIMARY KEY (`userId`,`artistId`),
  KEY `artist_sa_fk` (`artistId`),
  CONSTRAINT `artist_sa_fk` FOREIGN KEY (`artistId`) REFERENCES `artist` (`artistId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_sa_fk` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_searches_artist`
--

LOCK TABLES `user_searches_artist` WRITE;
/*!40000 ALTER TABLE `user_searches_artist` DISABLE KEYS */;
INSERT INTO `user_searches_artist` VALUES (2,1),(3,1),(3,2),(1,3),(3,3),(1,4),(4,6),(4,7);
/*!40000 ALTER TABLE `user_searches_artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_searches_s_review`
--

DROP TABLE IF EXISTS `user_searches_s_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_searches_s_review` (
  `userId` int NOT NULL,
  `songId` int NOT NULL,
  PRIMARY KEY (`userId`,`songId`),
  KEY `user_searches_s_r_f2` (`songId`),
  CONSTRAINT `user_searches_s_r_f1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_searches_s_r_f2` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_searches_s_review`
--

LOCK TABLES `user_searches_s_review` WRITE;
/*!40000 ALTER TABLE `user_searches_s_review` DISABLE KEYS */;
INSERT INTO `user_searches_s_review` VALUES (1,1),(1,2),(1,3),(2,4),(2,5),(4,6),(4,7),(3,8);
/*!40000 ALTER TABLE `user_searches_s_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_searches_song`
--

DROP TABLE IF EXISTS `user_searches_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_searches_song` (
  `userId` int NOT NULL,
  `songId` int NOT NULL,
  PRIMARY KEY (`userId`,`songId`),
  KEY `user_searches_s_f2` (`songId`),
  CONSTRAINT `user_searches_s_f1` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_searches_s_f2` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_searches_song`
--

LOCK TABLES `user_searches_song` WRITE;
/*!40000 ALTER TABLE `user_searches_song` DISABLE KEYS */;
INSERT INTO `user_searches_song` VALUES (1,1),(2,3),(3,4),(1,8),(4,8);
/*!40000 ALTER TABLE `user_searches_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_use_ss`
--

DROP TABLE IF EXISTS `user_use_ss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_use_ss` (
  `userId` int NOT NULL,
  `service_name` varchar(64) NOT NULL,
  PRIMARY KEY (`userId`,`service_name`),
  KEY `service_ss_fk` (`service_name`),
  CONSTRAINT `service_ss_fk` FOREIGN KEY (`service_name`) REFERENCES `streaming_service` (`service_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_ss_fk` FOREIGN KEY (`userId`) REFERENCES `database_user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_use_ss`
--

LOCK TABLES `user_use_ss` WRITE;
/*!40000 ALTER TABLE `user_use_ss` DISABLE KEYS */;
INSERT INTO `user_use_ss` VALUES (1,'Amazon Music Unlimited'),(1,'Apple Music'),(1,'Spotify'),(3,'Spotify'),(4,'Spotify'),(3,'Tidal'),(2,'Youtube Music');
/*!40000 ALTER TABLE `user_use_ss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'music'
--
/*!50003 DROP FUNCTION IF EXISTS `num_album_r_searches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_album_r_searches`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE num_searches_v INT; 
    SELECT COUNT(albumId) INTO num_searches_v FROM user_searches_al_review WHERE userId = userId_p GROUP BY userId; 
	RETURN num_searches_v; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `num_album_searches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_album_searches`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE num_searches_v INT; 
    SELECT COUNT(albumId) INTO num_searches_v FROM user_searches_album WHERE userId = userId_p GROUP BY userId; 
	RETURN num_searches_v; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `num_artist_r_searches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_artist_r_searches`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE num_searches_v INT; 
    SELECT COUNT(artistId) INTO num_searches_v FROM user_searches_ar_review WHERE userId = userId_p GROUP BY userId; 
	RETURN num_searches_v; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `num_artist_searches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_artist_searches`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE num_searches_v INT; 
    SELECT COUNT(artistId) INTO num_searches_v FROM user_searches_artist WHERE userId = userId_p GROUP BY userId; 
	RETURN num_searches_v; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `num_song_r_searches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_song_r_searches`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE num_searches_v INT; 
    SELECT COUNT(songId) INTO num_searches_v FROM user_searches_s_review WHERE userId = userId_p GROUP BY userId; 
	RETURN num_searches_v; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `num_song_searches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_song_searches`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE num_searches_v INT; 
    SELECT COUNT(songId) INTO num_searches_v FROM user_searches_song WHERE userId = userId_p GROUP BY userId; 
	RETURN num_searches_v;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_reviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_reviews`(userId_p INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN 
	DECLARE total_reviews_v INT; 
    DECLARE num_of_artist_review_v INT; 
	DECLARE num_of_album_review_v INT; 
	DECLARE num_of_song_review_v INT; 
    SELECT num_of_artist_review INTO num_of_artist_review_v FROM database_user WHERE userId = userId_p;
	SELECT num_of_album_review INTO num_of_album_review_v FROM database_user WHERE userId = userId_p;
	SELECT num_of_song_review INTO num_of_song_review_v FROM database_user WHERE userId = userId_p;
    SET total_reviews_v = num_of_artist_review_v + num_of_album_review_v + num_of_song_review_v;
    RETURN total_reviews_v;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_album_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_album_review`(IN userId_p INT, IN album_name_p VARCHAR(64), IN album_rating_p DECIMAL(2,1), IN album_review_desc_p VARCHAR(400))
BEGIN 
DECLARE albumId_v INT;

IF (SELECT albumId FROM album WHERE album_name = album_name_p) IS NULL THEN 
INSERT INTO album (album_name) VALUES (album_name_p); 
END IF; 

SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p;

IF album_rating_p IS NULL AND album_review_desc_p IS NULL THEN 
	SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'You must specify at least one of these: album rating or album review description',
        MYSQL_ERRNO = 1001;
END IF; 

IF (SELECT COUNT(userId) FROM album_review WHERE userId = userId_p AND albumId = albumId_v 
GROUP BY userId) IS NULL THEN 
INSERT INTO album_review VALUES (album_rating_p, album_review_desc_p, userId_p, albumId_v); 
ELSE 
	SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'You already made a review for this album. Please make an update instead.',
            MYSQL_ERRNO = 1062; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_artist_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_artist_review`(IN userId_p INT, IN artist_name_p VARCHAR(64), IN artist_rating_p DECIMAL(2,1), IN artist_review_desc_p VARCHAR(400))
BEGIN 
DECLARE artistId_v INT;

IF (SELECT artistId FROM artist WHERE artist_name = artist_name_p) IS NULL THEN 
INSERT INTO artist (artist_name) VALUES (artist_name_p); 
END IF; 

SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p;

IF artist_rating_p IS NULL AND artist_review_desc_p IS NULL THEN 
	SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'You must specify at least one of these: artist rating or artist review description',
        MYSQL_ERRNO = 1001;
END IF; 

IF (SELECT COUNT(userId) FROM artist_review WHERE userId = userId_p AND artistId = artistId_v 
GROUP BY userId) IS NULL THEN 
INSERT INTO artist_review VALUES (artist_rating_p, artist_review_desc_p, userId_p, artistId_v); 
ELSE 
	SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'You already made a review for this artist. Please make an update instead.',
            MYSQL_ERRNO = 1062; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_song` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_song`(IN song_name_p VARCHAR(64), IN musical_key_p VARCHAR(10), IN song_length_p TIME, 
IN song_language_p VARCHAR(64), IN song_genre_name_p VARCHAR(64), IN album_name_p VARCHAR(64), 
IN album_release_year_p YEAR, IN artist_name_p VARCHAR(64))
BEGIN
DECLARE albumId_v INT; 
DECLARE songId_v INT;
DECLARE artistId_v INT;

IF NOT EXISTS (SELECT song_name FROM song WHERE song_name = song_name_p) THEN
INSERT INTO song (song_name, musical_key, song_length, song_language, song_genre_name)
VALUES (song_name_p, musical_key_p, song_length_p, song_language_p, song_genre_name_p);
ELSE 
	SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'This song already exists in the database.',
            MYSQL_ERRNO = 1062; 
END IF; 

IF NOT EXISTS (SELECT artist_name FROM artist WHERE artist_name = artist_name_p) THEN 
INSERT INTO artist (artist_name) VALUES (artist_name_p); 
END IF; 
SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p; 

IF NOT EXISTS (SELECT album_name FROM album WHERE album_name = album_name_p)
THEN INSERT INTO album (album_name, release_year, artistId) VALUES (album_name_p, album_release_year_p,
artistId_v); 
END IF; 
SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p; 

IF song_genre_name_p NOT IN (SELECT album_genre_name FROM album_genre WHERE albumId = albumId_v) THEN
INSERT INTO album_genre VALUES (albumId_v, song_genre_name_p); 
END IF; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_song_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_song_review`(IN userId_p INT, IN song_name_p VARCHAR(64), IN song_rating_p DECIMAL(2,1), IN song_review_desc_p VARCHAR(400))
BEGIN 
DECLARE songId_v INT;

IF (SELECT songId FROM song WHERE song_name = song_name_p) IS NULL THEN 
INSERT INTO song (song_name) VALUES (song_name_p); 
END IF; 

SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p;

IF song_rating_p IS NULL AND song_review_desc_p IS NULL THEN 
	SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'You must specify at least one of these: song rating or song review description',
        MYSQL_ERRNO = 1001;
END IF; 

IF (SELECT COUNT(userId) FROM song_review WHERE userId = userId_p AND songId = songId_v 
GROUP BY userId) IS NULL THEN 
INSERT INTO song_review VALUES (song_rating_p, song_review_desc_p, userId_p, songId_v); 
ELSE 
	SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'You already made a review for this song. Please make an update instead.',
            MYSQL_ERRNO = 1062; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_ss` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_ss`(IN userId_p INT, IN service_name_p VARCHAR(64))
BEGIN 
	IF service_name_p NOT IN (SELECT service_name FROM streaming_service) THEN 
    INSERT INTO streaming_service VALUES (service_name_p); 
	END IF;
	IF userId_p NOT IN (SELECT userId FROM user_use_ss WHERE userId = userId_p AND service_name = service_name_p) THEN 
    INSERT INTO user_use_ss VALUES (userId_p, service_name_p);
    ELSE 
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'The user and their service name combination already exists in the system.',
            MYSQL_ERRNO = 1062; 
    END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user`(IN user_name_p VARCHAR(64))
BEGIN 
	IF user_name_p NOT IN (SELECT user_name FROM database_user) THEN 
	INSERT INTO database_user (user_name) VALUES (user_name_p); 
    ELSE 
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'The user already exists in the system.',
            MYSQL_ERRNO = 1062; 
	END IF; 
	SELECT userId FROM database_user WHERE user_name = user_name_p; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_user`(IN userId_p INT)
BEGIN 
	IF NOT EXISTS (SELECT userId FROM database_user WHERE userId = userId_p) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The userId you entered does not exist. Please enter again or make a new one',
        MYSQL_ERRNO = 1001;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_album_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_album_review`(IN album_name_p VARCHAR(64), IN userId_p INT)
BEGIN 
DECLARE albumId_v INT; 
SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p;

IF EXISTS (SELECT * FROM album_review WHERE albumId = albumId_v AND userId = userId_p) 
THEN DELETE FROM album_review  
	WHERE albumId = albumId_v AND userId = userId_p;
ELSE 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot delete an album review you never made.',
            MYSQL_ERRNO = 1001; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_artist_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_artist_review`(IN artist_name_p VARCHAR(64), IN userId_p INT)
BEGIN 
DECLARE artistId_v INT; 
SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p;

IF EXISTS (SELECT * FROM artist_review WHERE artistId = artistId_v AND userId = userId_p)
THEN DELETE FROM artist_review  
	WHERE (artistId = artistId_v AND userId = userId_p);
ELSE 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot delete an artist review you never made.',
            MYSQL_ERRNO = 1001; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_song` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_song`(IN song_name_p VARCHAR(64))
BEGIN
DECLARE songId_v INT;
SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p;
IF EXISTS (SELECT * FROM song WHERE songId = songId_v)
THEN DELETE FROM song
	 WHERE (songId = songId_v);
ELSE 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot delete a song that does not exist in our database.',
            MYSQL_ERRNO = 1001; 
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_song_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_song_review`(IN song_name_p VARCHAR(64), IN userId_p INT)
BEGIN 
DECLARE songId_v INT; 
SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p;

IF EXISTS (SELECT * FROM song_review WHERE songId = songId_v AND userId = userId_p) 
THEN DELETE FROM song_review  
	WHERE songId = songId_v AND userId = userId_p;
ELSE 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You cannot delete a song review you never made.',
            MYSQL_ERRNO = 1001; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_album_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_album_review`(IN userId_p INT, IN album_rating_p DECIMAL(2,1), IN album_name_p VARCHAR(64))
BEGIN 
	DECLARE albumId_v INT;
	IF album_rating_p IS NOT NULL AND album_name_p IS NOT NULL THEN 
		IF EXISTS (SELECT albumId FROM album WHERE album_name = album_name_p) AND 
        EXISTS (SELECT album_rating FROM album_review WHERE album_rating = album_rating_p) THEN
		SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p;
		SELECT * FROM album_review WHERE album_rating = album_rating_p AND albumId = albumId_v;
        IF NOT EXISTS (SELECT * FROM user_searches_al_review WHERE userId = userId_p AND albumId = albumId_v) THEN 
		INSERT INTO user_searches_al_review VALUES (userId_p, albumId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'The album rating and/or the album name you specified is not
				in the database.',
				MYSQL_ERRNO = 1001; 
        END IF; 
    ELSEIF album_rating_p IS NOT NULL AND album_name_p IS NULL THEN 
		IF EXISTS (SELECT album_rating FROM album_review WHERE album_rating = album_rating_p) THEN 
        SELECT albumId INTO albumId_v FROM album_review WHERE album_rating = album_rating_p LIMIT 1;
		SELECT * FROM album_review WHERE album_rating = album_rating_p;
		IF NOT EXISTS (SELECT * FROM user_searches_al_review WHERE userId = userId_p AND albumId = albumId_v) THEN 
		INSERT INTO user_searches_al_review VALUES (userId_p, albumId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The album rating you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
		END IF; 
	ELSEIF album_rating_p IS NULL AND album_name_p IS NOT NULL THEN 
		IF EXISTS (SELECT albumId FROM album WHERE album_name = album_name_p) THEN 
        SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p; 
		SELECT * FROM album_review WHERE albumId = albumId_v;
		IF NOT EXISTS (SELECT * FROM user_searches_al_review WHERE userId = userId_p AND albumId = albumId_v) THEN 
		INSERT INTO user_searches_al_review VALUES (userId_p, albumId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The album name you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
		END IF; 
    ELSEIF album_rating_p IS NULL AND album_name_p IS NULL THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You must at specify at least one: album rating or the album name.',
            MYSQL_ERRNO = 1001; 
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_artist_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_artist_review`(IN userId_p INT, IN artist_rating_p DECIMAL(2,1), 
IN artist_name_p VARCHAR(64))
BEGIN 
	DECLARE artistId_v INT;
	IF artist_rating_p IS NOT NULL AND artist_name_p IS NOT NULL THEN 
		IF EXISTS (SELECT artistId FROM artist WHERE artist_name = artist_name_p) AND 
        EXISTS (SELECT artist_rating FROM artist_review WHERE artist_rating = artist_rating_p) THEN
		SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p;
		SELECT * FROM artist_review WHERE artist_rating = artist_rating_p AND artistId = artistId_v;
        IF NOT EXISTS (SELECT * FROM user_searches_ar_review WHERE userId = userId_p AND artistId = artistId_v) THEN 
		INSERT INTO user_searches_ar_review VALUES (userId_p, artistId_v);  
        END IF; 
        ELSE
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'The artist rating and/or the artist name you specified is not
				in the database.',
				MYSQL_ERRNO = 1001; 
        END IF; 
    ELSEIF artist_rating_p IS NOT NULL AND artist_name_p IS NULL THEN 
		IF EXISTS (SELECT artist_rating FROM artist_review WHERE artist_rating = artist_rating_p) THEN 
        SELECT artistId INTO artistId_v FROM artist_review WHERE artist_rating = artist_rating_p LIMIT 1;
		SELECT * FROM artist_review WHERE artist_rating = artist_rating_p;
        IF NOT EXISTS (SELECT * FROM user_searches_ar_review WHERE userId = userId_p AND artistId = artistId_v) THEN 
		INSERT INTO user_searches_ar_review VALUES (userId_p, artistId_v);   
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The artist rating you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
		END IF; 
	ELSEIF artist_rating_p IS NULL AND artist_name_p IS NOT NULL THEN 
		IF EXISTS (SELECT artistId FROM artist WHERE artist_name = artist_name_p) THEN 
        SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p; 
		SELECT * FROM artist_review WHERE artistId = artistId_v;
        IF NOT EXISTS (SELECT * FROM user_searches_ar_review WHERE userId = userId_p AND artistId = artistId_v) THEN 
		INSERT INTO user_searches_ar_review VALUES (userId_p, artistId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The artist name you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
		END IF; 
    ELSEIF artist_rating_p IS NULL AND artist_name_p IS NULL THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You must at specify at least one: artist rating or the artist name.',
            MYSQL_ERRNO = 1001; 
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_song_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_song_review`(IN userId_p INT, IN song_rating_p DECIMAL(2,1), IN song_name_p VARCHAR(64))
BEGIN 
	DECLARE songId_v INT;
	IF song_rating_p IS NOT NULL AND song_name_p IS NOT NULL THEN 
		IF EXISTS (SELECT songId FROM song WHERE song_name = song_name_p) AND 
        EXISTS (SELECT song_rating FROM song_review WHERE song_rating = song_rating_p) THEN
		SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p;
		SELECT * FROM song_review WHERE song_rating = song_rating_p AND songId = songId_v;
        IF NOT EXISTS (SELECT * FROM user_searches_s_review WHERE userId = userId_p AND songId = songId_v) THEN 
		INSERT INTO user_searches_s_review VALUES (userId_p, songId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'The song rating and/or the song name you specified is not
				in the database.',
				MYSQL_ERRNO = 1001; 
        END IF; 
    ELSEIF song_rating_p IS NOT NULL AND song_name_p IS NULL THEN 
		IF EXISTS (SELECT song_rating FROM song_review WHERE song_rating = song_rating_p) THEN 
        SELECT songId INTO songId_v FROM song_review WHERE song_rating = song_rating_p LIMIT 1;
		SELECT * FROM song_review WHERE song_rating = song_rating_p;
		IF NOT EXISTS (SELECT * FROM user_searches_s_review WHERE userId = userId_p AND songId = songId_v) THEN 
		INSERT INTO user_searches_s_review VALUES (userId_p, songId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song rating you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
		END IF; 
	ELSEIF song_rating_p IS NULL AND song_name_p IS NOT NULL THEN 
		IF EXISTS (SELECT songId FROM song WHERE song_name = song_name_p) THEN 
        SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p; 
		SELECT * FROM song_review WHERE songId = songId_v;
		IF NOT EXISTS (SELECT * FROM user_searches_s_review WHERE userId = userId_p AND songId = songId_v) THEN 
		INSERT INTO user_searches_s_review VALUES (userId_p, songId_v);  
        END IF; 
        ELSE 
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song name you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
		END IF; 
    ELSEIF song_rating_p IS NULL AND song_name_p IS NULL THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You must at specify at least one: song rating or the song name.',
            MYSQL_ERRNO = 1001; 
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pop_ss` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pop_ss`()
BEGIN 
    SELECT service_name, COUNT(userId) FROM user_use_ss GROUP BY service_name ORDER BY COUNT(userId) DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_album` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_album`(userId_p INT, release_year_p INT, album_genre_name_p VARCHAR(64))
BEGIN
DECLARE albumId_v INT; 

IF release_year_p IS NOT NULL AND album_genre_name_p IS NOT NULL THEN 
	IF EXISTS (SELECT release_year FROM album WHERE release_year = release_year_p) AND 
    EXISTS (SELECT album_genre_name FROM album_genre WHERE album_genre_name = album_genre_name_p) THEN
    SELECT albumId INTO albumId_v FROM (SELECT * FROM album NATURAL JOIN album_genre 
    WHERE release_year = release_year_p AND album_genre_name = album_genre_name_p) AS p LIMIT 1;
    SELECT * FROM album NATURAL JOIN album_genre WHERE release_year = release_year_p AND album_genre_name = album_genre_name_p;
	IF NOT EXISTS (SELECT * FROM user_searches_album WHERE userId = userId_p AND albumId = albumId_v) THEN 
    INSERT INTO user_searches_album VALUES (userId_p, albumId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'The album release year and/or the album genre name you specified is not
					in the database.',
					MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF release_year_p IS NULL AND album_genre_name_p IS NOT NULL THEN 
	IF EXISTS (SELECT album_genre_name FROM album_genre WHERE album_genre_name = album_genre_name_p) THEN 
	SELECT albumId INTO albumId_v FROM (SELECT * FROM album NATURAL 
	JOIN album_genre WHERE album_genre_name = album_genre_name_p) AS q LIMIT 1;
    SELECT * FROM album NATURAL JOIN album_genre WHERE album_genre_name = album_genre_name_p; 
	IF NOT EXISTS (SELECT * FROM user_searches_album WHERE userId = userId_p AND albumId = albumId_v) THEN 
    INSERT INTO user_searches_album VALUES (userId_p, albumId_v); 
    END IF; 
	ELSE 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'The album genre name you specified is not in the database.',
		MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF release_year_p IS NOT NULL AND album_genre_name_p IS NULL THEN 
	IF EXISTS (SELECT * FROM album WHERE release_year = release_year_p) THEN 
	SELECT albumId INTO albumId_v FROM album WHERE release_year = release_year_p LIMIT 1; 
    SELECT * FROM album WHERE release_year = release_year_p;
	IF NOT EXISTS (SELECT * FROM user_searches_album WHERE userId = userId_p AND albumId = albumId_v) THEN 
    INSERT INTO user_searches_album VALUES (userId_p, albumId_v); 
    END IF; 
	ELSE 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'The release year you specified is not in the database.',
		MYSQL_ERRNO = 1001; 
	END IF; 
ELSE
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You must at specify at least one: album release year or the album genre.',
            MYSQL_ERRNO = 1001; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_album_exist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_album_exist`(IN userId_p INT, IN album_name_p VARCHAR(64))
BEGIN 
	DECLARE albumId_v INT; 
    IF EXISTS (SELECT album_name FROM album WHERE album_name = album_name_p) THEN 
	SELECT * FROM album WHERE album_name = album_name_p; 
    SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p; 
    IF NOT EXISTS (SELECT * FROM user_searches_album WHERE userId = userId_p AND albumId = albumId_v) THEN
    INSERT INTO user_searches_album VALUES (userId_p, albumId_v);
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Album does not exist in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_artist_exist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_artist_exist`(IN userId_p INT, IN artist_name_p VARCHAR(64))
BEGIN 
	DECLARE artistId_v INT; 
    IF EXISTS (SELECT artist_name FROM artist WHERE artist_name = artist_name_p) THEN 
	SELECT * FROM artist WHERE artist_name = artist_name_p; 
    SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p; 
    IF NOT EXISTS (SELECT * FROM user_searches_artist WHERE userId = userId_p AND artistId = artistId_v) THEN
    INSERT INTO user_searches_artist VALUES (userId_p, artistId_v);
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Artist does not exist in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_song` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_song`(IN userId_p INT, IN musical_key_p VARCHAR(10), IN song_length_p TIME, 
IN song_language_p VARCHAR(64), IN song_genre_name_p VARCHAR(64))
BEGIN 
DECLARE songId_v INT; 

IF song_genre_name_p IS NULL AND musical_key_p IS NULL AND song_length_p IS NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT song_language FROM song WHERE song_language = song_language_p) THEN 
	SELECT * FROM song WHERE song_language = song_language_p; 
	SELECT songId INTO songId_v FROM song WHERE song_language = song_language_p LIMIT 1; 
    IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NULL AND musical_key_p IS NULL AND song_length_p IS NOT NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT song_length FROM song WHERE ABS(song_length - song_length_p) < 15) THEN 
	SELECT * FROM song WHERE ABS(song_length - song_length_p) < 15; 
	SELECT songId INTO songId_v FROM song WHERE ABS(song_length - song_length_p) < 15 LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
	ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The length you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NULL AND musical_key_p IS NOT NULL AND song_length_p IS NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT musical_key FROM song WHERE musical_key = musical_key_p) THEN 
	SELECT * FROM song WHERE musical_key = musical_key_p; 
	SELECT songId INTO songId_v FROM song WHERE musical_key = musical_key_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
	ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The musical key you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NULL AND song_length_p IS NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT song_genre_name FROM song WHERE song_genre_name = song_genre_name_p) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p ;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF;
	ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NULL AND song_length_p IS NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND song_language = song_language_p;  
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND song_language = song_language_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or the song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NULL AND song_length_p IS NOT NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND ABS(song_length - song_length_p) < 15) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND ABS(song_length - song_length_p) < 15 LIMIT 1;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND ABS(song_length - song_length_p) < 15;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or the song length (within 15 seconds) you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p  IS NOT NULL AND musical_key_p IS NOT NULL AND song_length_p IS NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or the song musical key you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NULL AND musical_key_p IS NULL AND song_length_p IS NOT NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE ABS(song_length - song_length_p) < 15 AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE ABS(song_length - song_length_p) < 15 AND song_language = song_language_p;
	SELECT songId INTO songId_v FROM song WHERE ABS(song_length - song_length_p) < 15 AND song_language = song_language_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song length (within 15 seconds) and/or the song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NULL AND musical_key_p IS NOT NULL AND song_length_p IS NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE musical_key = musical_key_p AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE musical_key = musical_key_p AND song_language = song_language_p;
	SELECT songId INTO songId_v FROM song WHERE musical_key = musical_key_p AND song_language = song_language_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song musical key and/or the song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NULL AND musical_key_p IS NOT NULL AND song_length_p IS NOT NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15) THEN 
	SELECT * FROM song WHERE musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15;
	SELECT songId INTO songId_v FROM song WHERE musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song musical key and/or the song length (within 15 seconds) you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NULL AND musical_key_p IS NOT NULL AND song_length_p IS NOT NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p;
	SELECT songId INTO songId_v FROM song WHERE musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p LIMIT 1;
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song musical key and/or the song length (within 15 seconds) and/or song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NULL AND song_length_p IS NOT NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p LIMIT 1; 
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or the song length (within 15 seconds) and/or song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NOT NULL AND song_length_p IS NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND song_language = song_language_p;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND song_language = song_language_p LIMIT 1; 
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or song musical key and/or song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NOT NULL AND song_length_p IS NOT NULL AND song_language_p IS NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 LIMIT 1; 
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF;
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or song musical key and/or song length (within 15 seconds) you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSEIF song_genre_name_p IS NOT NULL AND musical_key_p IS NOT NULL AND song_length_p IS NOT NULL AND song_language_p IS NOT NULL THEN 
	IF EXISTS (SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p) THEN 
	SELECT * FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p;
	SELECT songId INTO songId_v FROM song WHERE song_genre_name = song_genre_name_p AND musical_key = musical_key_p AND ABS(song_length - song_length_p) < 15 AND song_language = song_language_p LIMIT 1; 
	IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
	INSERT INTO user_searches_song VALUES (userId_p, songId_v); 
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'The song genre name and/or song musical key and/or song length (within 15 seconds) and/or song language you specified is not in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
ELSE 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You must at specify at least one of the filters.',
            MYSQL_ERRNO = 1001; 
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_song_exist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_song_exist`(IN userId_p INT, IN song_name_p VARCHAR(64))
BEGIN 
	DECLARE songId_v INT; 
    IF EXISTS (SELECT song_name FROM song WHERE song_name = song_name_p) THEN 
	SELECT * FROM song WHERE song_name = song_name_p; 
    SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p; 
    IF NOT EXISTS (SELECT * FROM user_searches_song WHERE userId = userId_p AND songId = songId_v) THEN 
    INSERT INTO user_searches_song VALUES (userId_p, songId_v);
    END IF; 
    ELSE 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Song does not exist in the database.',
            MYSQL_ERRNO = 1001; 
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_album_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_album_review`(IN userId_p INT, IN album_name_p VARCHAR(64), 
IN album_rating_p DECIMAL(2,1), IN album_review_desc_p VARCHAR(400))
BEGIN
	DECLARE albumId_v INT;    
	SELECT albumId INTO albumId_v FROM album WHERE album_name = album_name_p;
    
	IF (SELECT COUNT(userId) FROM album_review WHERE userId = userId_p AND albumId = albumId_v 
    GROUP BY userId) IS NOT NULL THEN 
    UPDATE album_review SET album_rating = album_rating_p, album_review_desc = album_review_desc_p
	WHERE userId = userId_p AND albumId = albumId_v; 
    ELSE
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You never made a review for this album yet. Please make a new album review instead.',
            MYSQL_ERRNO = 1001; 
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_artist_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_artist_review`(IN userId_p INT, IN artist_name_p VARCHAR(64), 
IN artist_rating_p DECIMAL(2,1), IN artist_review_desc_p VARCHAR(400))
BEGIN
	DECLARE artistId_v INT;    
	SELECT artistId INTO artistId_v FROM artist WHERE artist_name = artist_name_p;
    
	IF (SELECT COUNT(userId) FROM artist_review WHERE userId = userId_p AND artistId = artistId_v 
    GROUP BY userId) IS NOT NULL THEN 
    UPDATE artist_review SET artist_rating = artist_rating_p, artist_review_desc = artist_review_desc_p
	WHERE userId = userId_p AND artistId = artistId_v; 
    ELSE
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'You never made a review for this artist yet. Please make a new artist review instead.',
            MYSQL_ERRNO = 1062; 
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_song_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_song_review`(IN userId_p INT, IN song_name_p VARCHAR(64), 
IN song_rating_p DECIMAL(2,1), IN song_review_desc_p VARCHAR(400))
BEGIN
	DECLARE songId_v INT;    
	SELECT songId INTO songId_v FROM song WHERE song_name = song_name_p;
    
	IF (SELECT COUNT(userId) FROM song_review WHERE userId = userId_p AND songId = songId_v 
    GROUP BY userId) IS NOT NULL THEN 
    UPDATE song_review SET song_rating = song_rating_p, song_review_desc = song_review_desc_p
	WHERE userId = userId_p AND songId = songId_v; 
    ELSE
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'You never made a review for this song yet. Please make a new song review instead.',
            MYSQL_ERRNO = 1001; 
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-22 17:54:17
