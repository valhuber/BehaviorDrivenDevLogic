CREATE DATABASE  IF NOT EXISTS `ValsEval_data` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ValsEval_data`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: evaldb.espressologic.com    Database: ValsEval_data
-- ------------------------------------------------------
-- Server version	5.5.27-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Logic`
--

DROP TABLE IF EXISTS `Logic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Logic` (
  `idLogic` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Stub, representing Espresso''s Rules table',
  `Name` varchar(95) DEFAULT NULL,
  `Notes` varchar(95) DEFAULT NULL,
  PRIMARY KEY (`idLogic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Logic`
--

LOCK TABLES `Logic` WRITE;
/*!40000 ALTER TABLE `Logic` DISABLE KEYS */;
/*!40000 ALTER TABLE `Logic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Person` (
  `Name` varchar(45) DEFAULT NULL,
  `DaysToDo` int(11) DEFAULT NULL,
  `idPerson` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPerson`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES ('VP Mktg',2,1),('Don Dev',NULL,2);
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sprint`
--

DROP TABLE IF EXISTS `Sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sprint` (
  `Name` varchar(45) DEFAULT NULL,
  `Target` date DEFAULT NULL,
  `idSprint` int(11) NOT NULL AUTO_INCREMENT,
  `DaysToGo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSprint`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sprint`
--

LOCK TABLES `Sprint` WRITE;
/*!40000 ALTER TABLE `Sprint` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Story`
--

DROP TABLE IF EXISTS `Story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Story` (
  `idUser` int(11) DEFAULT NULL,
  `Feature` varchar(45) DEFAULT NULL COMMENT 'As a <type of user>, I want <some goal> so that <some reason>',
  `Benefit` varchar(45) DEFAULT NULL,
  `DaysToDo` int(11) DEFAULT NULL,
  `idStory` int(11) NOT NULL AUTO_INCREMENT,
  `idDeveloper` int(11) DEFAULT NULL,
  PRIMARY KEY (`idStory`),
  KEY `Manager__Manages_idx` (`idDeveloper`),
  KEY `OwnedBy__DefinesStories_idx` (`idUser`),
  CONSTRAINT `ImplementedBy__BuildsStories` FOREIGN KEY (`idDeveloper`) REFERENCES `Person` (`idPerson`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OwnedBy__DefinesStories` FOREIGN KEY (`idUser`) REFERENCES `Person` (`idPerson`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Story`
--

LOCK TABLES `Story` WRITE;
/*!40000 ALTER TABLE `Story` DISABLE KEYS */;
INSERT INTO `Story` VALUES (1,'Place Order','Track Orders, Verify Credit',0,3,NULL);
/*!40000 ALTER TABLE `Story` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoryBehavior`
--

DROP TABLE IF EXISTS `StoryBehavior`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoryBehavior` (
  `Name` varchar(45) DEFAULT NULL,
  `GivenThat` varchar(45) DEFAULT NULL,
  `ThenVerify` varchar(45) DEFAULT NULL,
  `Done` bit(1) DEFAULT NULL,
  `DaysToDo` int(11) DEFAULT NULL,
  `idStory` int(11) DEFAULT NULL,
  `idStoryBehavior` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) DEFAULT NULL,
  `idSprint` int(11) DEFAULT NULL,
  PRIMARY KEY (`idStoryBehavior`),
  KEY `Manager__Manages_idx` (`idStory`),
  KEY `Sprint__Behaviors_idx` (`idSprint`),
  KEY `Manager__Manages_idx1` (`idUser`),
  CONSTRAINT `Manager__Manages` FOREIGN KEY (`idUser`) REFERENCES `Person` (`idPerson`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Sprint__Behaviors` FOREIGN KEY (`idSprint`) REFERENCES `Sprint` (`idSprint`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Strory__Behaviors` FOREIGN KEY (`idStory`) REFERENCES `Story` (`idStory`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoryBehavior`
--

LOCK TABLES `StoryBehavior` WRITE;
/*!40000 ALTER TABLE `StoryBehavior` DISABLE KEYS */;
INSERT INTO `StoryBehavior` VALUES ('Check Credit','Balance exceeds credit limit','Transaction Rejected','\0',NULL,3,17,NULL,NULL),('Compute balance','Order is placed','Customer Balance and Order Total are correct','\0',NULL,3,20,NULL,NULL);
/*!40000 ALTER TABLE `StoryBehavior` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoryBehaviorLogic`
--

DROP TABLE IF EXISTS `StoryBehaviorLogic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoryBehaviorLogic` (
  `idStoryBehaviorLogic` int(11) NOT NULL AUTO_INCREMENT,
  `idLogic` int(11) DEFAULT NULL,
  PRIMARY KEY (`idStoryBehaviorLogic`),
  KEY `Logic__ImplementsBehaviors_idx` (`idLogic`),
  CONSTRAINT `StoryBehavior__ImplementingLogic` FOREIGN KEY (`idStoryBehaviorLogic`) REFERENCES `StoryBehavior` (`idStoryBehavior`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Logic__ImplementsBehaviors` FOREIGN KEY (`idLogic`) REFERENCES `Logic` (`idLogic`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoryBehaviorLogic`
--

LOCK TABLES `StoryBehaviorLogic` WRITE;
/*!40000 ALTER TABLE `StoryBehaviorLogic` DISABLE KEYS */;
/*!40000 ALTER TABLE `StoryBehaviorLogic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TABLE 7`
--

DROP TABLE IF EXISTS `TABLE 7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TABLE 7` (
  `name` varchar(4) DEFAULT NULL,
  `salary` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TABLE 7`
--

LOCK TABLES `TABLE 7` WRITE;
/*!40000 ALTER TABLE `TABLE 7` DISABLE KEYS */;
INSERT INTO `TABLE 7` VALUES ('John',2),('Mary',3);
/*!40000 ALTER TABLE `TABLE 7` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-17 19:24:45
