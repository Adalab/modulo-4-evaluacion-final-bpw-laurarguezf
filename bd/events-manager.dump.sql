-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: events_manager
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `atendees`
--

DROP TABLE IF EXISTS `atendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atendees` (
  `idatendees` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `ticket_type` varchar(45) NOT NULL,
  PRIMARY KEY (`idatendees`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atendees`
--

LOCK TABLES `atendees` WRITE;
/*!40000 ALTER TABLE `atendees` DISABLE KEYS */;
INSERT INTO `atendees` VALUES (1,'Laura Gutiérrez','laura@gmail.com','987-654-322','General'),(2,'Pablo Herrera','pablo@gmail.com','876-543-210','VIP'),(3,'Silvia Castro','silvia@gmail.com','765-432-109','General'),(4,'Ricardo López','ricardo@gmail.com','654-321-098','General'),(5,'María González','mariag@gmail.com','543-210-987','Premium');
/*!40000 ALTER TABLE `atendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `idcategories` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idcategories`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Conferencias','Eventos relacionados con tecnología y ciencia'),(2,'Conciertos','Eventos musicales de cualquier tipo'),(3,'Exposiciones','Exposiciones artísticas o culturales'),(4,'Competencias','Hackathons o eventos competitivos'),(5,'Beneficencia','Eventos con fines de recaudación');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `idevents` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `date` date DEFAULT NULL,
  `capacity` int unsigned DEFAULT NULL,
  `price` float unsigned DEFAULT NULL,
  `idcategories` int NOT NULL,
  `idlocations` int DEFAULT NULL,
  `idorganizers` int DEFAULT NULL,
  PRIMARY KEY (`idevents`),
  KEY `fk_events_categories_idx` (`idcategories`),
  KEY `fk_events_locations1_idx` (`idlocations`),
  KEY `fk_events_organizers1_idx` (`idorganizers`),
  CONSTRAINT `fk_events_categories` FOREIGN KEY (`idcategories`) REFERENCES `categories` (`idcategories`),
  CONSTRAINT `fk_events_locations1` FOREIGN KEY (`idlocations`) REFERENCES `locations` (`idlocations`),
  CONSTRAINT `fk_events_organizers1` FOREIGN KEY (`idorganizers`) REFERENCES `organizers` (`idorganizers`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Tech Summit 2024','Conferencia anual sobre innovación tecnológica','2024-10-15',500,50,1,1,1),(2,'Festival de Música','Festival con bandas nacionales e internacionales','2024-08-23',3000,80,2,3,2),(3,'Feria del Libro','Exposición de libros y firma de autores','2024-06-12',1000,0,3,1,2),(4,'Hackathon de Startups','Maratón de desarrollo para startups emergentes',NULL,NULL,NULL,4,NULL,NULL),(5,'Gala de Beneficencia','Evento anual de recaudación de fondos','2024-11-10',150,99.5,5,2,5);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_has_atendees`
--

DROP TABLE IF EXISTS `events_has_atendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_has_atendees` (
  `idevents` int NOT NULL,
  `idatendees` int NOT NULL,
  PRIMARY KEY (`idevents`,`idatendees`),
  KEY `fk_events_has_atendees_atendees1_idx` (`idatendees`),
  KEY `fk_events_has_atendees_events1_idx` (`idevents`),
  CONSTRAINT `fk_events_has_atendees_atendees1` FOREIGN KEY (`idatendees`) REFERENCES `atendees` (`idatendees`),
  CONSTRAINT `fk_events_has_atendees_events1` FOREIGN KEY (`idevents`) REFERENCES `events` (`idevents`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_has_atendees`
--

LOCK TABLES `events_has_atendees` WRITE;
/*!40000 ALTER TABLE `events_has_atendees` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_has_atendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_has_speakers`
--

DROP TABLE IF EXISTS `events_has_speakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_has_speakers` (
  `idevents` int NOT NULL,
  `idspeakers` int NOT NULL,
  PRIMARY KEY (`idevents`,`idspeakers`),
  KEY `fk_events_has_speakers_speakers1_idx` (`idspeakers`),
  KEY `fk_events_has_speakers_events1_idx` (`idevents`),
  CONSTRAINT `fk_events_has_speakers_events1` FOREIGN KEY (`idevents`) REFERENCES `events` (`idevents`),
  CONSTRAINT `fk_events_has_speakers_speakers1` FOREIGN KEY (`idspeakers`) REFERENCES `speakers` (`idspeakers`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_has_speakers`
--

LOCK TABLES `events_has_speakers` WRITE;
/*!40000 ALTER TABLE `events_has_speakers` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_has_speakers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_has_sponsors`
--

DROP TABLE IF EXISTS `events_has_sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_has_sponsors` (
  `idevents` int NOT NULL,
  `idsponsors` int NOT NULL,
  PRIMARY KEY (`idevents`,`idsponsors`),
  KEY `fk_events_has_sponsors_sponsors1_idx` (`idsponsors`),
  KEY `fk_events_has_sponsors_events1_idx` (`idevents`),
  CONSTRAINT `fk_events_has_sponsors_events1` FOREIGN KEY (`idevents`) REFERENCES `events` (`idevents`),
  CONSTRAINT `fk_events_has_sponsors_sponsors1` FOREIGN KEY (`idsponsors`) REFERENCES `sponsors` (`idsponsors`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_has_sponsors`
--

LOCK TABLES `events_has_sponsors` WRITE;
/*!40000 ALTER TABLE `events_has_sponsors` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_has_sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `idlocations` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`idlocations`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Outdoors','Madrid','Spain'),(2,'Indoors','Paris','Francia'),(3,'Outdoors','Lisboa','Portugal'),(4,'Outdoors','New York','USA'),(5,'Indoors','Beijing','China');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizers`
--

DROP TABLE IF EXISTS `organizers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizers` (
  `idorganizers` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `organization_name` varchar(100) NOT NULL,
  PRIMARY KEY (`idorganizers`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizers`
--

LOCK TABLES `organizers` WRITE;
/*!40000 ALTER TABLE `organizers` DISABLE KEYS */;
INSERT INTO `organizers` VALUES (1,'Ana Pérez','ana@gmail.com','123-456-789','Tech Events Inc'),(2,'Carlos Rodríguez','carlos@gmail.com','987-654-321','Eventos S.A.'),(3,'Luisa Gómez','luisa@gmail.com','234-567-891','Ferias y Expos S.A.'),(4,'Miguel Torres','miguel@gmail.com','456-789-123','Innovation inc'),(5,'María Sánchez','maria@gmail.com','789-123-456','ExpoEvent Inc');
/*!40000 ALTER TABLE `organizers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speakers`
--

DROP TABLE IF EXISTS `speakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `speakers` (
  `idspeakers` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `website` varchar(200) NOT NULL,
  PRIMARY KEY (`idspeakers`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speakers`
--

LOCK TABLES `speakers` WRITE;
/*!40000 ALTER TABLE `speakers` DISABLE KEYS */;
INSERT INTO `speakers` VALUES (1,'Juan Martínez','https://conferencias.com/juan'),(2,'Sara Blanco','https://musica.com/sara'),(3,'Pedro Ruiz','https://ferias.com/pedro'),(4,'Marta Fernández','https://startups.com/marta'),(5,'Carlos Gómez','https://galas.com/carlos');
/*!40000 ALTER TABLE `speakers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsors` (
  `idsponsors` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `website` varchar(200) NOT NULL,
  PRIMARY KEY (`idsponsors`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsors`
--

LOCK TABLES `sponsors` WRITE;
/*!40000 ALTER TABLE `sponsors` DISABLE KEYS */;
INSERT INTO `sponsors` VALUES (1,'Tech Corp','https://techcorp.com'),(2,'Música Global','https://musicaglobal.com'),(3,'Cultura Viva','https://culturaviva.com'),(4,'Network Events','https://eventsnetwork.com'),(5,'Expo Fun','https://expofun.com');
/*!40000 ALTER TABLE `sponsors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-28 13:36:50
