-- MySQL dump 10.13  Distrib 5.1.44, for apple-darwin8.11.1 (i386)
--
-- Host: localhost    Database: live_db
-- ------------------------------------------------------
-- Server version	5.1.44

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
-- Current Database: `live_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `live_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `live_db`;

--
-- Table structure for table `hris_account`
--

DROP TABLE IF EXISTS `hris_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_guid` varchar(45) NOT NULL,
  `family_id` int(11) NOT NULL,
  `account_number` varchar(45) NOT NULL,
  `country_id` int(11) NOT NULL,
  `account_isprimary` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'True if account is used for payroll and billing',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `idx_number_country_unique` (`account_number`,`country_id`),
  UNIQUE KEY `idx_account_guid` (`account_guid`),
  KEY `fk_account_country_id` (`country_id`),
  KEY `fk_account_family_id` (`family_id`),
  CONSTRAINT `fk_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `hris_country_data` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_account_family_id` FOREIGN KEY (`family_id`) REFERENCES `hris_family` (`family_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_account`
--

LOCK TABLES `hris_account` WRITE;
/*!40000 ALTER TABLE `hris_account` DISABLE KEYS */;
INSERT INTO `hris_account` VALUES (1,'9231d9a5-fcf3-4887-881b-558607fb5748',1,'1111111',39,1);
/*!40000 ALTER TABLE `hris_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_address`
--

DROP TABLE IF EXISTS `hris_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_guid` varchar(45) NOT NULL,
  `family_id` int(11) DEFAULT NULL,
  `addresstype_id` int(11) NOT NULL DEFAULT '1',
  `country_id` int(11) NOT NULL DEFAULT '1',
  `phone_id` int(11) DEFAULT NULL,
  `location_id` int(11) NOT NULL DEFAULT '0',
  `address_postalcode` varchar(45) NOT NULL DEFAULT '-',
  `address_province` varchar(100) NOT NULL DEFAULT '-',
  `address_city` varchar(100) NOT NULL DEFAULT '-',
  `address_street` varchar(200) NOT NULL DEFAULT '-',
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `idx_address_guid` (`address_guid`),
  KEY `idx_address_addresstype_id` (`addresstype_id`),
  KEY `idx_address_family_id` (`family_id`),
  KEY `fk_address_country_id` (`country_id`),
  KEY `fk_address_phone_id` (`phone_id`),
  CONSTRAINT `fk_address_addresstype_id` FOREIGN KEY (`addresstype_id`) REFERENCES `hris_addresstype_data` (`addresstype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `hris_country_data` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_family_id` FOREIGN KEY (`family_id`) REFERENCES `hris_family` (`family_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `hris_phone_data` (`phone_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_address`
--

LOCK TABLES `hris_address` WRITE;
/*!40000 ALTER TABLE `hris_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_addresstype_data`
--

DROP TABLE IF EXISTS `hris_addresstype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_addresstype_data` (
  `addresstype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`addresstype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_addresstype_data`
--

LOCK TABLES `hris_addresstype_data` WRITE;
/*!40000 ALTER TABLE `hris_addresstype_data` DISABLE KEYS */;
INSERT INTO `hris_addresstype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `hris_addresstype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_addresstype_trans`
--

DROP TABLE IF EXISTS `hris_addresstype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_addresstype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `addresstype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `addresstype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `addresstype_id` (`addresstype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_addresstype_trans_ibfk_1` FOREIGN KEY (`addresstype_id`) REFERENCES `hris_addresstype_data` (`addresstype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_addresstype_trans`
--

LOCK TABLES `hris_addresstype_trans` WRITE;
/*!40000 ALTER TABLE `hris_addresstype_trans` DISABLE KEYS */;
INSERT INTO `hris_addresstype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Current'),(6,3,'zh-Hans','[zh-Hans]Current'),(7,4,'en','Business'),(8,4,'zh-Hans','[zh-Hans]Business'),(9,5,'en','Permanent'),(10,5,'zh-Hans','[zh-Hans]Permanent'),(11,6,'en','Temporary'),(12,6,'zh-Hans','[zh-Hans]Temporary'),(13,7,'en','Other'),(14,7,'zh-Hans','[zh-Hans]Other');
/*!40000 ALTER TABLE `hris_addresstype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_altcontact`
--

DROP TABLE IF EXISTS `hris_altcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_altcontact` (
  `altcontact_id` int(11) NOT NULL AUTO_INCREMENT,
  `altcontact_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `altcontacttype_id` int(11) NOT NULL,
  `altcontact_contact` varchar(128) NOT NULL DEFAULT '-',
  PRIMARY KEY (`altcontact_id`),
  UNIQUE KEY `idx_altcontact_guid` (`altcontact_guid`),
  KEY `fk_altcontact_ren_id` (`ren_id`),
  KEY `fk_altcontacttype_id` (`altcontacttype_id`),
  CONSTRAINT `fk_altcontacttype_id` FOREIGN KEY (`altcontacttype_id`) REFERENCES `hris_altcontacttype_data` (`altcontacttype_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_altcontact_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_altcontact`
--

LOCK TABLES `hris_altcontact` WRITE;
/*!40000 ALTER TABLE `hris_altcontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_altcontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_altcontacttype_data`
--

DROP TABLE IF EXISTS `hris_altcontacttype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_altcontacttype_data` (
  `altcontacttype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`altcontacttype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_altcontacttype_data`
--

LOCK TABLES `hris_altcontacttype_data` WRITE;
/*!40000 ALTER TABLE `hris_altcontacttype_data` DISABLE KEYS */;
INSERT INTO `hris_altcontacttype_data` VALUES (1,0),(2,0),(3,1);
/*!40000 ALTER TABLE `hris_altcontacttype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_altcontacttype_trans`
--

DROP TABLE IF EXISTS `hris_altcontacttype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_altcontacttype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `altcontacttype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `altcontacttype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `altcontacttype_id` (`altcontacttype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_altcontacttype_trans_ibfk_1` FOREIGN KEY (`altcontacttype_id`) REFERENCES `hris_altcontacttype_data` (`altcontacttype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_altcontacttype_trans`
--

LOCK TABLES `hris_altcontacttype_trans` WRITE;
/*!40000 ALTER TABLE `hris_altcontacttype_trans` DISABLE KEYS */;
INSERT INTO `hris_altcontacttype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Skype'),(6,3,'zh-Hans','[zh-Hans]Skype');
/*!40000 ALTER TABLE `hris_altcontacttype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_location_data`
--

DROP TABLE IF EXISTS `hris_assign_location_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_location_data` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_guid` varchar(45) NOT NULL,
  `locationtype_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`),
  KEY `locationtype_id` (`locationtype_id`),
  CONSTRAINT `hris_assign_location_data_ibfk_1` FOREIGN KEY (`locationtype_id`) REFERENCES `hris_assign_locationtype_data` (`locationtype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_location_data`
--

LOCK TABLES `hris_assign_location_data` WRITE;
/*!40000 ALTER TABLE `hris_assign_location_data` DISABLE KEYS */;
INSERT INTO `hris_assign_location_data` VALUES (1,'8bbe54c3-8860-4110-ac8d-b11742917169',3,0),(2,'1753287a-0d87-4f8f-b139-b790a50fa245',4,1),(3,'53381134-f210-4ca8-94f5-24ab3a35775d',4,1),(4,'03fc4054-b55f-4a5d-9751-b6c9efa2d756',4,1),(5,'a08b5292-c380-465f-887a-0dacfd0e1467',4,1),(6,'00e72daf-e07e-42ac-9afb-0ce820ee1297',4,1),(7,'4a93feff-4157-460c-94b7-e46b9056e344',4,1),(8,'32c1872e-ad9a-4d1d-8a8d-e27fea765df0',4,1),(9,'ffcffd1b-31e4-4fc9-9087-fe3b5a82bd27',4,1);
/*!40000 ALTER TABLE `hris_assign_location_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_location_trans`
--

DROP TABLE IF EXISTS `hris_assign_location_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_location_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `location_label` varchar(45) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `location_id` (`location_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_assign_location_trans_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `hris_assign_location_data` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAssignLocation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_location_trans`
--

LOCK TABLES `hris_assign_location_trans` WRITE;
/*!40000 ALTER TABLE `hris_assign_location_trans` DISABLE KEYS */;
INSERT INTO `hris_assign_location_trans` VALUES (1,1,'en','China'),(2,1,'zh-Hans','[zh-Hans]China'),(3,2,'en','NW'),(4,2,'zh-Hans','[zh-Hans]NW'),(5,3,'en','NE'),(6,3,'zh-Hans','[zh-Hans]NE'),(7,4,'en','BJ'),(8,4,'zh-Hans','[zh-Hans]BJ'),(9,5,'en','YR'),(10,5,'zh-Hans','[zh-Hans]YR'),(11,6,'en','MC'),(12,6,'zh-Hans','[zh-Hans]MC'),(13,7,'en','SH'),(14,7,'zh-Hans','[zh-Hans]SH'),(15,8,'en','SW'),(16,8,'zh-Hans','[zh-Hans]SW'),(17,9,'en','AOA'),(18,9,'zh-Hans','[zh-Hans]AOA');
/*!40000 ALTER TABLE `hris_assign_location_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_locationtype_data`
--

DROP TABLE IF EXISTS `hris_assign_locationtype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_locationtype_data` (
  `locationtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`locationtype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_locationtype_data`
--

LOCK TABLES `hris_assign_locationtype_data` WRITE;
/*!40000 ALTER TABLE `hris_assign_locationtype_data` DISABLE KEYS */;
INSERT INTO `hris_assign_locationtype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `hris_assign_locationtype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_locationtype_trans`
--

DROP TABLE IF EXISTS `hris_assign_locationtype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_locationtype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `locationtype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `locationtype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `locationtype_id` (`locationtype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_assign_locationtype_trans_ibfk_1` FOREIGN KEY (`locationtype_id`) REFERENCES `hris_assign_locationtype_data` (`locationtype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_locationtype_trans`
--

LOCK TABLES `hris_assign_locationtype_trans` WRITE;
/*!40000 ALTER TABLE `hris_assign_locationtype_trans` DISABLE KEYS */;
INSERT INTO `hris_assign_locationtype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Country'),(6,3,'zh-Hans','[zh-Hans]Country'),(7,4,'en','Region'),(8,4,'zh-Hans','[zh-Hans]Region'),(9,5,'en','Province'),(10,5,'zh-Hans','[zh-Hans]Province'),(11,6,'en','City'),(12,6,'zh-Hans','[zh-Hans]City'),(13,7,'en','Site'),(14,7,'zh-Hans','[zh-Hans]Site');
/*!40000 ALTER TABLE `hris_assign_locationtype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_mcc_data`
--

DROP TABLE IF EXISTS `hris_assign_mcc_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_mcc_data` (
  `mcc_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mcc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_mcc_data`
--

LOCK TABLES `hris_assign_mcc_data` WRITE;
/*!40000 ALTER TABLE `hris_assign_mcc_data` DISABLE KEYS */;
INSERT INTO `hris_assign_mcc_data` VALUES (1,0,0),(2,0,0),(3,0,0),(4,0,3),(5,0,3),(6,0,0),(7,0,0),(8,0,0),(9,0,8),(10,0,8),(11,0,8),(12,0,8),(13,0,0),(14,0,0),(15,0,0),(16,0,15),(17,0,15),(18,0,15),(19,0,0);
/*!40000 ALTER TABLE `hris_assign_mcc_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_mcc_trans`
--

DROP TABLE IF EXISTS `hris_assign_mcc_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_mcc_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `mcc_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `mcc_label` varchar(64) NOT NULL,
  `mcc_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `mcc_id` (`mcc_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_assign_mcc_trans_ibfk_1` FOREIGN KEY (`mcc_id`) REFERENCES `hris_assign_mcc_data` (`mcc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_mcc_trans`
--

LOCK TABLES `hris_assign_mcc_trans` WRITE;
/*!40000 ALTER TABLE `hris_assign_mcc_trans` DISABLE KEYS */;
INSERT INTO `hris_assign_mcc_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','CLM','Church-Led Movement'),(6,3,'zh-Hans','[zh-Hans]CLM','[zh-Hans]Church-Led Movement'),(7,4,'en','Orient Network',NULL),(8,4,'zh-Hans','[zh-Hans]Orient Network',NULL),(9,5,'en','Metro Link',NULL),(10,5,'zh-Hans','[zh-Hans]Metro Link',NULL),(11,6,'en','GSM','Global Sending Movement'),(12,6,'zh-Hans','[zh-Hans]GSM','[zh-Hans]Global Sending Movement'),(13,7,'en','LD/HR','Leadership Development/Human Resources'),(14,7,'zh-Hans','[zh-Hans]LD/HR','[zh-Hans]Leadership Development/Human Resources'),(15,8,'en','LLM','Leader-Led Movement'),(16,8,'zh-Hans','[zh-Hans]LLM','[zh-Hans]Leader-Led Movement'),(17,9,'en','CCOMM - TCS',NULL),(18,9,'zh-Hans','[zh-Hans]CCOMM - TCS',NULL),(19,10,'en','CCOMM - Young Professionals',NULL),(20,10,'zh-Hans','[zh-Hans]CCOMM - Young Professionals',NULL),(21,11,'en','CCOMM - Stage 2',NULL),(22,11,'zh-Hans','[zh-Hans]CCOMM - Stage 2',NULL),(23,12,'en','CCOMM - Family Life',NULL),(24,12,'zh-Hans','[zh-Hans]CCOMM - Family Life',NULL),(25,13,'en','MLM','Minority-Led Movement'),(26,13,'zh-Hans','[zh-Hans]MLM','[zh-Hans]Minority-Led Movement'),(27,14,'en','Ops','Operations'),(28,14,'zh-Hans','[zh-Hans]Ops','[zh-Hans]Operations'),(29,15,'en','SLM','Student-Led Movement'),(30,15,'zh-Hans','[zh-Hans]SLM','[zh-Hans]Student-Led Movement'),(31,16,'en','Asia Impact',NULL),(32,16,'zh-Hans','[zh-Hans]Asia Impact',NULL),(33,17,'en','Student Life',NULL),(34,17,'zh-Hans','[zh-Hans]Student Life',NULL),(35,18,'en','Faculty',NULL),(36,18,'zh-Hans','[zh-Hans]Faculty',NULL),(37,19,'en','VLM','Virtually-Led Movement'),(38,19,'zh-Hans','[zh-Hans]VLM','[zh-Hans]Virtually-Led Movement');
/*!40000 ALTER TABLE `hris_assign_mcc_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_position_data`
--

DROP TABLE IF EXISTS `hris_assign_position_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_position_data` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_position_data`
--

LOCK TABLES `hris_assign_position_data` WRITE;
/*!40000 ALTER TABLE `hris_assign_position_data` DISABLE KEYS */;
INSERT INTO `hris_assign_position_data` VALUES (1,0,0),(2,0,0);
/*!40000 ALTER TABLE `hris_assign_position_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_position_trans`
--

DROP TABLE IF EXISTS `hris_assign_position_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_position_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `position_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `position_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `position_id` (`position_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_assign_position_trans_ibfk_1` FOREIGN KEY (`position_id`) REFERENCES `hris_assign_position_data` (`position_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_position_trans`
--

LOCK TABLES `hris_assign_position_trans` WRITE;
/*!40000 ALTER TABLE `hris_assign_position_trans` DISABLE KEYS */;
INSERT INTO `hris_assign_position_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?');
/*!40000 ALTER TABLE `hris_assign_position_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_rptlvl_data`
--

DROP TABLE IF EXISTS `hris_assign_rptlvl_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_rptlvl_data` (
  `rptlvl_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rptlvl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_rptlvl_data`
--

LOCK TABLES `hris_assign_rptlvl_data` WRITE;
/*!40000 ALTER TABLE `hris_assign_rptlvl_data` DISABLE KEYS */;
INSERT INTO `hris_assign_rptlvl_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0);
/*!40000 ALTER TABLE `hris_assign_rptlvl_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_rptlvl_trans`
--

DROP TABLE IF EXISTS `hris_assign_rptlvl_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_rptlvl_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `rptlvl_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `rptlvl_label` varchar(64) NOT NULL,
  `rptlvl_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `rptlvl_id` (`rptlvl_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_assign_rptlvl_trans_ibfk_1` FOREIGN KEY (`rptlvl_id`) REFERENCES `hris_assign_rptlvl_data` (`rptlvl_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_rptlvl_trans`
--

LOCK TABLES `hris_assign_rptlvl_trans` WRITE;
/*!40000 ALTER TABLE `hris_assign_rptlvl_trans` DISABLE KEYS */;
INSERT INTO `hris_assign_rptlvl_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Local','You serve in a field ministry on a campus, in a city, or in part of a city or area'),(6,3,'zh-Hans','[zh-Hans]Local','[zh-Hans]You serve in a field ministry on a campus, in a city, or in part of a city or area'),(7,4,'en','Region','You serve in a field ministry team that oversees two or more MCC\'s'),(8,4,'zh-Hans','[zh-Hans]Region','[zh-Hans]You serve in a field ministry team that oversees two or more MCC\'s'),(9,5,'en','Area','You serve in an Area office'),(10,5,'zh-Hans','[zh-Hans]Area','[zh-Hans]You serve in an Area office');
/*!40000 ALTER TABLE `hris_assign_rptlvl_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_team_data`
--

DROP TABLE IF EXISTS `hris_assign_team_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_team_data` (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  `rptlvl_id` int(11) NOT NULL DEFAULT '0',
  `mcc_id` int(11) NOT NULL DEFAULT '0',
  `gma_locationID` int(11) NOT NULL DEFAULT '0',
  `team_type` varchar(10) NOT NULL DEFAULT 'PHYSICAL',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_team_data`
--

LOCK TABLES `hris_assign_team_data` WRITE;
/*!40000 ALTER TABLE `hris_assign_team_data` DISABLE KEYS */;
INSERT INTO `hris_assign_team_data` VALUES (1,0,0,0,0,'PHYSICAL'),(2,0,0,0,0,'PHYSICAL');
/*!40000 ALTER TABLE `hris_assign_team_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assign_team_trans`
--

DROP TABLE IF EXISTS `hris_assign_team_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assign_team_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `team_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `team_id` (`team_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_assign_team_trans_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `hris_assign_team_data` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assign_team_trans`
--

LOCK TABLES `hris_assign_team_trans` WRITE;
/*!40000 ALTER TABLE `hris_assign_team_trans` DISABLE KEYS */;
INSERT INTO `hris_assign_team_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?');
/*!40000 ALTER TABLE `hris_assign_team_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_assignment`
--

DROP TABLE IF EXISTS `hris_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_assignment` (
  `assignment_id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL DEFAULT '1',
  `position_id` int(11) NOT NULL DEFAULT '1',
  `assignment_startdate` date NOT NULL DEFAULT '1000-01-01',
  `assignment_enddate` date NOT NULL DEFAULT '1000-01-01',
  `assignment_isprimary` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`assignment_id`),
  UNIQUE KEY `idx_assignment_guid` (`assignment_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_assignment`
--

LOCK TABLES `hris_assignment` WRITE;
/*!40000 ALTER TABLE `hris_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_attachment_data`
--

DROP TABLE IF EXISTS `hris_attachment_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_attachment_data` (
  `attachment_id` int(11) NOT NULL AUTO_INCREMENT,
  `attachment_guid` varchar(45) NOT NULL,
  `attachment_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `attachment_filename` varchar(128) NOT NULL,
  `attachment_access` text NOT NULL,
  `attachmenttype_id` int(11) NOT NULL DEFAULT '1',
  `attachment_content` mediumblob,
  `attachment_mimetype` tinytext,
  PRIMARY KEY (`attachment_id`),
  UNIQUE KEY `idx_attachment_guid` (`attachment_guid`),
  KEY `fk_attachment_attachmenttype_id` (`attachmenttype_id`),
  CONSTRAINT `fk_attachment_attachmenttype_id` FOREIGN KEY (`attachmenttype_id`) REFERENCES `hris_attachmenttype_data` (`attachmenttype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_attachment_data`
--

LOCK TABLES `hris_attachment_data` WRITE;
/*!40000 ALTER TABLE `hris_attachment_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_attachment_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_attachment_trans`
--

DROP TABLE IF EXISTS `hris_attachment_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_attachment_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `attachment_id` int(11) NOT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `attachment_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `attachment_id` (`attachment_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_attachment_trans_ibfk_1` FOREIGN KEY (`attachment_id`) REFERENCES `hris_attachment_data` (`attachment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translatable Fields for HRISAttachment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_attachment_trans`
--

LOCK TABLES `hris_attachment_trans` WRITE;
/*!40000 ALTER TABLE `hris_attachment_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_attachment_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_attachmenttype_data`
--

DROP TABLE IF EXISTS `hris_attachmenttype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_attachmenttype_data` (
  `attachmenttype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attachmenttype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_attachmenttype_data`
--

LOCK TABLES `hris_attachmenttype_data` WRITE;
/*!40000 ALTER TABLE `hris_attachmenttype_data` DISABLE KEYS */;
INSERT INTO `hris_attachmenttype_data` VALUES (1,0),(2,0),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1);
/*!40000 ALTER TABLE `hris_attachmenttype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_attachmenttype_trans`
--

DROP TABLE IF EXISTS `hris_attachmenttype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_attachmenttype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `attachmenttype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `attachmenttype_label` varchar(64) NOT NULL,
  `attachmenttype_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `attachmenttype_id` (`attachmenttype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_attachmenttype_trans_ibfk_1` FOREIGN KEY (`attachmenttype_id`) REFERENCES `hris_attachmenttype_data` (`attachmenttype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_attachmenttype_trans`
--

LOCK TABLES `hris_attachmenttype_trans` WRITE;
/*!40000 ALTER TABLE `hris_attachmenttype_trans` DISABLE KEYS */;
INSERT INTO `hris_attachmenttype_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Selection Package','A compilation of documents and evaluations created during the selection process'),(6,3,'zh-Hans','[zh-Hans]Selection Package','[zh-Hans]A compilation of documents and evaluations created during the selection process'),(7,4,'en','ID Picture','A picture that can be used to identify the user'),(8,4,'zh-Hans','[zh-Hans]ID Picture','[zh-Hans]A picture that can be used to identify the user'),(9,5,'en','Passport Page','A digital scan of a user\'s passport picture page'),(10,5,'zh-Hans','[zh-Hans]Passport Page','[zh-Hans]A digital scan of a user\'s passport picture page'),(11,6,'en','Assessment Tool','Data used for personal assessment'),(12,6,'zh-Hans','[zh-Hans]Assessment Tool','[zh-Hans]Data used for personal assessment'),(13,7,'en','Personal Development','Data used for personal development'),(14,7,'zh-Hans','[zh-Hans]Personal Development','[zh-Hans]Data used for personal development'),(15,8,'en','MPD','Data used for Ministry Partner Development'),(16,8,'zh-Hans','[zh-Hans]MPD','[zh-Hans]Data used for Ministry Partner Development');
/*!40000 ALTER TABLE `hris_attachmenttype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_attitude_data`
--

DROP TABLE IF EXISTS `hris_attitude_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_attitude_data` (
  `attitude_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attitude_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_attitude_data`
--

LOCK TABLES `hris_attitude_data` WRITE;
/*!40000 ALTER TABLE `hris_attitude_data` DISABLE KEYS */;
INSERT INTO `hris_attitude_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0);
/*!40000 ALTER TABLE `hris_attitude_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_attitude_trans`
--

DROP TABLE IF EXISTS `hris_attitude_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_attitude_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `attitude_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `attitude_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `attitude_id` (`attitude_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_attitude_trans_ibfk_1` FOREIGN KEY (`attitude_id`) REFERENCES `hris_attitude_data` (`attitude_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_attitude_trans`
--

LOCK TABLES `hris_attitude_trans` WRITE;
/*!40000 ALTER TABLE `hris_attitude_trans` DISABLE KEYS */;
INSERT INTO `hris_attitude_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','NA - Deceased'),(6,3,'zh-Hans','[zh-Hans]NA - Deceased'),(7,4,'en','Very Favorable'),(8,4,'zh-Hans','[zh-Hans]Very Favorable'),(9,5,'en','Favorable'),(10,5,'zh-Hans','[zh-Hans]Favorable'),(11,6,'en','Neutral'),(12,6,'zh-Hans','[zh-Hans]Neutral'),(13,7,'en','Some Concerns'),(14,7,'zh-Hans','[zh-Hans]Some Concerns'),(15,8,'en','Opposed'),(16,8,'zh-Hans','[zh-Hans]Opposed'),(17,9,'en','Unknown'),(18,9,'zh-Hans','[zh-Hans]Unknown');
/*!40000 ALTER TABLE `hris_attitude_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_bloodtype_data`
--

DROP TABLE IF EXISTS `hris_bloodtype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_bloodtype_data` (
  `bloodtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`bloodtype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_bloodtype_data`
--

LOCK TABLES `hris_bloodtype_data` WRITE;
/*!40000 ALTER TABLE `hris_bloodtype_data` DISABLE KEYS */;
INSERT INTO `hris_bloodtype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0);
/*!40000 ALTER TABLE `hris_bloodtype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_bloodtype_trans`
--

DROP TABLE IF EXISTS `hris_bloodtype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_bloodtype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `bloodtype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `bloodtype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `bloodtype_id` (`bloodtype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_bloodtype_trans_ibfk_1` FOREIGN KEY (`bloodtype_id`) REFERENCES `hris_bloodtype_data` (`bloodtype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_bloodtype_trans`
--

LOCK TABLES `hris_bloodtype_trans` WRITE;
/*!40000 ALTER TABLE `hris_bloodtype_trans` DISABLE KEYS */;
INSERT INTO `hris_bloodtype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','A+'),(6,3,'zh-Hans','[zh-Hans]A+'),(7,4,'en','A-'),(8,4,'zh-Hans','[zh-Hans]A-'),(9,5,'en','B+'),(10,5,'zh-Hans','[zh-Hans]B+'),(11,6,'en','B-'),(12,6,'zh-Hans','[zh-Hans]B-'),(13,7,'en','AB+'),(14,7,'zh-Hans','[zh-Hans]AB+'),(15,8,'en','AB-'),(16,8,'zh-Hans','[zh-Hans]AB-'),(17,9,'en','O+'),(18,9,'zh-Hans','[zh-Hans]O+'),(19,10,'en','O-'),(20,10,'zh-Hans','[zh-Hans]O-');
/*!40000 ALTER TABLE `hris_bloodtype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_change`
--

DROP TABLE IF EXISTS `hris_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_change` (
  `change_id` int(11) NOT NULL AUTO_INCREMENT,
  `dbfield_id` int(11) NOT NULL,
  `change_previous_value` text NOT NULL,
  `change_new_value` text NOT NULL,
  `changegroup_id` int(11) NOT NULL,
  PRIMARY KEY (`change_id`),
  KEY `dbfield_id` (`dbfield_id`),
  KEY `changegroup_id` (`changegroup_id`),
  CONSTRAINT `fk_changegroup_id` FOREIGN KEY (`changegroup_id`) REFERENCES `hris_changegroup` (`changegroup_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_change_dbfield_id` FOREIGN KEY (`dbfield_id`) REFERENCES `hris_perm_dbfield` (`dbfield_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_change`
--

LOCK TABLES `hris_change` WRITE;
/*!40000 ALTER TABLE `hris_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_changegroup`
--

DROP TABLE IF EXISTS `hris_changegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_changegroup` (
  `changegroup_id` int(11) NOT NULL AUTO_INCREMENT,
  `changegroup_timestamp` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changegroup_requester_id` int(11) NOT NULL,
  `changegroup_approver_id` int(11) DEFAULT NULL,
  `ren_id` int(11) DEFAULT NULL,
  `family_id` int(11) NOT NULL,
  `changegroup_changetype` varchar(32) NOT NULL,
  `changegroup_status` varchar(32) NOT NULL,
  `changegroup_comment` text NOT NULL,
  `changegroup_resolution_timestamp` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`changegroup_id`),
  KEY `idx_ren_id` (`ren_id`),
  KEY `idx_changegroup_requester_id` (`changegroup_requester_id`),
  KEY `idx_changegroup_approver_id` (`changegroup_approver_id`),
  KEY `idx_family_id` (`family_id`),
  CONSTRAINT `fk_changegroup_approver_id` FOREIGN KEY (`changegroup_approver_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_changegroup_family_id` FOREIGN KEY (`family_id`) REFERENCES `hris_family` (`family_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_changegroup_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_changegroup_requester_id` FOREIGN KEY (`changegroup_requester_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_changegroup`
--

LOCK TABLES `hris_changegroup` WRITE;
/*!40000 ALTER TABLE `hris_changegroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_changegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_changestatustype`
--

DROP TABLE IF EXISTS `hris_changestatustype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_changestatustype` (
  `changestatustype_id` int(11) NOT NULL AUTO_INCREMENT,
  `changestatustype_name` varchar(45) NOT NULL,
  PRIMARY KEY (`changestatustype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_changestatustype`
--

LOCK TABLES `hris_changestatustype` WRITE;
/*!40000 ALTER TABLE `hris_changestatustype` DISABLE KEYS */;
INSERT INTO `hris_changestatustype` VALUES (1,'new'),(2,'awaiting feedback'),(3,'approved'),(4,'rejected');
/*!40000 ALTER TABLE `hris_changestatustype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_changetype`
--

DROP TABLE IF EXISTS `hris_changetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_changetype` (
  `changetype_id` int(11) NOT NULL AUTO_INCREMENT,
  `changetype_name` varchar(45) NOT NULL,
  PRIMARY KEY (`changetype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_changetype`
--

LOCK TABLES `hris_changetype` WRITE;
/*!40000 ALTER TABLE `hris_changetype` DISABLE KEYS */;
INSERT INTO `hris_changetype` VALUES (1,'add'),(2,'edit'),(3,'delete');
/*!40000 ALTER TABLE `hris_changetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_country_data`
--

DROP TABLE IF EXISTS `hris_country_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_country_data` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` char(2) NOT NULL,
  `country_callingcode` varchar(10) NOT NULL DEFAULT '-',
  `country_weight` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_country_data`
--

LOCK TABLES `hris_country_data` WRITE;
/*!40000 ALTER TABLE `hris_country_data` DISABLE KEYS */;
INSERT INTO `hris_country_data` VALUES (1,'00','',0),(2,'99','',0),(3,'AF','93',0),(4,'AX','',0),(5,'AL','355',0),(6,'DZ','213',0),(7,'AS','1 684',0),(8,'AD','376',0),(9,'AO','244',0),(10,'AI','1 264',0),(11,'AG','1 268',0),(12,'AR','54',0),(13,'AM','374',0),(14,'AW','297',0),(15,'AU','61',0),(16,'AT','43',0),(17,'AZ','994',0),(18,'BS','1 242',0),(19,'BH','973',0),(20,'BD','880',0),(21,'BB','1 246',0),(22,'BY','375',0),(23,'BE','32',0),(24,'BZ','501',0),(25,'BJ','229',0),(26,'BM','1 441',0),(27,'BT','975',0),(28,'BO','591',0),(29,'BA','387',0),(30,'BW','267',0),(31,'BV','',0),(32,'BR','55',0),(33,'BN','673',0),(34,'BG','359',0),(35,'BF','226',0),(36,'BI','257',0),(37,'KH','855',0),(38,'CM','237',0),(39,'CA','1',-1),(40,'CV','238',0),(41,'KY','1 345',0),(42,'CF','236',0),(43,'TD','235',0),(44,'CL','56',0),(45,'CN','86',-1),(46,'CX','61',0),(47,'CC','61',0),(48,'CO','57',0),(49,'KM','269',0),(50,'CG','242',0),(51,'CK','682',0),(52,'CR','506',0),(53,'CI','225',0),(54,'HR','385',0),(55,'CU','53',0),(56,'CY','357',0),(57,'CZ','420',0),(58,'CD','243',0),(59,'DK','45',0),(60,'DJ','253',0),(61,'DM','1 767',0),(62,'DO','1',0),(63,'TP','670',0),(64,'EC','593',0),(65,'EG','20',0),(66,'SV','503',0),(67,'GQ','240',0),(68,'ER','291',0),(69,'EE','372',0),(70,'ET','251',0),(71,'FK','500',0),(72,'FO','298',0),(73,'FJ','679',0),(74,'FI','358',0),(75,'FR','33',0),(76,'FX','33',0),(77,'GF','594',0),(78,'PF','689',0),(79,'GA','241',0),(80,'GM','220',0),(81,'GE','995',0),(82,'DE','49',0),(83,'GH','233',0),(84,'GI','350',0),(85,'GR','30',0),(86,'GL','299',0),(87,'GD','1 473',0),(88,'GP','590',0),(89,'GT','502',0),(90,'GU','1 671',0),(91,'GN','224',0),(92,'GW','245',0),(93,'GY','592',0),(94,'HT','509',0),(95,'HN','504',0),(96,'HK','852',0),(97,'HU','36',0),(98,'IS','354',0),(99,'IN','91',0),(100,'ID','62',0),(101,'IR','98',0),(102,'IQ','964',0),(103,'IE','353',0),(104,'IL','972',0),(105,'IT','39',0),(106,'JM','1 876',0),(107,'JP','81',0),(108,'JO','962',0),(109,'KZ','7',0),(110,'KE','254',0),(111,'KI','686',0),(112,'KP','850',0),(113,'KR','82',-1),(114,'KW','965',0),(115,'KG','996',0),(116,'LA','856',0),(117,'LV','371',0),(118,'LB','961',0),(119,'LS','266',0),(120,'LR','231',0),(121,'LY','218',0),(122,'LI','423',0),(123,'LT','370',0),(124,'LU','352',0),(125,'MO','853',0),(126,'MK','389',0),(127,'MG','261',0),(128,'MW','265',0),(129,'MY','60',-1),(130,'MV','960',0),(131,'ML','223',0),(132,'MT','356',0),(133,'MH','692',0),(134,'MQ','596',0),(135,'MR','222',0),(136,'MU','230',0),(137,'YT','262',0),(138,'MX','52',0),(139,'FM','691',0),(140,'MD','373',0),(141,'MC','377',0),(142,'MN','976',0),(143,'ME','382',0),(144,'MS','1 664',0),(145,'MA','212',0),(146,'MZ','258',0),(147,'MM','95',0),(148,'NA','264',0),(149,'NR','674',0),(150,'NP','977',0),(151,'NL','31',0),(152,'AN','599',0),(153,'NC','687',0),(154,'NZ','64',0),(155,'NI','505',0),(156,'NE','227',0),(157,'NG','234',0),(158,'NU','683',0),(159,'NF','672',0),(160,'MP','1 670',0),(161,'NO','47',0),(162,'OM','968',0),(163,'PK','92',0),(164,'PW','680',0),(165,'PS','970',0),(166,'PA','507',0),(167,'PG','675',0),(168,'PY','595',0),(169,'PE','51',0),(170,'PH','63',0),(171,'PN','',0),(172,'PL','48',0),(173,'PT','351',0),(174,'PR','1',0),(175,'QA','974',0),(176,'RE','262',0),(177,'RO','40',0),(178,'RU','7',0),(179,'RW','250',0),(180,'WS','685',0),(181,'SM','378',0),(182,'SA','966',0),(183,'SN','221',0),(184,'RS','381',0),(185,'SC','248',0),(186,'SL','232',0),(187,'SG','65',-1),(188,'SK','421',0),(189,'SI','386',0),(190,'SB','677',0),(191,'SO','252',0),(192,'ZA','27',0),(193,'ES','34',0),(194,'LK','94',0),(195,'SH','290',0),(196,'KN','1 869',0),(197,'LC','1 758',0),(198,'SD','249',0),(199,'SR','597',0),(200,'SZ','268',0),(201,'SE','46',0),(202,'CH','41',0),(203,'SY','963',0),(204,'TW','886',0),(205,'TJ','992',0),(206,'TZ','255',0),(207,'TH','66',0),(208,'TL','670',0),(209,'TG','228',0),(210,'TK','690',0),(211,'TO','676',0),(212,'TT','1 868',0),(213,'TN','216',0),(214,'TR','90',0),(215,'TM','993',0),(216,'TC','1 649',0),(217,'TV','688',0),(218,'UG','256',0),(219,'UA','380',0),(220,'AE','971',0),(221,'UK','44',0),(222,'US','1',-1),(223,'UY','598',0),(224,'UZ','998',0),(225,'VU','678',0),(226,'VA','379',0),(227,'VE','58',0),(228,'VN','84',0),(229,'VG','1 284',0),(230,'VI','1 340',0),(231,'WF','681',0),(232,'EH','',0),(233,'YE','967',0),(234,'ZM','260',0),(235,'ZW','263',0);
/*!40000 ALTER TABLE `hris_country_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_country_trans`
--

DROP TABLE IF EXISTS `hris_country_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_country_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `country_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `country_id` (`country_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_country_trans_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `hris_country_data` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISCountry';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_country_trans`
--

LOCK TABLES `hris_country_trans` WRITE;
/*!40000 ALTER TABLE `hris_country_trans` DISABLE KEYS */;
INSERT INTO `hris_country_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Afghanistan'),(6,3,'zh-Hans','[zh-Hans]Afghanistan'),(7,4,'en','Aland Islands'),(8,4,'zh-Hans','[zh-Hans]Aland Islands'),(9,5,'en','Albania'),(10,5,'zh-Hans','[zh-Hans]Albania'),(11,6,'en','Algeria'),(12,6,'zh-Hans','[zh-Hans]Algeria'),(13,7,'en','American Samoa'),(14,7,'zh-Hans','[zh-Hans]American Samoa'),(15,8,'en','Andorra'),(16,8,'zh-Hans','[zh-Hans]Andorra'),(17,9,'en','Angola'),(18,9,'zh-Hans','[zh-Hans]Angola'),(19,10,'en','Anguilla'),(20,10,'zh-Hans','[zh-Hans]Anguilla'),(21,11,'en','Antigua and Barbuda'),(22,11,'zh-Hans','[zh-Hans]Antigua and Barbuda'),(23,12,'en','Argentina'),(24,12,'zh-Hans','[zh-Hans]Argentina'),(25,13,'en','Armenia'),(26,13,'zh-Hans','[zh-Hans]Armenia'),(27,14,'en','Aruba'),(28,14,'zh-Hans','[zh-Hans]Aruba'),(29,15,'en','Australia'),(30,15,'zh-Hans','[zh-Hans]Australia'),(31,16,'en','Austria'),(32,16,'zh-Hans','[zh-Hans]Austria'),(33,17,'en','Azerbaijan'),(34,17,'zh-Hans','[zh-Hans]Azerbaijan'),(35,18,'en','Bahamas'),(36,18,'zh-Hans','[zh-Hans]Bahamas'),(37,19,'en','Bahrain'),(38,19,'zh-Hans','[zh-Hans]Bahrain'),(39,20,'en','Bangladesh'),(40,20,'zh-Hans','[zh-Hans]Bangladesh'),(41,21,'en','Barbados'),(42,21,'zh-Hans','[zh-Hans]Barbados'),(43,22,'en','Belarus'),(44,22,'zh-Hans','[zh-Hans]Belarus'),(45,23,'en','Belgium'),(46,23,'zh-Hans','[zh-Hans]Belgium'),(47,24,'en','Belize'),(48,24,'zh-Hans','[zh-Hans]Belize'),(49,25,'en','Benin'),(50,25,'zh-Hans','[zh-Hans]Benin'),(51,26,'en','Bermuda'),(52,26,'zh-Hans','[zh-Hans]Bermuda'),(53,27,'en','Bhutan'),(54,27,'zh-Hans','[zh-Hans]Bhutan'),(55,28,'en','Bolivia'),(56,28,'zh-Hans','[zh-Hans]Bolivia'),(57,29,'en','Bosnia and Herzegovina'),(58,29,'zh-Hans','[zh-Hans]Bosnia and Herzegovina'),(59,30,'en','Botswana'),(60,30,'zh-Hans','[zh-Hans]Botswana'),(61,31,'en','Bouvet Island'),(62,31,'zh-Hans','[zh-Hans]Bouvet Island'),(63,32,'en','Brazil'),(64,32,'zh-Hans','[zh-Hans]Brazil'),(65,33,'en','Brunei Darussalam'),(66,33,'zh-Hans','[zh-Hans]Brunei Darussalam'),(67,34,'en','Bulgaria'),(68,34,'zh-Hans','[zh-Hans]Bulgaria'),(69,35,'en','Burkina Faso'),(70,35,'zh-Hans','[zh-Hans]Burkina Faso'),(71,36,'en','Burundi'),(72,36,'zh-Hans','[zh-Hans]Burundi'),(73,37,'en','Cambodia'),(74,37,'zh-Hans','[zh-Hans]Cambodia'),(75,38,'en','Cameroon'),(76,38,'zh-Hans','[zh-Hans]Cameroon'),(77,39,'en','Canada'),(78,39,'zh-Hans','[zh-Hans]Canada'),(79,40,'en','Cape Verde'),(80,40,'zh-Hans','[zh-Hans]Cape Verde'),(81,41,'en','Cayman Islands'),(82,41,'zh-Hans','[zh-Hans]Cayman Islands'),(83,42,'en','Central African Republic'),(84,42,'zh-Hans','[zh-Hans]Central African Republic'),(85,43,'en','Chad'),(86,43,'zh-Hans','[zh-Hans]Chad'),(87,44,'en','Chile'),(88,44,'zh-Hans','[zh-Hans]Chile'),(89,45,'en','China'),(90,45,'zh-Hans','[zh-Hans]China'),(91,46,'en','Christmas Island'),(92,46,'zh-Hans','[zh-Hans]Christmas Island'),(93,47,'en','Cocos Islands'),(94,47,'zh-Hans','[zh-Hans]Cocos Islands'),(95,48,'en','Colombia'),(96,48,'zh-Hans','[zh-Hans]Colombia'),(97,49,'en','Comoros'),(98,49,'zh-Hans','[zh-Hans]Comoros'),(99,50,'en','Congo'),(100,50,'zh-Hans','[zh-Hans]Congo'),(101,51,'en','Cook Islands'),(102,51,'zh-Hans','[zh-Hans]Cook Islands'),(103,52,'en','Costa Rica'),(104,52,'zh-Hans','[zh-Hans]Costa Rica'),(105,53,'en','Cote D\'Ivoire'),(106,53,'zh-Hans','[zh-Hans]Cote D\'Ivoire'),(107,54,'en','Croatia (Hrvatska)'),(108,54,'zh-Hans','[zh-Hans]Croatia (Hrvatska)'),(109,55,'en','Cuba'),(110,55,'zh-Hans','[zh-Hans]Cuba'),(111,56,'en','Cyprus'),(112,56,'zh-Hans','[zh-Hans]Cyprus'),(113,57,'en','Czech Republic'),(114,57,'zh-Hans','[zh-Hans]Czech Republic'),(115,58,'en','Dem. Rep. of the Congo'),(116,58,'zh-Hans','[zh-Hans]Dem. Rep. of the Congo'),(117,59,'en','Denmark'),(118,59,'zh-Hans','[zh-Hans]Denmark'),(119,60,'en','Djibouti'),(120,60,'zh-Hans','[zh-Hans]Djibouti'),(121,61,'en','Dominica'),(122,61,'zh-Hans','[zh-Hans]Dominica'),(123,62,'en','Dominican Republic'),(124,62,'zh-Hans','[zh-Hans]Dominican Republic'),(125,63,'en','East Timor'),(126,63,'zh-Hans','[zh-Hans]East Timor'),(127,64,'en','Ecuador'),(128,64,'zh-Hans','[zh-Hans]Ecuador'),(129,65,'en','Egypt'),(130,65,'zh-Hans','[zh-Hans]Egypt'),(131,66,'en','El Salvador'),(132,66,'zh-Hans','[zh-Hans]El Salvador'),(133,67,'en','Equatorial Guinea'),(134,67,'zh-Hans','[zh-Hans]Equatorial Guinea'),(135,68,'en','Eritrea'),(136,68,'zh-Hans','[zh-Hans]Eritrea'),(137,69,'en','Estonia'),(138,69,'zh-Hans','[zh-Hans]Estonia'),(139,70,'en','Ethiopia'),(140,70,'zh-Hans','[zh-Hans]Ethiopia'),(141,71,'en','Falkland Islands'),(142,71,'zh-Hans','[zh-Hans]Falkland Islands'),(143,72,'en','Faroe Islands'),(144,72,'zh-Hans','[zh-Hans]Faroe Islands'),(145,73,'en','Fiji'),(146,73,'zh-Hans','[zh-Hans]Fiji'),(147,74,'en','Finland'),(148,74,'zh-Hans','[zh-Hans]Finland'),(149,75,'en','France'),(150,75,'zh-Hans','[zh-Hans]France'),(151,76,'en','France, Metropolitan'),(152,76,'zh-Hans','[zh-Hans]France, Metropolitan'),(153,77,'en','French Guiana'),(154,77,'zh-Hans','[zh-Hans]French Guiana'),(155,78,'en','French Polynesia'),(156,78,'zh-Hans','[zh-Hans]French Polynesia'),(157,79,'en','Gabon'),(158,79,'zh-Hans','[zh-Hans]Gabon'),(159,80,'en','Gambia'),(160,80,'zh-Hans','[zh-Hans]Gambia'),(161,81,'en','Georgia'),(162,81,'zh-Hans','[zh-Hans]Georgia'),(163,82,'en','Germany'),(164,82,'zh-Hans','[zh-Hans]Germany'),(165,83,'en','Ghana'),(166,83,'zh-Hans','[zh-Hans]Ghana'),(167,84,'en','Gibraltar'),(168,84,'zh-Hans','[zh-Hans]Gibraltar'),(169,85,'en','Greece'),(170,85,'zh-Hans','[zh-Hans]Greece'),(171,86,'en','Greenland'),(172,86,'zh-Hans','[zh-Hans]Greenland'),(173,87,'en','Grenada'),(174,87,'zh-Hans','[zh-Hans]Grenada'),(175,88,'en','Guadeloupe'),(176,88,'zh-Hans','[zh-Hans]Guadeloupe'),(177,89,'en','Guatemala'),(178,89,'zh-Hans','[zh-Hans]Guatemala'),(179,90,'en','Guam'),(180,90,'zh-Hans','[zh-Hans]Guam'),(181,91,'en','Guinea'),(182,91,'zh-Hans','[zh-Hans]Guinea'),(183,92,'en','Guinea-Bissau'),(184,92,'zh-Hans','[zh-Hans]Guinea-Bissau'),(185,93,'en','Guyana'),(186,93,'zh-Hans','[zh-Hans]Guyana'),(187,94,'en','Haiti'),(188,94,'zh-Hans','[zh-Hans]Haiti'),(189,95,'en','Honduras'),(190,95,'zh-Hans','[zh-Hans]Honduras'),(191,96,'en','Hong Kong'),(192,96,'zh-Hans','[zh-Hans]Hong Kong'),(193,97,'en','Hungary'),(194,97,'zh-Hans','[zh-Hans]Hungary'),(195,98,'en','Iceland'),(196,98,'zh-Hans','[zh-Hans]Iceland'),(197,99,'en','India'),(198,99,'zh-Hans','[zh-Hans]India'),(199,100,'en','Indonesia'),(200,100,'zh-Hans','[zh-Hans]Indonesia'),(201,101,'en','Iran'),(202,101,'zh-Hans','[zh-Hans]Iran'),(203,102,'en','Iraq'),(204,102,'zh-Hans','[zh-Hans]Iraq'),(205,103,'en','Ireland'),(206,103,'zh-Hans','[zh-Hans]Ireland'),(207,104,'en','Israel'),(208,104,'zh-Hans','[zh-Hans]Israel'),(209,105,'en','Italy'),(210,105,'zh-Hans','[zh-Hans]Italy'),(211,106,'en','Jamaica'),(212,106,'zh-Hans','[zh-Hans]Jamaica'),(213,107,'en','Japan'),(214,107,'zh-Hans','[zh-Hans]Japan'),(215,108,'en','Jordan'),(216,108,'zh-Hans','[zh-Hans]Jordan'),(217,109,'en','Kazakhstan'),(218,109,'zh-Hans','[zh-Hans]Kazakhstan'),(219,110,'en','Kenya'),(220,110,'zh-Hans','[zh-Hans]Kenya'),(221,111,'en','Kiribati'),(222,111,'zh-Hans','[zh-Hans]Kiribati'),(223,112,'en','Korea (North)'),(224,112,'zh-Hans','[zh-Hans]Korea (North)'),(225,113,'en','Korea (South)'),(226,113,'zh-Hans','[zh-Hans]Korea (South)'),(227,114,'en','Kuwait'),(228,114,'zh-Hans','[zh-Hans]Kuwait'),(229,115,'en','Kyrgyzstan'),(230,115,'zh-Hans','[zh-Hans]Kyrgyzstan'),(231,116,'en','Laos'),(232,116,'zh-Hans','[zh-Hans]Laos'),(233,117,'en','Latvia'),(234,117,'zh-Hans','[zh-Hans]Latvia'),(235,118,'en','Lebanon'),(236,118,'zh-Hans','[zh-Hans]Lebanon'),(237,119,'en','Lesotho'),(238,119,'zh-Hans','[zh-Hans]Lesotho'),(239,120,'en','Liberia'),(240,120,'zh-Hans','[zh-Hans]Liberia'),(241,121,'en','Libya'),(242,121,'zh-Hans','[zh-Hans]Libya'),(243,122,'en','Liechtenstein'),(244,122,'zh-Hans','[zh-Hans]Liechtenstein'),(245,123,'en','Lithuania'),(246,123,'zh-Hans','[zh-Hans]Lithuania'),(247,124,'en','Luxembourg'),(248,124,'zh-Hans','[zh-Hans]Luxembourg'),(249,125,'en','Macao'),(250,125,'zh-Hans','[zh-Hans]Macao'),(251,126,'en','Macedonia'),(252,126,'zh-Hans','[zh-Hans]Macedonia'),(253,127,'en','Madagascar'),(254,127,'zh-Hans','[zh-Hans]Madagascar'),(255,128,'en','Malawi'),(256,128,'zh-Hans','[zh-Hans]Malawi'),(257,129,'en','Malaysia'),(258,129,'zh-Hans','[zh-Hans]Malaysia'),(259,130,'en','Maldives'),(260,130,'zh-Hans','[zh-Hans]Maldives'),(261,131,'en','Mali'),(262,131,'zh-Hans','[zh-Hans]Mali'),(263,132,'en','Malta'),(264,132,'zh-Hans','[zh-Hans]Malta'),(265,133,'en','Marshall Islands'),(266,133,'zh-Hans','[zh-Hans]Marshall Islands'),(267,134,'en','Martinique'),(268,134,'zh-Hans','[zh-Hans]Martinique'),(269,135,'en','Mauritania'),(270,135,'zh-Hans','[zh-Hans]Mauritania'),(271,136,'en','Mauritius'),(272,136,'zh-Hans','[zh-Hans]Mauritius'),(273,137,'en','Mayotte'),(274,137,'zh-Hans','[zh-Hans]Mayotte'),(275,138,'en','Mexico'),(276,138,'zh-Hans','[zh-Hans]Mexico'),(277,139,'en','Micronesia'),(278,139,'zh-Hans','[zh-Hans]Micronesia'),(279,140,'en','Moldova'),(280,140,'zh-Hans','[zh-Hans]Moldova'),(281,141,'en','Monaco'),(282,141,'zh-Hans','[zh-Hans]Monaco'),(283,142,'en','Mongolia'),(284,142,'zh-Hans','[zh-Hans]Mongolia'),(285,143,'en','Montenegro'),(286,143,'zh-Hans','[zh-Hans]Montenegro'),(287,144,'en','Montserrat'),(288,144,'zh-Hans','[zh-Hans]Montserrat'),(289,145,'en','Morocco'),(290,145,'zh-Hans','[zh-Hans]Morocco'),(291,146,'en','Mozambique'),(292,146,'zh-Hans','[zh-Hans]Mozambique'),(293,147,'en','Myanmar'),(294,147,'zh-Hans','[zh-Hans]Myanmar'),(295,148,'en','Namibia'),(296,148,'zh-Hans','[zh-Hans]Namibia'),(297,149,'en','Nauru'),(298,149,'zh-Hans','[zh-Hans]Nauru'),(299,150,'en','Nepal'),(300,150,'zh-Hans','[zh-Hans]Nepal'),(301,151,'en','Netherlands'),(302,151,'zh-Hans','[zh-Hans]Netherlands'),(303,152,'en','Netherlands Antilles'),(304,152,'zh-Hans','[zh-Hans]Netherlands Antilles'),(305,153,'en','New Caledonia'),(306,153,'zh-Hans','[zh-Hans]New Caledonia'),(307,154,'en','New Zealand'),(308,154,'zh-Hans','[zh-Hans]New Zealand'),(309,155,'en','Nicaragua'),(310,155,'zh-Hans','[zh-Hans]Nicaragua'),(311,156,'en','Niger'),(312,156,'zh-Hans','[zh-Hans]Niger'),(313,157,'en','Nigeria'),(314,157,'zh-Hans','[zh-Hans]Nigeria'),(315,158,'en','Niue'),(316,158,'zh-Hans','[zh-Hans]Niue'),(317,159,'en','Norfolk Island'),(318,159,'zh-Hans','[zh-Hans]Norfolk Island'),(319,160,'en','Northern Mariana Islands'),(320,160,'zh-Hans','[zh-Hans]Northern Mariana Islands'),(321,161,'en','Norway'),(322,161,'zh-Hans','[zh-Hans]Norway'),(323,162,'en','Oman'),(324,162,'zh-Hans','[zh-Hans]Oman'),(325,163,'en','Pakistan'),(326,163,'zh-Hans','[zh-Hans]Pakistan'),(327,164,'en','Palau'),(328,164,'zh-Hans','[zh-Hans]Palau'),(329,165,'en','Palestinian Territory'),(330,165,'zh-Hans','[zh-Hans]Palestinian Territory'),(331,166,'en','Panama'),(332,166,'zh-Hans','[zh-Hans]Panama'),(333,167,'en','Papua New Guinea'),(334,167,'zh-Hans','[zh-Hans]Papua New Guinea'),(335,168,'en','Paraguay'),(336,168,'zh-Hans','[zh-Hans]Paraguay'),(337,169,'en','Peru'),(338,169,'zh-Hans','[zh-Hans]Peru'),(339,170,'en','Philippines'),(340,170,'zh-Hans','[zh-Hans]Philippines'),(341,171,'en','Pitcairn'),(342,171,'zh-Hans','[zh-Hans]Pitcairn'),(343,172,'en','Poland'),(344,172,'zh-Hans','[zh-Hans]Poland'),(345,173,'en','Portugal'),(346,173,'zh-Hans','[zh-Hans]Portugal'),(347,174,'en','Puerto Rico'),(348,174,'zh-Hans','[zh-Hans]Puerto Rico'),(349,175,'en','Qatar'),(350,175,'zh-Hans','[zh-Hans]Qatar'),(351,176,'en','Reunion'),(352,176,'zh-Hans','[zh-Hans]Reunion'),(353,177,'en','Romania'),(354,177,'zh-Hans','[zh-Hans]Romania'),(355,178,'en','Russia'),(356,178,'zh-Hans','[zh-Hans]Russia'),(357,179,'en','Rwanda'),(358,179,'zh-Hans','[zh-Hans]Rwanda'),(359,180,'en','Samoa'),(360,180,'zh-Hans','[zh-Hans]Samoa'),(361,181,'en','San Marino'),(362,181,'zh-Hans','[zh-Hans]San Marino'),(363,182,'en','Saudi Arabia'),(364,182,'zh-Hans','[zh-Hans]Saudi Arabia'),(365,183,'en','Senegal'),(366,183,'zh-Hans','[zh-Hans]Senegal'),(367,184,'en','Serbia'),(368,184,'zh-Hans','[zh-Hans]Serbia'),(369,185,'en','Seychelles'),(370,185,'zh-Hans','[zh-Hans]Seychelles'),(371,186,'en','Sierra Leone'),(372,186,'zh-Hans','[zh-Hans]Sierra Leone'),(373,187,'en','Singapore'),(374,187,'zh-Hans','[zh-Hans]Singapore'),(375,188,'en','Slovakia'),(376,188,'zh-Hans','[zh-Hans]Slovakia'),(377,189,'en','Slovenia'),(378,189,'zh-Hans','[zh-Hans]Slovenia'),(379,190,'en','Solomon Islands'),(380,190,'zh-Hans','[zh-Hans]Solomon Islands'),(381,191,'en','Somalia'),(382,191,'zh-Hans','[zh-Hans]Somalia'),(383,192,'en','South Africa'),(384,192,'zh-Hans','[zh-Hans]South Africa'),(385,193,'en','Spain'),(386,193,'zh-Hans','[zh-Hans]Spain'),(387,194,'en','Sri Lanka'),(388,194,'zh-Hans','[zh-Hans]Sri Lanka'),(389,195,'en','St Helena'),(390,195,'zh-Hans','[zh-Hans]St Helena'),(391,196,'en','St Kitts and Nevis'),(392,196,'zh-Hans','[zh-Hans]St Kitts and Nevis'),(393,197,'en','St Lucia'),(394,197,'zh-Hans','[zh-Hans]St Lucia'),(395,198,'en','Sudan'),(396,198,'zh-Hans','[zh-Hans]Sudan'),(397,199,'en','Suriname'),(398,199,'zh-Hans','[zh-Hans]Suriname'),(399,200,'en','Swaziland'),(400,200,'zh-Hans','[zh-Hans]Swaziland'),(401,201,'en','Sweden'),(402,201,'zh-Hans','[zh-Hans]Sweden'),(403,202,'en','Switzerland'),(404,202,'zh-Hans','[zh-Hans]Switzerland'),(405,203,'en','Syria'),(406,203,'zh-Hans','[zh-Hans]Syria'),(407,204,'en','Taiwan'),(408,204,'zh-Hans','[zh-Hans]Taiwan'),(409,205,'en','Tajikistan'),(410,205,'zh-Hans','[zh-Hans]Tajikistan'),(411,206,'en','Tanzania'),(412,206,'zh-Hans','[zh-Hans]Tanzania'),(413,207,'en','Thailand'),(414,207,'zh-Hans','[zh-Hans]Thailand'),(415,208,'en','Timor-Leste'),(416,208,'zh-Hans','[zh-Hans]Timor-Leste'),(417,209,'en','Togo'),(418,209,'zh-Hans','[zh-Hans]Togo'),(419,210,'en','Tokelau'),(420,210,'zh-Hans','[zh-Hans]Tokelau'),(421,211,'en','Tonga'),(422,211,'zh-Hans','[zh-Hans]Tonga'),(423,212,'en','Trinidad and Tobago'),(424,212,'zh-Hans','[zh-Hans]Trinidad and Tobago'),(425,213,'en','Tunisia'),(426,213,'zh-Hans','[zh-Hans]Tunisia'),(427,214,'en','Turkey'),(428,214,'zh-Hans','[zh-Hans]Turkey'),(429,215,'en','Turkmenistan'),(430,215,'zh-Hans','[zh-Hans]Turkmenistan'),(431,216,'en','Turks and Caicos'),(432,216,'zh-Hans','[zh-Hans]Turks and Caicos'),(433,217,'en','Tuvalu'),(434,217,'zh-Hans','[zh-Hans]Tuvalu'),(435,218,'en','Uganda'),(436,218,'zh-Hans','[zh-Hans]Uganda'),(437,219,'en','Ukraine'),(438,219,'zh-Hans','[zh-Hans]Ukraine'),(439,220,'en','United Arab Emirates'),(440,220,'zh-Hans','[zh-Hans]United Arab Emirates'),(441,221,'en','United Kingdom'),(442,221,'zh-Hans','[zh-Hans]United Kingdom'),(443,222,'en','United States'),(444,222,'zh-Hans','[zh-Hans]United States'),(445,223,'en','Uruguay'),(446,223,'zh-Hans','[zh-Hans]Uruguay'),(447,224,'en','Uzbekistan'),(448,224,'zh-Hans','[zh-Hans]Uzbekistan'),(449,225,'en','Vanuatu'),(450,225,'zh-Hans','[zh-Hans]Vanuatu'),(451,226,'en','Vatican City'),(452,226,'zh-Hans','[zh-Hans]Vatican City'),(453,227,'en','Venezuela'),(454,227,'zh-Hans','[zh-Hans]Venezuela'),(455,228,'en','Viet Nam'),(456,228,'zh-Hans','[zh-Hans]Viet Nam'),(457,229,'en','Virgin Islands (British)'),(458,229,'zh-Hans','[zh-Hans]Virgin Islands (British)'),(459,230,'en','Virgin Islands (US)'),(460,230,'zh-Hans','[zh-Hans]Virgin Islands (US)'),(461,231,'en','Wallis and Futuna'),(462,231,'zh-Hans','[zh-Hans]Wallis and Futuna'),(463,232,'en','Western Sahara'),(464,232,'zh-Hans','[zh-Hans]Western Sahara'),(465,233,'en','Yemen'),(466,233,'zh-Hans','[zh-Hans]Yemen'),(467,234,'en','Zambia'),(468,234,'zh-Hans','[zh-Hans]Zambia'),(469,235,'en','Zimbabwe'),(470,235,'zh-Hans','[zh-Hans]Zimbabwe');
/*!40000 ALTER TABLE `hris_country_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_degree_data`
--

DROP TABLE IF EXISTS `hris_degree_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_degree_data` (
  `degree_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`degree_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_degree_data`
--

LOCK TABLES `hris_degree_data` WRITE;
/*!40000 ALTER TABLE `hris_degree_data` DISABLE KEYS */;
INSERT INTO `hris_degree_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `hris_degree_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_degree_trans`
--

DROP TABLE IF EXISTS `hris_degree_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_degree_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `degree_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `degree_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `degree_id` (`degree_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_degree_trans_ibfk_1` FOREIGN KEY (`degree_id`) REFERENCES `hris_degree_data` (`degree_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_degree_trans`
--

LOCK TABLES `hris_degree_trans` WRITE;
/*!40000 ALTER TABLE `hris_degree_trans` DISABLE KEYS */;
INSERT INTO `hris_degree_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','High School'),(6,3,'zh-Hans','[zh-Hans]High School'),(7,4,'en','Associate'),(8,4,'zh-Hans','[zh-Hans]Associate'),(9,5,'en','Bachelor'),(10,5,'zh-Hans','[zh-Hans]Bachelor'),(11,6,'en','Master'),(12,6,'zh-Hans','[zh-Hans]Master'),(13,7,'en','Doctorate'),(14,7,'zh-Hans','[zh-Hans]Doctorate');
/*!40000 ALTER TABLE `hris_degree_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_dependent`
--

DROP TABLE IF EXISTS `hris_dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_dependent` (
  `dependent_id` int(11) NOT NULL AUTO_INCREMENT,
  `dependent_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `schoolingmethod_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dependent_id`),
  UNIQUE KEY `dependent_guid` (`dependent_guid`),
  UNIQUE KEY `ren_id` (`ren_id`),
  UNIQUE KEY `idx_dependent_guid` (`dependent_guid`),
  KEY `fk_dependent_schoolingmethod_id` (`schoolingmethod_id`),
  CONSTRAINT `fk_dependent_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_dependent_schoolingmethod_id` FOREIGN KEY (`schoolingmethod_id`) REFERENCES `hris_schoolingmethod_data` (`schoolingmethod_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_dependent`
--

LOCK TABLES `hris_dependent` WRITE;
/*!40000 ALTER TABLE `hris_dependent` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_education_data`
--

DROP TABLE IF EXISTS `hris_education_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_education_data` (
  `education_id` int(11) NOT NULL AUTO_INCREMENT,
  `education_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `degree_id` int(11) DEFAULT NULL,
  `educationmajor_id` int(11) DEFAULT NULL,
  `education_gradyr` int(11) DEFAULT NULL,
  PRIMARY KEY (`education_id`),
  UNIQUE KEY `idx_education_guid` (`education_guid`),
  KEY `fk_education_degree_id` (`degree_id`),
  KEY `fk_education_educationmajor_id` (`educationmajor_id`),
  KEY `fk_education_ren_id` (`ren_id`),
  CONSTRAINT `fk_education_degree_id` FOREIGN KEY (`degree_id`) REFERENCES `hris_degree_data` (`degree_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_education_educationmajor_id` FOREIGN KEY (`educationmajor_id`) REFERENCES `hris_educationmajor_data` (`educationmajor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_education_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_education_data`
--

LOCK TABLES `hris_education_data` WRITE;
/*!40000 ALTER TABLE `hris_education_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_education_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_education_trans`
--

DROP TABLE IF EXISTS `hris_education_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_education_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `education_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `education_school` text NOT NULL,
  `education_comment` text,
  PRIMARY KEY (`Trans_id`),
  KEY `education_id` (`education_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_education_trans_ibfk_1` FOREIGN KEY (`education_id`) REFERENCES `hris_education_data` (`education_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISEducation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_education_trans`
--

LOCK TABLES `hris_education_trans` WRITE;
/*!40000 ALTER TABLE `hris_education_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_education_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_educationmajor_data`
--

DROP TABLE IF EXISTS `hris_educationmajor_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_educationmajor_data` (
  `educationmajor_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`educationmajor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_educationmajor_data`
--

LOCK TABLES `hris_educationmajor_data` WRITE;
/*!40000 ALTER TABLE `hris_educationmajor_data` DISABLE KEYS */;
INSERT INTO `hris_educationmajor_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0);
/*!40000 ALTER TABLE `hris_educationmajor_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_educationmajor_trans`
--

DROP TABLE IF EXISTS `hris_educationmajor_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_educationmajor_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `educationmajor_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `educationmajor_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `educationmajor_id` (`educationmajor_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_educationmajor_trans_ibfk_1` FOREIGN KEY (`educationmajor_id`) REFERENCES `hris_educationmajor_data` (`educationmajor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_educationmajor_trans`
--

LOCK TABLES `hris_educationmajor_trans` WRITE;
/*!40000 ALTER TABLE `hris_educationmajor_trans` DISABLE KEYS */;
INSERT INTO `hris_educationmajor_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Accounting/Finance'),(6,3,'zh-Hans','[zh-Hans]Accounting/Finance'),(7,4,'en','Classics'),(8,4,'zh-Hans','[zh-Hans]Classics'),(9,5,'en','Computer Programming'),(10,5,'zh-Hans','[zh-Hans]Computer Programming'),(11,6,'en','Computers - System Administration'),(12,6,'zh-Hans','[zh-Hans]Computers - System Administration'),(13,7,'en','Conference/Event Planning'),(14,7,'zh-Hans','[zh-Hans]Conference/Event Planning'),(15,8,'en','Counseling'),(16,8,'zh-Hans','[zh-Hans]Counseling'),(17,9,'en','Divinity/Pastoral/Religious Education'),(18,9,'zh-Hans','[zh-Hans]Divinity/Pastoral/Religious Education'),(19,10,'en','Drama'),(20,10,'zh-Hans','[zh-Hans]Drama'),(21,11,'en','Engineering'),(22,11,'zh-Hans','[zh-Hans]Engineering'),(23,12,'en','General Administrative'),(24,12,'zh-Hans','[zh-Hans]General Administrative'),(25,13,'en','Graphic Design'),(26,13,'zh-Hans','[zh-Hans]Graphic Design'),(27,14,'en','Leadership'),(28,14,'zh-Hans','[zh-Hans]Leadership'),(29,15,'en','Legal'),(30,15,'zh-Hans','[zh-Hans]Legal'),(31,16,'en','Management'),(32,16,'zh-Hans','[zh-Hans]Management'),(33,17,'en','Medical'),(34,17,'zh-Hans','[zh-Hans]Medical'),(35,18,'en','Missions'),(36,18,'zh-Hans','[zh-Hans]Missions'),(37,19,'en','Music'),(38,19,'zh-Hans','[zh-Hans]Music'),(39,20,'en','Other Humanities'),(40,20,'zh-Hans','[zh-Hans]Other Humanities'),(41,21,'en','Other Science'),(42,21,'zh-Hans','[zh-Hans]Other Science'),(43,22,'en','Photography/Video'),(44,22,'zh-Hans','[zh-Hans]Photography/Video'),(45,23,'en','Public Speaking/Speech'),(46,23,'zh-Hans','[zh-Hans]Public Speaking/Speech'),(47,24,'en','Social Services'),(48,24,'zh-Hans','[zh-Hans]Social Services'),(49,25,'en','Spiritual Formation'),(50,25,'zh-Hans','[zh-Hans]Spiritual Formation'),(51,26,'en','Teaching'),(52,26,'zh-Hans','[zh-Hans]Teaching'),(53,27,'en','Theology/Theological Studies'),(54,27,'zh-Hans','[zh-Hans]Theology/Theological Studies'),(55,28,'en','Web Design'),(56,28,'zh-Hans','[zh-Hans]Web Design'),(57,29,'en','Writing'),(58,29,'zh-Hans','[zh-Hans]Writing'),(59,30,'en','Other'),(60,30,'zh-Hans','[zh-Hans]Other');
/*!40000 ALTER TABLE `hris_educationmajor_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_email`
--

DROP TABLE IF EXISTS `hris_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_email` (
  `email_id` int(11) NOT NULL AUTO_INCREMENT,
  `email_guid` varchar(45) NOT NULL,
  `ren_id` int(11) DEFAULT NULL,
  `email_issecure` int(1) NOT NULL DEFAULT '0',
  `email_address` varchar(64) NOT NULL DEFAULT '-',
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `idx_email_guid` (`email_guid`),
  KEY `fk_email_ren_id` (`ren_id`),
  CONSTRAINT `fk_email_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_email`
--

LOCK TABLES `hris_email` WRITE;
/*!40000 ALTER TABLE `hris_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_email_secure_domain_data`
--

DROP TABLE IF EXISTS `hris_email_secure_domain_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_email_secure_domain_data` (
  `domain_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_email_secure_domain_data`
--

LOCK TABLES `hris_email_secure_domain_data` WRITE;
/*!40000 ALTER TABLE `hris_email_secure_domain_data` DISABLE KEYS */;
INSERT INTO `hris_email_secure_domain_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0);
/*!40000 ALTER TABLE `hris_email_secure_domain_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_email_secure_domain_trans`
--

DROP TABLE IF EXISTS `hris_email_secure_domain_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_email_secure_domain_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `domain_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `domain_id` (`domain_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_email_secure_domain_trans_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `hris_email_secure_domain_data` (`domain_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_email_secure_domain_trans`
--

LOCK TABLES `hris_email_secure_domain_trans` WRITE;
/*!40000 ALTER TABLE `hris_email_secure_domain_trans` DISABLE KEYS */;
INSERT INTO `hris_email_secure_domain_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','bpta.net'),(6,3,'zh-Hans','[zh-Hans]bpta.net'),(7,4,'en','ccomm.biz'),(8,4,'zh-Hans','[zh-Hans]ccomm.biz'),(9,5,'en','dodomail.net'),(10,5,'zh-Hans','[zh-Hans]dodomail.net'),(11,6,'en','kvmail.net'),(12,6,'zh-Hans','[zh-Hans]kvmail.net'),(13,7,'en','nsservices.net'),(14,7,'zh-Hans','[zh-Hans]nsservices.net'),(15,8,'en','maybetoday.net'),(16,8,'zh-Hans','[zh-Hans]maybetoday.net'),(17,9,'en','tgtd.net'),(18,9,'zh-Hans','[zh-Hans]tgtd.net'),(19,10,'en','zonemail.net'),(20,10,'zh-Hans','[zh-Hans]zonemail.net'),(21,11,'en','zteam.biz'),(22,11,'zh-Hans','[zh-Hans]zteam.biz');
/*!40000 ALTER TABLE `hris_email_secure_domain_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_emergencycontact_data`
--

DROP TABLE IF EXISTS `hris_emergencycontact_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_emergencycontact_data` (
  `ec_id` int(11) NOT NULL AUTO_INCREMENT,
  `ec_guid` varchar(45) NOT NULL,
  `family_id` int(11) NOT NULL,
  `ec_name` varchar(128) NOT NULL,
  `relationship_id` int(11) NOT NULL DEFAULT '1',
  `ec_phone1_type` int(11) NOT NULL DEFAULT '1',
  `ec_phone1` varchar(20) NOT NULL DEFAULT '-',
  `ec_phone2_type` int(11) NOT NULL DEFAULT '1',
  `ec_phone2` varchar(20) NOT NULL DEFAULT '-',
  `ec_email` varchar(64) NOT NULL DEFAULT '-',
  `attitude_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ec_id`),
  UNIQUE KEY `idx_ec_guid` (`ec_guid`),
  UNIQUE KEY `idx_ec_name_family_unique` (`family_id`,`ec_name`),
  KEY `fk_ec_attitude_id` (`attitude_id`),
  KEY `fk_ec_relationship_id` (`relationship_id`),
  KEY `fk_ec_phone1_type` (`ec_phone1_type`),
  KEY `fk_ec_phone2_type` (`ec_phone2_type`),
  CONSTRAINT `fk_ec_attitude_id` FOREIGN KEY (`attitude_id`) REFERENCES `hris_attitude_data` (`attitude_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ec_family_id` FOREIGN KEY (`family_id`) REFERENCES `hris_family` (`family_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ec_phone1_type` FOREIGN KEY (`ec_phone1_type`) REFERENCES `hris_phonetype_data` (`phonetype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ec_phone2_type` FOREIGN KEY (`ec_phone2_type`) REFERENCES `hris_phonetype_data` (`phonetype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ec_relationship_id` FOREIGN KEY (`relationship_id`) REFERENCES `hris_relationship_data` (`relationship_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_emergencycontact_data`
--

LOCK TABLES `hris_emergencycontact_data` WRITE;
/*!40000 ALTER TABLE `hris_emergencycontact_data` DISABLE KEYS */;
INSERT INTO `hris_emergencycontact_data` VALUES (1,'b61f57b0-dcca-4183-8c3a-02cf2837171e',1,'Max Bruce',9,3,'7137772962',1,'','max@bruce.com',4);
/*!40000 ALTER TABLE `hris_emergencycontact_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_emergencycontact_trans`
--

DROP TABLE IF EXISTS `hris_emergencycontact_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_emergencycontact_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `ec_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `ec_address` text,
  `ec_specialinstructions` text,
  `ec_languagesspoken` text,
  PRIMARY KEY (`Trans_id`),
  KEY `ec_id` (`ec_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_emergencycontact_trans_ibfk_1` FOREIGN KEY (`ec_id`) REFERENCES `hris_emergencycontact_data` (`ec_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISEmergencyContact';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_emergencycontact_trans`
--

LOCK TABLES `hris_emergencycontact_trans` WRITE;
/*!40000 ALTER TABLE `hris_emergencycontact_trans` DISABLE KEYS */;
INSERT INTO `hris_emergencycontact_trans` VALUES (1,1,'en','houston','speak texan','English'),(2,1,'zh-Hans','[zh-Hans]houston','[zh-Hans]speak texan','[zh-Hans]English');
/*!40000 ALTER TABLE `hris_emergencycontact_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_ethnicity_data`
--

DROP TABLE IF EXISTS `hris_ethnicity_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_ethnicity_data` (
  `ethnicity_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ethnicity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_ethnicity_data`
--

LOCK TABLES `hris_ethnicity_data` WRITE;
/*!40000 ALTER TABLE `hris_ethnicity_data` DISABLE KEYS */;
INSERT INTO `hris_ethnicity_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0);
/*!40000 ALTER TABLE `hris_ethnicity_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_ethnicity_trans`
--

DROP TABLE IF EXISTS `hris_ethnicity_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_ethnicity_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `ethnicity_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `ethnicity_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `ethnicity_id` (`ethnicity_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_ethnicity_trans_ibfk_1` FOREIGN KEY (`ethnicity_id`) REFERENCES `hris_ethnicity_data` (`ethnicity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_ethnicity_trans`
--

LOCK TABLES `hris_ethnicity_trans` WRITE;
/*!40000 ALTER TABLE `hris_ethnicity_trans` DISABLE KEYS */;
INSERT INTO `hris_ethnicity_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Asian'),(6,3,'zh-Hans','[zh-Hans]Asian'),(7,4,'en','African'),(8,4,'zh-Hans','[zh-Hans]African'),(9,5,'en','Asian American'),(10,5,'zh-Hans','[zh-Hans]Asian American'),(11,6,'en','African American'),(12,6,'zh-Hans','[zh-Hans]African American'),(13,7,'en','Caucasian'),(14,7,'zh-Hans','[zh-Hans]Caucasian'),(15,8,'en','Hispanic'),(16,8,'zh-Hans','[zh-Hans]Hispanic'),(17,9,'en','Eurasian'),(18,9,'zh-Hans','[zh-Hans]Eurasian'),(19,10,'en','Other'),(20,10,'zh-Hans','[zh-Hans]Other');
/*!40000 ALTER TABLE `hris_ethnicity_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_family`
--

DROP TABLE IF EXISTS `hris_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_family` (
  `family_id` int(11) NOT NULL AUTO_INCREMENT,
  `family_guid` varchar(45) NOT NULL,
  `family_anniversary` date NOT NULL DEFAULT '1000-01-01' COMMENT 'Wedding anniversary date, does not apply to singles',
  `family_isregwithembassy` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`family_id`),
  UNIQUE KEY `idx_family_guid` (`family_guid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_family`
--

LOCK TABLES `hris_family` WRITE;
/*!40000 ALTER TABLE `hris_family` DISABLE KEYS */;
INSERT INTO `hris_family` VALUES (1,'2fdc7669-ddc0-4d9e-ba63-488599db75b6','1000-01-01',1);
/*!40000 ALTER TABLE `hris_family` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_fundingsource_data`
--

DROP TABLE IF EXISTS `hris_fundingsource_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_fundingsource_data` (
  `fundingsource_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fundingsource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_fundingsource_data`
--

LOCK TABLES `hris_fundingsource_data` WRITE;
/*!40000 ALTER TABLE `hris_fundingsource_data` DISABLE KEYS */;
INSERT INTO `hris_fundingsource_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `hris_fundingsource_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_fundingsource_trans`
--

DROP TABLE IF EXISTS `hris_fundingsource_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_fundingsource_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `fundingsource_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `fundingsource_label` varchar(64) NOT NULL,
  `fundingsource_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `fundingsource_id` (`fundingsource_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_fundingsource_trans_ibfk_1` FOREIGN KEY (`fundingsource_id`) REFERENCES `hris_fundingsource_data` (`fundingsource_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_fundingsource_trans`
--

LOCK TABLES `hris_fundingsource_trans` WRITE;
/*!40000 ALTER TABLE `hris_fundingsource_trans` DISABLE KEYS */;
INSERT INTO `hris_fundingsource_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Supported Staff','You fund your ministry by donations you raise'),(6,3,'zh-Hans','[zh-Hans]Supported Staff','[zh-Hans]You fund your ministry by donations you raise'),(7,4,'en','Centrally Funded','You are fully paid (funded) by Campus Crusade, you do not raise support'),(8,4,'zh-Hans','[zh-Hans]Centrally Funded','[zh-Hans]You are fully paid (funded) by Campus Crusade, you do not raise support'),(9,5,'en','Self-funded','You fund your ministry with personal funds'),(10,5,'zh-Hans','[zh-Hans]Self-funded','[zh-Hans]You fund your ministry with personal funds'),(11,6,'en','Hybrid','Two or more of the other categories apply to you'),(12,6,'zh-Hans','[zh-Hans]Hybrid','[zh-Hans]Two or more of the other categories apply to you'),(13,7,'en','Other','None of the other categories apply to you'),(14,7,'zh-Hans','[zh-Hans]Other','[zh-Hans]None of the other categories apply to you');
/*!40000 ALTER TABLE `hris_fundingsource_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_gender_data`
--

DROP TABLE IF EXISTS `hris_gender_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_gender_data` (
  `gender_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_gender_data`
--

LOCK TABLES `hris_gender_data` WRITE;
/*!40000 ALTER TABLE `hris_gender_data` DISABLE KEYS */;
INSERT INTO `hris_gender_data` VALUES (1,0),(2,0),(3,1),(4,1);
/*!40000 ALTER TABLE `hris_gender_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_gender_trans`
--

DROP TABLE IF EXISTS `hris_gender_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_gender_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `gender_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `gender_id` (`gender_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_gender_trans_ibfk_1` FOREIGN KEY (`gender_id`) REFERENCES `hris_gender_data` (`gender_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_gender_trans`
--

LOCK TABLES `hris_gender_trans` WRITE;
/*!40000 ALTER TABLE `hris_gender_trans` DISABLE KEYS */;
INSERT INTO `hris_gender_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Male'),(6,3,'zh-Hans','[zh-Hans]Male'),(7,4,'en','Female'),(8,4,'zh-Hans','[zh-Hans]Female');
/*!40000 ALTER TABLE `hris_gender_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_image`
--

DROP TABLE IF EXISTS `hris_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_image` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_size` varchar(45) NOT NULL,
  `attachment_id` int(11) NOT NULL,
  `base_attachment_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `idx_image_attachment_id` (`attachment_id`),
  KEY `idx_image_base_attachment_id` (`base_attachment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_image`
--

LOCK TABLES `hris_image` WRITE;
/*!40000 ALTER TABLE `hris_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_insurance`
--

DROP TABLE IF EXISTS `hris_insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_insurance` (
  `insurance_id` int(11) NOT NULL AUTO_INCREMENT,
  `insurance_guid` varchar(45) NOT NULL,
  `family_id` int(11) NOT NULL,
  `insurancetype_id` int(11) DEFAULT NULL,
  `insurance_providername` varchar(100) DEFAULT NULL,
  `insurance_providerphone` varchar(32) DEFAULT NULL,
  `insurance_policynumber` varchar(64) DEFAULT NULL,
  `insurance_effectivedate` date DEFAULT NULL,
  `insurance_expirationdate` date DEFAULT NULL,
  `insurance_contactname` varchar(100) DEFAULT NULL,
  `insurance_contactphone` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`insurance_id`),
  UNIQUE KEY `idx_insurance_guid` (`insurance_guid`),
  KEY `fk_insurance_insurancetype_id` (`insurancetype_id`),
  KEY `fk_insurance_family_id` (`family_id`),
  CONSTRAINT `fk_insurance_family_id` FOREIGN KEY (`family_id`) REFERENCES `hris_family` (`family_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_insurance_insurancetype_id` FOREIGN KEY (`insurancetype_id`) REFERENCES `hris_insurancetype_data` (`insurancetype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_insurance`
--

LOCK TABLES `hris_insurance` WRITE;
/*!40000 ALTER TABLE `hris_insurance` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_insurancetype_data`
--

DROP TABLE IF EXISTS `hris_insurancetype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_insurancetype_data` (
  `insurancetype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`insurancetype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_insurancetype_data`
--

LOCK TABLES `hris_insurancetype_data` WRITE;
/*!40000 ALTER TABLE `hris_insurancetype_data` DISABLE KEYS */;
INSERT INTO `hris_insurancetype_data` VALUES (1,0),(2,0),(3,0),(4,0);
/*!40000 ALTER TABLE `hris_insurancetype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_insurancetype_trans`
--

DROP TABLE IF EXISTS `hris_insurancetype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_insurancetype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `insurancetype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `insurancetype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `insurancetype_id` (`insurancetype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_insurancetype_trans_ibfk_1` FOREIGN KEY (`insurancetype_id`) REFERENCES `hris_insurancetype_data` (`insurancetype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_insurancetype_trans`
--

LOCK TABLES `hris_insurancetype_trans` WRITE;
/*!40000 ALTER TABLE `hris_insurancetype_trans` DISABLE KEYS */;
INSERT INTO `hris_insurancetype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Health'),(6,3,'zh-Hans','[zh-Hans]Health'),(7,4,'en','Evacuation'),(8,4,'zh-Hans','[zh-Hans]Evacuation');
/*!40000 ALTER TABLE `hris_insurancetype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_interest_data`
--

DROP TABLE IF EXISTS `hris_interest_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_interest_data` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `interest_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `interesttype_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`interest_id`),
  UNIQUE KEY `idx_interest_guid` (`interest_guid`),
  KEY `idx_ren_id` (`ren_id`),
  KEY `idx_interest_id` (`interesttype_id`),
  CONSTRAINT `fk_interest_interesttype_id` FOREIGN KEY (`interesttype_id`) REFERENCES `hris_interesttype_data` (`interesttype_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_interest_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_interest_data`
--

LOCK TABLES `hris_interest_data` WRITE;
/*!40000 ALTER TABLE `hris_interest_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_interest_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_interest_trans`
--

DROP TABLE IF EXISTS `hris_interest_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_interest_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `interest_id` int(11) NOT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `interest_comment` text,
  PRIMARY KEY (`Trans_id`),
  KEY `interest_id` (`interest_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_interest_trans_ibfk_1` FOREIGN KEY (`interest_id`) REFERENCES `hris_interest_data` (`interest_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISInterest';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_interest_trans`
--

LOCK TABLES `hris_interest_trans` WRITE;
/*!40000 ALTER TABLE `hris_interest_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_interest_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_interesttype_data`
--

DROP TABLE IF EXISTS `hris_interesttype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_interesttype_data` (
  `interesttype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`interesttype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_interesttype_data`
--

LOCK TABLES `hris_interesttype_data` WRITE;
/*!40000 ALTER TABLE `hris_interesttype_data` DISABLE KEYS */;
INSERT INTO `hris_interesttype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0);
/*!40000 ALTER TABLE `hris_interesttype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_interesttype_trans`
--

DROP TABLE IF EXISTS `hris_interesttype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_interesttype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `interesttype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `interesttype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `interesttype_id` (`interesttype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_interesttype_trans_ibfk_1` FOREIGN KEY (`interesttype_id`) REFERENCES `hris_interesttype_data` (`interesttype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_interesttype_trans`
--

LOCK TABLES `hris_interesttype_trans` WRITE;
/*!40000 ALTER TABLE `hris_interesttype_trans` DISABLE KEYS */;
INSERT INTO `hris_interesttype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Accounting/Finance'),(6,3,'zh-Hans','[zh-Hans]Accounting/Finance'),(7,4,'en','Administration'),(8,4,'zh-Hans','[zh-Hans]Administration'),(9,5,'en','Communication'),(10,5,'zh-Hans','[zh-Hans]Communication'),(11,6,'en','Conference Admin'),(12,6,'zh-Hans','[zh-Hans]Conference Admin'),(13,7,'en','Drama'),(14,7,'zh-Hans','[zh-Hans]Drama'),(15,8,'en','Graphic/Web Design'),(16,8,'zh-Hans','[zh-Hans]Graphic/Web Design'),(17,9,'en','IT'),(18,9,'zh-Hans','[zh-Hans]IT'),(19,10,'en','Legal'),(20,10,'zh-Hans','[zh-Hans]Legal'),(21,11,'en','Medical'),(22,11,'zh-Hans','[zh-Hans]Medical'),(23,12,'en','Multi-Media'),(24,12,'zh-Hans','[zh-Hans]Multi-Media'),(25,13,'en','Music'),(26,13,'zh-Hans','[zh-Hans]Music'),(27,14,'en','Photography'),(28,14,'zh-Hans','[zh-Hans]Photography'),(29,15,'en','Translation'),(30,15,'zh-Hans','[zh-Hans]Translation');
/*!40000 ALTER TABLE `hris_interesttype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_language_data`
--

DROP TABLE IF EXISTS `hris_language_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_language_data` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_language_data`
--

LOCK TABLES `hris_language_data` WRITE;
/*!40000 ALTER TABLE `hris_language_data` DISABLE KEYS */;
INSERT INTO `hris_language_data` VALUES (1,0),(2,0),(3,1),(4,1),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0),(31,0),(32,0),(33,0),(34,0),(35,0),(36,0),(37,0),(38,0),(39,0),(40,0),(41,0),(42,0),(43,0),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0);
/*!40000 ALTER TABLE `hris_language_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_language_trans`
--

DROP TABLE IF EXISTS `hris_language_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_language_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `language_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `language_id` (`language_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_language_trans_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `hris_language_data` (`language_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_language_trans`
--

LOCK TABLES `hris_language_trans` WRITE;
/*!40000 ALTER TABLE `hris_language_trans` DISABLE KEYS */;
INSERT INTO `hris_language_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Mandarin'),(6,3,'zh-Hans','[zh-Hans]Mandarin'),(7,4,'en','English'),(8,4,'zh-Hans','[zh-Hans]English'),(9,5,'en','Amdo Tibetan'),(10,5,'zh-Hans','[zh-Hans]Amdo Tibetan'),(11,6,'en','Arabic'),(12,6,'zh-Hans','[zh-Hans]Arabic'),(13,7,'en','Bai'),(14,7,'zh-Hans','[zh-Hans]Bai'),(15,8,'en','Burmese'),(16,8,'zh-Hans','[zh-Hans]Burmese'),(17,9,'en','Cambodian'),(18,9,'zh-Hans','[zh-Hans]Cambodian'),(19,10,'en','Cantonese'),(20,10,'zh-Hans','[zh-Hans]Cantonese'),(21,11,'en','Central Tibetan'),(22,11,'zh-Hans','[zh-Hans]Central Tibetan'),(23,12,'en','Dong (any dialect)'),(24,12,'zh-Hans','[zh-Hans]Dong (any dialect)'),(25,13,'en','Dongxiang'),(26,13,'zh-Hans','[zh-Hans]Dongxiang'),(27,14,'en','Dutch'),(28,14,'zh-Hans','[zh-Hans]Dutch'),(29,15,'en','Farsi'),(30,15,'zh-Hans','[zh-Hans]Farsi'),(31,16,'en','French'),(32,16,'zh-Hans','[zh-Hans]French'),(33,17,'en','German'),(34,17,'zh-Hans','[zh-Hans]German'),(35,18,'en','Hakka'),(36,18,'zh-Hans','[zh-Hans]Hakka'),(37,19,'en','Hani'),(38,19,'zh-Hans','[zh-Hans]Hani'),(39,20,'en','Hindi'),(40,20,'zh-Hans','[zh-Hans]Hindi'),(41,21,'en','Hmu'),(42,21,'zh-Hans','[zh-Hans]Hmu'),(43,22,'en','Hui'),(44,22,'zh-Hans','[zh-Hans]Hui'),(45,23,'en','Indonesian (Bahasa Indonesia)'),(46,23,'zh-Hans','[zh-Hans]Indonesian (Bahasa Indonesia)'),(47,24,'en','Italian'),(48,24,'zh-Hans','[zh-Hans]Italian'),(49,25,'en','Japanese'),(50,25,'zh-Hans','[zh-Hans]Japanese'),(51,26,'en','Kazakh'),(52,26,'zh-Hans','[zh-Hans]Kazakh'),(53,27,'en','Kham Tibetan'),(54,27,'zh-Hans','[zh-Hans]Kham Tibetan'),(55,28,'en','Kyrgyz'),(56,28,'zh-Hans','[zh-Hans]Kyrgyz'),(57,29,'en','Malay (Bahasa Malaysia)'),(58,29,'zh-Hans','[zh-Hans]Malay (Bahasa Malaysia)'),(59,30,'en','Manchu'),(60,30,'zh-Hans','[zh-Hans]Manchu'),(61,31,'en','Miao'),(62,31,'zh-Hans','[zh-Hans]Miao'),(63,32,'en','Modern Greek'),(64,32,'zh-Hans','[zh-Hans]Modern Greek'),(65,33,'en','Modern Hebrew'),(66,33,'zh-Hans','[zh-Hans]Modern Hebrew'),(67,34,'en','Mongolian'),(68,34,'zh-Hans','[zh-Hans]Mongolian'),(69,35,'en','Portuguese'),(70,35,'zh-Hans','[zh-Hans]Portuguese'),(71,36,'en','Russian'),(72,36,'zh-Hans','[zh-Hans]Russian'),(73,37,'en','Spanish'),(74,37,'zh-Hans','[zh-Hans]Spanish'),(75,38,'en','Tai Lu'),(76,38,'zh-Hans','[zh-Hans]Tai Lu'),(77,39,'en','Taiwanese'),(78,39,'zh-Hans','[zh-Hans]Taiwanese'),(79,40,'en','Tamil'),(80,40,'zh-Hans','[zh-Hans]Tamil'),(81,41,'en','Thai'),(82,41,'zh-Hans','[zh-Hans]Thai'),(83,42,'en','Tujia'),(84,42,'zh-Hans','[zh-Hans]Tujia'),(85,43,'en','Turkish'),(86,43,'zh-Hans','[zh-Hans]Turkish'),(87,44,'en','Urdu'),(88,44,'zh-Hans','[zh-Hans]Urdu'),(89,45,'en','Uyghur'),(90,45,'zh-Hans','[zh-Hans]Uyghur'),(91,46,'en','Uzbek'),(92,46,'zh-Hans','[zh-Hans]Uzbek'),(93,47,'en','Vietnamese'),(94,47,'zh-Hans','[zh-Hans]Vietnamese'),(95,48,'en','Yi (any dialect)'),(96,48,'zh-Hans','[zh-Hans]Yi (any dialect)'),(97,49,'en','Zhuang (any dialect)'),(98,49,'zh-Hans','[zh-Hans]Zhuang (any dialect)');
/*!40000 ALTER TABLE `hris_language_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_maritalstatus_data`
--

DROP TABLE IF EXISTS `hris_maritalstatus_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_maritalstatus_data` (
  `maritalstatus_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maritalstatus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_maritalstatus_data`
--

LOCK TABLES `hris_maritalstatus_data` WRITE;
/*!40000 ALTER TABLE `hris_maritalstatus_data` DISABLE KEYS */;
INSERT INTO `hris_maritalstatus_data` VALUES (1,0),(2,0),(3,1),(4,1),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `hris_maritalstatus_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_maritalstatus_trans`
--

DROP TABLE IF EXISTS `hris_maritalstatus_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_maritalstatus_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `maritalstatus_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `maritalstatus_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `maritalstatus_id` (`maritalstatus_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_maritalstatus_trans_ibfk_1` FOREIGN KEY (`maritalstatus_id`) REFERENCES `hris_maritalstatus_data` (`maritalstatus_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_maritalstatus_trans`
--

LOCK TABLES `hris_maritalstatus_trans` WRITE;
/*!40000 ALTER TABLE `hris_maritalstatus_trans` DISABLE KEYS */;
INSERT INTO `hris_maritalstatus_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Single'),(6,3,'zh-Hans','[zh-Hans]Single'),(7,4,'en','Married'),(8,4,'zh-Hans','[zh-Hans]Married'),(9,5,'en','Widowed'),(10,5,'zh-Hans','[zh-Hans]Widowed'),(11,6,'en','Separated'),(12,6,'zh-Hans','[zh-Hans]Separated'),(13,7,'en','Divorced'),(14,7,'zh-Hans','[zh-Hans]Divorced');
/*!40000 ALTER TABLE `hris_maritalstatus_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_medical_data`
--

DROP TABLE IF EXISTS `hris_medical_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_medical_data` (
  `medical_id` int(11) NOT NULL AUTO_INCREMENT,
  `medical_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `bloodtype_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`medical_id`),
  UNIQUE KEY `idx_medical_guid` (`medical_guid`),
  KEY `fk_medical_ren_id` (`ren_id`),
  KEY `fk_bloodtype_id_id` (`bloodtype_id`),
  CONSTRAINT `fk_bloodtype_id_id` FOREIGN KEY (`bloodtype_id`) REFERENCES `hris_bloodtype_data` (`bloodtype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_medical_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_medical_data`
--

LOCK TABLES `hris_medical_data` WRITE;
/*!40000 ALTER TABLE `hris_medical_data` DISABLE KEYS */;
INSERT INTO `hris_medical_data` VALUES (1,'58febde3-dc40-4d65-a134-ffb2a2824707',1,3);
/*!40000 ALTER TABLE `hris_medical_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_medical_trans`
--

DROP TABLE IF EXISTS `hris_medical_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_medical_trans` (
  `Trans_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `medical_id` int(11) NOT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `medical_healthissues` text,
  `medical_allergies` text,
  PRIMARY KEY (`Trans_id`),
  KEY `medical_id` (`medical_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_medical_trans_ibfk_1` FOREIGN KEY (`medical_id`) REFERENCES `hris_medical_data` (`medical_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISMedical';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_medical_trans`
--

LOCK TABLES `hris_medical_trans` WRITE;
/*!40000 ALTER TABLE `hris_medical_trans` DISABLE KEYS */;
INSERT INTO `hris_medical_trans` VALUES (1,1,'en','',''),(2,1,'zh-Hans',NULL,NULL);
/*!40000 ALTER TABLE `hris_medical_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_passport`
--

DROP TABLE IF EXISTS `hris_passport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_passport` (
  `passport_id` int(11) NOT NULL AUTO_INCREMENT,
  `passport_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `passport_number` varchar(50) NOT NULL DEFAULT '-',
  `country_id` int(11) NOT NULL DEFAULT '1',
  `passport_issuedate` date NOT NULL DEFAULT '1000-01-01',
  `passport_expirationdate` date NOT NULL DEFAULT '1000-01-01',
  PRIMARY KEY (`passport_id`),
  UNIQUE KEY `idx_passport_guid` (`passport_guid`),
  UNIQUE KEY `idx_passport_ren_number` (`ren_id`,`passport_number`),
  KEY `fk_passport_country_id` (`country_id`),
  CONSTRAINT `fk_passport_country_id` FOREIGN KEY (`country_id`) REFERENCES `hris_country_data` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_passport_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_passport`
--

LOCK TABLES `hris_passport` WRITE;
/*!40000 ALTER TABLE `hris_passport` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_passport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_passportvisa`
--

DROP TABLE IF EXISTS `hris_passportvisa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_passportvisa` (
  `rpv_id` int(11) NOT NULL AUTO_INCREMENT,
  `rpv_guid` varchar(45) NOT NULL,
  `visatype_id` int(11) NOT NULL DEFAULT '0',
  `passport_id` int(11) NOT NULL DEFAULT '0',
  `rpv_visaexpirationdate` date NOT NULL DEFAULT '1000-01-01',
  PRIMARY KEY (`rpv_id`),
  UNIQUE KEY `idx_rpv_guid` (`rpv_guid`),
  KEY `idx_visatype_id` (`visatype_id`),
  KEY `idx_passport_id` (`passport_id`),
  CONSTRAINT `fk_xref_pv_passport` FOREIGN KEY (`passport_id`) REFERENCES `hris_passport` (`passport_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_pv_visatype` FOREIGN KEY (`visatype_id`) REFERENCES `hris_visatype_data` (`visatype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_passportvisa`
--

LOCK TABLES `hris_passportvisa` WRITE;
/*!40000 ALTER TABLE `hris_passportvisa` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_passportvisa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_access`
--

DROP TABLE IF EXISTS `hris_perm_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `ren_id` int(11) NOT NULL DEFAULT '0',
  `viewer_guid` varchar(64) NOT NULL DEFAULT '-',
  PRIMARY KEY (`access_id`),
  UNIQUE KEY `idx_ren_id` (`ren_id`),
  UNIQUE KEY `idx_view_guid` (`viewer_guid`),
  CONSTRAINT `fk_perm_access_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_access`
--

LOCK TABLES `hris_perm_access` WRITE;
/*!40000 ALTER TABLE `hris_perm_access` DISABLE KEYS */;
INSERT INTO `hris_perm_access` VALUES (1,1,'admin');
/*!40000 ALTER TABLE `hris_perm_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_dbfield`
--

DROP TABLE IF EXISTS `hris_perm_dbfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_dbfield` (
  `dbfield_id` int(11) NOT NULL AUTO_INCREMENT,
  `dbfield_rowmgr` varchar(45) NOT NULL,
  `dbfield_name` varchar(45) NOT NULL,
  `dbfield_path` text NOT NULL,
  PRIMARY KEY (`dbfield_id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_dbfield`
--

LOCK TABLES `hris_perm_dbfield` WRITE;
/*!40000 ALTER TABLE `hris_perm_dbfield` DISABLE KEYS */;
INSERT INTO `hris_perm_dbfield` VALUES (1,'HRISAssignLocation','location_guid','modules/HRIS/objects_bl/assignment/HRISAssignLocation.php'),(2,'HRISAssignLocation','locationtype_id','modules/HRIS/objects_bl/assignment/HRISAssignLocation.php'),(3,'HRISAssignLocation','parent_id','modules/HRIS/objects_bl/assignment/HRISAssignLocation.php'),(4,'HRISAssignLocation','location_label','modules/HRIS/objects_bl/assignment/HRISAssignLocation.php'),(5,'HRISAssignLocationType','locationtype_label','modules/HRIS/objects_bl/assignment/HRISAssignLocationType.php'),(6,'HRISAssignMCC','parent_id','modules/HRIS/objects_bl/assignment/HRISAssignMCC.php'),(7,'HRISAssignMCC','mcc_label','modules/HRIS/objects_bl/assignment/HRISAssignMCC.php'),(8,'HRISAssignMCC','mcc_description','modules/HRIS/objects_bl/assignment/HRISAssignMCC.php'),(9,'HRISAssignment','assignment_guid','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(10,'HRISAssignment','ren_id','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(11,'HRISAssignment','position_id','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(12,'HRISAssignment','team_id','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(13,'HRISAssignment','assignment_startdate','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(14,'HRISAssignment','assignment_enddate','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(15,'HRISAssignment','assignment_isprimary','modules/HRIS/objects_bl/assignment/HRISAssignment.php'),(16,'HRISAssignPosition','parent_id','modules/HRIS/objects_bl/assignment/HRISAssignPosition.php'),(17,'HRISAssignPosition','position_label','modules/HRIS/objects_bl/assignment/HRISAssignPosition.php'),(18,'HRISAssignReportingLevel','rptlvl_label','modules/HRIS/objects_bl/assignment/HRISAssignReportingLevel.php'),(19,'HRISAssignReportingLevel','rptlvl_description','modules/HRIS/objects_bl/assignment/HRISAssignReportingLevel.php'),(20,'HRISAssignTeam','rptlvl_id','modules/HRIS/objects_bl/assignment/HRISAssignTeam.php'),(21,'HRISAssignTeam','mcc_id','modules/HRIS/objects_bl/assignment/HRISAssignTeam.php'),(22,'HRISAssignTeam','gma_locationID','modules/HRIS/objects_bl/assignment/HRISAssignTeam.php'),(23,'HRISAssignTeam','team_type','modules/HRIS/objects_bl/assignment/HRISAssignTeam.php'),(24,'HRISAssignTeam','team_label','modules/HRIS/objects_bl/assignment/HRISAssignTeam.php'),(25,'HRISXrefAssignmentLocation','assignment_id','modules/HRIS/objects_bl/assignment/HRISXrefAssignmentLocation.php'),(26,'HRISXrefAssignmentLocation','location_id','modules/HRIS/objects_bl/assignment/HRISXrefAssignmentLocation.php'),(27,'HRISXrefTeamLocation','tl_guid','modules/HRIS/objects_bl/assignment/HRISXrefTeamLocation.php'),(28,'HRISXrefTeamLocation','team_id','modules/HRIS/objects_bl/assignment/HRISXrefTeamLocation.php'),(29,'HRISXrefTeamLocation','location_id','modules/HRIS/objects_bl/assignment/HRISXrefTeamLocation.php'),(30,'HRISAccount','account_guid','modules/HRIS/objects_bl/HRISAccount.php'),(31,'HRISAccount','family_id','modules/HRIS/objects_bl/HRISAccount.php'),(32,'HRISAccount','account_number','modules/HRIS/objects_bl/HRISAccount.php'),(33,'HRISAccount','country_id','modules/HRIS/objects_bl/HRISAccount.php'),(34,'HRISAccount','account_isprimary','modules/HRIS/objects_bl/HRISAccount.php'),(35,'HRISAddress','address_guid','modules/HRIS/objects_bl/HRISAddress.php'),(36,'HRISAddress','family_id','modules/HRIS/objects_bl/HRISAddress.php'),(37,'HRISAddress','addresstype_id','modules/HRIS/objects_bl/HRISAddress.php'),(38,'HRISAddress','country_id','modules/HRIS/objects_bl/HRISAddress.php'),(39,'HRISAddress','phone_id','modules/HRIS/objects_bl/HRISAddress.php'),(40,'HRISAddress','address_postalcode','modules/HRIS/objects_bl/HRISAddress.php'),(41,'HRISAddress','address_province','modules/HRIS/objects_bl/HRISAddress.php'),(42,'HRISAddress','address_city','modules/HRIS/objects_bl/HRISAddress.php'),(43,'HRISAddress','address_street','modules/HRIS/objects_bl/HRISAddress.php'),(44,'HRISAddressType','addresstype_label','modules/HRIS/objects_bl/HRISAddressType.php'),(45,'HRISAltContact','altcontact_guid','modules/HRIS/objects_bl/HRISAltContact.php'),(46,'HRISAltContact','ren_id','modules/HRIS/objects_bl/HRISAltContact.php'),(47,'HRISAltContact','altcontacttype_id','modules/HRIS/objects_bl/HRISAltContact.php'),(48,'HRISAltContact','altcontact_contact','modules/HRIS/objects_bl/HRISAltContact.php'),(49,'HRISAltContactType','altcontacttype_label','modules/HRIS/objects_bl/HRISAltContactType.php'),(50,'HRISAttachment','attachment_guid','modules/HRIS/objects_bl/HRISAttachment.php'),(51,'HRISAttachment','attachment_timestamp','modules/HRIS/objects_bl/HRISAttachment.php'),(52,'HRISAttachment','attachment_filename','modules/HRIS/objects_bl/HRISAttachment.php'),(53,'HRISAttachment','attachment_access','modules/HRIS/objects_bl/HRISAttachment.php'),(54,'HRISAttachment','attachmenttype_id','modules/HRIS/objects_bl/HRISAttachment.php'),(55,'HRISAttachment','attachment_content','modules/HRIS/objects_bl/HRISAttachment.php'),(56,'HRISAttachment','attachment_mimetype','modules/HRIS/objects_bl/HRISAttachment.php'),(57,'HRISAttachment','attachment_description','modules/HRIS/objects_bl/HRISAttachment.php'),(58,'HRISAttachmentType','attachmenttype_label','modules/HRIS/objects_bl/HRISAttachmentType.php'),(59,'HRISAttachmentType','attachmenttype_description','modules/HRIS/objects_bl/HRISAttachmentType.php'),(60,'HRISAttitude','attitude_label','modules/HRIS/objects_bl/HRISAttitude.php'),(61,'HRISBloodType','bloodtype_label','modules/HRIS/objects_bl/HRISBloodType.php'),(62,'HRISChange','dbfield_id','modules/HRIS/objects_bl/HRISChange.php'),(63,'HRISChange','change_previous_value','modules/HRIS/objects_bl/HRISChange.php'),(64,'HRISChange','change_new_value','modules/HRIS/objects_bl/HRISChange.php'),(65,'HRISChange','changegroup_id','modules/HRIS/objects_bl/HRISChange.php'),(66,'HRISChangeGroup','changegroup_timestamp','modules/HRIS/objects_bl/HRISChangeGroup.php'),(67,'HRISChangeGroup','changegroup_requester_id','modules/HRIS/objects_bl/HRISChangeGroup.php'),(68,'HRISChangeGroup','changegroup_approver_id','modules/HRIS/objects_bl/HRISChangeGroup.php'),(69,'HRISChangeGroup','ren_id','modules/HRIS/objects_bl/HRISChangeGroup.php'),(70,'HRISChangeGroup','family_id','modules/HRIS/objects_bl/HRISChangeGroup.php'),(71,'HRISChangeGroup','changegroup_status','modules/HRIS/objects_bl/HRISChangeGroup.php'),(72,'HRISChangeGroup','changegroup_changetype','modules/HRIS/objects_bl/HRISChangeGroup.php'),(73,'HRISChangeGroup','changegroup_resolution_timestamp','modules/HRIS/objects_bl/HRISChangeGroup.php'),(74,'HRISChangeGroup','changegroup_comment','modules/HRIS/objects_bl/HRISChangeGroup.php'),(75,'HRISCountry','country_code','modules/HRIS/objects_bl/HRISCountry.php'),(76,'HRISCountry','country_callingcode','modules/HRIS/objects_bl/HRISCountry.php'),(77,'HRISCountry','country_weight','modules/HRIS/objects_bl/HRISCountry.php'),(78,'HRISCountry','country_label','modules/HRIS/objects_bl/HRISCountry.php'),(79,'HRISDegree','degree_label','modules/HRIS/objects_bl/HRISDegree.php'),(80,'HRISDependent','dependent_guid','modules/HRIS/objects_bl/HRISDependent.php'),(81,'HRISDependent','ren_id','modules/HRIS/objects_bl/HRISDependent.php'),(82,'HRISDependent','schoolingmethod_id','modules/HRIS/objects_bl/HRISDependent.php'),(83,'HRISEducation','education_guid','modules/HRIS/objects_bl/HRISEducation.php'),(84,'HRISEducation','ren_id','modules/HRIS/objects_bl/HRISEducation.php'),(85,'HRISEducation','degree_id','modules/HRIS/objects_bl/HRISEducation.php'),(86,'HRISEducation','educationmajor_id','modules/HRIS/objects_bl/HRISEducation.php'),(87,'HRISEducation','education_gradyr','modules/HRIS/objects_bl/HRISEducation.php'),(88,'HRISEducation','education_school','modules/HRIS/objects_bl/HRISEducation.php'),(89,'HRISEducation','education_comment','modules/HRIS/objects_bl/HRISEducation.php'),(90,'HRISEducationMajor','educationmajor_label','modules/HRIS/objects_bl/HRISEducationMajor.php'),(91,'HRISEmail','email_guid','modules/HRIS/objects_bl/HRISEmail.php'),(92,'HRISEmail','ren_id','modules/HRIS/objects_bl/HRISEmail.php'),(93,'HRISEmail','email_issecure','modules/HRIS/objects_bl/HRISEmail.php'),(94,'HRISEmail','email_address','modules/HRIS/objects_bl/HRISEmail.php'),(95,'HRISEmailSecureDomain','domain_label','modules/HRIS/objects_bl/HRISEmailSecureDomain.php'),(96,'HRISEmergencyContact','ec_guid','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(97,'HRISEmergencyContact','family_id','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(98,'HRISEmergencyContact','ec_name','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(99,'HRISEmergencyContact','relationship_id','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(100,'HRISEmergencyContact','ec_phone1_type','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(101,'HRISEmergencyContact','ec_phone1','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(102,'HRISEmergencyContact','ec_phone2_type','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(103,'HRISEmergencyContact','ec_phone2','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(104,'HRISEmergencyContact','ec_email','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(105,'HRISEmergencyContact','attitude_id','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(106,'HRISEmergencyContact','ec_address','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(107,'HRISEmergencyContact','ec_specialinstructions','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(108,'HRISEmergencyContact','ec_languagesspoken','modules/HRIS/objects_bl/HRISEmergencyContact.php'),(109,'HRISEthnicity','ethnicity_label','modules/HRIS/objects_bl/HRISEthnicity.php'),(110,'HRISFamily','family_guid','modules/HRIS/objects_bl/HRISFamily.php'),(111,'HRISFamily','family_anniversary','modules/HRIS/objects_bl/HRISFamily.php'),(112,'HRISFamily','family_isregwithembassy','modules/HRIS/objects_bl/HRISFamily.php'),(113,'HRISFundingSource','fundingsource_label','modules/HRIS/objects_bl/HRISFundingSource.php'),(114,'HRISFundingSource','fundingsource_description','modules/HRIS/objects_bl/HRISFundingSource.php'),(115,'HRISGender','gender_label','modules/HRIS/objects_bl/HRISGender.php'),(116,'HRISImage','image_size','modules/HRIS/objects_bl/HRISImage.php'),(117,'HRISImage','attachment_id','modules/HRIS/objects_bl/HRISImage.php'),(118,'HRISImage','base_attachment_id','modules/HRIS/objects_bl/HRISImage.php'),(119,'HRISInsurance','insurance_guid','modules/HRIS/objects_bl/HRISInsurance.php'),(120,'HRISInsurance','family_id','modules/HRIS/objects_bl/HRISInsurance.php'),(121,'HRISInsurance','insurancetype_id','modules/HRIS/objects_bl/HRISInsurance.php'),(122,'HRISInsurance','insurance_providername','modules/HRIS/objects_bl/HRISInsurance.php'),(123,'HRISInsurance','insurance_providerphone','modules/HRIS/objects_bl/HRISInsurance.php'),(124,'HRISInsurance','insurance_policynumber','modules/HRIS/objects_bl/HRISInsurance.php'),(125,'HRISInsurance','insurance_effectivedate','modules/HRIS/objects_bl/HRISInsurance.php'),(126,'HRISInsurance','insurance_expirationdate','modules/HRIS/objects_bl/HRISInsurance.php'),(127,'HRISInsurance','insurance_contactname','modules/HRIS/objects_bl/HRISInsurance.php'),(128,'HRISInsurance','insurance_contactphone','modules/HRIS/objects_bl/HRISInsurance.php'),(129,'HRISInsuranceType','insurancetype_label','modules/HRIS/objects_bl/HRISInsuranceType.php'),(130,'HRISInterest','interest_guid','modules/HRIS/objects_bl/HRISInterest.php'),(131,'HRISInterest','ren_id','modules/HRIS/objects_bl/HRISInterest.php'),(132,'HRISInterest','interesttype_id','modules/HRIS/objects_bl/HRISInterest.php'),(133,'HRISInterest','interest_comment','modules/HRIS/objects_bl/HRISInterest.php'),(134,'HRISInterestType','interesttype_label','modules/HRIS/objects_bl/HRISInterestType.php'),(135,'HRISLanguage','language_label','modules/HRIS/objects_bl/HRISLanguage.php'),(136,'HRISMaritalStatus','maritalstatus_label','modules/HRIS/objects_bl/HRISMaritalStatus.php'),(137,'HRISMedical','medical_guid','modules/HRIS/objects_bl/HRISMedical.php'),(138,'HRISMedical','ren_id','modules/HRIS/objects_bl/HRISMedical.php'),(139,'HRISMedical','bloodtype_id','modules/HRIS/objects_bl/HRISMedical.php'),(140,'HRISMedical','medical_healthissues','modules/HRIS/objects_bl/HRISMedical.php'),(141,'HRISMedical','medical_allergies','modules/HRIS/objects_bl/HRISMedical.php'),(142,'HRISPassport','passport_guid','modules/HRIS/objects_bl/HRISPassport.php'),(143,'HRISPassport','ren_id','modules/HRIS/objects_bl/HRISPassport.php'),(144,'HRISPassport','passport_number','modules/HRIS/objects_bl/HRISPassport.php'),(145,'HRISPassport','country_id','modules/HRIS/objects_bl/HRISPassport.php'),(146,'HRISPassport','passport_issuedate','modules/HRIS/objects_bl/HRISPassport.php'),(147,'HRISPassport','passport_expirationdate','modules/HRIS/objects_bl/HRISPassport.php'),(148,'HRISPassportVisa','rpv_guid','modules/HRIS/objects_bl/HRISPassportVisa.php'),(149,'HRISPassportVisa','visatype_id','modules/HRIS/objects_bl/HRISPassportVisa.php'),(150,'HRISPassportVisa','passport_id','modules/HRIS/objects_bl/HRISPassportVisa.php'),(151,'HRISPassportVisa','rpv_visaexpirationdate','modules/HRIS/objects_bl/HRISPassportVisa.php'),(152,'HRISPhone','phone_guid','modules/HRIS/objects_bl/HRISPhone.php'),(153,'HRISPhone','ren_id','modules/HRIS/objects_bl/HRISPhone.php'),(154,'HRISPhone','phonetype_id','modules/HRIS/objects_bl/HRISPhone.php'),(155,'HRISPhone','phone_countrycode','modules/HRIS/objects_bl/HRISPhone.php'),(156,'HRISPhone','phone_number','modules/HRIS/objects_bl/HRISPhone.php'),(157,'HRISPhone','phone_comment','modules/HRIS/objects_bl/HRISPhone.php'),(158,'HRISPhoneType','phonetype_label','modules/HRIS/objects_bl/HRISPhoneType.php'),(159,'HRISProficiency','proficiency_label','modules/HRIS/objects_bl/HRISProficiency.php'),(160,'HRISProficiency','proficiency_description','modules/HRIS/objects_bl/HRISProficiency.php'),(161,'HRISRelationship','relationship_label','modules/HRIS/objects_bl/HRISRelationship.php'),(162,'HRISRen','ren_guid','modules/HRIS/objects_bl/HRISRen.php'),(163,'HRISRen','rentype_id','modules/HRIS/objects_bl/HRISRen.php'),(164,'HRISRen','family_id','modules/HRIS/objects_bl/HRISRen.php'),(165,'HRISRen','ren_surname','modules/HRIS/objects_bl/HRISRen.php'),(166,'HRISRen','ren_givenname','modules/HRIS/objects_bl/HRISRen.php'),(167,'HRISRen','ren_namecharacters','modules/HRIS/objects_bl/HRISRen.php'),(168,'HRISRen','ren_namepinyin','modules/HRIS/objects_bl/HRISRen.php'),(169,'HRISRen','ren_preferredname','modules/HRIS/objects_bl/HRISRen.php'),(170,'HRISRen','ren_birthdate','modules/HRIS/objects_bl/HRISRen.php'),(171,'HRISRen','ren_deathdate','modules/HRIS/objects_bl/HRISRen.php'),(172,'HRISRen','gender_id','modules/HRIS/objects_bl/HRISRen.php'),(173,'HRISRen','maritalstatus_id','modules/HRIS/objects_bl/HRISRen.php'),(174,'HRISRen','ethnicity_id','modules/HRIS/objects_bl/HRISRen.php'),(175,'HRISRen','ren_primarycitizenship','modules/HRIS/objects_bl/HRISRen.php'),(176,'HRISRen','statustype_id','modules/HRIS/objects_bl/HRISRen.php'),(177,'HRISRen','ren_isfamilypoc','modules/HRIS/objects_bl/HRISRen.php'),(178,'HRISRen','ren_preferredlang','modules/HRIS/objects_bl/HRISRen.php'),(179,'HRISRen','ren_picture','modules/HRIS/objects_bl/HRISRen.php'),(180,'HRISRen','ren_comments','modules/HRIS/objects_bl/HRISRen.php'),(181,'HRISRenStatusType','statustype_label','modules/HRIS/objects_bl/HRISRenStatusType.php'),(182,'HRISRenStatusType','statustype_description','modules/HRIS/objects_bl/HRISRenStatusType.php'),(183,'HRISRenType','rentype_label','modules/HRIS/objects_bl/HRISRenType.php'),(184,'HRISRenType','rentype_description','modules/HRIS/objects_bl/HRISRenType.php'),(185,'HRISSchoolingMethod','schoolingmethod_label','modules/HRIS/objects_bl/HRISSchoolingMethod.php'),(186,'HRISSendingRegion','country_id','modules/HRIS/objects_bl/HRISSendingRegion.php'),(187,'HRISSendingRegion','sendingregion_label','modules/HRIS/objects_bl/HRISSendingRegion.php'),(188,'HRISTalent','talent_guid','modules/HRIS/objects_bl/HRISTalent.php'),(189,'HRISTalent','ren_id','modules/HRIS/objects_bl/HRISTalent.php'),(190,'HRISTalent','talenttype_id','modules/HRIS/objects_bl/HRISTalent.php'),(191,'HRISTalent','talent_comment','modules/HRIS/objects_bl/HRISTalent.php'),(192,'HRISTalentType','talenttype_label','modules/HRIS/objects_bl/HRISTalentType.php'),(193,'HRISTraining','training_guid','modules/HRIS/objects_bl/HRISTraining.php'),(194,'HRISTraining','ren_id','modules/HRIS/objects_bl/HRISTraining.php'),(195,'HRISTraining','course_id','modules/HRIS/objects_bl/HRISTraining.php'),(196,'HRISTraining','training_completiondate','modules/HRIS/objects_bl/HRISTraining.php'),(197,'HRISTrainingCourse','course_label','modules/HRIS/objects_bl/HRISTrainingCourse.php'),(198,'HRISVersion','version_num','modules/HRIS/objects_bl/HRISVersion.php'),(199,'HRISVersion','version_date','modules/HRIS/objects_bl/HRISVersion.php'),(200,'HRISVersion','version_desc','modules/HRIS/objects_bl/HRISVersion.php'),(201,'HRISVisaType','country_id','modules/HRIS/objects_bl/HRISVisaType.php'),(202,'HRISVisaType','visatype_label','modules/HRIS/objects_bl/HRISVisaType.php'),(203,'HRISWorker','worker_guid','modules/HRIS/objects_bl/HRISWorker.php'),(204,'HRISWorker','ren_id','modules/HRIS/objects_bl/HRISWorker.php'),(205,'HRISWorker','worker_enrolledasstudent','modules/HRIS/objects_bl/HRISWorker.php'),(206,'HRISWorker','sendingregion_id','modules/HRIS/objects_bl/HRISWorker.php'),(207,'HRISWorker','worker_acceptancedate','modules/HRIS/objects_bl/HRISWorker.php'),(208,'HRISWorker','worker_datejoinedstaff','modules/HRIS/objects_bl/HRISWorker.php'),(209,'HRISWorker','worker_datejoinedchinamin','modules/HRIS/objects_bl/HRISWorker.php'),(210,'HRISWorker','worker_dateleftchinamin','modules/HRIS/objects_bl/HRISWorker.php'),(211,'HRISWorker','worker_terminationdate','modules/HRIS/objects_bl/HRISWorker.php'),(212,'HRISWorker','worker_motherattitude','modules/HRIS/objects_bl/HRISWorker.php'),(213,'HRISWorker','worker_fatherattitude','modules/HRIS/objects_bl/HRISWorker.php'),(214,'HRISWorker','worker_isenrolledfortax','modules/HRIS/objects_bl/HRISWorker.php'),(215,'HRISWorker','worker_hukoulocation','modules/HRIS/objects_bl/HRISWorker.php'),(216,'HRISWorker','worker_governmentid','modules/HRIS/objects_bl/HRISWorker.php'),(217,'HRISWorker','worker_vocation','modules/HRIS/objects_bl/HRISWorker.php'),(218,'HRISWorker','statustype_id','modules/HRIS/objects_bl/HRISWorker.php'),(219,'HRISWorker','paysys_id','modules/HRIS/objects_bl/HRISWorker.php'),(220,'HRISWorker','fundingsource_id','modules/HRIS/objects_bl/HRISWorker.php'),(221,'HRISWorkerPaySys','paysys_label','modules/HRIS/objects_bl/HRISWorkerPaySys.php'),(222,'HRISWorkerPaySys','paysys_description','modules/HRIS/objects_bl/HRISWorkerPaySys.php'),(223,'HRISWorkerStatusHistory','sh_guid','modules/HRIS/objects_bl/HRISWorkerStatusHistory.php'),(224,'HRISWorkerStatusHistory','worker_id','modules/HRIS/objects_bl/HRISWorkerStatusHistory.php'),(225,'HRISWorkerStatusHistory','statustype_id','modules/HRIS/objects_bl/HRISWorkerStatusHistory.php'),(226,'HRISWorkerStatusHistory','sh_time','modules/HRIS/objects_bl/HRISWorkerStatusHistory.php'),(227,'HRISWorkerStatusType','statustype_label','modules/HRIS/objects_bl/HRISWorkerStatusType.php'),(228,'HRISWorkerStatusType','statustype_description','modules/HRIS/objects_bl/HRISWorkerStatusType.php'),(229,'HRISXrefAttachmentRen','ar_id','modules/HRIS/objects_bl/HRISXrefAttachmentRen.php'),(230,'HRISXrefAttachmentRen','ar_guid','modules/HRIS/objects_bl/HRISXrefAttachmentRen.php'),(231,'HRISXrefAttachmentRen','ren_id','modules/HRIS/objects_bl/HRISXrefAttachmentRen.php'),(232,'HRISXrefAttachmentRen','attachment_id','modules/HRIS/objects_bl/HRISXrefAttachmentRen.php'),(233,'HRISXrefRenLanguageProficiency','rlp_guid','modules/HRIS/objects_bl/HRISXrefRenLanguageProficiency.php'),(234,'HRISXrefRenLanguageProficiency','ren_id','modules/HRIS/objects_bl/HRISXrefRenLanguageProficiency.php'),(235,'HRISXrefRenLanguageProficiency','language_id','modules/HRIS/objects_bl/HRISXrefRenLanguageProficiency.php'),(236,'HRISXrefRenLanguageProficiency','proficiency_id','modules/HRIS/objects_bl/HRISXrefRenLanguageProficiency.php'),(237,'HRISAccess','ren_id','modules/HRIS/objects_bl/permissions/HRISAccess.php'),(238,'HRISAccess','viewer_guid','modules/HRIS/objects_bl/permissions/HRISAccess.php'),(239,'HRISFilter','filter_condition','modules/HRIS/objects_bl/permissions/HRISFilter.php'),(240,'HRISFilter','filter_type','modules/HRIS/objects_bl/permissions/HRISFilter.php'),(241,'HRISFilter','filter_parsedcondition','modules/HRIS/objects_bl/permissions/HRISFilter.php'),(242,'HRISFilter','filter_label','modules/HRIS/objects_bl/permissions/HRISFilter.php'),(243,'HRISOptionType','optiontype_label','modules/HRIS/objects_bl/permissions/HRISOptionType.php'),(244,'HRISRenFilter','ren_id','modules/HRIS/objects_bl/permissions/HRISRenFilter.php'),(245,'HRISRenFilter','filter_id','modules/HRIS/objects_bl/permissions/HRISRenFilter.php'),(246,'HRISRole','role_label','modules/HRIS/objects_bl/permissions/HRISRole.php'),(247,'HRISRoleAction','role_id','modules/HRIS/objects_bl/permissions/HRISRoleAction.php'),(248,'HRISRoleAction','action_key','modules/HRIS/objects_bl/permissions/HRISRoleAction.php'),(249,'HRISRule','ruleset_id','modules/HRIS/objects_bl/permissions/HRISRule.php'),(250,'HRISRule','rule_field','modules/HRIS/objects_bl/permissions/HRISRule.php'),(251,'HRISRule','rule_condition','modules/HRIS/objects_bl/permissions/HRISRule.php'),(252,'HRISRule','rule_value','modules/HRIS/objects_bl/permissions/HRISRule.php'),(253,'HRISRule','searchablefields_id','modules/HRIS/objects_bl/permissions/HRISRule.php'),(254,'HRISRuleSet','ruleset_label','modules/HRIS/objects_bl/permissions/HRISRuleSet.php'),(255,'HRISRuleSet','ruleset_matches','modules/HRIS/objects_bl/permissions/HRISRuleSet.php'),(256,'HRISRuleSet','filter_id','modules/HRIS/objects_bl/permissions/HRISRuleSet.php'),(257,'HRISReport','report_name','modules/HRIS/objects_bl/reports/HRISReport.php'),(258,'HRISReport','report_type','modules/HRIS/objects_bl/reports/HRISReport.php'),(259,'HRISReport','ren_id','modules/HRIS/objects_bl/reports/HRISReport.php'),(260,'HRISReport','report_view','modules/HRIS/objects_bl/reports/HRISReport.php'),(261,'HRISReport','filter_id','modules/HRIS/objects_bl/reports/HRISReport.php'),(262,'HRISReport','report_shareable','modules/HRIS/objects_bl/reports/HRISReport.php'),(263,'HRISReportFields','report_id','modules/HRIS/objects_bl/reports/HRISReportFields.php'),(264,'HRISReportFields','reportfield_weight','modules/HRIS/objects_bl/reports/HRISReportFields.php'),(265,'HRISReportFields','reportfield_type','modules/HRIS/objects_bl/reports/HRISReportFields.php'),(266,'HRISReportFields','reportfield_name','modules/HRIS/objects_bl/reports/HRISReportFields.php'),(267,'HRISReportFields','searchablefields_id','modules/HRIS/objects_bl/reports/HRISReportFields.php'),(268,'HRISReportWebService','report_name','modules/HRIS/objects_bl/reports/HRISReportWebService.php'),(269,'HRISReportWebService','report_type','modules/HRIS/objects_bl/reports/HRISReportWebService.php'),(270,'HRISReportWebService','ren_id','modules/HRIS/objects_bl/reports/HRISReportWebService.php'),(271,'HRISReportWebService','report_view','modules/HRIS/objects_bl/reports/HRISReportWebService.php'),(272,'HRISReportWebService','filter_id','modules/HRIS/objects_bl/reports/HRISReportWebService.php'),(273,'HRISReportWebService','report_shareable','modules/HRIS/objects_bl/reports/HRISReportWebService.php'),(274,'HRISReportWeight','report_id','modules/HRIS/objects_bl/reports/HRISReportWeight.php'),(275,'HRISReportWeight','ren_id','modules/HRIS/objects_bl/reports/HRISReportWeight.php'),(276,'HRISReportWeight','reportweight_value','modules/HRIS/objects_bl/reports/HRISReportWeight.php'),(277,'HRISXrefReportRole','report_id','modules/HRIS/objects_bl/reports/HRISXrefReportRole.php'),(278,'HRISXrefReportRole','role_id','modules/HRIS/objects_bl/reports/HRISXrefReportRole.php');
/*!40000 ALTER TABLE `hris_perm_dbfield` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_filter_data`
--

DROP TABLE IF EXISTS `hris_perm_filter_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_filter_data` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_type` varchar(10) NOT NULL DEFAULT 'perm',
  `filter_condition` text,
  `filter_parsedcondition` text,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_filter_data`
--

LOCK TABLES `hris_perm_filter_data` WRITE;
/*!40000 ALTER TABLE `hris_perm_filter_data` DISABLE KEYS */;
INSERT INTO `hris_perm_filter_data` VALUES (1,'group','none',''),(2,'perm','none',''),(3,'group','Filter1','');
/*!40000 ALTER TABLE `hris_perm_filter_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_filter_trans`
--

DROP TABLE IF EXISTS `hris_perm_filter_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_filter_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `filter_label` text NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `filter_id` (`filter_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_perm_filter_trans_ibfk_1` FOREIGN KEY (`filter_id`) REFERENCES `hris_perm_filter_data` (`filter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISFilter';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_filter_trans`
--

LOCK TABLES `hris_perm_filter_trans` WRITE;
/*!40000 ALTER TABLE `hris_perm_filter_trans` DISABLE KEYS */;
INSERT INTO `hris_perm_filter_trans` VALUES (1,1,'en','All'),(2,1,'zh-Hans','[zh-Hans]All'),(3,2,'en','No Filter'),(4,2,'zh-Hans','[zh-Hans]No Filter'),(5,3,'en','All'),(6,3,'zh-Hans','[zh-Hans]All');
/*!40000 ALTER TABLE `hris_perm_filter_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_optiontype_data`
--

DROP TABLE IF EXISTS `hris_perm_optiontype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_optiontype_data` (
  `optiontype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`optiontype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_optiontype_data`
--

LOCK TABLES `hris_perm_optiontype_data` WRITE;
/*!40000 ALTER TABLE `hris_perm_optiontype_data` DISABLE KEYS */;
INSERT INTO `hris_perm_optiontype_data` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `hris_perm_optiontype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_optiontype_trans`
--

DROP TABLE IF EXISTS `hris_perm_optiontype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_optiontype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `optiontype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `optiontype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `optiontype_id` (`optiontype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_perm_optiontype_trans_ibfk_1` FOREIGN KEY (`optiontype_id`) REFERENCES `hris_perm_optiontype_data` (`optiontype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_optiontype_trans`
--

LOCK TABLES `hris_perm_optiontype_trans` WRITE;
/*!40000 ALTER TABLE `hris_perm_optiontype_trans` DISABLE KEYS */;
INSERT INTO `hris_perm_optiontype_trans` VALUES (1,1,'en','No Access'),(2,1,'zh-Hans','[zh-Hans]No Access'),(3,2,'en','View'),(4,2,'zh-Hans','[zh-Hans]View'),(5,3,'en','Edit'),(6,3,'zh-Hans','[zh-Hans]Edit');
/*!40000 ALTER TABLE `hris_perm_optiontype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_role_data`
--

DROP TABLE IF EXISTS `hris_perm_role_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_role_data` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_role_data`
--

LOCK TABLES `hris_perm_role_data` WRITE;
/*!40000 ALTER TABLE `hris_perm_role_data` DISABLE KEYS */;
INSERT INTO `hris_perm_role_data` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `hris_perm_role_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_role_trans`
--

DROP TABLE IF EXISTS `hris_perm_role_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_role_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `role_label` varchar(100) NOT NULL DEFAULT '-',
  PRIMARY KEY (`Trans_id`),
  UNIQUE KEY `role_label` (`role_label`),
  KEY `role_id` (`role_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_perm_role_trans_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `hris_perm_role_data` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISRole';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_role_trans`
--

LOCK TABLES `hris_perm_role_trans` WRITE;
/*!40000 ALTER TABLE `hris_perm_role_trans` DISABLE KEYS */;
INSERT INTO `hris_perm_role_trans` VALUES (1,1,'en','User'),(2,1,'zh-Hans','[zh-Hans]User'),(3,2,'en','HR Admin'),(4,2,'zh-Hans','[zh-Hans]HR Admin'),(5,3,'en','System Admin'),(6,3,'zh-Hans','[zh-Hans]System Admin');
/*!40000 ALTER TABLE `hris_perm_role_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_roleaction`
--

DROP TABLE IF EXISTS `hris_perm_roleaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_roleaction` (
  `roleaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '1',
  `action_key` text NOT NULL,
  PRIMARY KEY (`roleaction_id`),
  KEY `idx_role_id` (`role_id`),
  CONSTRAINT `fk_perm_roleaction_role_id` FOREIGN KEY (`role_id`) REFERENCES `hris_perm_role_data` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_roleaction`
--

LOCK TABLES `hris_perm_roleaction` WRITE;
/*!40000 ALTER TABLE `hris_perm_roleaction` DISABLE KEYS */;
INSERT INTO `hris_perm_roleaction` VALUES (1,1,'viewModuleFU'),(2,2,'viewModuleAO'),(3,2,'viewModuleAC'),(4,3,'viewModuleAC'),(5,3,'viewModuleAA'),(6,2,'ReportAccess'),(7,2,'ReportCreate'),(8,2,'ReportEditable');
/*!40000 ALTER TABLE `hris_perm_roleaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_rule`
--

DROP TABLE IF EXISTS `hris_perm_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_rule` (
  `rule_id` int(11) NOT NULL AUTO_INCREMENT,
  `ruleset_id` int(11) NOT NULL,
  `searchablefields_id` int(11) NOT NULL,
  `rule_field` varchar(45) NOT NULL DEFAULT '-',
  `rule_condition` varchar(45) NOT NULL DEFAULT '-',
  `rule_value` text,
  PRIMARY KEY (`rule_id`),
  KEY `idx_scope_ruleset_id` (`ruleset_id`),
  CONSTRAINT `fk_perm_rule_ruleset_id` FOREIGN KEY (`ruleset_id`) REFERENCES `hris_perm_ruleset` (`ruleset_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_rule`
--

LOCK TABLES `hris_perm_rule` WRITE;
/*!40000 ALTER TABLE `hris_perm_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_perm_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_perm_ruleset`
--

DROP TABLE IF EXISTS `hris_perm_ruleset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_perm_ruleset` (
  `ruleset_id` int(11) NOT NULL AUTO_INCREMENT,
  `ruleset_label` varchar(45) NOT NULL DEFAULT '-',
  `ruleset_matches` varchar(3) NOT NULL DEFAULT 'any',
  `filter_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ruleset_id`),
  KEY `idx_scope_id` (`filter_id`),
  CONSTRAINT `fk_perm_ruleset_filter_id` FOREIGN KEY (`filter_id`) REFERENCES `hris_perm_filter_data` (`filter_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_perm_ruleset`
--

LOCK TABLES `hris_perm_ruleset` WRITE;
/*!40000 ALTER TABLE `hris_perm_ruleset` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_perm_ruleset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_phone_data`
--

DROP TABLE IF EXISTS `hris_phone_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_phone_data` (
  `phone_id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_guid` varchar(45) NOT NULL,
  `ren_id` int(11) DEFAULT NULL,
  `phonetype_id` int(11) NOT NULL DEFAULT '1',
  `phone_countrycode` int(11) NOT NULL DEFAULT '1',
  `phone_number` varchar(45) NOT NULL DEFAULT '-',
  PRIMARY KEY (`phone_id`),
  UNIQUE KEY `idx_phone_guid` (`phone_guid`),
  KEY `fk_phone_phonetype_id` (`phonetype_id`),
  KEY `fk_phone_ren_id` (`ren_id`),
  KEY `fk_phone_country_id` (`phone_countrycode`),
  CONSTRAINT `fk_phone_country_id` FOREIGN KEY (`phone_countrycode`) REFERENCES `hris_country_data` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_phonetype_id` FOREIGN KEY (`phonetype_id`) REFERENCES `hris_phonetype_data` (`phonetype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_phone_data`
--

LOCK TABLES `hris_phone_data` WRITE;
/*!40000 ALTER TABLE `hris_phone_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_phone_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_phone_trans`
--

DROP TABLE IF EXISTS `hris_phone_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_phone_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `phone_comment` text,
  PRIMARY KEY (`Trans_id`),
  KEY `phone_id` (`phone_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_phone_trans_ibfk_1` FOREIGN KEY (`phone_id`) REFERENCES `hris_phone_data` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISPhone';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_phone_trans`
--

LOCK TABLES `hris_phone_trans` WRITE;
/*!40000 ALTER TABLE `hris_phone_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_phone_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_phonetype_data`
--

DROP TABLE IF EXISTS `hris_phonetype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_phonetype_data` (
  `phonetype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`phonetype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_phonetype_data`
--

LOCK TABLES `hris_phonetype_data` WRITE;
/*!40000 ALTER TABLE `hris_phonetype_data` DISABLE KEYS */;
INSERT INTO `hris_phonetype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0);
/*!40000 ALTER TABLE `hris_phonetype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_phonetype_trans`
--

DROP TABLE IF EXISTS `hris_phonetype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_phonetype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `phonetype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `phonetype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `phonetype_id` (`phonetype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_phonetype_trans_ibfk_1` FOREIGN KEY (`phonetype_id`) REFERENCES `hris_phonetype_data` (`phonetype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_phonetype_trans`
--

LOCK TABLES `hris_phonetype_trans` WRITE;
/*!40000 ALTER TABLE `hris_phonetype_trans` DISABLE KEYS */;
INSERT INTO `hris_phonetype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Mobile'),(6,3,'zh-Hans','[zh-Hans]Mobile'),(7,4,'en','Home'),(8,4,'zh-Hans','[zh-Hans]Home'),(9,5,'en','Work'),(10,5,'zh-Hans','[zh-Hans]Work'),(11,6,'en','Other'),(12,6,'zh-Hans','[zh-Hans]Other');
/*!40000 ALTER TABLE `hris_phonetype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_proficiency_data`
--

DROP TABLE IF EXISTS `hris_proficiency_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_proficiency_data` (
  `proficiency_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`proficiency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_proficiency_data`
--

LOCK TABLES `hris_proficiency_data` WRITE;
/*!40000 ALTER TABLE `hris_proficiency_data` DISABLE KEYS */;
INSERT INTO `hris_proficiency_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0);
/*!40000 ALTER TABLE `hris_proficiency_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_proficiency_trans`
--

DROP TABLE IF EXISTS `hris_proficiency_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_proficiency_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `proficiency_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `proficiency_label` varchar(64) NOT NULL,
  `proficiency_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `proficiency_id` (`proficiency_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_proficiency_trans_ibfk_1` FOREIGN KEY (`proficiency_id`) REFERENCES `hris_proficiency_data` (`proficiency_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_proficiency_trans`
--

LOCK TABLES `hris_proficiency_trans` WRITE;
/*!40000 ALTER TABLE `hris_proficiency_trans` DISABLE KEYS */;
INSERT INTO `hris_proficiency_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Not able to have a conversation',NULL),(6,3,'zh-Hans','[zh-Hans]Not able to have a conversation',NULL),(7,4,'en','Elementary',NULL),(8,4,'zh-Hans','[zh-Hans]Elementary',NULL),(9,5,'en','Limited working',NULL),(10,5,'zh-Hans','[zh-Hans]Limited working',NULL),(11,6,'en','Professional working',NULL),(12,6,'zh-Hans','[zh-Hans]Professional working',NULL),(13,7,'en','Full professional',NULL),(14,7,'zh-Hans','[zh-Hans]Full professional',NULL),(15,8,'en','Native or bilingual',NULL),(16,8,'zh-Hans','[zh-Hans]Native or bilingual',NULL);
/*!40000 ALTER TABLE `hris_proficiency_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_relationship_data`
--

DROP TABLE IF EXISTS `hris_relationship_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_relationship_data` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`relationship_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_relationship_data`
--

LOCK TABLES `hris_relationship_data` WRITE;
/*!40000 ALTER TABLE `hris_relationship_data` DISABLE KEYS */;
INSERT INTO `hris_relationship_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0);
/*!40000 ALTER TABLE `hris_relationship_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_relationship_trans`
--

DROP TABLE IF EXISTS `hris_relationship_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_relationship_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `relationship_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `relationship_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `relationship_id` (`relationship_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_relationship_trans_ibfk_1` FOREIGN KEY (`relationship_id`) REFERENCES `hris_relationship_data` (`relationship_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_relationship_trans`
--

LOCK TABLES `hris_relationship_trans` WRITE;
/*!40000 ALTER TABLE `hris_relationship_trans` DISABLE KEYS */;
INSERT INTO `hris_relationship_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Friend'),(6,3,'zh-Hans','[zh-Hans]Friend'),(7,4,'en','Parent'),(8,4,'zh-Hans','[zh-Hans]Parent'),(9,5,'en','Brother'),(10,5,'zh-Hans','[zh-Hans]Brother'),(11,6,'en','Sister'),(12,6,'zh-Hans','[zh-Hans]Sister'),(13,7,'en','Child'),(14,7,'zh-Hans','[zh-Hans]Child'),(15,8,'en','Grandparent'),(16,8,'zh-Hans','[zh-Hans]Grandparent'),(17,9,'en','Spouse\'s Parent'),(18,9,'zh-Hans','[zh-Hans]Spouse\'s Parent'),(19,10,'en','Spouse\'s Brother'),(20,10,'zh-Hans','[zh-Hans]Spouse\'s Brother'),(21,11,'en','Spouse\'s Sister'),(22,11,'zh-Hans','[zh-Hans]Spouse\'s Sister'),(23,12,'en','Spouse\'s Grandparent'),(24,12,'zh-Hans','[zh-Hans]Spouse\'s Grandparent'),(25,13,'en','Other'),(26,13,'zh-Hans','[zh-Hans]Other');
/*!40000 ALTER TABLE `hris_relationship_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_ren_data`
--

DROP TABLE IF EXISTS `hris_ren_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_ren_data` (
  `ren_id` int(11) NOT NULL AUTO_INCREMENT,
  `ren_guid` varchar(45) NOT NULL,
  `rentype_id` int(11) NOT NULL DEFAULT '1',
  `family_id` int(11) NOT NULL DEFAULT '1',
  `ren_surname` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '-',
  `ren_givenname` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '-',
  `ren_namecharacters` varchar(45) NOT NULL DEFAULT '-',
  `ren_namepinyin` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '-',
  `ren_preferredname` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '-',
  `ren_birthdate` date NOT NULL DEFAULT '1000-01-01',
  `ren_deathdate` date NOT NULL DEFAULT '1000-01-01',
  `gender_id` int(11) NOT NULL DEFAULT '1',
  `maritalstatus_id` int(11) NOT NULL DEFAULT '1',
  `ethnicity_id` int(11) NOT NULL DEFAULT '1',
  `ren_primarycitizenship` int(11) NOT NULL DEFAULT '1',
  `statustype_id` int(11) NOT NULL DEFAULT '1',
  `ren_isfamilypoc` tinyint(1) NOT NULL DEFAULT '1',
  `ren_preferredlang` int(11) NOT NULL DEFAULT '1',
  `ren_picture` blob,
  PRIMARY KEY (`ren_id`),
  UNIQUE KEY `idx_ren_guid` (`ren_guid`),
  KEY `fk_ren_country_id` (`ren_primarycitizenship`),
  KEY `fk_ren_ethnicity_id` (`ethnicity_id`),
  KEY `fk_ren_family_id` (`family_id`),
  KEY `fk_ren_gender_id` (`gender_id`),
  KEY `fk_ren_maritalstatus_id` (`maritalstatus_id`),
  KEY `fk_ren_rentype_id` (`rentype_id`),
  KEY `fk_ren_statustype_id` (`statustype_id`),
  KEY `fk_ren_language_id` (`ren_preferredlang`),
  CONSTRAINT `fk_ren_country_id` FOREIGN KEY (`ren_primarycitizenship`) REFERENCES `hris_country_data` (`country_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_ethnicity_id` FOREIGN KEY (`ethnicity_id`) REFERENCES `hris_ethnicity_data` (`ethnicity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_family_id` FOREIGN KEY (`family_id`) REFERENCES `hris_family` (`family_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_gender_id` FOREIGN KEY (`gender_id`) REFERENCES `hris_gender_data` (`gender_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_language_id` FOREIGN KEY (`ren_preferredlang`) REFERENCES `hris_language_data` (`language_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_maritalstatus_id` FOREIGN KEY (`maritalstatus_id`) REFERENCES `hris_maritalstatus_data` (`maritalstatus_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_rentype_id` FOREIGN KEY (`rentype_id`) REFERENCES `hris_rentype_data` (`rentype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ren_statustype_id` FOREIGN KEY (`statustype_id`) REFERENCES `hris_ren_statustype_data` (`statustype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_ren_data`
--

LOCK TABLES `hris_ren_data` WRITE;
/*!40000 ALTER TABLE `hris_ren_data` DISABLE KEYS */;
INSERT INTO `hris_ren_data` VALUES (1,'5d7bdd40-2a02-4bcc-9c54-454c5aa63df8',3,1,'Admin','User','老板','laoban','Boss','1970-07-21','1000-01-01',3,4,3,3,4,1,1,NULL);
/*!40000 ALTER TABLE `hris_ren_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_ren_statustype_data`
--

DROP TABLE IF EXISTS `hris_ren_statustype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_ren_statustype_data` (
  `statustype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statustype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_ren_statustype_data`
--

LOCK TABLES `hris_ren_statustype_data` WRITE;
/*!40000 ALTER TABLE `hris_ren_statustype_data` DISABLE KEYS */;
INSERT INTO `hris_ren_statustype_data` VALUES (1,0),(2,0),(3,1),(4,1),(5,1),(6,1),(7,1);
/*!40000 ALTER TABLE `hris_ren_statustype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_ren_statustype_trans`
--

DROP TABLE IF EXISTS `hris_ren_statustype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_ren_statustype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `statustype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `statustype_label` varchar(64) NOT NULL,
  `statustype_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `statustype_id` (`statustype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_ren_statustype_trans_ibfk_1` FOREIGN KEY (`statustype_id`) REFERENCES `hris_ren_statustype_data` (`statustype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_ren_statustype_trans`
--

LOCK TABLES `hris_ren_statustype_trans` WRITE;
/*!40000 ALTER TABLE `hris_ren_statustype_trans` DISABLE KEYS */;
INSERT INTO `hris_ren_statustype_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','New User','User has been added to the system but not yet entered personal information'),(6,3,'zh-Hans','[zh-Hans]New User','[zh-Hans]User has been added to the system but not yet entered personal information'),(7,4,'en','Awaiting Approval','Person is awaiting approval of entered data'),(8,4,'zh-Hans','[zh-Hans]Awaiting Approval','[zh-Hans]Person is awaiting approval of entered data'),(9,5,'en','Active','Person is currently involved in ministry'),(10,5,'zh-Hans','[zh-Hans]Active','[zh-Hans]Person is currently involved in ministry'),(11,6,'en','Inactive','Person is no longer involved with ministry in this area'),(12,6,'zh-Hans','[zh-Hans]Inactive','[zh-Hans]Person is no longer involved with ministry in this area'),(13,7,'en','Deceased','Person has died'),(14,7,'zh-Hans','[zh-Hans]Deceased','[zh-Hans]Person has died');
/*!40000 ALTER TABLE `hris_ren_statustype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_ren_trans`
--

DROP TABLE IF EXISTS `hris_ren_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_ren_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `ren_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `ren_comments` text,
  PRIMARY KEY (`Trans_id`),
  KEY `ren_id` (`ren_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_ren_trans_ibfk_1` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISRen';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_ren_trans`
--

LOCK TABLES `hris_ren_trans` WRITE;
/*!40000 ALTER TABLE `hris_ren_trans` DISABLE KEYS */;
INSERT INTO `hris_ren_trans` VALUES (1,1,'en',NULL),(2,1,'zh-Hans',NULL);
/*!40000 ALTER TABLE `hris_ren_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_rentype_data`
--

DROP TABLE IF EXISTS `hris_rentype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_rentype_data` (
  `rentype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rentype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_rentype_data`
--

LOCK TABLES `hris_rentype_data` WRITE;
/*!40000 ALTER TABLE `hris_rentype_data` DISABLE KEYS */;
INSERT INTO `hris_rentype_data` VALUES (1,0),(2,0),(3,1),(4,1),(5,1),(6,1),(7,1);
/*!40000 ALTER TABLE `hris_rentype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_rentype_trans`
--

DROP TABLE IF EXISTS `hris_rentype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_rentype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `rentype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `rentype_label` varchar(64) NOT NULL,
  `rentype_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `rentype_id` (`rentype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_rentype_trans_ibfk_1` FOREIGN KEY (`rentype_id`) REFERENCES `hris_rentype_data` (`rentype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_rentype_trans`
--

LOCK TABLES `hris_rentype_trans` WRITE;
/*!40000 ALTER TABLE `hris_rentype_trans` DISABLE KEYS */;
INSERT INTO `hris_rentype_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Worker','Person works for the ministry in some capacity, can be full-time, part-time, or volunteer'),(6,3,'zh-Hans','[zh-Hans]Worker','[zh-Hans]Person works for the ministry in some capacity, can be full-time, part-time, or volunteer'),(7,4,'en','Child','Child of a worker'),(8,4,'zh-Hans','[zh-Hans]Child','[zh-Hans]Child of a worker'),(9,5,'en','Non-Staff Spouse','Person is spouse of a worker but does not involved in Campus Crusade ministry'),(10,5,'zh-Hans','[zh-Hans]Non-Staff Spouse','[zh-Hans]Person is spouse of a worker but does not involved in Campus Crusade ministry'),(11,6,'en','Friend of Ministry','Person is not a member of Campus Crusade but participates in various events, e.g. a conference speaker'),(12,6,'zh-Hans','[zh-Hans]Friend of Ministry','[zh-Hans]Person is not a member of Campus Crusade but participates in various events, e.g. a conference speaker'),(13,7,'en','Other Dependent','Person is a dependent of a worker but not a child'),(14,7,'zh-Hans','[zh-Hans]Other Dependent','[zh-Hans]Person is a dependent of a worker but not a child');
/*!40000 ALTER TABLE `hris_rentype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_report`
--

DROP TABLE IF EXISTS `hris_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` text NOT NULL,
  `report_type` varchar(64) DEFAULT 'PERSONNEL',
  `ren_id` int(11) NOT NULL,
  `report_view` varchar(64) NOT NULL DEFAULT 'HTML',
  `report_shareable` tinyint(3) NOT NULL DEFAULT '0',
  `filter_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `fk_ren_id` (`ren_id`),
  CONSTRAINT `fk_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_report`
--

LOCK TABLES `hris_report` WRITE;
/*!40000 ALTER TABLE `hris_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_report_fields`
--

DROP TABLE IF EXISTS `hris_report_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_report_fields` (
  `reportfield_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `reportfield_weight` int(4) NOT NULL,
  `reportfield_type` varchar(64) NOT NULL DEFAULT 'FIELD',
  `reportfield_name` varchar(64) NOT NULL,
  `searchablefields_id` int(11) NOT NULL,
  PRIMARY KEY (`reportfield_id`),
  KEY `fk_report_id` (`report_id`),
  CONSTRAINT `fk_report_id` FOREIGN KEY (`report_id`) REFERENCES `hris_report` (`report_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_report_fields`
--

LOCK TABLES `hris_report_fields` WRITE;
/*!40000 ALTER TABLE `hris_report_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_report_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_reportweight`
--

DROP TABLE IF EXISTS `hris_reportweight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_reportweight` (
  `reportweight_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `reportweight_value` int(11) NOT NULL,
  PRIMARY KEY (`reportweight_id`),
  KEY `fk_reportweight_report_id` (`report_id`),
  CONSTRAINT `fk_reportweight_report_id` FOREIGN KEY (`report_id`) REFERENCES `hris_report` (`report_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_reportweight`
--

LOCK TABLES `hris_reportweight` WRITE;
/*!40000 ALTER TABLE `hris_reportweight` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_reportweight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_schoolingmethod_data`
--

DROP TABLE IF EXISTS `hris_schoolingmethod_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_schoolingmethod_data` (
  `schoolingmethod_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schoolingmethod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_schoolingmethod_data`
--

LOCK TABLES `hris_schoolingmethod_data` WRITE;
/*!40000 ALTER TABLE `hris_schoolingmethod_data` DISABLE KEYS */;
INSERT INTO `hris_schoolingmethod_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `hris_schoolingmethod_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_schoolingmethod_trans`
--

DROP TABLE IF EXISTS `hris_schoolingmethod_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_schoolingmethod_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `schoolingmethod_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `schoolingmethod_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `schoolingmethod_id` (`schoolingmethod_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_schoolingmethod_trans_ibfk_1` FOREIGN KEY (`schoolingmethod_id`) REFERENCES `hris_schoolingmethod_data` (`schoolingmethod_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_schoolingmethod_trans`
--

LOCK TABLES `hris_schoolingmethod_trans` WRITE;
/*!40000 ALTER TABLE `hris_schoolingmethod_trans` DISABLE KEYS */;
INSERT INTO `hris_schoolingmethod_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Public'),(6,3,'zh-Hans','[zh-Hans]Public'),(7,4,'en','Private'),(8,4,'zh-Hans','[zh-Hans]Private'),(9,5,'en','Home School'),(10,5,'zh-Hans','[zh-Hans]Home School'),(11,6,'en','Other'),(12,6,'zh-Hans','[zh-Hans]Other'),(13,7,'en','Not Applicable'),(14,7,'zh-Hans','[zh-Hans]Not Applicable');
/*!40000 ALTER TABLE `hris_schoolingmethod_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_searchablefields_test`
--

DROP TABLE IF EXISTS `hris_searchablefields_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_searchablefields_test` (
  `test_id` int(11) NOT NULL AUTO_INCREMENT,
  `test_text` varchar(45) NOT NULL,
  `test_droplist` varchar(45) NOT NULL,
  `test_lookup` varchar(45) NOT NULL,
  `test_date` varchar(45) NOT NULL,
  `rentype_id` int(11) NOT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_searchablefields_test`
--

LOCK TABLES `hris_searchablefields_test` WRITE;
/*!40000 ALTER TABLE `hris_searchablefields_test` DISABLE KEYS */;
INSERT INTO `hris_searchablefields_test` VALUES (1,'','','Table value A','',2),(2,'','','Table value B','',3),(3,'','','Table value C','',4),(4,'','','Table value D','',0);
/*!40000 ALTER TABLE `hris_searchablefields_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_sendingregion_data`
--

DROP TABLE IF EXISTS `hris_sendingregion_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_sendingregion_data` (
  `sendingregion_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  `country_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sendingregion_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `hris_sendingregion_data_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `hris_country_data` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_sendingregion_data`
--

LOCK TABLES `hris_sendingregion_data` WRITE;
/*!40000 ALTER TABLE `hris_sendingregion_data` DISABLE KEYS */;
INSERT INTO `hris_sendingregion_data` VALUES (1,0,1),(2,0,1),(3,0,45),(4,0,45),(5,0,45),(6,0,45),(7,0,45),(8,0,45),(9,0,45),(10,0,45),(11,0,222),(12,0,222),(13,0,222),(14,0,222),(15,0,222),(16,0,222),(17,0,222),(18,0,222),(19,0,222),(20,0,222);
/*!40000 ALTER TABLE `hris_sendingregion_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_sendingregion_trans`
--

DROP TABLE IF EXISTS `hris_sendingregion_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_sendingregion_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `sendingregion_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `sendingregion_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `sendingregion_id` (`sendingregion_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_sendingregion_trans_ibfk_1` FOREIGN KEY (`sendingregion_id`) REFERENCES `hris_sendingregion_data` (`sendingregion_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_sendingregion_trans`
--

LOCK TABLES `hris_sendingregion_trans` WRITE;
/*!40000 ALTER TABLE `hris_sendingregion_trans` DISABLE KEYS */;
INSERT INTO `hris_sendingregion_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Northwest aka Silk Road'),(6,3,'zh-Hans','[zh-Hans]Northwest aka Silk Road'),(7,4,'en','Beijing'),(8,4,'zh-Hans','[zh-Hans]Beijing'),(9,5,'en','Northeast'),(10,5,'zh-Hans','[zh-Hans]Northeast'),(11,6,'en','Yellow River aka River of Life'),(12,6,'zh-Hans','[zh-Hans]Yellow River aka River of Life'),(13,7,'en','Shanghai aka The Zone'),(14,7,'zh-Hans','[zh-Hans]Shanghai aka The Zone'),(15,8,'en','Mid-China'),(16,8,'zh-Hans','[zh-Hans]Mid-China'),(17,9,'en','Southwest'),(18,9,'zh-Hans','[zh-Hans]Southwest'),(19,10,'en','Southeast'),(20,10,'zh-Hans','[zh-Hans]Southeast'),(21,11,'en','Northeast'),(22,11,'zh-Hans','[zh-Hans]Northeast'),(23,12,'en','Mid-Atlantic'),(24,12,'zh-Hans','[zh-Hans]Mid-Atlantic'),(25,13,'en','Mid-South'),(26,13,'zh-Hans','[zh-Hans]Mid-South'),(27,14,'en','Southeast'),(28,14,'zh-Hans','[zh-Hans]Southeast'),(29,15,'en','Great Lakes'),(30,15,'zh-Hans','[zh-Hans]Great Lakes'),(31,16,'en','Upper Mid-West'),(32,16,'zh-Hans','[zh-Hans]Upper Mid-West'),(33,17,'en','Great Plains'),(34,17,'zh-Hans','[zh-Hans]Great Plains'),(35,18,'en','Red River'),(36,18,'zh-Hans','[zh-Hans]Red River'),(37,19,'en','Greater Northwest'),(38,19,'zh-Hans','[zh-Hans]Greater Northwest'),(39,20,'en','Pacific Southwest'),(40,20,'zh-Hans','[zh-Hans]Pacific Southwest');
/*!40000 ALTER TABLE `hris_sendingregion_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_talent_data`
--

DROP TABLE IF EXISTS `hris_talent_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_talent_data` (
  `talent_id` int(11) NOT NULL AUTO_INCREMENT,
  `talent_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `talenttype_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`talent_id`),
  UNIQUE KEY `idx_talent_guid` (`talent_guid`),
  KEY `idx_ren_id` (`ren_id`),
  KEY `idx_talent_id` (`talenttype_id`),
  CONSTRAINT `fk_talent_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_talent_talenttype_id` FOREIGN KEY (`talenttype_id`) REFERENCES `hris_talenttype_data` (`talenttype_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_talent_data`
--

LOCK TABLES `hris_talent_data` WRITE;
/*!40000 ALTER TABLE `hris_talent_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_talent_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_talent_trans`
--

DROP TABLE IF EXISTS `hris_talent_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_talent_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `talent_id` int(11) NOT NULL,
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `talent_comment` text,
  PRIMARY KEY (`Trans_id`),
  KEY `talent_id` (`talent_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_talent_trans_ibfk_1` FOREIGN KEY (`talent_id`) REFERENCES `hris_talent_data` (`talent_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISTalent';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_talent_trans`
--

LOCK TABLES `hris_talent_trans` WRITE;
/*!40000 ALTER TABLE `hris_talent_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_talent_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_talenttype_data`
--

DROP TABLE IF EXISTS `hris_talenttype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_talenttype_data` (
  `talenttype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`talenttype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_talenttype_data`
--

LOCK TABLES `hris_talenttype_data` WRITE;
/*!40000 ALTER TABLE `hris_talenttype_data` DISABLE KEYS */;
INSERT INTO `hris_talenttype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0);
/*!40000 ALTER TABLE `hris_talenttype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_talenttype_trans`
--

DROP TABLE IF EXISTS `hris_talenttype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_talenttype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `talenttype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `talenttype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `talenttype_id` (`talenttype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_talenttype_trans_ibfk_1` FOREIGN KEY (`talenttype_id`) REFERENCES `hris_talenttype_data` (`talenttype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_talenttype_trans`
--

LOCK TABLES `hris_talenttype_trans` WRITE;
/*!40000 ALTER TABLE `hris_talenttype_trans` DISABLE KEYS */;
INSERT INTO `hris_talenttype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','Accounting/Finance'),(6,3,'zh-Hans','[zh-Hans]Accounting/Finance'),(7,4,'en','Administration'),(8,4,'zh-Hans','[zh-Hans]Administration'),(9,5,'en','Communication'),(10,5,'zh-Hans','[zh-Hans]Communication'),(11,6,'en','Conference Admin'),(12,6,'zh-Hans','[zh-Hans]Conference Admin'),(13,7,'en','Drama'),(14,7,'zh-Hans','[zh-Hans]Drama'),(15,8,'en','Graphic/Web Design'),(16,8,'zh-Hans','[zh-Hans]Graphic/Web Design'),(17,9,'en','IT'),(18,9,'zh-Hans','[zh-Hans]IT'),(19,10,'en','Legal'),(20,10,'zh-Hans','[zh-Hans]Legal'),(21,11,'en','Medical'),(22,11,'zh-Hans','[zh-Hans]Medical'),(23,12,'en','Multi-Media'),(24,12,'zh-Hans','[zh-Hans]Multi-Media'),(25,13,'en','Music'),(26,13,'zh-Hans','[zh-Hans]Music'),(27,14,'en','Photography'),(28,14,'zh-Hans','[zh-Hans]Photography'),(29,15,'en','Translation'),(30,15,'zh-Hans','[zh-Hans]Translation');
/*!40000 ALTER TABLE `hris_talenttype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_training`
--

DROP TABLE IF EXISTS `hris_training`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_training` (
  `training_id` int(11) NOT NULL AUTO_INCREMENT,
  `training_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `training_completiondate` date DEFAULT '1000-01-01',
  PRIMARY KEY (`training_id`),
  UNIQUE KEY `idx_training_guid` (`training_guid`),
  KEY `fk_training_course_id` (`course_id`),
  KEY `fk_training_ren_id` (`ren_id`),
  CONSTRAINT `fk_training_course_id` FOREIGN KEY (`course_id`) REFERENCES `hris_training_course_data` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_training_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_training`
--

LOCK TABLES `hris_training` WRITE;
/*!40000 ALTER TABLE `hris_training` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_training` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_training_course_data`
--

DROP TABLE IF EXISTS `hris_training_course_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_training_course_data` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_training_course_data`
--

LOCK TABLES `hris_training_course_data` WRITE;
/*!40000 ALTER TABLE `hris_training_course_data` DISABLE KEYS */;
INSERT INTO `hris_training_course_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0);
/*!40000 ALTER TABLE `hris_training_course_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_training_course_trans`
--

DROP TABLE IF EXISTS `hris_training_course_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_training_course_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `course_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `course_id` (`course_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_training_course_trans_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `hris_training_course_data` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_training_course_trans`
--

LOCK TABLES `hris_training_course_trans` WRITE;
/*!40000 ALTER TABLE `hris_training_course_trans` DISABLE KEYS */;
INSERT INTO `hris_training_course_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','DMPD Training'),(6,3,'zh-Hans','[zh-Hans]DMPD Training'),(7,4,'en','Emerging Leaders Training (ELI)'),(8,4,'zh-Hans','[zh-Hans]Emerging Leaders Training (ELI)'),(9,5,'en','IBS Requirements Completed'),(10,5,'zh-Hans','[zh-Hans]IBS Requirements Completed'),(11,6,'en','Local Leaders Training'),(12,6,'zh-Hans','[zh-Hans]Local Leaders Training'),(13,7,'en','New Staff Training'),(14,7,'zh-Hans','[zh-Hans]New Staff Training'),(15,8,'en','SALT Requirements Completed'),(16,8,'zh-Hans','[zh-Hans]SALT Requirements Completed'),(17,9,'en','Selection Training'),(18,9,'zh-Hans','[zh-Hans]Selection Training'),(19,10,'en','TMTC Training'),(20,10,'zh-Hans','[zh-Hans]TMTC Training'),(21,11,'en','Trainer\'s Training'),(22,11,'zh-Hans','[zh-Hans]Trainer\'s Training');
/*!40000 ALTER TABLE `hris_training_course_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_version_data`
--

DROP TABLE IF EXISTS `hris_version_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_version_data` (
  `version_id` int(11) NOT NULL AUTO_INCREMENT,
  `version_num` float NOT NULL,
  `version_date` date NOT NULL,
  PRIMARY KEY (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_version_data`
--

LOCK TABLES `hris_version_data` WRITE;
/*!40000 ALTER TABLE `hris_version_data` DISABLE KEYS */;
INSERT INTO `hris_version_data` VALUES (1,0.9,'2010-04-20');
/*!40000 ALTER TABLE `hris_version_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_version_trans`
--

DROP TABLE IF EXISTS `hris_version_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_version_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `version_desc` text NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `version_id` (`version_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_version_trans_ibfk_1` FOREIGN KEY (`version_id`) REFERENCES `hris_version_data` (`version_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISVersion';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_version_trans`
--

LOCK TABLES `hris_version_trans` WRITE;
/*!40000 ALTER TABLE `hris_version_trans` DISABLE KEYS */;
INSERT INTO `hris_version_trans` VALUES (1,1,'en','Initial schema version'),(2,1,'zh-Hans','[zh-Hans]Initial schema version');
/*!40000 ALTER TABLE `hris_version_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_visatype_data`
--

DROP TABLE IF EXISTS `hris_visatype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_visatype_data` (
  `visatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  `country_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`visatype_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `hris_visatype_data_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `hris_country_data` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_visatype_data`
--

LOCK TABLES `hris_visatype_data` WRITE;
/*!40000 ALTER TABLE `hris_visatype_data` DISABLE KEYS */;
INSERT INTO `hris_visatype_data` VALUES (1,0,1),(2,0,1),(3,1,45),(4,1,45),(5,1,45),(6,1,45),(7,1,45),(8,1,45),(9,1,45),(10,1,45),(11,1,45);
/*!40000 ALTER TABLE `hris_visatype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_visatype_trans`
--

DROP TABLE IF EXISTS `hris_visatype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_visatype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `visatype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `visatype_label` varchar(64) NOT NULL,
  PRIMARY KEY (`Trans_id`),
  KEY `visatype_id` (`visatype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_visatype_trans_ibfk_1` FOREIGN KEY (`visatype_id`) REFERENCES `hris_visatype_data` (`visatype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_visatype_trans`
--

LOCK TABLES `hris_visatype_trans` WRITE;
/*!40000 ALTER TABLE `hris_visatype_trans` DISABLE KEYS */;
INSERT INTO `hris_visatype_trans` VALUES (1,1,'en','-'),(2,1,'zh-Hans','-'),(3,2,'en','?'),(4,2,'zh-Hans','?'),(5,3,'en','L - Tourist'),(6,3,'zh-Hans','[zh-Hans]L - Tourist'),(7,4,'en','F - Business'),(8,4,'zh-Hans','[zh-Hans]F - Business'),(9,5,'en','Z - Work'),(10,5,'zh-Hans','[zh-Hans]Z - Work'),(11,6,'en','X - Student'),(12,6,'zh-Hans','[zh-Hans]X - Student'),(13,7,'en','D - Residence'),(14,7,'zh-Hans','[zh-Hans]D - Residence'),(15,8,'en','G - Transit'),(16,8,'zh-Hans','[zh-Hans]G - Transit'),(17,9,'en','J1 - Journalist 1-Year'),(18,9,'zh-Hans','[zh-Hans]J1 - Journalist 1-Year'),(19,10,'en','J2 - Journalist Temporary'),(20,10,'zh-Hans','[zh-Hans]J2 - Journalist Temporary'),(21,11,'en','C - Crewmember'),(22,11,'zh-Hans','[zh-Hans]C - Crewmember');
/*!40000 ALTER TABLE `hris_visatype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_worker`
--

DROP TABLE IF EXISTS `hris_worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_worker` (
  `worker_id` int(11) NOT NULL AUTO_INCREMENT,
  `worker_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `worker_enrolledasstudent` tinyint(1) NOT NULL DEFAULT '0',
  `sendingregion_id` int(11) NOT NULL DEFAULT '1',
  `worker_acceptancedate` date NOT NULL DEFAULT '1000-01-01',
  `worker_datejoinedstaff` date NOT NULL DEFAULT '1000-01-01',
  `worker_datejoinedchinamin` date NOT NULL DEFAULT '1000-01-01',
  `worker_dateleftchinamin` date NOT NULL DEFAULT '1000-01-01',
  `worker_terminationdate` date NOT NULL DEFAULT '1000-01-01',
  `worker_motherattitude` int(11) NOT NULL DEFAULT '1',
  `worker_fatherattitude` int(11) NOT NULL DEFAULT '1',
  `worker_isenrolledfortax` tinyint(1) NOT NULL DEFAULT '0',
  `worker_hukoulocation` varchar(45) NOT NULL DEFAULT '-',
  `worker_governmentid` varchar(16) NOT NULL DEFAULT '-',
  `worker_vocation` varchar(45) NOT NULL DEFAULT '-',
  `statustype_id` int(11) NOT NULL DEFAULT '1',
  `paysys_id` int(11) NOT NULL DEFAULT '1',
  `fundingsource_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`worker_id`),
  UNIQUE KEY `fk_worker_ren_id` (`ren_id`),
  UNIQUE KEY `idx_worker_guid` (`worker_guid`),
  KEY `fk_worker_father_attitude` (`worker_fatherattitude`),
  KEY `fk_worker_mother_attitude` (`worker_motherattitude`),
  KEY `fk_worker_statustype_id` (`statustype_id`),
  KEY `fk_worker_paysys_id` (`paysys_id`),
  KEY `fk_worker_fundingsource_id` (`fundingsource_id`),
  CONSTRAINT `fk_worker_father_attitude` FOREIGN KEY (`worker_fatherattitude`) REFERENCES `hris_attitude_data` (`attitude_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_fundingsource_id` FOREIGN KEY (`fundingsource_id`) REFERENCES `hris_fundingsource_data` (`fundingsource_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_mother_attitude` FOREIGN KEY (`worker_motherattitude`) REFERENCES `hris_attitude_data` (`attitude_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_paysys_id` FOREIGN KEY (`paysys_id`) REFERENCES `hris_worker_paysys_data` (`paysys_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_statustype_id` FOREIGN KEY (`statustype_id`) REFERENCES `hris_worker_statustype_data` (`statustype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_worker`
--

LOCK TABLES `hris_worker` WRITE;
/*!40000 ALTER TABLE `hris_worker` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_worker` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER insert_worker_status_trigger AFTER INSERT ON hris_worker
                    FOR EACH ROW
                    BEGIN
                      INSERT INTO hris_worker_statushistory (sh_guid, worker_id, statustype_id, sh_time) 
                        VALUES (UUID(), NEW.worker_id, NEW.statustype_id, NOW());
                    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_worker_status_trigger AFTER UPDATE ON hris_worker
                    FOR EACH ROW 
                    BEGIN
                      IF NEW.statustype_id != OLD.statustype_id THEN
                        INSERT INTO hris_worker_statushistory 
                          (sh_guid, worker_id, statustype_id, sh_time) 
                          VALUES (UUID(), NEW.worker_id, NEW.statustype_id, NOW());
                      END IF;
                    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hris_worker_paysys_data`
--

DROP TABLE IF EXISTS `hris_worker_paysys_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_worker_paysys_data` (
  `paysys_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`paysys_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_worker_paysys_data`
--

LOCK TABLES `hris_worker_paysys_data` WRITE;
/*!40000 ALTER TABLE `hris_worker_paysys_data` DISABLE KEYS */;
INSERT INTO `hris_worker_paysys_data` VALUES (1,0),(2,0),(3,0),(4,0);
/*!40000 ALTER TABLE `hris_worker_paysys_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_worker_paysys_trans`
--

DROP TABLE IF EXISTS `hris_worker_paysys_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_worker_paysys_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `paysys_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `paysys_label` varchar(64) NOT NULL,
  `paysys_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `paysys_id` (`paysys_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_worker_paysys_trans_ibfk_1` FOREIGN KEY (`paysys_id`) REFERENCES `hris_worker_paysys_data` (`paysys_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_worker_paysys_trans`
--

LOCK TABLES `hris_worker_paysys_trans` WRITE;
/*!40000 ALTER TABLE `hris_worker_paysys_trans` DISABLE KEYS */;
INSERT INTO `hris_worker_paysys_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Stewardwise','Pay system uses the Stewardwise application'),(6,3,'zh-Hans','[zh-Hans]Stewardwise','[zh-Hans]Pay system uses the Stewardwise application'),(7,4,'en','Other','Worker payment is handled through a system other than those listed'),(8,4,'zh-Hans','[zh-Hans]Other','[zh-Hans]Worker payment is handled through a system other than those listed');
/*!40000 ALTER TABLE `hris_worker_paysys_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_worker_statushistory`
--

DROP TABLE IF EXISTS `hris_worker_statushistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_worker_statushistory` (
  `sh_id` int(11) NOT NULL AUTO_INCREMENT,
  `sh_guid` varchar(45) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `statustype_id` int(11) NOT NULL,
  `sh_time` datetime NOT NULL,
  PRIMARY KEY (`sh_id`),
  UNIQUE KEY `idx_sh_guid` (`sh_guid`),
  KEY `fk_statushistory_worker_id` (`worker_id`),
  KEY `fk_statushistory_statustype_id` (`statustype_id`),
  CONSTRAINT `fk_statushistory_statustype_id` FOREIGN KEY (`statustype_id`) REFERENCES `hris_worker_statustype_data` (`statustype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_statushistory_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `hris_worker` (`worker_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_worker_statushistory`
--

LOCK TABLES `hris_worker_statushistory` WRITE;
/*!40000 ALTER TABLE `hris_worker_statushistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_worker_statushistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_worker_statustype_data`
--

DROP TABLE IF EXISTS `hris_worker_statustype_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_worker_statustype_data` (
  `statustype_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_protected` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`statustype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_worker_statustype_data`
--

LOCK TABLES `hris_worker_statustype_data` WRITE;
/*!40000 ALTER TABLE `hris_worker_statustype_data` DISABLE KEYS */;
INSERT INTO `hris_worker_statustype_data` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0);
/*!40000 ALTER TABLE `hris_worker_statustype_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_worker_statustype_trans`
--

DROP TABLE IF EXISTS `hris_worker_statustype_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_worker_statustype_trans` (
  `Trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `statustype_id` int(11) NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL DEFAULT '-',
  `statustype_label` varchar(64) NOT NULL,
  `statustype_description` text,
  PRIMARY KEY (`Trans_id`),
  KEY `statustype_id` (`statustype_id`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hris_worker_statustype_trans_ibfk_1` FOREIGN KEY (`statustype_id`) REFERENCES `hris_worker_statustype_data` (`statustype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Translateable Fields for HRISAddressType';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_worker_statustype_trans`
--

LOCK TABLES `hris_worker_statustype_trans` WRITE;
/*!40000 ALTER TABLE `hris_worker_statustype_trans` DISABLE KEYS */;
INSERT INTO `hris_worker_statustype_trans` VALUES (1,1,'en','-','A value for this field has not been selected'),(2,1,'zh-Hans','[zh-Hans]-','[zh-Hans]A value for this field has not been selected'),(3,2,'en','?','Value for this field is unknown'),(4,2,'zh-Hans','[zh-Hans]?','[zh-Hans]Value for this field is unknown'),(5,3,'en','Full-time','You are employed full-time by Campus Crusade and plan to stay with the organization for an indefinite period'),(6,3,'zh-Hans','[zh-Hans]Full-time','[zh-Hans]You are employed full-time by Campus Crusade and plan to stay with the organization for an indefinite period'),(7,4,'en','Short-term','You are employed full-time by Campus Crusade but applied to Campus Crusade to participate in a project of 2 years or less'),(8,4,'zh-Hans','[zh-Hans]Short-term','[zh-Hans]You are employed full-time by Campus Crusade but applied to Campus Crusade to participate in a project of 2 years or less'),(9,5,'en','Part-time','You have applied for staff and met all standards for full-time staff, but do not devote full-time to the ministry. You may be self-funded.'),(10,5,'zh-Hans','[zh-Hans]Part-time','[zh-Hans]You have applied for staff and met all standards for full-time staff, but do not devote full-time to the ministry. You may be self-funded.'),(11,6,'en','Volunteer','You volunteer with the ministry of Campus Crusade. This would include student leaders on a college campus or other volunteer leaders within the ministry'),(12,6,'zh-Hans','[zh-Hans]Volunteer','[zh-Hans]You volunteer with the ministry of Campus Crusade. This would include student leaders on a college campus or other volunteer leaders within the ministry');
/*!40000 ALTER TABLE `hris_worker_statustype_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_attachmentren`
--

DROP TABLE IF EXISTS `hris_xref_attachmentren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_attachmentren` (
  `ar_id` int(11) NOT NULL AUTO_INCREMENT,
  `ar_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `attachment_id` int(11) NOT NULL,
  PRIMARY KEY (`ar_id`),
  UNIQUE KEY `idx_xar_unique` (`ren_id`,`attachment_id`),
  UNIQUE KEY `idx_xar_guid` (`ar_guid`),
  KEY `fk_xar_attachment_id` (`attachment_id`),
  CONSTRAINT `fk_xar_attachment_id` FOREIGN KEY (`attachment_id`) REFERENCES `hris_attachment_data` (`attachment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xar_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_attachmentren`
--

LOCK TABLES `hris_xref_attachmentren` WRITE;
/*!40000 ALTER TABLE `hris_xref_attachmentren` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_attachmentren` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_location_assignment`
--

DROP TABLE IF EXISTS `hris_xref_location_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_location_assignment` (
  `al_id` int(11) NOT NULL AUTO_INCREMENT,
  `al_guid` varchar(45) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`al_id`),
  UNIQUE KEY `idx_al_unique` (`assignment_id`,`location_id`),
  KEY `fk_xref_al_location_id` (`location_id`),
  CONSTRAINT `fk_xref_al_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `hris_assignment` (`assignment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xref_al_location_id` FOREIGN KEY (`location_id`) REFERENCES `hris_assign_location_data` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_location_assignment`
--

LOCK TABLES `hris_xref_location_assignment` WRITE;
/*!40000 ALTER TABLE `hris_xref_location_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_location_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_perm_dbfield_role_optiontype`
--

DROP TABLE IF EXISTS `hris_xref_perm_dbfield_role_optiontype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_perm_dbfield_role_optiontype` (
  `dro_id` int(11) NOT NULL AUTO_INCREMENT,
  `dbfield_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  `optiontype_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dro_id`),
  UNIQUE KEY `idx_dro_unique` (`dbfield_id`,`role_id`,`optiontype_id`),
  KEY `fk_xref_pdro_optiontype_id` (`optiontype_id`),
  KEY `fk_xref_pdro_role_id` (`role_id`),
  CONSTRAINT `fk_xref_pdro_dbfield_id` FOREIGN KEY (`dbfield_id`) REFERENCES `hris_perm_dbfield` (`dbfield_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_pdro_optiontype_id` FOREIGN KEY (`optiontype_id`) REFERENCES `hris_perm_optiontype_data` (`optiontype_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_pdro_role_id` FOREIGN KEY (`role_id`) REFERENCES `hris_perm_role_data` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_perm_dbfield_role_optiontype`
--

LOCK TABLES `hris_xref_perm_dbfield_role_optiontype` WRITE;
/*!40000 ALTER TABLE `hris_xref_perm_dbfield_role_optiontype` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_perm_dbfield_role_optiontype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_perm_ren_filter`
--

DROP TABLE IF EXISTS `hris_xref_perm_ren_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_perm_ren_filter` (
  `rf_id` int(11) NOT NULL AUTO_INCREMENT,
  `ren_id` int(11) NOT NULL DEFAULT '0',
  `filter_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rf_id`),
  UNIQUE KEY `idx_rf_unique` (`ren_id`,`filter_id`),
  KEY `fk_rf_filter_id` (`filter_id`),
  CONSTRAINT `fk_rf_filter_id` FOREIGN KEY (`filter_id`) REFERENCES `hris_perm_filter_data` (`filter_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_rf_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_perm_ren_filter`
--

LOCK TABLES `hris_xref_perm_ren_filter` WRITE;
/*!40000 ALTER TABLE `hris_xref_perm_ren_filter` DISABLE KEYS */;
INSERT INTO `hris_xref_perm_ren_filter` VALUES (1,1,3);
/*!40000 ALTER TABLE `hris_xref_perm_ren_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_perm_role_filter_access`
--

DROP TABLE IF EXISTS `hris_xref_perm_role_filter_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_perm_role_filter_access` (
  `rfa_id` int(11) NOT NULL AUTO_INCREMENT,
  `access_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  `filter_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rfa_id`),
  UNIQUE KEY `idx_rfa_unique` (`role_id`,`filter_id`,`access_id`),
  KEY `fk_xref_prsa_access_id` (`access_id`),
  KEY `fk_xref_prsa_filter_id` (`filter_id`),
  CONSTRAINT `fk_xref_prsa_access_id` FOREIGN KEY (`access_id`) REFERENCES `hris_perm_access` (`access_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_prsa_filter_id` FOREIGN KEY (`filter_id`) REFERENCES `hris_perm_filter_data` (`filter_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_prsa_role_id` FOREIGN KEY (`role_id`) REFERENCES `hris_perm_role_data` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_perm_role_filter_access`
--

LOCK TABLES `hris_xref_perm_role_filter_access` WRITE;
/*!40000 ALTER TABLE `hris_xref_perm_role_filter_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_perm_role_filter_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_ren_language_proficiency`
--

DROP TABLE IF EXISTS `hris_xref_ren_language_proficiency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_ren_language_proficiency` (
  `rlp_id` int(11) NOT NULL AUTO_INCREMENT,
  `rlp_guid` varchar(45) NOT NULL,
  `ren_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `proficiency_id` int(11) NOT NULL,
  PRIMARY KEY (`rlp_id`),
  UNIQUE KEY `idx_xrlp_guid` (`rlp_guid`),
  KEY `fk_xref_lp_languageproficiency_id` (`proficiency_id`),
  KEY `fk_xref_lp_language_id` (`language_id`),
  KEY `fk_xref_lp_ren_id` (`ren_id`),
  CONSTRAINT `fk_xref_lp_languageproficiency_id` FOREIGN KEY (`proficiency_id`) REFERENCES `hris_proficiency_data` (`proficiency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_lp_language_id` FOREIGN KEY (`language_id`) REFERENCES `hris_language_data` (`language_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_xref_lp_ren_id` FOREIGN KEY (`ren_id`) REFERENCES `hris_ren_data` (`ren_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_ren_language_proficiency`
--

LOCK TABLES `hris_xref_ren_language_proficiency` WRITE;
/*!40000 ALTER TABLE `hris_xref_ren_language_proficiency` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_ren_language_proficiency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_reportrole`
--

DROP TABLE IF EXISTS `hris_xref_reportrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_reportrole` (
  `rr_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`rr_id`),
  KEY `fk_reportrole_report_id` (`report_id`),
  CONSTRAINT `fk_reportrole_report_id` FOREIGN KEY (`report_id`) REFERENCES `hris_report` (`report_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_reportrole`
--

LOCK TABLES `hris_xref_reportrole` WRITE;
/*!40000 ALTER TABLE `hris_xref_reportrole` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_reportrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hris_xref_team_location`
--

DROP TABLE IF EXISTS `hris_xref_team_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hris_xref_team_location` (
  `tl_id` int(11) NOT NULL AUTO_INCREMENT,
  `tl_guid` varchar(45) NOT NULL,
  `team_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`tl_id`),
  UNIQUE KEY `idx_tl_unique` (`team_id`,`location_id`),
  KEY `fk_xref_tl_location_id` (`location_id`),
  CONSTRAINT `fk_xref_al_team_id` FOREIGN KEY (`team_id`) REFERENCES `hris_assign_team_data` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xref_tl_location_id` FOREIGN KEY (`location_id`) REFERENCES `hris_assign_location_data` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hris_xref_team_location`
--

LOCK TABLES `hris_xref_team_location` WRITE;
/*!40000 ALTER TABLE `hris_xref_team_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `hris_xref_team_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cms_activeresources`
--

DROP TABLE IF EXISTS `site_cms_activeresources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cms_activeresources` (
  `activeresource_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `activeresource_key` text,
  `resource_id` int(11) unsigned NOT NULL DEFAULT '0',
  `activeresource_initString` text,
  PRIMARY KEY (`activeresource_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cms_activeresources`
--

LOCK TABLES `site_cms_activeresources` WRITE;
/*!40000 ALTER TABLE `site_cms_activeresources` DISABLE KEYS */;
INSERT INTO `site_cms_activeresources` VALUES (1,'Site:HTMLBlock:NotAuthorized',1,''),(2,'Site:HTMLBlock:PageNotFound',1,'');
/*!40000 ALTER TABLE `site_cms_activeresources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cms_page`
--

DROP TABLE IF EXISTS `site_cms_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cms_page` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ruleset_id` int(11) unsigned NOT NULL DEFAULT '0',
  `page_key` text,
  `page_eventTriggers` text,
  PRIMARY KEY (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cms_page`
--

LOCK TABLES `site_cms_page` WRITE;
/*!40000 ALTER TABLE `site_cms_page` DISABLE KEYS */;
INSERT INTO `site_cms_page` VALUES (1,1,0,'Site:NotAuthorized',''),(2,1,0,'Site:PageNotFound','');
/*!40000 ALTER TABLE `site_cms_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cms_pageResources`
--

DROP TABLE IF EXISTS `site_cms_pageResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cms_pageResources` (
  `pageresource_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL DEFAULT '0',
  `zone_key` text,
  `activeresource_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pageresource_order` int(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pageresource_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cms_pageResources`
--

LOCK TABLES `site_cms_pageResources` WRITE;
/*!40000 ALTER TABLE `site_cms_pageResources` DISABLE KEYS */;
INSERT INTO `site_cms_pageResources` VALUES (1,1,'content',1,1),(2,2,'content',2,1);
/*!40000 ALTER TABLE `site_cms_pageResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cms_resources`
--

DROP TABLE IF EXISTS `site_cms_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cms_resources` (
  `resource_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_path` text,
  `resource_objectName` text,
  PRIMARY KEY (`resource_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cms_resources`
--

LOCK TABLES `site_cms_resources` WRITE;
/*!40000 ALTER TABLE `site_cms_resources` DISABLE KEYS */;
INSERT INTO `site_cms_resources` VALUES (1,'modules/siteCreator/resources/htmlBlock/htmlBlockResource.php','HTMLBlockResource');
/*!40000 ALTER TABLE `site_cms_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cms_template`
--

DROP TABLE IF EXISTS `site_cms_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cms_template` (
  `template_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `template_key` text,
  `template_label` text,
  `template_html` text,
  `template_kind` text,
  PRIMARY KEY (`template_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cms_template`
--

LOCK TABLES `site_cms_template` WRITE;
/*!40000 ALTER TABLE `site_cms_template` DISABLE KEYS */;
INSERT INTO `site_cms_template` VALUES (1,'Content:SingleBlock','Single Content Block','[[[content]]]','site');
/*!40000 ALTER TABLE `site_cms_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cms_zones`
--

DROP TABLE IF EXISTS `site_cms_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cms_zones` (
  `zone_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `zone_key` text,
  PRIMARY KEY (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cms_zones`
--

LOCK TABLES `site_cms_zones` WRITE;
/*!40000 ALTER TABLE `site_cms_zones` DISABLE KEYS */;
INSERT INTO `site_cms_zones` VALUES (1,'content');
/*!40000 ALTER TABLE `site_cms_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_cron_schedule`
--

DROP TABLE IF EXISTS `site_cron_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_cron_schedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_key` varchar(50) NOT NULL DEFAULT '',
  `schedule_taskLabel` varchar(50) NOT NULL DEFAULT '',
  `schedule_nextRunDateTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`schedule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_cron_schedule`
--

LOCK TABLES `site_cron_schedule` WRITE;
/*!40000 ALTER TABLE `site_cron_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_cron_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_log`
--

DROP TABLE IF EXISTS `site_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_log` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `viewer_globalUserID` text NOT NULL,
  `switcheroo_realID` text NOT NULL,
  `log_dateTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_ipAddress` varchar(15) NOT NULL DEFAULT '',
  `log_moduleKey` varchar(15) NOT NULL DEFAULT '',
  `log_actionKey` varchar(15) NOT NULL DEFAULT '',
  `log_class` varchar(30) NOT NULL DEFAULT '',
  `log_key1` int(11) unsigned NOT NULL DEFAULT '0',
  `log_key2` int(11) unsigned NOT NULL DEFAULT '0',
  `log_key3` int(11) unsigned NOT NULL DEFAULT '0',
  `log_data` text NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_log`
--

LOCK TABLES `site_log` WRITE;
/*!40000 ALTER TABLE `site_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_modules`
--

DROP TABLE IF EXISTS `site_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_modules` (
  `module_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_key` text,
  `module_path` text,
  `module_includeFile` text,
  `module_cronFile` text,
  `module_cronObj` text,
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_modules`
--

LOCK TABLES `site_modules` WRITE;
/*!40000 ALTER TABLE `site_modules` DISABLE KEYS */;
INSERT INTO `site_modules` VALUES (1,'Root','objects/','','',''),(2,'site','modules/site/','','',''),(3,'HRIS','modules/HRIS/','app_HRIS.php','',''),(4,'HRISWebService','modules/HRIS/','app_HRIS.php',NULL,NULL),(5,'siteAdmin','modules/siteAdmin/','app_SiteAdmin.php','','');
/*!40000 ALTER TABLE `site_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_modules_actions`
--

DROP TABLE IF EXISTS `site_modules_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_modules_actions` (
  `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(11) unsigned NOT NULL DEFAULT '0',
  `action_key` text,
  `action_objFile` text,
  `action_objName` text,
  `action_parameters` text,
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_modules_actions`
--

LOCK TABLES `site_modules_actions` WRITE;
/*!40000 ALTER TABLE `site_modules_actions` DISABLE KEYS */;
INSERT INTO `site_modules_actions` VALUES (1,2,'ActionListLanguageTypes','actions/ActionListLanguageTypes.php','ActionListLanguageTypes',NULL),(2,2,'actionAdminBackupDB','actions/admin_backupDB.php','AdminBackupDB',NULL),(3,2,'actionAdminDeleteBackup','actions/admin_deleteBackup.php','AdminDeleteBackup',NULL),(4,2,'actionAdminListBackups','actions/admin_listBackups.php','AdminListBackups',NULL),(5,2,'actionAdminRestoreBackup','actions/admin_restoreBackup.php','AdminRestoreBackup',NULL),(6,2,'actionEvalAuthentication','actions/evalAuthentication.php','EvalAuthentication',NULL),(7,2,'actionLanguageSwitch','actions/languageSwitch.php','LanguageSwitch',NULL),(8,2,'actionLanguageSwitchMLTable','actions/languageSwitchMLTable.php','LanguageSwitchMLTable',NULL),(9,2,'actionAuthentication','actions/loginAuthentication.php','Authentication',NULL),(10,2,'puxLoadLabel','actions/puxLoadLabel.php','ActionPUXLoadLabel',NULL),(11,2,'puxViewForm','actions/puxViewForm.php','ActionPUXViewForm',NULL),(12,2,'actionSwitcherooService','actions/switcheroo.php','SwitcherooService',NULL),(13,2,'viewAdmin','object_page/page_Admin.php','PageAdmin',''),(14,2,'pageClose','object_page/page_Close.php','PageClose',NULL),(15,2,'viewLogin','object_page/page_Login.php','PageLogin','m=Li'),(16,2,'viewWelcome','object_page/page_Welcome.php','PageWelcome',''),(17,2,'loginEvalLogin','actions/loginEvalLogin.php','ActionEvalLogin',NULL),(18,2,'puxUpdateLabel','actions/puxUpdateLabel.php','ActionPUXUpdateLabel',NULL),(19,2,'viewTempDefault','object_page/page_Welcome.php','PageWelcome',''),(20,3,'actionAccountAdd','actions/AccountAdd.php','AccountAdd',NULL),(21,3,'actionAccountUpdate','actions/AccountUpdate.php','AccountUpdate',NULL),(22,3,'actionAddressListFamilyByRen','actions/AddressListFamilyByRen.php','AddressListFamilyByRen',NULL),(23,3,'actionAssignmentListFamilyByRen','actions/AssignmentListFamilyByRen.php','AssignmentListFamilyByRen',NULL),(24,3,'actionAttachmentDelete','actions/AttachmentDelete.php','AttachmentDelete',NULL),(25,3,'actionAttachmentDownload','actions/AttachmentDownload.php','AttachmentDownload',NULL),(26,3,'actionAttachmentListFamilyByRen','actions/AttachmentListFamilyByRen.php','AttachmentListFamilyByRen',NULL),(27,3,'actionAttachmentUpload','actions/AttachmentUpload.php','AttachmentUpload',NULL),(28,3,'actionDeletePendingUpdate','actions/change/DeletePendingUpdate.php','DeletePendingUpdate',NULL),(29,3,'actionEditPendingUpdate','actions/change/EditPendingUpdate.php','EditPendingUpdate',NULL),(30,3,'actionRequestUpdate','actions/change/RequestPendingUpdate.php','RequestPendingUpdate',NULL),(31,3,'actionGetViewableRoles','actions/controlBoxes/getViewableRoles.php','GetViewableRoles',NULL),(32,3,'actionDefaultDefTableAdd','actions/DefaultDefTableAdd.php','DefaultDefTableAdd',NULL),(33,3,'actionDefTableDelete','actions/DefTableDelete.php','DefTableDelete',NULL),(34,3,'actionDefTableList','actions/DefTableList.php','DefTableList',NULL),(35,3,'actionDefTablesListOf','actions/DefTablesListOf.php','DefTablesListOf',NULL),(36,3,'actionDefTableUpdate','actions/DefTableUpdate.php','DefTableUpdate',NULL),(37,3,'actionFamilyListByRenID','actions/FamilyListByRenID.php','FamilyListByRenID',NULL),(38,3,'actionFamilyMemberList','actions/FamilyMemberList.php','FamilyMemberList',NULL),(39,3,'actionFamilyMemberUpdate','actions/FamilyMemberUpdate.php','FamilyMemberUpdate',NULL),(40,3,'actionFamilySummaryInfoList','actions/FamilySummaryInfoList.php','FamilySummaryInfoList',NULL),(41,3,'actionGroupList','actions/GroupList.php','GroupList',NULL),(42,3,'actionLoadMedical','actions/LoadMedical.php','LoadMedical',NULL),(43,3,'actionRenAdd','actions/RenAdd.php','RenAdd',NULL),(44,3,'actionRenList','actions/RenList.php','RenList',NULL),(45,3,'actionRenUpdate','actions/RenUpdate.php','RenUpdate',NULL),(46,3,'cloneHrisReport','actions/reports/cloneReport.php','Reports_CloneReport',NULL),(47,3,'createHrisReport','actions/reports/createReport.php','Reports_CreateReport',NULL),(48,3,'deleteHrisReport','actions/reports/deleteReport.php','Reports_DeleteReport',NULL),(49,3,'generateHrisReport','actions/reports/generateReport.php','Reports_GenerateReport',NULL),(50,4,'getRenList','actions/reports/HRISWebService.php','HRISWebService',NULL),(51,3,'listHrisReports','actions/reports/listReports.php','Reports_ListReports',NULL),(52,3,'reportLoadFields','actions/reports/loadFields.php','Reports_LoadFields',NULL),(53,3,'loadHrisReport','actions/reports/loadReport.php','Reports_LoadReport',NULL),(54,3,'saveHrisReport','actions/reports/saveReport.php','Reports_SaveReport',NULL),(55,3,'reportUpdateFields','actions/reports/updateFields.php','Reports_UpdateFields',NULL),(56,3,'updateReportWeights','actions/reports/updateReportWeights.php','Reports_UpdateWeights',NULL),(57,3,'scopeAddRule','actions/scopeEditor/addRule.php','ScopeEditor_AddRule',NULL),(58,3,'scopeDeleteFilter','actions/scopeEditor/deleteFilter.php','ScopeEditor_DeleteFilter',NULL),(59,3,'scopeDeleteRule','actions/scopeEditor/deleteRule.php','ScopeEditor_DeleteRule',NULL),(60,3,'scopeEditMatches','actions/scopeEditor/editMatches.php','ScopeEditor_EditMatches',NULL),(61,3,'scopeLoadFilter','actions/scopeEditor/loadFilter.php','ScopeEditor_LoadFilter',NULL),(62,3,'scopeLoadRuleset','actions/scopeEditor/loadRuleset.php','ScopeEditor_LoadRuleset',NULL),(63,3,'scopeSaveFilter','actions/scopeEditor/saveFilter.php','ScopeEditor_SaveFilter',NULL),(64,3,'scopeSaveFilterLabel','actions/scopeEditor/saveFilterLabel.php','ScopeEditor_SaveFilterLabel',NULL),(65,3,'actionSetDefaultModule','actions/SetDefaultModule.php','SetDefaultModule',NULL),(66,3,'actionTableAdd','actions/TableAdd.php','TableAdd',NULL),(67,3,'actionTableDelete','actions/TableDelete.php','TableDelete',NULL),(68,3,'actionTableList','actions/TableList.php','TableList',NULL),(69,3,'actionTableListByFamilyFromRen','actions/TableListByFamilyFromRen.php','TableListByFamilyFromRen',NULL),(70,3,'actionTableListFamilyByRen','actions/TableListFamilyByRen.php','TableListFamilyByRen',NULL),(71,3,'actionTableListWorkerByRen','actions/TableListWorkerByRen.php','TableListWorkerByRen',NULL),(72,3,'actionTableUpdate','actions/TableUpdate.php','TableUpdate',NULL),(73,3,'TestCreateNewUser','actions/TestCreateNewUser.php','TestCreateNewUser',NULL),(74,3,'TestEmail','actions/TestEmail.php','TestEmail',NULL),(75,3,'TestSwitchUser','actions/TestSwitchUser.php','TestSwitchUser',NULL),(76,3,'wizardCompleted','actions/WizardCompleted.php','WizardCompleted',NULL),(77,3,'actionWorkerAdd','actions/WorkerAdd.php','WorkerAdd',NULL),(78,3,'actionAddRole','pages/admin/actions/addRole.php','AddRole',NULL),(79,3,'actionAddRoleFilter','pages/admin/actions/AddRoleFilter.php','AddRoleFilter',NULL),(80,3,'actionDeleteRole','pages/admin/actions/deleteRole.php','DeleteRole',NULL),(81,3,'actionDeleteRoleFilter','pages/admin/actions/DeleteRoleFilter.php','DeleteRoleFilter',NULL),(82,3,'actionListActionsUnused','pages/admin/actions/listActionsUnused.php','ListActionsUnused',NULL),(83,3,'actionListActionsUsed','pages/admin/actions/listActionsUsed.php','ListActionsUsed',NULL),(84,3,'actionListRoleFilters','pages/admin/actions/ListRoleFilters.php','ListRoleFilters',NULL),(85,3,'LoadResourcesAA','pages/admin/actions/loadResourcesAA.php','LoadResourcesAA',''),(86,3,'actionSaveRole','pages/admin/actions/saveRole.php','SaveRole',NULL),(87,3,'actionScopeAdd','pages/admin/actions/ScopeAdd.php','ScopeAdd',NULL),(88,3,'actionDeleteScope','pages/admin/actions/ScopeDelete.php','DeleteScope',NULL),(89,3,'actionScopeGet','pages/admin/actions/ScopeGet.php','ScopeGet',NULL),(90,3,'actionScopeList','pages/admin/actions/ScopeList.php','ScopeList',NULL),(91,3,'viewPageLayoutOrganizerAA','pages/admin/PageLayoutOrganizerAA.php','PageLayoutOrganizerAA',''),(92,3,'actionAssignmentAdd','pages/admin/plugins/ToolAdminAssignment/actions/AssignmentAdd.php','AssignmentAdd',NULL),(93,3,'actionAssignmentDelete','pages/admin/plugins/ToolAdminAssignment/actions/AssignmentDelete.php','AssignmentDelete',NULL),(94,3,'actionAssignmentList','pages/admin/plugins/ToolAdminAssignment/actions/AssignmentList.php','AssignmentList',NULL),(95,3,'actionListAllRolesFilters','pages/admin/plugins/ToolAdminAssignment/actions/ListAllRolesFilters.php','ListAllRolesFilters',NULL),(96,3,'viewToolAdminAssignment','pages/admin/plugins/ToolAdminAssignment/ToolAdminAssignment.php','ToolAdminAssignment',''),(97,3,'viewToolAdminFilter','pages/admin/plugins/ToolAdminFilter/ToolAdminFilter.php','ToolAdminFilter',''),(98,3,'actionFieldPermFieldsListOf','pages/admin/plugins/ToolAdminRole/actions/FieldPermFieldsListOf.php','FieldPermFieldsListOf',NULL),(99,3,'actionFieldPermFieldsUpdate','pages/admin/plugins/ToolAdminRole/actions/FieldPermFieldsUpdate.php','FieldPermFieldsUpdate',NULL),(100,3,'actionFieldPermTablesListOf','pages/admin/plugins/ToolAdminRole/actions/FieldPermTablesListOf.php','FieldPermTablesListOf',NULL),(101,3,'viewToolAdminRole','pages/admin/plugins/ToolAdminRole/ToolAdminRole.php','ToolAdminRole',''),(102,3,'LoadResourcesFU','pages/fieldUser/actions/loadResourcesFU.php','LoadResourcesFU',''),(103,3,'viewPageLayoutOrganizerFU','pages/fieldUser/PageLayoutOrganizerFU.php','PageLayoutOrganizerFU',''),(104,3,'viewToolFieldUserMarryStaff','pages/fieldUser/plugins/ToolFieldUserMarryStaff/ToolFieldUserMarryStaff.php','ToolFieldUserMarryStaff',''),(105,3,'viewToolFieldUserSummary','pages/fieldUser/plugins/ToolFieldUserSummary/ToolFieldUserSummary.php','ToolFieldUserSummary',''),(106,3,'viewHRISLayout','pages/layout/layout.php','HRISLayout',''),(107,3,'LoadResourcesAC','pages/manageContent/actions/loadResourcesAC.php','LoadResourcesAC',''),(108,3,'viewPageLayoutOrganizerAC','pages/manageContent/PageLayoutOrganizerAC.php','PageLayoutOrganizerAC',''),(109,3,'viewToolEditDefinitionFields','pages/manageContent/plugins/toolEditDefinitionFields/ToolEditDefinitionFields.php','ToolEditDefinitionFields',''),(110,3,'LoadAssignmentTeam','pages/manageContent/plugins/toolManageAssignments/actions/loadTeam.php','LoadAssignmentTeam',NULL),(111,3,'SaveAssignmentTeam','pages/manageContent/plugins/toolManageAssignments/actions/saveTeam.php','SaveAssignmentTeam',NULL),(112,3,'PanelListTeamsJS','pages/manageContent/plugins/toolManageAssignments/panels/PanelListTeams.php','PanelListTeams',''),(113,3,'PanelTeamEditFormJS','pages/manageContent/plugins/toolManageAssignments/panels/PanelTeamEditForm.php','PanelTeamEditForm',''),(114,3,'LoadResourcesAO','pages/manageOthers/actions/loadResourcesAO.php','LoadResourcesAO',''),(115,3,'viewPageLayoutOrganizerAO','pages/manageOthers/PageLayoutOrganizerAO.php','PageLayoutOrganizerAO',''),(116,3,'ApprovalTool_LoadChangeRequests','pages/manageOthers/plugins/ToolApproveEntry/actions/loadChangeRequests.php','ApprovalTool_LoadChangeRequests',NULL),(117,3,'ApprovalTool_SaveChangeRequests','pages/manageOthers/plugins/ToolApproveEntry/actions/saveChangeRequests.php','ApprovalTool_SaveChangeRequests',NULL),(118,3,'ApprovalTool_UpdateFamilyRegistration','pages/manageOthers/plugins/ToolApproveEntry/actions/updateFamilyRegistration.php','ApprovalTool_UpdateFamilyRegistration',NULL),(119,3,'HRIS::PanelApproveRegistration','pages/manageOthers/plugins/ToolApproveEntry/panels/PanelApproveRegistration.php','PanelApproveRegistration',NULL),(120,3,'viewToolApproveEntry','pages/manageOthers/plugins/ToolApproveEntry/ToolApproveEntry.php','ToolApproveEntry',''),(121,3,'ManageOthers_AddRen','pages/manageOthers/plugins/ToolManageOthers/actions/addRen.php','ManageOthers_AddRen',NULL),(122,3,'ManageOthers_CheckUserID','pages/manageOthers/plugins/ToolManageOthers/actions/checkUserID.php','ManageOthers_CheckUserID',NULL),(123,3,'viewToolManageOthers','pages/manageOthers/plugins/ToolManageOthers/ToolManageOthers.php','ToolManageOthers',''),(124,3,'Reports_BeginFieldEdit','pages/manageOthers/plugins/ToolReports/actions/beginFieldEdit.php','Reports_BeginFieldEdit',NULL),(125,3,'Reports_SaveFieldEdit','pages/manageOthers/plugins/ToolReports/actions/saveFieldEdit.php','Reports_SaveFieldEdit',NULL),(126,3,'viewToolReports','pages/manageOthers/plugins/ToolReports/ToolReports.php','ToolReports',''),(127,3,'viewWizardNewUser','pages/wizardNewUser/WizardNewUser.php','WizardNewUser',''),(128,3,'WidgetRenField','widgets/WidgetRenField.php','WidgetRenField',''),(129,3,'HRIS','app_HRIS.php','HRIS',NULL),(130,5,'viewSiteAdmin','app_SiteAdmin.php','SiteAdmin','');
/*!40000 ALTER TABLE `site_modules_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_multilingual_access`
--

DROP TABLE IF EXISTS `site_multilingual_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_access` (
  `multilingualaccess_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `viewer_id` int(11) unsigned NOT NULL DEFAULT '0',
  `multilingualaccess_level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`multilingualaccess_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_access`
--

LOCK TABLES `site_multilingual_access` WRITE;
/*!40000 ALTER TABLE `site_multilingual_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_multilingual_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_multilingual_application`
--

DROP TABLE IF EXISTS `site_multilingual_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_application` (
  `application_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `application_key` text NOT NULL,
  PRIMARY KEY (`application_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_application`
--

LOCK TABLES `site_multilingual_application` WRITE;
/*!40000 ALTER TABLE `site_multilingual_application` DISABLE KEYS */;
INSERT INTO `site_multilingual_application` VALUES (1,'site'),(2,'HRIS'),(3,'siteAdmin');
/*!40000 ALTER TABLE `site_multilingual_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_multilingual_label`
--

DROP TABLE IF EXISTS `site_multilingual_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_label` (
  `label_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `set_id` int(11) unsigned NOT NULL DEFAULT '0',
  `language_code` varchar(10) NOT NULL,
  `label_key` text,
  `label_label` text,
  `label_lastMod` datetime DEFAULT NULL,
  `label_needs_translation` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `label_path` text,
  PRIMARY KEY (`label_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1552 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_label`
--

LOCK TABLES `site_multilingual_label` WRITE;
/*!40000 ALTER TABLE `site_multilingual_label` DISABLE KEYS */;
INSERT INTO `site_multilingual_label` VALUES (1,1,'en','[yes]','Yes','2011-09-07 16:26:31',0,NULL),(2,1,'zh-Hans','[yes]','是','2011-09-07 16:26:31',0,NULL),(3,1,'en','[no]','No','2011-09-07 16:26:31',0,NULL),(4,1,'zh-Hans','[no]','否','2011-09-07 16:26:31',0,NULL),(5,1,'en','[save]','Save','2011-09-07 16:26:31',0,NULL),(6,1,'zh-Hans','[save]','‰øùÂ≠ò','2011-09-07 16:26:31',0,NULL),(7,1,'en','[submit]','Submit','2011-09-07 16:26:31',0,NULL),(8,1,'zh-Hans','[submit]','[zh-Hans]Submit','2011-09-07 16:26:31',1,NULL),(9,1,'en','[ok]','OK','2011-09-07 16:26:31',0,NULL),(10,1,'zh-Hans','[ok]','&#30830;&#23450;','2011-09-07 16:26:31',0,NULL),(11,1,'en','[cancel]','Cancel','2011-09-07 16:26:31',0,NULL),(12,1,'zh-Hans','[cancel]','ÂèñÊ∂à','2011-09-07 16:26:31',0,NULL),(13,1,'en','[close]','Close','2011-09-07 16:26:31',0,NULL),(14,1,'zh-Hans','[close]','[zh-Hans]Close','2011-09-07 16:26:31',1,NULL),(15,1,'en','[delete]','Delete','2011-09-07 16:26:31',0,NULL),(16,1,'zh-Hans','[delete]','&#21024;&#38500;','2011-09-07 16:26:31',0,NULL),(17,1,'en','[add]','Add','2011-09-07 16:26:31',0,NULL),(18,1,'zh-Hans','[add]','Ê∑ªÂä†','2011-09-07 16:26:31',0,NULL),(19,1,'en','[edit]','Edit','2011-09-07 16:26:31',0,NULL),(20,1,'zh-Hans','[edit]','&#32534;&#36753;','2011-09-07 16:26:31',0,NULL),(21,1,'en','[error]','Error','2011-09-07 16:26:31',0,NULL),(22,1,'zh-Hans','[error]','&#38169;&#35823;','2011-09-07 16:26:31',0,NULL),(23,1,'en','[translation]','Translation','2011-09-07 16:26:31',0,NULL),(24,1,'zh-Hans','[translation]','[zh-Hans]Translation','2011-09-07 16:26:31',1,NULL),(25,1,'en','[puxMissingLabels]','Missing Labels','2011-09-07 16:26:31',0,NULL),(26,1,'zh-Hans','[puxMissingLabels]','[zh-Hans]Missing Labels','2011-09-07 16:26:31',1,NULL),(27,1,'en','[puxMissingLanguage]','Missing Language','2011-09-07 16:26:31',0,NULL),(28,1,'zh-Hans','[puxMissingLanguage]','[zh-Hans]Missing Language','2011-09-07 16:26:31',1,NULL),(29,1,'en','[puxAllLabels]','All Labels','2011-09-07 16:26:31',0,NULL),(30,1,'zh-Hans','[puxAllLabels]','[zh-Hans]All Labels','2011-09-07 16:26:31',1,NULL),(31,1,'en','[puxOff]','Off','2011-09-07 16:26:31',0,NULL),(32,1,'zh-Hans','[puxOff]','[zh-Hans]Off','2011-09-07 16:26:31',1,NULL),(33,2,'en','[error_invalid_email]','Invalid e-mail address','2011-09-07 16:26:31',0,NULL),(34,2,'zh-Hans','[error_invalid_email]','[zh-Hans]Invalid e-mail address','2011-09-07 16:26:31',1,NULL),(35,2,'en','[error_invalid_date]','Invalid date','2011-09-07 16:26:31',0,NULL),(36,2,'zh-Hans','[error_invalid_date]','[zh-Hans]Invalid date','2011-09-07 16:26:31',1,NULL),(37,2,'en','[error_invalid_telephone]','Invalid telephone number format','2011-09-07 16:26:31',0,NULL),(38,2,'zh-Hans','[error_invalid_telephone]','[zh-Hans]Invalid telephone number format','2011-09-07 16:26:31',1,NULL),(39,2,'en','[error_latin_only]','This name field is restricted to latin characters a-z and A-Z','2011-09-07 16:26:31',0,NULL),(40,2,'zh-Hans','[error_latin_only]','[zh-Hans]This name field is restricted to latin characters a-z and A-Z','2011-09-07 16:26:31',1,NULL),(41,2,'en','[error_characters_only]','This name field is restricted to Chinese characters only','2011-09-07 16:26:31',0,NULL),(42,2,'zh-Hans','[error_characters_only]','[zh-Hans]This name field is restricted to Chinese characters only','2011-09-07 16:26:31',1,NULL),(43,2,'en','[error_unmanaged_field]','Unmanaged field','2011-09-07 16:26:31',0,NULL),(44,2,'zh-Hans','[error_unmanaged_field]','[zh-Hans]Unmanaged field','2011-09-07 16:26:31',1,NULL),(45,3,'en','[error_T]','Enter a Text Value','2011-09-07 16:26:31',0,NULL),(46,3,'zh-Hans','[error_T]','[zh-Hans]Enter a Text Value','2011-09-07 16:26:31',1,NULL),(47,3,'en','[error_N]','Enter a Numeric Value','2011-09-07 16:26:31',0,NULL),(48,3,'zh-Hans','[error_N]','[zh-Hans]Enter a Numeric Value','2011-09-07 16:26:31',1,NULL),(49,4,'en','[DeleteText]','Delete?','2011-09-07 16:26:31',0,NULL),(50,4,'zh-Hans','[DeleteText]','[zh-Hans]Delete?','2011-09-07 16:26:31',1,NULL),(51,5,'en','[backedUpCount]','Backed up [count] tables','2011-09-07 16:26:31',0,NULL),(52,5,'zh-Hans','[backedUpCount]','[zh-Hans]Backed up [count] tables','2011-09-07 16:26:31',1,NULL),(53,5,'en','[backedUpAll]','Backed up all tables','2011-09-07 16:26:31',0,NULL),(54,5,'zh-Hans','[backedUpAll]','[zh-Hans]Backed up all tables','2011-09-07 16:26:31',1,NULL),(55,5,'en','[errorOutput]','backup script gave following error:','2011-09-07 16:26:31',0,NULL),(56,5,'zh-Hans','[errorOutput]','[zh-Hans]backup script gave following error:','2011-09-07 16:26:31',1,NULL),(57,6,'en','[fileNotFound]','File [[fileName]] not found','2011-09-07 16:26:31',0,NULL),(58,6,'zh-Hans','[fileNotFound]','[zh-Hans]File [[fileName]] not found','2011-09-07 16:26:31',1,NULL),(59,6,'en','[errorUnlink]','Couldn\'t unlink file [[fileName]]','2011-09-07 16:26:31',0,NULL),(60,6,'zh-Hans','[errorUnlink]','[zh-Hans]Couldn\'t unlink file [[fileName]]','2011-09-07 16:26:31',1,NULL),(61,6,'en','[errorOutput]','backup script gave following error:','2011-09-07 16:26:31',0,NULL),(62,6,'zh-Hans','[errorOutput]','[zh-Hans]backup script gave following error:','2011-09-07 16:26:31',1,NULL),(63,7,'en','[success]','Backup[[fileName]] was successfully restored. Good Luck!','2011-09-07 16:26:31',0,NULL),(64,7,'zh-Hans','[success]','[zh-Hans]Backup[[fileName]] was successfully restored. Good Luck!','2011-09-07 16:26:31',1,NULL),(65,7,'en','[errorOutput]','restore script gave following error:','2011-09-07 16:26:31',0,NULL),(66,7,'zh-Hans','[errorOutput]','[zh-Hans]restore script gave following error:','2011-09-07 16:26:31',1,NULL),(67,8,'en','[puxEditLabel]','Edit Label:','2011-09-07 16:26:31',0,NULL),(68,8,'zh-Hans','[puxEditLabel]','[zh-Hans]Edit Label:','2011-09-07 16:26:31',1,NULL),(69,9,'en','[formLabel_userID]','Username','2011-09-07 16:26:31',0,NULL),(70,9,'zh-Hans','[formLabel_userID]','[zh-Hans]Username','2011-09-07 16:26:31',1,NULL),(71,9,'en','[formLabel_pWord]','Password','2011-09-07 16:26:31',0,NULL),(72,9,'zh-Hans','[formLabel_pWord]','[zh-Hans]Password','2011-09-07 16:26:31',1,NULL),(73,9,'en','[titleDatabaseBackups]','Database Backups','2011-09-07 16:26:31',0,NULL),(74,9,'zh-Hans','[titleDatabaseBackups]','[zh-Hans]Database Backups','2011-09-07 16:26:31',1,NULL),(75,9,'en','[labelNewBackups]','New Backups','2011-09-07 16:26:31',0,NULL),(76,9,'zh-Hans','[labelNewBackups]','[zh-Hans]New Backups','2011-09-07 16:26:31',1,NULL),(77,9,'en','[labelAllData]','all data','2011-09-07 16:26:31',0,NULL),(78,9,'zh-Hans','[labelAllData]','[zh-Hans]all data','2011-09-07 16:26:31',1,NULL),(79,9,'en','[labelByModule]','by module','2011-09-07 16:26:31',0,NULL),(80,9,'zh-Hans','[labelByModule]','[zh-Hans]by module','2011-09-07 16:26:31',1,NULL),(81,9,'en','[labelSelectOption]','Select a backup option. ','2011-09-07 16:26:31',0,NULL),(82,9,'zh-Hans','[labelSelectOption]','[zh-Hans]Select a backup option. ','2011-09-07 16:26:31',1,NULL),(83,9,'en','[labelNameOfFile]','Name of File','2011-09-07 16:26:31',0,NULL),(84,9,'zh-Hans','[labelNameOfFile]','[zh-Hans]Name of File','2011-09-07 16:26:31',1,NULL),(85,9,'en','[labelNameOfFileInstr]','Enter the name of the file to save this backup as.','2011-09-07 16:26:31',0,NULL),(86,9,'zh-Hans','[labelNameOfFileInstr]','[zh-Hans]Enter the name of the file to save this backup as.','2011-09-07 16:26:31',1,NULL),(87,9,'en','[labelFilter]','Filter','2011-09-07 16:26:31',0,NULL),(88,9,'zh-Hans','[labelFilter]','[zh-Hans]Filter','2011-09-07 16:26:31',1,NULL),(89,9,'en','[labelFilterInstr]','A comma seperated list of names that must exist in the <br />DB.Table name in order to include in the backup.<br />eg. for labels use: \"data, trans, label\"','2011-09-07 16:26:31',0,NULL),(90,9,'zh-Hans','[labelFilterInstr]','[zh-Hans]A comma seperated list of names that must exist in the <br />DB.Table name in order to include in the backup.<br />eg. for labels use: \"data, trans, label\"','2011-09-07 16:26:31',1,NULL),(91,9,'en','[labelBackup]','backup','2011-09-07 16:26:31',0,NULL),(92,9,'zh-Hans','[labelBackup]','[zh-Hans]backup','2011-09-07 16:26:31',1,NULL),(93,9,'en','[labelExistingBackups]','Existing Backups','2011-09-07 16:26:31',0,NULL),(94,9,'zh-Hans','[labelExistingBackups]','[zh-Hans]Existing Backups','2011-09-07 16:26:31',1,NULL),(95,9,'en','[labelOnFile]','On File:','2011-09-07 16:26:31',0,NULL),(96,9,'zh-Hans','[labelOnFile]','[zh-Hans]On File:','2011-09-07 16:26:31',1,NULL),(97,9,'en','[labelErrorResponse]','Error Response from server: ','2011-09-07 16:26:31',0,NULL),(98,9,'zh-Hans','[labelErrorResponse]','[zh-Hans]Error Response from server: ','2011-09-07 16:26:31',1,NULL),(99,9,'en','[statusBackingUpAll]','Backing up all tables.','2011-09-07 16:26:31',0,NULL),(100,9,'zh-Hans','[statusBackingUpAll]','[zh-Hans]Backing up all tables.','2011-09-07 16:26:31',1,NULL),(101,9,'en','[statusRestoringBackup]','Restoring Backup ...','2011-09-07 16:26:31',0,NULL),(102,9,'zh-Hans','[statusRestoringBackup]','[zh-Hans]Restoring Backup ...','2011-09-07 16:26:31',1,NULL),(103,9,'en','[labelSureToRestore]','Are you sure you want to restore this backup?  You will loose all data entered in the backedup tables since the backup was made.','2011-09-07 16:26:31',0,NULL),(104,9,'zh-Hans','[labelSureToRestore]','[zh-Hans]Are you sure you want to restore this backup?  You will loose all data entered in the backedup tables since the backup was made.','2011-09-07 16:26:31',1,NULL),(105,9,'en','[labelYes]','Yes','2011-09-07 16:26:31',0,NULL),(106,9,'zh-Hans','[labelYes]','[zh-Hans]Yes','2011-09-07 16:26:31',1,NULL),(107,9,'en','[labelNo]','No','2011-09-07 16:26:31',0,NULL),(108,9,'zh-Hans','[labelNo]','[zh-Hans]No','2011-09-07 16:26:31',1,NULL),(109,9,'en','[labelOptional]','Optional','2011-09-07 16:26:31',0,NULL),(110,9,'zh-Hans','[labelOptional]','[zh-Hans]Optional','2011-09-07 16:26:31',1,NULL),(111,9,'en','[labelRemovingBackup]','Removing Backup ...','2011-09-07 16:26:31',0,NULL),(112,9,'zh-Hans','[labelRemovingBackup]','[zh-Hans]Removing Backup ...','2011-09-07 16:26:31',1,NULL),(113,9,'en','[labelSureToDelete]','Are you sure you want to delete this backup?  You can not get it back once you do.','2011-09-07 16:26:31',0,NULL),(114,9,'zh-Hans','[labelSureToDelete]','[zh-Hans]Are you sure you want to delete this backup?  You can not get it back once you do.','2011-09-07 16:26:31',1,NULL),(115,9,'en','[labelRestore]','restore','2011-09-07 16:26:31',0,NULL),(116,9,'zh-Hans','[labelRestore]','[zh-Hans]restore','2011-09-07 16:26:31',1,NULL),(117,9,'en','[labelDelete]','del','2011-09-07 16:26:31',0,NULL),(118,9,'zh-Hans','[labelDelete]','[zh-Hans]del','2011-09-07 16:26:31',1,NULL),(119,9,'en','[labelConfirm]','confirm','2011-09-07 16:26:31',0,NULL),(120,9,'zh-Hans','[labelConfirm]','[zh-Hans]confirm','2011-09-07 16:26:31',1,NULL),(121,9,'en','[labelRequired]','required','2011-09-07 16:26:31',0,NULL),(122,9,'zh-Hans','[labelRequired]','[zh-Hans]required','2011-09-07 16:26:31',1,NULL),(123,10,'en','[formLabel_userID]','Username','2011-09-07 16:26:31',0,'/page/site/login'),(124,10,'zh-Hans','[formLabel_userID]','&#29992;&#25143;&#21517;','2011-09-07 16:26:31',0,'/page/site/login'),(125,10,'en','[formLabel_pWord]','Password','2011-09-07 16:26:31',0,'/page/site/login'),(126,10,'zh-Hans','[formLabel_pWord]','&#23494;&#30721;','2011-09-07 16:26:31',0,'/page/site/login'),(127,10,'en','[login]','Login','2011-09-07 16:26:31',0,'/page/site/login'),(128,10,'zh-Hans','[login]','&#30331;&#24405;','2011-09-07 16:26:31',0,'/page/site/login'),(129,10,'en','[submit]','Submit','2011-09-07 16:26:31',0,'/page/site/login'),(130,10,'zh-Hans','[submit]','&#25552;&#20132;','2011-09-07 16:26:31',0,'/page/site/login'),(131,3,'en','[ok]','OK','2011-09-07 16:26:31',0,NULL),(132,3,'zh-Hans','[ok]','[zh-Hans]OK','2011-09-07 16:26:31',1,NULL),(133,11,'en','[error_one_primary_account_max]','Cannot have more than 1 primary account.','2011-09-07 16:26:52',0,NULL),(134,11,'zh-Hans','[error_one_primary_account_max]','[zh-Hans]Cannot have more than 1 primary account.','2011-09-07 16:26:52',1,NULL),(135,12,'en','[error_one_primary_account_max]','Cannot have more than 1 primary account.','2011-09-07 16:26:52',0,NULL),(136,12,'zh-Hans','[error_one_primary_account_max]','[zh-Hans]Cannot have more than 1 primary account.','2011-09-07 16:26:52',1,NULL),(137,13,'en','[InvalidRen]','Invalid ren id','2011-09-07 16:26:52',0,NULL),(138,13,'zh-Hans','[InvalidRen]','[zh-Hans]Invalid ren id','2011-09-07 16:26:52',1,NULL),(139,13,'en','[RenNotFound]','Ren not found','2011-09-07 16:26:52',0,NULL),(140,13,'zh-Hans','[RenNotFound]','[zh-Hans]Ren not found','2011-09-07 16:26:52',1,NULL),(141,14,'en','[InvalidRen]','Invalid ren id','2011-09-07 16:26:52',0,NULL),(142,14,'zh-Hans','[InvalidRen]','[zh-Hans]Invalid ren id','2011-09-07 16:26:52',1,NULL),(143,14,'en','[RenNotFound]','Ren not found','2011-09-07 16:26:52',0,NULL),(144,14,'zh-Hans','[RenNotFound]','[zh-Hans]Ren not found','2011-09-07 16:26:52',1,NULL),(145,15,'en','[InvalidRen]','Invalid ren id','2011-09-07 16:26:52',0,NULL),(146,15,'zh-Hans','[InvalidRen]','[zh-Hans]Invalid ren id','2011-09-07 16:26:52',1,NULL),(147,15,'en','[RenNotFound]','Ren not found','2011-09-07 16:26:52',0,NULL),(148,15,'zh-Hans','[RenNotFound]','[zh-Hans]Ren not found','2011-09-07 16:26:52',1,NULL),(149,16,'en','[download]','Download','2011-09-07 16:26:52',0,NULL),(150,16,'zh-Hans','[download]','[zh-Hans]Download','2011-09-07 16:26:52',1,NULL),(151,17,'en','[ErrorFindFile]','Couldn\'t find file[[fileName]]','2011-09-07 16:26:52',0,NULL),(152,17,'zh-Hans','[ErrorFindFile]','[zh-Hans]Couldn\'t find file[[fileName]]','2011-09-07 16:26:52',1,NULL),(153,17,'en','[ErrorNoRowManager]','Error: No RowManager specified.','2011-09-07 16:26:52',0,NULL),(154,17,'zh-Hans','[ErrorNoRowManager]','[zh-Hans]Error: No RowManager specified.','2011-09-07 16:26:52',1,NULL),(155,17,'en','[ErrorNoPrimaryKey]','Error: No PrimaryKey specified.','2011-09-07 16:26:52',0,NULL),(156,17,'zh-Hans','[ErrorNoPrimaryKey]','[zh-Hans]Error: No PrimaryKey specified.','2011-09-07 16:26:52',1,NULL),(157,17,'en','[ErrorNoPermission]','Error: Permissions don\'t allow this operation.','2011-09-07 16:26:52',0,NULL),(158,17,'zh-Hans','[ErrorNoPermission]','[zh-Hans]Error: Permissions don\'t allow this operation.','2011-09-07 16:26:52',1,NULL),(159,18,'en','[error_foreign_key_dependency]','This definition cannot be deleted now because there is at least one record referencing it.','2011-09-07 16:26:52',0,NULL),(160,18,'zh-Hans','[error_foreign_key_dependency]','[zh-Hans]This definition cannot be deleted now because there is at least one record referencing it.','2011-09-07 16:26:52',1,NULL),(161,18,'en','[error_required_by_system]','This definition cannot be deleted because it is required by the system.','2011-09-07 16:26:52',0,NULL),(162,18,'zh-Hans','[error_required_by_system]','[zh-Hans]This definition cannot be deleted because it is required by the system.','2011-09-07 16:26:52',1,NULL),(163,19,'en','[ErrorInvalidRowManager]','[RowManager] missing definition for [function]','2011-09-07 16:26:52',0,NULL),(164,19,'zh-Hans','[ErrorInvalidRowManager]','[zh-Hans][RowManager] missing definition for [function]','2011-09-07 16:26:52',1,NULL),(165,20,'en','[copy]','(copy)','2011-09-07 16:26:52',0,NULL),(166,20,'zh-Hans','[copy]','[zh-Hans](copy)','2011-09-07 16:26:52',1,NULL),(167,22,'en','[error_no_such_report]','Error: No such report exists.','2011-09-07 16:26:52',0,NULL),(168,22,'zh-Hans','[error_no_such_report]','[zh-Hans]Error: No such report exists.','2011-09-07 16:26:52',1,NULL),(169,22,'en','[error_not_owner]','Error: This report belongs to another user.','2011-09-07 16:26:52',0,NULL),(170,22,'zh-Hans','[error_not_owner]','[zh-Hans]Error: This report belongs to another user.','2011-09-07 16:26:52',1,NULL),(171,23,'en','[no_fields_found]','Use the edit button to define what fields will be in this report.','2011-09-07 16:26:52',0,NULL),(172,23,'zh-Hans','[no_fields_found]','[zh-Hans]Use the edit button to define what fields will be in this report.','2011-09-07 16:26:52',1,NULL),(173,23,'en','[invalid_report]','Error: No such report exists.','2011-09-07 16:26:52',0,NULL),(174,23,'zh-Hans','[invalid_report]','[zh-Hans]Error: No such report exists.','2011-09-07 16:26:52',1,NULL),(175,23,'en','[report_not_shared]','Error: You do not have access to this report.','2011-09-07 16:26:52',0,NULL),(176,23,'zh-Hans','[report_not_shared]','[zh-Hans]Error: You do not have access to this report.','2011-09-07 16:26:52',1,NULL),(177,23,'en','[Excel_download]','Excel Download','2011-09-07 16:26:52',0,NULL),(178,23,'zh-Hans','[Excel_download]','[zh-Hans]Excel Download','2011-09-07 16:26:52',1,NULL),(179,23,'en','[count]','(count: [num])','2011-09-07 16:26:52',0,NULL),(180,23,'zh-Hans','[count]','[zh-Hans](count: [num])','2011-09-07 16:26:52',1,NULL),(181,30,'en','[invalid_ruleset]','Error: No such ruleset exists.','2011-09-07 16:26:52',0,NULL),(182,30,'zh-Hans','[invalid_ruleset]','[zh-Hans]Error: No such ruleset exists.','2011-09-07 16:26:52',1,NULL),(183,30,'en','[invalid_field]','Error: No such field exists.','2011-09-07 16:26:52',0,NULL),(184,30,'zh-Hans','[invalid_field]','[zh-Hans]Error: No such field exists.','2011-09-07 16:26:52',1,NULL),(185,30,'en','[invalid_condition]','Error: Invalid condition.','2011-09-07 16:26:52',0,NULL),(186,30,'zh-Hans','[invalid_condition]','[zh-Hans]Error: Invalid condition.','2011-09-07 16:26:52',1,NULL),(187,30,'en','[invalid_value]','Error: Invalid condition.','2011-09-07 16:26:52',0,NULL),(188,30,'zh-Hans','[invalid_value]','[zh-Hans]Error: Invalid condition.','2011-09-07 16:26:52',1,NULL),(189,30,'en','[error_adding_rule]','Error: There was an unexpected problem while adding the rule.','2011-09-07 16:26:52',0,NULL),(190,30,'zh-Hans','[error_adding_rule]','[zh-Hans]Error: There was an unexpected problem while adding the rule.','2011-09-07 16:26:52',1,NULL),(191,31,'en','[no_such_filter]','Error: No such filter.','2011-09-07 16:26:52',0,NULL),(192,31,'zh-Hans','[no_such_filter]','[zh-Hans]Error: No such filter.','2011-09-07 16:26:52',1,NULL),(193,32,'en','[invalid_rule]','Warning: No such rule exists.','2011-09-07 16:26:52',0,NULL),(194,32,'zh-Hans','[invalid_rule]','[zh-Hans]Warning: No such rule exists.','2011-09-07 16:26:52',1,NULL),(195,32,'en','[error_deleting_rule]','Error: There was an unexpected problem while deleting the rule\".','2011-09-07 16:26:52',0,NULL),(196,32,'zh-Hans','[error_deleting_rule]','[zh-Hans]Error: There was an unexpected problem while deleting the rule\".','2011-09-07 16:26:52',1,NULL),(197,33,'en','[invalid_matches_type]','Error: Invalid \"Matches\".','2011-09-07 16:26:52',0,NULL),(198,33,'zh-Hans','[invalid_matches_type]','[zh-Hans]Error: Invalid \"Matches\".','2011-09-07 16:26:52',1,NULL),(199,33,'en','[invalid_ruleset]','Error: Invalid ruleset.','2011-09-07 16:26:52',0,NULL),(200,33,'zh-Hans','[invalid_ruleset]','[zh-Hans]Error: Invalid ruleset.','2011-09-07 16:26:52',1,NULL),(201,33,'en','[error_updating_ruleset]','Error: There was an unexpected problem while updating the ruleset\".','2011-09-07 16:26:52',0,NULL),(202,33,'zh-Hans','[error_updating_ruleset]','[zh-Hans]Error: There was an unexpected problem while updating the ruleset\".','2011-09-07 16:26:52',1,NULL),(203,34,'en','[error_loading_filter]','Error: Could not load filter.','2011-09-07 16:26:52',0,NULL),(204,34,'zh-Hans','[error_loading_filter]','[zh-Hans]Error: Could not load filter.','2011-09-07 16:26:52',1,NULL),(205,34,'en','[error_parsing_condition]','Error: Could not parse the condition.','2011-09-07 16:26:52',0,NULL),(206,34,'zh-Hans','[error_parsing_condition]','[zh-Hans]Error: Could not parse the condition.','2011-09-07 16:26:52',1,NULL),(207,35,'en','[ruleset_not_found]','Error: The ruleset could not be found.','2011-09-07 16:26:52',0,NULL),(208,35,'zh-Hans','[ruleset_not_found]','[zh-Hans]Error: The ruleset could not be found.','2011-09-07 16:26:52',1,NULL),(209,36,'en','[error_saving_filter]','Error: Could not save filter.','2011-09-07 16:26:52',0,NULL),(210,36,'zh-Hans','[error_saving_filter]','[zh-Hans]Error: Could not save filter.','2011-09-07 16:26:52',1,NULL),(211,36,'en','[error_parsing_condition]','Error: Could not parse the condition.','2011-09-07 16:26:52',0,NULL),(212,36,'zh-Hans','[error_parsing_condition]','[zh-Hans]Error: Could not parse the condition.','2011-09-07 16:26:52',1,NULL),(213,37,'en','[error_saving_filter]','Error: Could not save filter.','2011-09-07 16:26:52',0,NULL),(214,37,'zh-Hans','[error_saving_filter]','[zh-Hans]Error: Could not save filter.','2011-09-07 16:26:52',1,NULL),(215,38,'en','[ErrorFindFile]','Couldn\'t find file[[fileName]]','2011-09-07 16:26:52',0,NULL),(216,38,'zh-Hans','[ErrorFindFile]','[zh-Hans]Couldn\'t find file[[fileName]]','2011-09-07 16:26:52',1,NULL),(217,38,'en','[ErrorNoRowManager]','Error: No RowManager specified.','2011-09-07 16:26:52',0,NULL),(218,38,'zh-Hans','[ErrorNoRowManager]','[zh-Hans]Error: No RowManager specified.','2011-09-07 16:26:52',1,NULL),(219,39,'en','[InvalidUserId]','Invalid user id','2011-09-07 16:26:52',0,NULL),(220,39,'zh-Hans','[InvalidUserId]','[zh-Hans]Invalid user id','2011-09-07 16:26:52',1,NULL),(221,39,'en','[DuplicateUserId]','User id already exists','2011-09-07 16:26:52',0,NULL),(222,39,'zh-Hans','[DuplicateUserId]','[zh-Hans]User id already exists','2011-09-07 16:26:52',1,NULL),(223,39,'en','[InvalidPassword]','Invalid password or confirmation','2011-09-07 16:26:52',0,NULL),(224,39,'zh-Hans','[InvalidPassword]','[zh-Hans]Invalid password or confirmation','2011-09-07 16:26:52',1,NULL),(225,39,'en','[InvalidLanguageKey]','Invalid language preference','2011-09-07 16:26:52',0,NULL),(226,39,'zh-Hans','[InvalidLanguageKey]','[zh-Hans]Invalid language preference','2011-09-07 16:26:52',1,NULL),(227,39,'en','[ConfirmationFailed]','Password and confirmation do not match','2011-09-07 16:26:52',0,NULL),(228,39,'zh-Hans','[ConfirmationFailed]','[zh-Hans]Password and confirmation do not match','2011-09-07 16:26:52',1,NULL),(229,40,'en','[error_not_a_worker]','This person is not a worker and should not have a worker record.','2011-09-07 16:26:52',0,NULL),(230,40,'zh-Hans','[error_not_a_worker]','[zh-Hans]This person is not a worker and should not have a worker record.','2011-09-07 16:26:52',1,NULL),(231,40,'en','[error_worker_record_exists]','This person already has a worker record.','2011-09-07 16:26:52',0,NULL),(232,40,'zh-Hans','[error_worker_record_exists]','[zh-Hans]This person already has a worker record.','2011-09-07 16:26:52',1,NULL),(233,41,'en','[ErrorDuplicateName]','Duplicate Name. Names need to be unique.','2011-09-07 16:26:52',0,NULL),(234,41,'zh-Hans','[ErrorDuplicateName]','[zh-Hans]Duplicate Name. Names need to be unique.','2011-09-07 16:26:52',1,NULL),(235,42,'en','[noAccessID]','No Access ID [access_id] found','2011-09-07 16:26:52',0,NULL),(236,42,'zh-Hans','[noAccessID]','[zh-Hans]No Access ID [access_id] found','2011-09-07 16:26:52',1,NULL),(237,43,'en','[noRenID]','No Ren ID provided.','2011-09-07 16:26:52',0,NULL),(238,43,'zh-Hans','[noRenID]','[zh-Hans]No Ren ID provided.','2011-09-07 16:26:52',1,NULL),(239,43,'en','[errorNoAccessID]','No accessID[[access_id]] for ren[[ren_id]]. Perhaps they don\'t have access to the WebSite?','2011-09-07 16:26:52',0,NULL),(240,43,'zh-Hans','[errorNoAccessID]','[zh-Hans]No accessID[[access_id]] for ren[[ren_id]]. Perhaps they don\'t have access to the WebSite?','2011-09-07 16:26:52',1,NULL),(241,44,'en','[role_filter_assignment]','Role & Scope Assignment','2011-09-07 16:26:52',0,NULL),(242,44,'zh-Hans','[role_filter_assignment]','[zh-Hans]Role & Scope Assignment','2011-09-07 16:26:52',1,NULL),(243,44,'en','[add_role_filter_title]','Add a new role & scope assignment','2011-09-07 16:26:52',0,NULL),(244,44,'zh-Hans','[add_role_filter_title]','[zh-Hans]Add a new role & scope assignment','2011-09-07 16:26:52',1,NULL),(245,44,'en','[add_role_filter_instructions]','Select the <b>role</b> that you want to assign to this person, and the <b>scope</b> for which this role will apply. Click the Save button when you are done.','2011-09-07 16:26:52',0,NULL),(246,44,'zh-Hans','[add_role_filter_instructions]','[zh-Hans]Select the <b>role</b> that you want to assign to this person, and the <b>scope</b> for which this role will apply. Click the Save button when you are done.','2011-09-07 16:26:52',1,NULL),(247,44,'en','[title_role_id]','Available Roles','2011-09-07 16:26:52',0,NULL),(248,44,'zh-Hans','[title_role_id]','[zh-Hans]Available Roles','2011-09-07 16:26:52',1,NULL),(249,44,'en','[title_filter_id]','Available Scopes','2011-09-07 16:26:52',0,NULL),(250,44,'zh-Hans','[title_filter_id]','[zh-Hans]Available Scopes','2011-09-07 16:26:52',1,NULL),(251,45,'en','[tooltipToolAdminAssignment]','Admin Assignment','2011-09-07 16:26:52',0,NULL),(252,45,'zh-Hans','[tooltipToolAdminAssignment]','[zh-Hans]Admin Assignment','2011-09-07 16:26:52',1,NULL),(253,45,'en','[PanelTitle]','Role & Filter Assignment','2011-09-07 16:26:52',0,NULL),(254,45,'zh-Hans','[PanelTitle]','[zh-Hans]Role & Filter Assignment','2011-09-07 16:26:52',1,NULL),(255,45,'en','[SelectRole]','Select Role','2011-09-07 16:26:52',0,NULL),(256,45,'zh-Hans','[SelectRole]','[zh-Hans]Select Role','2011-09-07 16:26:52',1,NULL),(257,45,'en','[SelectFilter]','Select Filter','2011-09-07 16:26:52',0,NULL),(258,45,'zh-Hans','[SelectFilter]','[zh-Hans]Select Filter','2011-09-07 16:26:52',1,NULL),(259,45,'en','[AssignmentList]','Assignments List','2011-09-07 16:26:52',0,NULL),(260,45,'zh-Hans','[AssignmentList]','[zh-Hans]Assignments List','2011-09-07 16:26:52',1,NULL),(261,46,'en','[EditFilter]','Edit Filter','2011-09-07 16:26:52',0,NULL),(262,46,'zh-Hans','[EditFilter]','[zh-Hans]Edit Filter','2011-09-07 16:26:52',1,NULL),(263,46,'en','[ScopeName]','Name','2011-09-07 16:26:52',0,NULL),(264,46,'zh-Hans','[ScopeName]','[zh-Hans]Name','2011-09-07 16:26:52',1,NULL),(265,47,'en','[Scope_Filters]','Scope Filters','2011-09-07 16:26:52',0,NULL),(266,47,'zh-Hans','[Scope_Filters]','[zh-Hans]Scope Filters','2011-09-07 16:26:52',1,NULL),(267,48,'en','[tooltipToolAdminFilter]','Admin Filter','2011-09-07 16:26:52',0,NULL),(268,48,'zh-Hans','[tooltipToolAdminFilter]','[zh-Hans]Admin Filter','2011-09-07 16:26:52',1,NULL),(269,49,'en','[actions]','Actions','2011-09-07 16:26:52',0,NULL),(270,49,'zh-Hans','[actions]','[zh-Hans]Actions','2011-09-07 16:26:52',1,NULL),(271,49,'en','[fields]','Data Fields','2011-09-07 16:26:52',0,NULL),(272,49,'zh-Hans','[fields]','[zh-Hans]Data Fields','2011-09-07 16:26:52',1,NULL),(273,49,'en','[TableList]','Table List','2011-09-07 16:26:52',0,NULL),(274,49,'zh-Hans','[TableList]','[zh-Hans]Table List','2011-09-07 16:26:52',1,NULL),(275,49,'en','[title_dbfield_name]','Data Field Name','2011-09-07 16:26:52',0,NULL),(276,49,'zh-Hans','[title_dbfield_name]','[zh-Hans]Data Field Name','2011-09-07 16:26:52',1,NULL),(277,49,'en','[title_optiontype_label]','Permission','2011-09-07 16:26:52',0,NULL),(278,49,'zh-Hans','[title_optiontype_label]','[zh-Hans]Permission','2011-09-07 16:26:52',1,NULL),(279,49,'en','[role_name]','Role Name','2011-09-07 16:26:52',0,NULL),(280,49,'zh-Hans','[role_name]','[zh-Hans]Role Name','2011-09-07 16:26:52',1,NULL),(281,49,'en','[available_actions]','Available actions','2011-09-07 16:26:52',0,NULL),(282,49,'zh-Hans','[available_actions]','[zh-Hans]Available actions','2011-09-07 16:26:52',1,NULL),(283,49,'en','[allowed_for_role]','Actions allowed for this role','2011-09-07 16:26:52',0,NULL),(284,49,'zh-Hans','[allowed_for_role]','[zh-Hans]Actions allowed for this role','2011-09-07 16:26:52',1,NULL),(285,50,'en','[tooltipToolAdminRole]','Admin Role','2011-09-07 16:26:52',0,NULL),(286,50,'zh-Hans','[tooltipToolAdminRole]','[zh-Hans]Admin Role','2011-09-07 16:26:52',1,NULL),(287,50,'en','[Save]','Save','2011-09-07 16:26:52',0,NULL),(288,50,'zh-Hans','[Save]','[zh-Hans]Save','2011-09-07 16:26:52',1,NULL),(289,50,'en','[Roles]','Roles','2011-09-07 16:26:52',0,NULL),(290,50,'zh-Hans','[Roles]','[zh-Hans]Roles','2011-09-07 16:26:52',1,NULL),(291,50,'en','[RoleName]','Role Name','2011-09-07 16:26:52',0,NULL),(292,50,'zh-Hans','[RoleName]','[zh-Hans]Role Name','2011-09-07 16:26:52',1,NULL),(293,50,'en','[Name]','Name','2011-09-07 16:26:52',0,NULL),(294,50,'zh-Hans','[Name]','[zh-Hans]Name','2011-09-07 16:26:52',1,NULL),(295,50,'en','[Adding]','Adding','2011-09-07 16:26:52',0,NULL),(296,50,'zh-Hans','[Adding]','[zh-Hans]Adding','2011-09-07 16:26:52',1,NULL),(297,50,'en','[Removing]','Removing','2011-09-07 16:26:52',0,NULL),(298,50,'zh-Hans','[Removing]','[zh-Hans]Removing','2011-09-07 16:26:52',1,NULL),(299,50,'en','[Delete?]','Delete?','2011-09-07 16:26:52',0,NULL),(300,50,'zh-Hans','[Delete?]','[zh-Hans]Delete?','2011-09-07 16:26:52',1,NULL),(301,50,'en','[DeleteText]','Are you sure you want to delete the selected Role(s)?','2011-09-07 16:26:52',0,NULL),(302,50,'zh-Hans','[DeleteText]','[zh-Hans]Are you sure you want to delete the selected Role(s)?','2011-09-07 16:26:52',1,NULL),(303,50,'en','[EditRole]','Loading ...','2011-09-07 16:26:52',0,NULL),(304,50,'zh-Hans','[EditRole]','[zh-Hans]Loading ...','2011-09-07 16:26:52',1,NULL),(305,50,'en','[WaitMessage]','Loading ...','2011-09-07 16:26:52',0,NULL),(306,50,'zh-Hans','[WaitMessage]','[zh-Hans]Loading ...','2011-09-07 16:26:52',1,NULL),(307,50,'en','[colHdrFieldName]','Field Name','2011-09-07 16:26:52',0,NULL),(308,50,'zh-Hans','[colHdrFieldName]','[zh-Hans]Field Name','2011-09-07 16:26:52',1,NULL),(309,50,'en','[colHdrOptionType]','Option Type','2011-09-07 16:26:52',0,NULL),(310,50,'zh-Hans','[colHdrOptionType]','[zh-Hans]Option Type','2011-09-07 16:26:52',1,NULL),(311,50,'en','[tabFieldPerm]','Field Permissions','2011-09-07 16:26:52',0,NULL),(312,50,'zh-Hans','[tabFieldPerm]','[zh-Hans]Field Permissions','2011-09-07 16:26:52',1,NULL),(313,50,'en','[buttonUpdateFieldOption]','Update Selected Fields','2011-09-07 16:26:52',0,NULL),(314,50,'zh-Hans','[buttonUpdateFieldOption]','[zh-Hans]Update Selected Fields','2011-09-07 16:26:52',1,NULL),(315,50,'en','[comboSelectOption]','Select an option...','2011-09-07 16:26:52',0,NULL),(316,50,'zh-Hans','[comboSelectOption]','[zh-Hans]Select an option...','2011-09-07 16:26:52',1,NULL),(317,50,'en','[listFieldPermTablesTitle]','Table List','2011-09-07 16:26:52',0,NULL),(318,50,'zh-Hans','[listFieldPermTablesTitle]','[zh-Hans]Table List','2011-09-07 16:26:52',1,NULL),(319,51,'en','[tooltipToolFieldUserMarryStaff]','Staff Marriage','2011-09-07 16:26:52',0,NULL),(320,51,'zh-Hans','[tooltipToolFieldUserMarryStaff]','[zh-Hans]Staff Marriage','2011-09-07 16:26:52',1,NULL),(321,52,'en','[tooltipToolFieldUserSummary]','User Summary','2011-09-07 16:26:52',0,NULL),(322,52,'zh-Hans','[tooltipToolFieldUserSummary]','[zh-Hans]User Summary','2011-09-07 16:26:52',1,NULL),(323,53,'en','[ToolTipFU]','User Portal','2011-09-07 16:26:52',0,NULL),(324,53,'zh-Hans','[ToolTipFU]','[zh-Hans]User Portal','2011-09-07 16:26:52',1,NULL),(325,53,'en','[ToolTipAO]','User Management Portal','2011-09-07 16:26:52',0,NULL),(326,53,'zh-Hans','[ToolTipAO]','[zh-Hans]User Management Portal','2011-09-07 16:26:52',1,NULL),(327,53,'en','[ToolTipAC]','Content Management Portal','2011-09-07 16:26:52',0,NULL),(328,53,'zh-Hans','[ToolTipAC]','[zh-Hans]Content Management Portal','2011-09-07 16:26:52',1,NULL),(329,53,'en','[ToolTipAA]','Administrator Portal','2011-09-07 16:26:52',0,NULL),(330,53,'zh-Hans','[ToolTipAA]','[zh-Hans]Administrator Portal','2011-09-07 16:26:52',1,NULL),(331,54,'en','[panelTitle]','Definition Tables','2011-09-07 16:26:52',0,NULL),(332,54,'zh-Hans','[panelTitle]','[zh-Hans]Definition Tables','2011-09-07 16:26:52',1,NULL),(333,54,'en','[rowEditorButtonUpdate]','Update','2011-09-07 16:26:52',0,NULL),(334,54,'zh-Hans','[rowEditorButtonUpdate]','[zh-Hans]Update','2011-09-07 16:26:52',1,NULL),(335,54,'en','[rowEditorButtonCancel]','Cancel','2011-09-07 16:26:52',0,NULL),(336,54,'zh-Hans','[rowEditorButtonCancel]','[zh-Hans]Cancel','2011-09-07 16:26:52',1,NULL),(337,54,'en','[buttonAddRow]','Add','2011-09-07 16:26:52',0,NULL),(338,54,'zh-Hans','[buttonAddRow]','[zh-Hans]Add','2011-09-07 16:26:52',1,NULL),(339,54,'en','[buttonRemoveRow]','Remove','2011-09-07 16:26:52',0,NULL),(340,54,'zh-Hans','[buttonRemoveRow]','[zh-Hans]Remove','2011-09-07 16:26:52',1,NULL),(341,54,'en','[defaultNewLabel]','New Label','2011-09-07 16:26:52',0,NULL),(342,54,'zh-Hans','[defaultNewLabel]','[zh-Hans]New Label','2011-09-07 16:26:52',1,NULL),(343,55,'en','[DefFieldsGridTitle]','Select a Definition Table from the list at left.','2011-09-07 16:26:52',0,NULL),(344,55,'zh-Hans','[DefFieldsGridTitle]','[zh-Hans]Select a Definition Table from the list at left.','2011-09-07 16:26:52',1,NULL),(345,55,'en','[DefFieldsToolTip]','Double-click a value or description to edit.','2011-09-07 16:26:52',0,NULL),(346,55,'zh-Hans','[DefFieldsToolTip]','[zh-Hans]Double-click a value or description to edit.','2011-09-07 16:26:52',1,NULL),(347,55,'en','[Name]','Name','2011-09-07 16:26:52',0,NULL),(348,55,'zh-Hans','[Name]','[zh-Hans]Name','2011-09-07 16:26:52',1,NULL),(349,55,'en','[Adding]','Adding','2011-09-07 16:26:52',0,NULL),(350,55,'zh-Hans','[Adding]','[zh-Hans]Adding','2011-09-07 16:26:52',1,NULL),(351,55,'en','[Removing]','Removing','2011-09-07 16:26:52',0,NULL),(352,55,'zh-Hans','[Removing]','[zh-Hans]Removing','2011-09-07 16:26:52',1,NULL),(353,55,'en','[Delete?]','Delete?','2011-09-07 16:26:52',0,NULL),(354,55,'zh-Hans','[Delete?]','[zh-Hans]Delete?','2011-09-07 16:26:52',1,NULL),(355,55,'en','[delete]','Delete!','2011-09-07 16:26:52',0,NULL),(356,55,'zh-Hans','[delete]','[zh-Hans]Delete!','2011-09-07 16:26:52',1,NULL),(357,55,'en','[DeleteText]','Are you sure you want to delete the selected definition?','2011-09-07 16:26:52',0,NULL),(358,55,'zh-Hans','[DeleteText]','[zh-Hans]Are you sure you want to delete the selected definition?','2011-09-07 16:26:52',1,NULL),(359,55,'en','[colHdrID]','ID','2011-09-07 16:26:52',0,NULL),(360,55,'zh-Hans','[colHdrID]','[zh-Hans]ID','2011-09-07 16:26:52',1,NULL),(361,55,'en','[colHdrLabel]','Label','2011-09-07 16:26:52',0,NULL),(362,55,'zh-Hans','[colHdrLabel]','[zh-Hans]Label','2011-09-07 16:26:52',1,NULL),(363,55,'en','[colHdrDesc]','Description','2011-09-07 16:26:52',0,NULL),(364,55,'zh-Hans','[colHdrDesc]','[zh-Hans]Description','2011-09-07 16:26:52',1,NULL),(365,55,'en','[edit_definition]','Edit Definition','2011-09-07 16:26:52',0,NULL),(366,55,'zh-Hans','[edit_definition]','[zh-Hans]Edit Definition','2011-09-07 16:26:52',1,NULL),(367,55,'en','[are_you_sure]','Really delete this definition?','2011-09-07 16:26:52',0,NULL),(368,55,'zh-Hans','[are_you_sure]','[zh-Hans]Really delete this definition?','2011-09-07 16:26:52',1,NULL),(369,56,'en','[tooltipToolEditDefinitionFields]','Edit Definition Fields','2011-09-07 16:26:52',0,NULL),(370,56,'zh-Hans','[tooltipToolEditDefinitionFields]','[zh-Hans]Edit Definition Fields','2011-09-07 16:26:52',1,NULL),(371,57,'en','[invalid_team_name]','Error: Invalid team name.','2011-09-07 16:26:52',0,NULL),(372,57,'zh-Hans','[invalid_team_name]','[zh-Hans]Error: Invalid team name.','2011-09-07 16:26:52',1,NULL),(373,58,'en','[Teams]','Teams','2011-09-07 16:26:52',0,NULL),(374,58,'zh-Hans','[Teams]','[zh-Hans]Teams','2011-09-07 16:26:52',1,NULL),(375,59,'en','[formLabel_locations]','Locations','2011-09-07 16:26:52',0,NULL),(376,59,'zh-Hans','[formLabel_locations]','[zh-Hans]Locations','2011-09-07 16:26:52',1,NULL),(377,59,'en','[formLabel_members]','Members','2011-09-07 16:26:52',0,NULL),(378,59,'zh-Hans','[formLabel_members]','[zh-Hans]Members','2011-09-07 16:26:52',1,NULL),(379,59,'en','[Person]','Person','2011-09-07 16:26:52',0,NULL),(380,59,'zh-Hans','[Person]','[zh-Hans]Person','2011-09-07 16:26:52',1,NULL),(381,59,'en','[add_location]','Add Location','2011-09-07 16:26:52',0,NULL),(382,59,'zh-Hans','[add_location]','[zh-Hans]Add Location','2011-09-07 16:26:52',1,NULL),(383,59,'en','[instr_add_location]','Select a location that this team is active in.','2011-09-07 16:26:52',0,NULL),(384,59,'zh-Hans','[instr_add_location]','[zh-Hans]Select a location that this team is active in.','2011-09-07 16:26:52',1,NULL),(385,59,'en','[add_member]','Add Member','2011-09-07 16:26:52',0,NULL),(386,59,'zh-Hans','[add_member]','[zh-Hans]Add Member','2011-09-07 16:26:52',1,NULL),(387,59,'en','[instr_add_member]','Select a team member from this list of people.','2011-09-07 16:26:52',0,NULL),(388,59,'zh-Hans','[instr_add_member]','[zh-Hans]Select a team member from this list of people.','2011-09-07 16:26:52',1,NULL),(389,59,'en','[add_mcc]','Select MCC','2011-09-07 16:26:52',0,NULL),(390,59,'zh-Hans','[add_mcc]','[zh-Hans]Select MCC','2011-09-07 16:26:52',1,NULL),(391,59,'en','[instr_add_mcc]','Select the MCC for this team.','2011-09-07 16:26:52',0,NULL),(392,59,'zh-Hans','[instr_add_mcc]','[zh-Hans]Select the MCC for this team.','2011-09-07 16:26:52',1,NULL),(393,61,'en','[error_rejection_comment_requred]','When rejecting a request, please write a short comment explaining why.','2011-09-07 16:26:52',0,NULL),(394,61,'zh-Hans','[error_rejection_comment_requred]','[zh-Hans]When rejecting a request, please write a short comment explaining why.','2011-09-07 16:26:52',1,NULL),(395,61,'en','[error_already_approved]','This request has already been approved and the changes have been made.','2011-09-07 16:26:52',0,NULL),(396,61,'zh-Hans','[error_already_approved]','[zh-Hans]This request has already been approved and the changes have been made.','2011-09-07 16:26:52',1,NULL),(397,62,'en','[error_invalid_account_number]','Please enter the primary account number.','2011-09-07 16:26:52',0,NULL),(398,62,'zh-Hans','[error_invalid_account_number]','[zh-Hans]Please enter the primary account number.','2011-09-07 16:26:52',1,NULL),(399,62,'en','[warning_unable_to_update_account]','This family does not have a primary account to update.','2011-09-07 16:26:52',0,NULL),(400,62,'zh-Hans','[warning_unable_to_update_account]','[zh-Hans]This family does not have a primary account to update.','2011-09-07 16:26:52',1,NULL),(401,63,'en','[ApproveChange]','Approve Change','2011-09-07 16:26:52',0,NULL),(402,63,'zh-Hans','[ApproveChange]','[zh-Hans]Approve Change','2011-09-07 16:26:52',1,NULL),(403,63,'en','[Instructions]','To approve an account\'s initial HRIS entry, select the person above and press this button.','2011-09-07 16:26:52',0,NULL),(404,63,'zh-Hans','[Instructions]','[zh-Hans]To approve an account\'s initial HRIS entry, select the person above and press this button.','2011-09-07 16:26:52',1,NULL),(405,63,'en','[ErrorNoRenSelected]','Choose a person in the person list to approve.','2011-09-07 16:26:52',0,NULL),(406,63,'zh-Hans','[ErrorNoRenSelected]','[zh-Hans]Choose a person in the person list to approve.','2011-09-07 16:26:52',1,NULL),(407,63,'en','[SuccessText]','Approved.','2011-09-07 16:26:52',0,NULL),(408,63,'zh-Hans','[SuccessText]','[zh-Hans]Approved.','2011-09-07 16:26:52',1,NULL),(409,63,'en','[title_add]','Add New Records','2011-09-07 16:26:52',0,NULL),(410,63,'zh-Hans','[title_add]','[zh-Hans]Add New Records','2011-09-07 16:26:52',1,NULL),(411,63,'en','[title_edit]','Update Records','2011-09-07 16:26:52',0,NULL),(412,63,'zh-Hans','[title_edit]','[zh-Hans]Update Records','2011-09-07 16:26:52',1,NULL),(413,63,'en','[title_delete]','Delete Records','2011-09-07 16:26:52',0,NULL),(414,63,'zh-Hans','[title_delete]','[zh-Hans]Delete Records','2011-09-07 16:26:52',1,NULL),(415,63,'en','[title_dbfield_name]','Data Field','2011-09-07 16:26:52',0,NULL),(416,63,'zh-Hans','[title_dbfield_name]','[zh-Hans]Data Field','2011-09-07 16:26:52',1,NULL),(417,63,'en','[title_change_previous_value]','Old Value','2011-09-07 16:26:52',0,NULL),(418,63,'zh-Hans','[title_change_previous_value]','[zh-Hans]Old Value','2011-09-07 16:26:52',1,NULL),(419,63,'en','[title_change_new_value]','New Value','2011-09-07 16:26:52',0,NULL),(420,63,'zh-Hans','[title_change_new_value]','[zh-Hans]New Value','2011-09-07 16:26:52',1,NULL),(421,63,'en','[title_change_set_value]','Set Value','2011-09-07 16:26:52',0,NULL),(422,63,'zh-Hans','[title_change_set_value]','[zh-Hans]Set Value','2011-09-07 16:26:52',1,NULL),(423,63,'en','[instr_requested_changes]','These are the changes requested. You may make final updates or corrections to them and set the final value here if needed.','2011-09-07 16:26:52',0,NULL),(424,63,'zh-Hans','[instr_requested_changes]','[zh-Hans]These are the changes requested. You may make final updates or corrections to them and set the final value here if needed.','2011-09-07 16:26:52',1,NULL),(425,63,'en','[instr_admin_response]','Set the new status of this request below. If you set it to <b>Approved</b>, the changes will immediately take effect and cannot be rejected after that. If you reject this request, you should write a comment explaining why.','2011-09-07 16:26:52',0,NULL),(426,63,'zh-Hans','[instr_admin_response]','[zh-Hans]Set the new status of this request below. If you set it to <b>Approved</b>, the changes will immediately take effect and cannot be rejected after that. If you reject this request, you should write a comment explaining why.','2011-09-07 16:26:52',1,NULL),(427,64,'en','[title_registration]','New Family Registration','2011-09-07 16:26:52',0,NULL),(428,64,'zh-Hans','[title_registration]','[zh-Hans]New Family Registration','2011-09-07 16:26:52',1,NULL),(429,64,'en','[family_member_count]','Family Members','2011-09-07 16:26:52',0,NULL),(430,64,'zh-Hans','[family_member_count]','[zh-Hans]Family Members','2011-09-07 16:26:52',1,NULL),(431,64,'en','[instr_approve_registration]','Here are the main details of this family. You may make some changes below before approving the registration. Further changes can be made later on using the Manage Others tool.','2011-09-07 16:26:52',0,NULL),(432,64,'zh-Hans','[instr_approve_registration]','[zh-Hans]Here are the main details of this family. You may make some changes below before approving the registration. Further changes can be made later on using the Manage Others tool.','2011-09-07 16:26:52',1,NULL),(433,64,'en','[instr_admin_response]','Click the Approve button to finalize the registration. Rejecting the registration will require the family to go through the New User Wizard again. If you do that, you should also e-mail the person to notify them and explain what needs to be done.','2011-09-07 16:26:52',0,NULL),(434,64,'zh-Hans','[instr_admin_response]','[zh-Hans]Click the Approve button to finalize the registration. Rejecting the registration will require the family to go through the New User Wizard again. If you do that, you should also e-mail the person to notify them and explain what needs to be done.','2011-09-07 16:26:52',1,NULL),(435,64,'en','[hint_approve]','Approve the registration for this family.','2011-09-07 16:26:52',0,NULL),(436,64,'zh-Hans','[hint_approve]','[zh-Hans]Approve the registration for this family.','2011-09-07 16:26:52',1,NULL),(437,64,'en','[hint_reject]','Have the family go through the New User Wizard again.','2011-09-07 16:26:52',0,NULL),(438,64,'zh-Hans','[hint_reject]','[zh-Hans]Have the family go through the New User Wizard again.','2011-09-07 16:26:52',1,NULL),(439,64,'en','[hint_delete]','Remove this family entry from the database because it was added by mistake.','2011-09-07 16:26:52',0,NULL),(440,64,'zh-Hans','[hint_delete]','[zh-Hans]Remove this family entry from the database because it was added by mistake.','2011-09-07 16:26:52',1,NULL),(441,64,'en','[approve]','Approve','2011-09-07 16:26:52',0,NULL),(442,64,'zh-Hans','[approve]','[zh-Hans]Approve','2011-09-07 16:26:52',1,NULL),(443,64,'en','[reject]','Reject','2011-09-07 16:26:52',0,NULL),(444,64,'zh-Hans','[reject]','[zh-Hans]Reject','2011-09-07 16:26:52',1,NULL),(445,64,'en','[delete]','Delete','2011-09-07 16:26:52',0,NULL),(446,64,'zh-Hans','[delete]','[zh-Hans]Delete','2011-09-07 16:26:52',1,NULL),(447,63,'en','[tooltipToolApproveEntry]','ToolApproveEntry','2011-09-07 16:26:52',0,NULL),(448,63,'zh-Hans','[tooltipToolApproveEntry]','[zh-Hans]ToolApproveEntry','2011-09-07 16:26:52',1,NULL),(449,66,'en','[error_invalid_spouse_ren_id]','Error: The selected spouse is somehow not in the HRIS anymore.','2011-09-07 16:26:52',0,NULL),(450,66,'zh-Hans','[error_invalid_spouse_ren_id]','[zh-Hans]Error: The selected spouse is somehow not in the HRIS anymore.','2011-09-07 16:26:52',1,NULL),(451,66,'en','[error_missing_fields]','Error: One or more required fields were not give.','2011-09-07 16:26:52',0,NULL),(452,66,'zh-Hans','[error_missing_fields]','[zh-Hans]Error: One or more required fields were not give.','2011-09-07 16:26:52',1,NULL),(453,66,'en','[error_duplicate_userID]','Error: This user ID is already being used','2011-09-07 16:26:52',0,NULL),(454,66,'zh-Hans','[error_duplicate_userID]','[zh-Hans]Error: This user ID is already being used','2011-09-07 16:26:52',1,NULL),(455,67,'en','[error_duplicate_userID]','Error: This user ID is already being used','2011-09-07 16:26:52',0,NULL),(456,67,'zh-Hans','[error_duplicate_userID]','[zh-Hans]Error: This user ID is already being used','2011-09-07 16:26:52',1,NULL),(457,68,'en','[addRenTitle]','Add a new person to HRIS','2011-09-07 16:26:52',0,NULL),(458,68,'zh-Hans','[addRenTitle]','[zh-Hans]Add a new person to HRIS','2011-09-07 16:26:52',1,NULL),(459,68,'en','[is_spouse_in_the_hris]','Is this person&apos;s spouse already in the HRIS?','2011-09-07 16:26:52',0,NULL),(460,68,'zh-Hans','[is_spouse_in_the_hris]','[zh-Hans]Is this person&apos;s spouse already in the HRIS?','2011-09-07 16:26:52',1,NULL),(461,68,'en','[select_spouse]','Please identify the spouse from this list','2011-09-07 16:26:52',0,NULL),(462,68,'zh-Hans','[select_spouse]','[zh-Hans]Please identify the spouse from this list','2011-09-07 16:26:52',1,NULL),(463,68,'en','[formLabel_sponsor]','Sponsor','2011-09-07 16:26:52',0,NULL),(464,68,'zh-Hans','[formLabel_sponsor]','[zh-Hans]Sponsor','2011-09-07 16:26:52',1,NULL),(465,68,'en','[volunteer]','Volunteer','2011-09-07 16:26:52',0,NULL),(466,68,'zh-Hans','[volunteer]','[zh-Hans]Volunteer','2011-09-07 16:26:52',1,NULL),(467,68,'en','[none]','(none)','2011-09-07 16:26:52',0,NULL),(468,68,'zh-Hans','[none]','[zh-Hans](none)','2011-09-07 16:26:52',1,NULL),(469,68,'en','[continue]','Continue','2011-09-07 16:26:52',0,NULL),(470,68,'zh-Hans','[continue]','[zh-Hans]Continue','2011-09-07 16:26:52',1,NULL),(471,68,'en','[previous]','Previous','2011-09-07 16:26:52',0,NULL),(472,68,'zh-Hans','[previous]','[zh-Hans]Previous','2011-09-07 16:26:52',1,NULL),(473,68,'en','[formLabel_viewer_userID]','Ele User Name (GUID)','2011-09-07 16:26:52',0,NULL),(474,68,'zh-Hans','[formLabel_viewer_userID]','[zh-Hans]Ele User Name (GUID)','2011-09-07 16:26:52',1,NULL),(475,68,'en','[formLabel_viewer_password]','Password','2011-09-07 16:26:52',0,NULL),(476,68,'zh-Hans','[formLabel_viewer_password]','[zh-Hans]Password','2011-09-07 16:26:52',1,NULL),(477,68,'en','[ren_type_instr]','Please select the type of person you are adding.','2011-09-07 16:26:52',0,NULL),(478,68,'zh-Hans','[ren_type_instr]','[zh-Hans]Please select the type of person you are adding.','2011-09-07 16:26:52',1,NULL),(479,68,'en','[add_ren_instr]','Please enter the following information of the person being added.','2011-09-07 16:26:52',0,NULL),(480,68,'zh-Hans','[add_ren_instr]','[zh-Hans]Please enter the following information of the person being added.','2011-09-07 16:26:52',1,NULL),(481,68,'en','[staff_instr]','Please enter the following information for this staff.','2011-09-07 16:26:52',0,NULL),(482,68,'zh-Hans','[staff_instr]','[zh-Hans]Please enter the following information for this staff.','2011-09-07 16:26:52',1,NULL),(483,68,'en','[volunteer_instr]','Please enter the following information for this volunteer.','2011-09-07 16:26:52',0,NULL),(484,68,'zh-Hans','[volunteer_instr]','[zh-Hans]Please enter the following information for this volunteer.','2011-09-07 16:26:52',1,NULL),(485,68,'en','[friend_of_ministry_instr]','Please enter the following information for this friend of the ministry. <i>Sponsor</i> refers to the person who is adding his/her friend to the HRIS.','2011-09-07 16:26:52',0,NULL),(486,68,'zh-Hans','[friend_of_ministry_instr]','[zh-Hans]Please enter the following information for this friend of the ministry. <i>Sponsor</i> refers to the person who is adding his/her friend to the HRIS.','2011-09-07 16:26:52',1,NULL),(487,68,'en','[contact_info_instr]','Please enter the contact information for this person.','2011-09-07 16:26:52',0,NULL),(488,68,'zh-Hans','[contact_info_instr]','[zh-Hans]Please enter the contact information for this person.','2011-09-07 16:26:52',1,NULL),(489,68,'en','[select_spouse_instr]','Check the box if this person\'s spouse is already in the HRIS.','2011-09-07 16:26:52',0,NULL),(490,68,'zh-Hans','[select_spouse_instr]','[zh-Hans]Check the box if this person\'s spouse is already in the HRIS.','2011-09-07 16:26:52',1,NULL),(491,68,'en','[account_instr]','Please enter this person\'s family account information.','2011-09-07 16:26:52',0,NULL),(492,68,'zh-Hans','[account_instr]','[zh-Hans]Please enter this person\'s family account information.','2011-09-07 16:26:52',1,NULL),(493,68,'en','[add_spouse_instr]','Please enter the following information of the spouse.','2011-09-07 16:26:52',0,NULL),(494,68,'zh-Hans','[add_spouse_instr]','[zh-Hans]Please enter the following information of the spouse.','2011-09-07 16:26:52',1,NULL),(495,68,'en','[family_poc_instr]','Who is the family point of contact?','2011-09-07 16:26:52',0,NULL),(496,68,'zh-Hans','[family_poc_instr]','[zh-Hans]Who is the family point of contact?','2011-09-07 16:26:52',1,NULL),(497,68,'en','[added_successfully]','Person added!','2011-09-07 16:26:52',0,NULL),(498,68,'zh-Hans','[added_successfully]','[zh-Hans]Person added!','2011-09-07 16:26:52',1,NULL),(499,68,'en','[error_missing_required_fields]','Please enter these required fields:','2011-09-07 16:26:52',0,NULL),(500,68,'zh-Hans','[error_missing_required_fields]','[zh-Hans]Please enter these required fields:','2011-09-07 16:26:52',1,NULL),(501,68,'en','[error_select_spouse]','Please make a selection from the list.','2011-09-07 16:26:52',0,NULL),(502,68,'zh-Hans','[error_select_spouse]','[zh-Hans]Please make a selection from the list.','2011-09-07 16:26:52',1,NULL),(503,69,'en','[GroupDefinition]','Group Definition','2011-09-07 16:26:52',0,NULL),(504,69,'zh-Hans','[GroupDefinition]','[zh-Hans]Group Definition','2011-09-07 16:26:52',1,NULL),(505,69,'en','[title_filter_label]','Group Name: ','2011-09-07 16:26:52',0,NULL),(506,69,'zh-Hans','[title_filter_label]','[zh-Hans]Group Name: ','2011-09-07 16:26:52',1,NULL),(507,69,'en','[scope_editor_instr]','\n          <p>Use the condition editor below to define who will be included in the group.</p>\n          <p>A condition is made up of one or more <i>rulesets</i> combined together with either AND or OR.\n          You may name a ruleset anything you like. These are some example conditions:\n            <ul>\n              <li>StaffMen</li>\n              <li>Expats OR STINTers</li>\n              <li>apples AND oranges AND grapefruit</li>\n            </ul>\n          </p>\n          <p>Once a condition has been set, you can click on any of the rulesets within it. This will reveal the definition of that ruleset. To add a rule to the set, choose the Field, Condition, and Value, then click on the <b>+</b> button. Add as many rules to the ruleset as needed. Use the <b>-</b> button to remove rules that are not wanted.</p>\n          <p>All changes are saved automatically.</p>\n          ','2011-09-07 16:26:52',0,NULL),(508,69,'zh-Hans','[scope_editor_instr]','[zh-Hans]\n          <p>Use the condition editor below to define who will be included in the group.</p>\n          <p>A condition is made up of one or more <i>rulesets</i> combined together with either AND or OR.\n          You may name a ruleset anything you like. These are some example conditions:\n            <ul>\n              <li>StaffMen</li>\n              <li>Expats OR STINTers</li>\n              <li>apples AND oranges AND grapefruit</li>\n            </ul>\n          </p>\n          <p>Once a condition has been set, you can click on any of the rulesets within it. This will reveal the definition of that ruleset. To add a rule to the set, choose the Field, Condition, and Value, then click on the <b>+</b> button. Add as many rules to the ruleset as needed. Use the <b>-</b> button to remove rules that are not wanted.</p>\n          <p>All changes are saved automatically.</p>\n          ','2011-09-07 16:26:52',1,NULL),(509,69,'en','[close]','Close','2011-09-07 16:26:52',0,NULL),(510,69,'zh-Hans','[close]','[zh-Hans]Close','2011-09-07 16:26:52',1,NULL),(511,70,'en','[tooltipToolManageOthers]','Manage Others','2011-09-07 16:26:52',0,NULL),(512,70,'zh-Hans','[tooltipToolManageOthers]','[zh-Hans]Manage Others','2011-09-07 16:26:52',1,NULL),(513,71,'en','[invalid_field]','Error: The field you have selected cannot be edited.','2011-09-07 16:26:52',0,NULL),(514,71,'zh-Hans','[invalid_field]','[zh-Hans]Error: The field you have selected cannot be edited.','2011-09-07 16:26:52',1,NULL),(515,71,'en','[its_gone]','Error: This field has already been deleted. Possibly by someone else.','2011-09-07 16:26:52',0,NULL),(516,71,'zh-Hans','[its_gone]','[zh-Hans]Error: This field has already been deleted. Possibly by someone else.','2011-09-07 16:26:52',1,NULL),(517,71,'en','[no_dbfield_access]','Error: You do not have the right permissions to edit this field.','2011-09-07 16:26:52',0,NULL),(518,71,'zh-Hans','[no_dbfield_access]','[zh-Hans]Error: You do not have the right permissions to edit this field.','2011-09-07 16:26:52',1,NULL),(519,72,'en','[invalid_field]','Error: The field you have selected cannot be edited.','2011-09-07 16:26:52',0,NULL),(520,72,'zh-Hans','[invalid_field]','[zh-Hans]Error: The field you have selected cannot be edited.','2011-09-07 16:26:52',1,NULL),(521,72,'en','[its_gone]','Error: This field has already been deleted. Possibly by someone else.','2011-09-07 16:26:52',0,NULL),(522,72,'zh-Hans','[its_gone]','[zh-Hans]Error: This field has already been deleted. Possibly by someone else.','2011-09-07 16:26:52',1,NULL),(523,72,'en','[save_Error]','Error: There was a problem while saving the field.','2011-09-07 16:26:52',0,NULL),(524,72,'zh-Hans','[save_Error]','[zh-Hans]Error: There was a problem while saving the field.','2011-09-07 16:26:52',1,NULL),(525,73,'en','[shared_by]','shared by','2011-09-07 16:26:52',0,NULL),(526,73,'zh-Hans','[shared_by]','[zh-Hans]shared by','2011-09-07 16:26:52',1,NULL),(527,73,'en','[Edit_Report_Definition]','Edit Report Definition','2011-09-07 16:26:52',0,NULL),(528,73,'zh-Hans','[Edit_Report_Definition]','[zh-Hans]Edit Report Definition','2011-09-07 16:26:52',1,NULL),(529,73,'en','[HTML]','HTML','2011-09-07 16:26:52',0,NULL),(530,73,'zh-Hans','[HTML]','[zh-Hans]HTML','2011-09-07 16:26:52',1,NULL),(531,73,'en','[Printable]','Printable','2011-09-07 16:26:52',0,NULL),(532,73,'zh-Hans','[Printable]','[zh-Hans]Printable','2011-09-07 16:26:52',1,NULL),(533,73,'en','[Excel_download]','Excel Download','2011-09-07 16:26:52',0,NULL),(534,73,'zh-Hans','[Excel_download]','[zh-Hans]Excel Download','2011-09-07 16:26:52',1,NULL),(535,73,'en','[Editable]','Editable','2011-09-07 16:26:52',0,NULL),(536,73,'zh-Hans','[Editable]','[zh-Hans]Editable','2011-09-07 16:26:52',1,NULL),(537,73,'en','[Share_with]','Share with','2011-09-07 16:26:52',0,NULL),(538,73,'zh-Hans','[Share_with]','[zh-Hans]Share with','2011-09-07 16:26:52',1,NULL),(539,73,'en','[Make_shareable]','Make shareable','2011-09-07 16:26:52',0,NULL),(540,73,'zh-Hans','[Make_shareable]','[zh-Hans]Make shareable','2011-09-07 16:26:52',1,NULL),(541,73,'en','[Save]','Save','2011-09-07 16:26:52',0,NULL),(542,73,'zh-Hans','[Save]','[zh-Hans]Save','2011-09-07 16:26:52',1,NULL),(543,74,'en','[title_personnel]','Personnel Reports','2011-09-07 16:26:52',0,NULL),(544,74,'zh-Hans','[title_personnel]','[zh-Hans]Personnel Reports','2011-09-07 16:26:52',1,NULL),(545,74,'en','[title_summary]','Summary Reports','2011-09-07 16:26:52',0,NULL),(546,74,'zh-Hans','[title_summary]','[zh-Hans]Summary Reports','2011-09-07 16:26:52',1,NULL),(547,75,'en','[tooltipToolReports]','Reports','2011-09-07 16:26:52',0,NULL),(548,75,'zh-Hans','[tooltipToolReports]','[zh-Hans]Reports','2011-09-07 16:26:52',1,NULL),(549,76,'en','[logout]','Log Out','2011-09-07 16:26:52',0,NULL),(550,76,'zh-Hans','[logout]','[zh-Hans]Log Out','2011-09-07 16:26:52',1,NULL),(551,76,'en','[work_saved]','Work Saved!','2011-09-07 16:26:52',0,NULL),(552,76,'zh-Hans','[work_saved]','[zh-Hans]Work Saved!','2011-09-07 16:26:52',1,NULL),(553,76,'en','[UserNotes1]','All work is saved immediately when you add or update an entry.','2011-09-07 16:26:52',0,NULL),(554,76,'zh-Hans','[UserNotes1]','[zh-Hans]All work is saved immediately when you add or update an entry.','2011-09-07 16:26:52',1,NULL),(555,76,'en','[UserNotes2]','You may logout at any time and return to the wizard later to finish filling out your information. ','2011-09-07 16:26:52',0,NULL),(556,76,'zh-Hans','[UserNotes2]','[zh-Hans]You may logout at any time and return to the wizard later to finish filling out your information. ','2011-09-07 16:26:52',1,NULL),(557,76,'en','[UserNotes3]','Until you have completed the New User Wizard you will not be able to access the HRIS.','2011-09-07 16:26:52',0,NULL),(558,76,'zh-Hans','[UserNotes3]','[zh-Hans]Until you have completed the New User Wizard you will not be able to access the HRIS.','2011-09-07 16:26:52',1,NULL),(559,76,'en','[Title_Welcome]','Welcome To The HRIS New User Wizard','2011-09-07 16:26:52',0,NULL),(560,76,'zh-Hans','[Title_Welcome]','&#27426;&#36814;&#35775;&#38382;HRIS&#31995;&#32479;---&#26032;&#29992;&#25143;&#21521;&#23548;','2011-09-07 16:26:52',0,NULL),(561,76,'en','[StepTitle_Welcome]','Welcome','2011-09-07 16:26:52',0,NULL),(562,76,'zh-Hans','[StepTitle_Welcome]','&#27426;&#36814;','2011-09-07 16:26:52',0,NULL),(563,76,'en','[Thanks]','Thanks for taking the time to give us the most accurate picture of who you are, where you are, and what makes you tick.','2011-09-07 16:26:52',0,NULL),(564,76,'zh-Hans','[Thanks]','&#38750;&#24120;&#24863;&#35874;&#20320;&#33457;&#36153;&#23453;&#36149;&#30340;&#26102;&#38388;&#36755;&#20837;&#20320;&#20010;&#20154;&#30340;&#20449;&#24687;&#65292;&#35753;&#25105;&#20204;&#30693;&#36947;&#20320;&#26159;&#35841;&#12289;&#22312;&#21738;&#20799;&#20197;&#21450;&#20320;&#30340;&#20854;&#20182;&#20449;&#24687;&#12290;','2011-09-07 16:26:52',0,NULL),(565,76,'en','[WillHelp]','This information will help your region and your national leadership better shepherd you. It will be used to account for you and your family in times of crisis as well as provide you with opportunities to make your ministry more effective. Please fill it out completely and accurately.  Answering the questions will take 30 minutes or more depending upon the size of your family.','2011-09-07 16:26:52',0,NULL),(566,76,'zh-Hans','[WillHelp]','&#36825;&#20123;&#20449;&#24687;&#23558;&#24110;&#21161;&#20320;&#25152;&#22312;&#22320;&#21306;&#21644;&#22269;&#23478;&#30340;&#39046;&#23548;&#26356;&#22909;&#30340;&#29287;&#32650;&#20320;&#12290;&#36825;&#20123;&#20449;&#24687;&#19981;&#20165;&#22312;&#21487;&#20197;&#25552;&#20379;&#26356;&#22810;&#30340;&#26426;&#20250;&#20351;&#20320;&#30340;&#20107;&#24037;&#26356;&#26377;&#25928;&#29575;&#65292;&#32780;&#19988;&#22312;&#21361;&#26426;&#21457;&#29983;&#30340;&#26102;&#20505;&#20063;&#21487;&#20197;&#24110;&#21161;&#21040;&#20320;&#21644;&#20320;&#30340;&#23478;&#24237;&#12290;&#35831;&#23436;&#25972;&#24182;&#20934;&#30830;&#30340;&#22635;&#20889;&#36825;&#20123;&#20449;&#24687;&#12290;&#22238;&#31572;&#36825;&#20123;&#38382;&#39064;&#32422;&#38656;30&#20998;&#38047;&#30340;&#26102;&#38388;&#12290;&#26681;&#25454;&#20320;&#23478;&#24237;&#25104;&#21592;&#30340;&#22810;&#23569;&#65292;&#20250;&#26377;&#25152;&#19981;&#21516;&#12290;','2011-09-07 16:26:52',0,NULL),(567,76,'en','[YouWillNeed]','Before you begin, you will need the following information for each member of your family:','2011-09-07 16:26:52',0,NULL),(568,76,'zh-Hans','[YouWillNeed]','&#22312;&#24320;&#22987;&#20043;&#21069;&#65292;&#20320;&#38656;&#35201;&#20934;&#22791;&#27599;&#20010;&#23478;&#24237;&#25104;&#21592;&#30340;&#20197;&#19979;&#20449;&#24687;&#65306;','2011-09-07 16:26:52',0,NULL),(569,76,'en','[Passports]','Passport information','2011-09-07 16:26:52',0,NULL),(570,76,'zh-Hans','[Passports]','&#25252;&#29031;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(571,76,'en','[MedicalRecords]','Information regarding any medical conditions','2011-09-07 16:26:52',0,NULL),(572,76,'zh-Hans','[MedicalRecords]','&#21307;&#30103;&#24773;&#20917;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(573,76,'en','[BloodType]','Blood type and RH factor (if you do not know this information, please contact your family doctor in your home country)','2011-09-07 16:26:52',0,NULL),(574,76,'zh-Hans','[BloodType]','&#34880;&#22411;&#21644;RH&#22240;&#23376;&#65288;&#22914;&#26524;&#20320;&#19981;&#30693;&#36947;&#36825;&#20123;&#20449;&#24687;&#65292;&#35831;&#19982;&#20320;&#26412;&#22269;&#30340;&#23478;&#24237;&#21307;&#29983;&#32852;&#31995;&#65289;','2011-09-07 16:26:52',0,NULL),(575,76,'en','[Address]','In-country address, phone numbers, and alternate e-mail addresses','2011-09-07 16:26:52',0,NULL),(576,76,'zh-Hans','[Address]','&#22269;&#20869;&#22320;&#22336;&#12289;&#30005;&#35805;&#21644;&#22791;&#29992;&#30340;&#30005;&#23376;&#37038;&#20214;&#22320;&#22336;','2011-09-07 16:26:52',0,NULL),(577,76,'en','[Account]','CCC staff account numbers','2011-09-07 16:26:52',0,NULL),(578,76,'zh-Hans','[Account]','CCC&#21516;&#24037;&#24080;&#21495;','2011-09-07 16:26:52',0,NULL),(579,76,'en','[ContactInfo]','Emergency contact information including mailing address, e-mail addresses, and phone numbers','2011-09-07 16:26:52',0,NULL),(580,76,'zh-Hans','[ContactInfo]','&#32039;&#24613;&#24773;&#20917;&#32852;&#31995;&#20449;&#24687;&#65292;&#21253;&#25324;&#36890;&#20449;&#22320;&#22336;&#12289;&#30005;&#23376;&#37038;&#20214;&#22320;&#22336;&#24050;&#32463;&#30005;&#35805;&#21495;&#30721;','2011-09-07 16:26:52',0,NULL),(581,76,'en','[Having]','Having this information before you begin will help you quickly and accurately answer the questions.','2011-09-07 16:26:52',0,NULL),(582,76,'zh-Hans','[Having]','&#22312;&#24320;&#22987;&#20043;&#21069;&#20934;&#22791;&#22909;&#36825;&#20123;&#20449;&#24687;&#23558;&#26377;&#21161;&#20320;&#24555;&#36895;&#20934;&#30830;&#30340;&#22238;&#31572;&#19979;&#38754;&#30340;&#38382;&#39064;','2011-09-07 16:26:52',0,NULL),(583,76,'en','[Questions]','You may come back at anytime to change or correct the information entered. If you have any questions, please consult your HR or IT personnel.','2011-09-07 16:26:52',0,NULL),(584,76,'zh-Hans','[Questions]','&#20320;&#21487;&#20197;&#22312;&#20219;&#20309;&#26102;&#20505;&#36820;&#22238;&#20462;&#25913;&#25110;&#32773;&#32416;&#27491;&#36755;&#20837;&#30340;&#20449;&#24687;&#12290;&#22914;&#26524;&#20320;&#26377;&#20219;&#20309;&#38382;&#39064;&#65292;&#35831;&#19982;&#20320;&#30340;HR&#21644;IT&#36127;&#36131;&#20154;&#32852;&#31995;.','2011-09-07 16:26:52',0,NULL),(585,76,'en','[invalid]','Please correct all invalid or missing field value(s).','2011-09-07 16:26:52',0,NULL),(586,76,'zh-Hans','[invalid]','&#35831;&#32416;&#27491;&#26080;&#25928;&#30340;&#25110;&#26410;&#36755;&#20837;&#30340;&#20540;.','2011-09-07 16:26:52',0,NULL),(587,76,'en','[Next]','Next','2011-09-07 16:26:52',0,NULL),(588,76,'zh-Hans','[Next]','&#19979;&#19968;&#20010;','2011-09-07 16:26:52',0,NULL),(589,76,'en','[Back]','Back','2011-09-07 16:26:52',0,NULL),(590,76,'zh-Hans','[Back]','&#21518;&#36864;','2011-09-07 16:26:52',0,NULL),(591,76,'en','[Finish]','Finish','2011-09-07 16:26:52',0,NULL),(592,76,'zh-Hans','[Finish]','&#23436;&#25104;','2011-09-07 16:26:52',0,NULL),(593,76,'en','[title_AreYouSure]','Confirmation','2011-09-07 16:26:52',0,NULL),(594,76,'zh-Hans','[title_AreYouSure]','&#30830;&#35748;','2011-09-07 16:26:52',0,NULL),(595,76,'en','[AreYouSure]','Are you sure you really want to delete this?','2011-09-07 16:26:52',0,NULL),(596,76,'zh-Hans','[AreYouSure]','&#20320;&#30830;&#23450;&#30495;&#35201;&#21024;&#38500;&#21527;&#65311;','2011-09-07 16:26:52',0,NULL),(597,76,'en','[title_Error]','Error','2011-09-07 16:26:52',0,NULL),(598,76,'zh-Hans','[title_Error]','&#38169;&#35823;','2011-09-07 16:26:52',0,NULL),(599,76,'en','[errorInvalidFields]','Please correct the invalid fields','2011-09-07 16:26:52',0,NULL),(600,76,'zh-Hans','[errorInvalidFields]','&#35831;&#32416;&#27491;&#26080;&#25928;&#30340;&#20540;','2011-09-07 16:26:52',0,NULL),(601,76,'en','[errorNoPrimaryAccount]','You must specify a primary account','2011-09-07 16:26:52',0,NULL),(602,76,'zh-Hans','[errorNoPrimaryAccount]','&#20320;&#24517;&#39035;&#25351;&#23450;&#19968;&#20010;&#39318;&#36873;&#24080;&#21495;','2011-09-07 16:26:52',0,NULL),(603,76,'en','[errorMultiplePrimaryAccounts]','You may have only one primary account','2011-09-07 16:26:52',0,NULL),(604,76,'zh-Hans','[errorMultiplePrimaryAccounts]','&#20320;&#20165;&#21487;&#20197;&#26377;&#19968;&#20010;&#39318;&#36873;&#24080;&#21495;','2011-09-07 16:26:52',0,NULL),(605,76,'en','[errorNoEmergencyContact]','You must have at least one emergency contact','2011-09-07 16:26:52',0,NULL),(606,76,'zh-Hans','[errorNoEmergencyContact]','&#20320;&#33267;&#23569;&#38656;&#35201;&#19968;&#20010;&#32039;&#24613;&#32852;&#31995;&#26041;&#24335;','2011-09-07 16:26:52',0,NULL),(607,76,'en','[errorAllHaveMedical]','All family members have a medical information record. You cannot add another record.','2011-09-07 16:26:52',0,NULL),(608,76,'zh-Hans','[errorAllHaveMedical]','&#25152;&#26377;&#23478;&#24237;&#25104;&#21592;&#37117;&#26377;&#19968;&#20010;&#21307;&#30103;&#35760;&#24405;&#12290;&#20320;&#19981;&#33021;&#28155;&#21152;&#21478;&#22806;&#19968;&#20010;&#12290;','2011-09-07 16:26:52',0,NULL),(609,76,'en','[Title_account]','Account Information','2011-09-07 16:26:52',0,NULL),(610,76,'zh-Hans','[Title_account]','&#24080;&#25143;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(611,76,'en','[StepTitle_account]','Account','2011-09-07 16:26:52',0,NULL),(612,76,'zh-Hans','[StepTitle_account]','&#24080;&#25143;','2011-09-07 16:26:52',0,NULL),(613,76,'en','[accountPrimary]','Primary','2011-09-07 16:26:52',0,NULL),(614,76,'zh-Hans','[accountPrimary]','&#39318;&#36873;&#30340;','2011-09-07 16:26:52',0,NULL),(615,76,'en','[accountAlternate]','Alternate','2011-09-07 16:26:52',0,NULL),(616,76,'zh-Hans','[accountAlternate]','&#20379;&#36873;&#25321;&#30340;','2011-09-07 16:26:52',0,NULL),(617,76,'en','[Description_account]','List the accounts belonging to you. You must have one Primary account and zero or more Alternate accounts. Definitions for these account types are as follows.','2011-09-07 16:26:52',0,NULL),(618,76,'zh-Hans','[Description_account]','&#21015;&#20986;&#20320;&#30340;&#25152;&#26377;&#36134;&#25143;&#12290;&#20320;&#24517;&#39035;&#26377;&#19968;&#20010;&#39318;&#36873;&#36134;&#25143;&#65292;&#38646;&#20010;&#25110;&#22810;&#20010;&#20379;&#36873;&#25321;&#36134;&#25143;&#12290;&#36825;&#20123;&#36134;&#25143;&#31867;&#22411;&#30340;&#23450;&#20041;&#22914;&#19979;&#12290;','2011-09-07 16:26:52',0,NULL),(619,76,'en','[PrimaryAccountDescription]','An account used to pay your salary and any company billing charges','2011-09-07 16:26:52',0,NULL),(620,76,'zh-Hans','[PrimaryAccountDescription]','&#29992;&#26469;&#25903;&#20184;&#24037;&#36164;&#20197;&#21450;&#20219;&#20309;&#20844;&#21496;&#36134;&#21333;&#36153;&#29992;&#30340;&#36134;&#25143;','2011-09-07 16:26:52',0,NULL),(621,76,'en','[AlternateAccountDescription]','An account that can have various uses but is typically set up for donors in a foreign country','2011-09-07 16:26:52',0,NULL),(622,76,'zh-Hans','[AlternateAccountDescription]','&#21487;&#20197;&#26377;&#22810;&#31181;&#19981;&#21516;&#30340;&#29992;&#36884;&#65292;&#20294;&#36890;&#24120;&#26159;&#20026;&#20026;&#22312;&#22269;&#22806;&#30340;&#25903;&#25345;&#32773;&#35774;&#32622;&#30340;&#25509;&#25910;&#22857;&#29486;&#30340;&#36134;&#25143;','2011-09-07 16:26:52',0,NULL),(623,76,'en','[Notice]','Please note, only enter information for accounts that currently exist. Adding an account below does not create a new account. To create a new account contact your HR representative.','2011-09-07 16:26:52',0,NULL),(624,76,'zh-Hans','[Notice]','&#35831;&#27880;&#24847;&#65306;&#20165;&#21487;&#20197;&#36755;&#20837;&#24050;&#26377;&#30340;&#36134;&#25143;&#20449;&#24687;&#12290;&#28155;&#21152;&#20197;&#19979;&#30340;&#36134;&#25143;&#20449;&#24687;&#24182;&#19981;&#33021;&#21019;&#24314;&#19968;&#20010;&#26032;&#36134;&#25143;&#12290;&#20026;&#20102;&#21019;&#24314;&#26032;&#36134;&#25143;&#65292;&#35831;&#19982;&#20320;&#30340;HR&#36127;&#36131;&#20154;&#32852;&#31995;&#12290;','2011-09-07 16:26:52',0,NULL),(625,76,'en','[Title_family-info]','Family Information','2011-09-07 16:26:52',0,NULL),(626,76,'zh-Hans','[Title_family-info]','&#23478;&#24237;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(627,76,'en','[StepTitle_family-info]','Family','2011-09-07 16:26:52',0,NULL),(628,76,'zh-Hans','[StepTitle_family-info]','&#23478;&#24237;','2011-09-07 16:26:52',0,NULL),(629,76,'en','[RegWithEmbassy]','If you are a foreigner, are you registered with your country\'s embassy?','2011-09-07 16:26:52',0,NULL),(630,76,'zh-Hans','[RegWithEmbassy]','&#22914;&#26524;&#20320;&#26159;&#22806;&#22269;&#20154;&#65292;&#20320;&#26377;&#27809;&#26377;&#22312;&#20320;&#26412;&#22269;&#30340;&#22823;&#20351;&#39302;&#30331;&#35760;&#36807;&#65311;','2011-09-07 16:26:52',0,NULL),(631,76,'en','[AnniversaryDate]','If married, enter your anniversary date.','2011-09-07 16:26:52',0,NULL),(632,76,'zh-Hans','[AnniversaryDate]','&#22914;&#26524;&#24050;&#23130;&#65292;&#35831;&#36755;&#20837;&#20320;&#20204;&#30340;&#32467;&#23130;&#21608;&#24180;&#32426;&#24565;&#26085;&#12290;','2011-09-07 16:26:52',0,NULL),(633,76,'en','[AddFamilyMembers]','Add family members to the table below.','2011-09-07 16:26:52',0,NULL),(634,76,'zh-Hans','[AddFamilyMembers]','&#35831;&#28155;&#21152;&#23478;&#24237;&#25104;&#21592;&#21040;&#19979;&#38754;&#30340;&#34920;&#26684;&#20013;&#12290;','2011-09-07 16:26:52',0,NULL),(635,76,'en','[SurnamePrompt]','Surname (latin characters only)','2011-09-07 16:26:52',0,NULL),(636,76,'zh-Hans','[SurnamePrompt]','&#22995;&#65288;&#20165;&#25289;&#19969;&#23383;&#31526;&#65289;','2011-09-07 16:26:52',0,NULL),(637,76,'en','[GivenNamePrompt]','Given name(s) (latin characters only)','2011-09-07 16:26:52',0,NULL),(638,76,'zh-Hans','[GivenNamePrompt]','&#21517;&#65288;&#20165;&#25289;&#19969;&#23383;&#31526;&#65289;','2011-09-07 16:26:52',0,NULL),(639,76,'en','[Title_family-names]','Family Names','2011-09-07 16:26:52',0,NULL),(640,76,'zh-Hans','[Title_family-names]','&#23478;&#24237;&#21517;&#23383;','2011-09-07 16:26:52',0,NULL),(641,76,'en','[StepTitle_family-names]','Names','2011-09-07 16:26:52',0,NULL),(642,76,'zh-Hans','[StepTitle_family-names]','&#22995;&#21517;','2011-09-07 16:26:52',0,NULL),(643,76,'en','[Description_family-names]','Please fill in the extended name information for each family member.','2011-09-07 16:26:52',0,NULL),(644,76,'zh-Hans','[Description_family-names]','&#35831;&#20026;&#27599;&#20301;&#23478;&#24237;&#25104;&#21592;&#22635;&#20889;&#35814;&#32454;&#30340;&#22995;&#21517;&#20449;&#24687;&#12290;','2011-09-07 16:26:52',0,NULL),(645,76,'en','[formLabel_ren_id]','Family Member','2011-09-07 16:26:52',0,NULL),(646,76,'zh-Hans','[formLabel_ren_id]','&#23478;&#24237;&#25104;&#21592;','2011-09-07 16:26:52',0,NULL),(647,76,'en','[PhotoDescription]','You may upload ID photos for family members here.','2011-09-07 16:26:52',0,NULL),(648,76,'zh-Hans','[PhotoDescription]','&#20320;&#21487;&#20197;&#22312;&#36825;&#37324;&#20026;&#27599;&#20301;&#23478;&#24237;&#25104;&#21592;&#19978;&#20256;&#20182;&#20204;&#30340;&#36523;&#20221;&#29031;&#29255;&#12290;','2011-09-07 16:26:52',0,NULL),(649,76,'en','[formLabel_attachment_content]','Photo','2011-09-07 16:26:52',0,NULL),(650,76,'zh-Hans','[formLabel_attachment_content]','&#29031;&#29255;','2011-09-07 16:26:52',0,NULL),(651,76,'en','[Title_personal]','Personal Information','2011-09-07 16:26:52',0,NULL),(652,76,'zh-Hans','[Title_personal]','&#20010;&#20154;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(653,76,'en','[StepTitle_personal]','Personal','2011-09-07 16:26:52',0,NULL),(654,76,'zh-Hans','[StepTitle_personal]','&#20010;&#20154;','2011-09-07 16:26:52',0,NULL),(655,76,'en','[Description_personal]','Please fill in the personal information for each family member.','2011-09-07 16:26:52',0,NULL),(656,76,'zh-Hans','[Description_personal]','&#35831;&#20026;&#27599;&#20301;&#23478;&#24237;&#25104;&#21592;&#22635;&#20889;&#20010;&#20154;&#20449;&#24687;&#12290;','2011-09-07 16:26:52',0,NULL),(657,76,'en','[Title_passport]','Passport Information','2011-09-07 16:26:52',0,NULL),(658,76,'zh-Hans','[Title_passport]','&#25252;&#29031;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(659,76,'en','[StepTitle_passport]','Passport','2011-09-07 16:26:52',0,NULL),(660,76,'zh-Hans','[StepTitle_passport]','&#25252;&#29031;','2011-09-07 16:26:52',0,NULL),(661,76,'en','[PassportDescription]','Enter the information for each member of your family who has a passport. One person may have multiple passports.','2011-09-07 16:26:52',0,NULL),(662,76,'zh-Hans','[PassportDescription]','&#35831;&#20026;&#27599;&#20301;&#23478;&#24237;&#25104;&#21592;&#36755;&#20837;&#25252;&#29031;&#20449;&#24687;&#12290;&#21487;&#20197;&#20026;&#19968;&#20010;&#20154;&#36755;&#20837;&#22810;&#20010;&#25252;&#29031;&#12290;','2011-09-07 16:26:52',0,NULL),(663,76,'en','[VisaDescription]','Enter visa information for your family\'s passports. You may have multiple current visas for each passport.','2011-09-07 16:26:52',0,NULL),(664,76,'zh-Hans','[VisaDescription]','&#35831;&#36755;&#20837;&#23478;&#24237;&#25104;&#21592;&#25252;&#29031;&#30340;&#31614;&#35777;&#20449;&#24687;&#12290;&#27599;&#26412;&#25252;&#29031;&#21487;&#20197;&#26377;&#22810;&#20010;&#29616;&#26377;&#31614;&#35777;&#12290;','2011-09-07 16:26:52',0,NULL),(665,76,'en','[VisaDialogTitle]','Visa Information','2011-09-07 16:26:52',0,NULL),(666,76,'zh-Hans','[VisaDialogTitle]','&#31614;&#35777;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(667,76,'en','[PassportPageDescription]','You may upload passport pages for family members here.','2011-09-07 16:26:52',0,NULL),(668,76,'zh-Hans','[PassportPageDescription]','&#20320;&#21487;&#20197;&#22312;&#36825;&#37324;&#19978;&#20256;&#23478;&#24237;&#25104;&#21592;&#30340;&#25252;&#29031;&#39029;&#12290;','2011-09-07 16:26:52',0,NULL),(669,76,'en','[formLabel_attachment_description]','Description','2011-09-07 16:26:52',0,NULL),(670,76,'zh-Hans','[formLabel_attachment_description]','&#25551;&#36848;','2011-09-07 16:26:52',0,NULL),(671,76,'en','[Title_contact]','Contact Information','2011-09-07 16:26:52',0,NULL),(672,76,'zh-Hans','[Title_contact]','&#32852;&#31995;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(673,76,'en','[StepTitle_contact]','Contact','2011-09-07 16:26:52',0,NULL),(674,76,'zh-Hans','[StepTitle_contact]','&#32852;&#31995;&#26041;&#24335;','2011-09-07 16:26:52',0,NULL),(675,76,'en','[Description_contact]','','2011-09-07 16:26:52',0,NULL),(676,76,'zh-Hans','[Description_contact]','','2011-09-07 16:26:52',0,NULL),(677,76,'en','[PhoneDialogTitle]','Phone','2011-09-07 16:26:52',0,NULL),(678,76,'zh-Hans','[PhoneDialogTitle]','&#30005;&#35805;','2011-09-07 16:26:52',0,NULL),(679,76,'en','[EmailDialogTitle]','Email','2011-09-07 16:26:52',0,NULL),(680,76,'zh-Hans','[EmailDialogTitle]','&#30005;&#23376;&#37038;&#20214;','2011-09-07 16:26:52',0,NULL),(681,76,'en','[SkypeDialogTitle]','Skype','2011-09-07 16:26:52',0,NULL),(682,76,'zh-Hans','[SkypeDialogTitle]','Skype','2011-09-07 16:26:52',0,NULL),(683,76,'en','[AddressDialogTitle]','Address','2011-09-07 16:26:52',0,NULL),(684,76,'zh-Hans','[AddressDialogTitle]','&#36890;&#20449;&#22320;&#22336;','2011-09-07 16:26:52',0,NULL),(685,76,'en','[formLabel_altcontact_contact]','User Name','2011-09-07 16:26:52',0,NULL),(686,76,'zh-Hans','[formLabel_altcontact_contact]','&#29992;&#25143;&#21517;','2011-09-07 16:26:52',0,NULL),(687,76,'en','[CI-Q1]','Add phone numbers for family members.','2011-09-07 16:26:52',0,NULL),(688,76,'zh-Hans','[CI-Q1]','&#20026;&#23478;&#24237;&#25104;&#21592;&#28155;&#21152;&#32852;&#31995;&#30005;&#35805;','2011-09-07 16:26:52',0,NULL),(689,76,'en','[CI-Q2]','Add email addresses for family members.','2011-09-07 16:26:52',0,NULL),(690,76,'zh-Hans','[CI-Q2]','&#20026;&#23478;&#24237;&#25104;&#21592;&#28155;&#21152;&#30005;&#37038;&#22320;&#22336;','2011-09-07 16:26:52',0,NULL),(691,76,'en','[CI-Q3]','Add your current physical address and any alternate addresses for your family.','2011-09-07 16:26:52',0,NULL),(692,76,'zh-Hans','[CI-Q3]','&#28155;&#21152;&#24403;&#21069;&#23478;&#24237;&#23621;&#20303;&#22320;&#22336;&#20197;&#21450;&#20219;&#20309;&#20379;&#36873;&#25321;&#30340;&#22320;&#22336;','2011-09-07 16:26:52',0,NULL),(693,76,'en','[CI-Q4]','Add Skype addresses for your family.','2011-09-07 16:26:52',0,NULL),(694,76,'zh-Hans','[CI-Q4]','&#28155;&#21152;&#23478;&#24237;&#25104;&#21592;&#30340;Skype&#22320;&#22336;','2011-09-07 16:26:52',0,NULL),(695,76,'en','[Title_emergency-contact]','Emergency Contact Information','2011-09-07 16:26:52',0,NULL),(696,76,'zh-Hans','[Title_emergency-contact]','&#32039;&#24613;&#20107;&#20214;&#32852;&#31995;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(697,76,'en','[StepTitle_emergency-contact]','Emergency','2011-09-07 16:26:52',0,NULL),(698,76,'zh-Hans','[StepTitle_emergency-contact]','&#32039;&#24613;&#24773;&#20917;','2011-09-07 16:26:52',0,NULL),(699,76,'en','[Description_emergency-contact]','Enter information for someone to contact in case of emergency.','2011-09-07 16:26:52',0,NULL),(700,76,'zh-Hans','[Description_emergency-contact]','&#35831;&#36755;&#20837;&#32039;&#24613;&#24773;&#20917;&#19979;&#32852;&#31995;&#20154;&#30340;&#20449;&#24687;&#12290;','2011-09-07 16:26:52',0,NULL),(701,76,'en','[dialogContactName]','Name of contact','2011-09-07 16:26:52',0,NULL),(702,76,'zh-Hans','[dialogContactName]','&#32852;&#31995;&#20154;&#22995;&#21517;','2011-09-07 16:26:52',0,NULL),(703,76,'en','[dialogRelationship]','Relationship to you','2011-09-07 16:26:52',0,NULL),(704,76,'zh-Hans','[dialogRelationship]','&#19982;&#20320;&#30340;&#20851;&#31995;','2011-09-07 16:26:52',0,NULL),(705,76,'en','[dialogLanguages]','Languages spoken by contact','2011-09-07 16:26:52',0,NULL),(706,76,'zh-Hans','[dialogLanguages]','&#19982;&#32852;&#31995;&#20154;&#27807;&#36890;&#30340;&#35821;&#35328;','2011-09-07 16:26:52',0,NULL),(707,76,'en','[dialogAttitude]','Contact\'s attitude toward CCC','2011-09-07 16:26:52',0,NULL),(708,76,'zh-Hans','[dialogAttitude]','&#32852;&#31995;&#20154;&#23545;&#20844;&#21496;&#30340;&#24577;&#24230;','2011-09-07 16:26:52',0,NULL),(709,76,'en','[dialogSpecialInstructions]','Special Instructions when contacting this person','2011-09-07 16:26:52',0,NULL),(710,76,'zh-Hans','[dialogSpecialInstructions]','&#36319;&#35813;&#20154;&#32852;&#31995;&#26102;&#30340;&#29305;&#27530;&#35828;&#26126;','2011-09-07 16:26:52',0,NULL),(711,76,'en','[EMI-Q1]','Enter the information for someone to contact in case of an emergency.','2011-09-07 16:26:52',0,NULL),(712,76,'zh-Hans','[EMI-Q1]','&#35831;&#36755;&#20837;&#32039;&#24613;&#24773;&#20917;&#19979;&#32852;&#31995;&#20154;&#30340;&#20449;&#24687;&#12290;','2011-09-07 16:26:52',0,NULL),(713,76,'en','[Title_language-education]','Language, Education, and Talents','2011-09-07 16:26:52',0,NULL),(714,76,'zh-Hans','[Title_language-education]','&#35821;&#35328;&#12289;&#25945;&#32946;&#20197;&#21450;&#29305;&#38271;&#24773;&#20917;','2011-09-07 16:26:52',0,NULL),(715,76,'en','[StepTitle_language-education]','Skills','2011-09-07 16:26:52',0,NULL),(716,76,'zh-Hans','[StepTitle_language-education]','&#25216;&#33021;','2011-09-07 16:26:52',0,NULL),(717,76,'en','[Description_language-education]','','2011-09-07 16:26:52',0,NULL),(718,76,'zh-Hans','[Description_language-education]','','2011-09-07 16:26:52',0,NULL),(719,76,'en','[LanguageDialogTitle]','Language Proficiency','2011-09-07 16:26:52',0,NULL),(720,76,'zh-Hans','[LanguageDialogTitle]','&#35821;&#35328;&#29087;&#32451;&#24230;','2011-09-07 16:26:52',0,NULL),(721,76,'en','[formLabel_language_id]','Language','2011-09-07 16:26:52',0,NULL),(722,76,'zh-Hans','[formLabel_language_id]','&#35821;&#35328;','2011-09-07 16:26:52',0,NULL),(723,76,'en','[formLabel_proficiency_id]','Proficiency Level','2011-09-07 16:26:52',0,NULL),(724,76,'zh-Hans','[formLabel_proficiency_id]','&#29087;&#32451;&#31561;&#32423;','2011-09-07 16:26:52',0,NULL),(725,76,'en','[EducationDialogTitle]','Education','2011-09-07 16:26:52',0,NULL),(726,76,'zh-Hans','[EducationDialogTitle]','&#21463;&#25945;&#32946;&#24773;&#20917;','2011-09-07 16:26:52',0,NULL),(727,76,'en','[TalentDialogTitle]','Talent','2011-09-07 16:26:52',0,NULL),(728,76,'zh-Hans','[TalentDialogTitle]','&#29305;&#38271;','2011-09-07 16:26:52',0,NULL),(729,76,'en','[formLabel_talenttype_id]','Talent Type','2011-09-07 16:26:52',0,NULL),(730,76,'zh-Hans','[formLabel_talenttype_id]','&#29305;&#38271;&#31867;&#22411;','2011-09-07 16:26:52',0,NULL),(731,76,'en','[formLabel_talent_comment]','Comment','2011-09-07 16:26:52',0,NULL),(732,76,'zh-Hans','[formLabel_talent_comment]','&#27880;&#37322;','2011-09-07 16:26:52',0,NULL),(733,76,'en','[InterestDialogTitle]','Interest','2011-09-07 16:26:52',0,NULL),(734,76,'zh-Hans','[InterestDialogTitle]','&#20852;&#36259;&#29233;&#22909;','2011-09-07 16:26:52',0,NULL),(735,76,'en','[ESI-Q1]','Enter your language proficiency.','2011-09-07 16:26:52',0,NULL),(736,76,'zh-Hans','[ESI-Q1]','&#36755;&#20837;&#20320;&#30340;&#35821;&#35328;&#29087;&#32451;&#24230;.','2011-09-07 16:26:52',0,NULL),(737,76,'en','[ESI-Q2]','Enter your education background.','2011-09-07 16:26:52',0,NULL),(738,76,'zh-Hans','[ESI-Q2]','&#36755;&#20837;&#20320;&#30340;&#25945;&#32946;&#32972;&#26223;.','2011-09-07 16:26:52',0,NULL),(739,76,'en','[ESI-Q3]','Enter talent(s) for each of your family members.','2011-09-07 16:26:52',0,NULL),(740,76,'zh-Hans','[ESI-Q3]','&#36755;&#20837;&#23478;&#24237;&#25104;&#21592;&#30340;&#29305;&#38271;.','2011-09-07 16:26:52',0,NULL),(741,76,'en','[ESI-Q4]','Enter areas of interest for each of your family members. No experience required.','2011-09-07 16:26:52',0,NULL),(742,76,'zh-Hans','[ESI-Q4]','&#36755;&#20837;&#23478;&#24237;&#25104;&#21592;&#30340;&#20852;&#36259;&#33539;&#22260;&#12290;&#19981;&#38656;&#35201;&#26377;&#32463;&#39564;.','2011-09-07 16:26:52',0,NULL),(743,76,'en','[Title_work1]','Worker Information','2011-09-07 16:26:52',0,NULL),(744,76,'zh-Hans','[Title_work1]','&#24037;&#20316;&#20154;&#21592;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(745,76,'en','[StepTitle_work1]','Work','2011-09-07 16:26:52',0,NULL),(746,76,'zh-Hans','[StepTitle_work1]','&#24037;&#20316;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(747,76,'en','[Description_work1]','Enter information for each of your family members who is a worker.','2011-09-07 16:26:52',0,NULL),(748,76,'zh-Hans','[Description_work1]','&#36755;&#20837;&#23478;&#24237;&#20013;&#24037;&#20316;&#20154;&#21592;&#30340;&#20449;&#24687;.','2011-09-07 16:26:52',0,NULL),(749,76,'en','[Title_work2]','Worker Information Continued','2011-09-07 16:26:52',0,NULL),(750,76,'zh-Hans','[Title_work2]','&#24037;&#20316;&#20154;&#21592;&#20449;&#24687;(&#25509;&#19978;&#39029;)','2011-09-07 16:26:52',0,NULL),(751,76,'en','[StepTitle_work2]','Work cont.','2011-09-07 16:26:52',0,NULL),(752,76,'zh-Hans','[StepTitle_work2]','&#24037;&#20316;&#20449;&#24687;&#32493;','2011-09-07 16:26:52',0,NULL),(753,76,'en','[Description_work2]','Enter information for each of your family members who is a worker.','2011-09-07 16:26:52',0,NULL),(754,76,'zh-Hans','[Description_work2]','&#36755;&#20837;&#23478;&#24237;&#20013;&#24037;&#20316;&#20154;&#21592;&#30340;&#20449;&#24687;.','2011-09-07 16:26:52',0,NULL),(755,76,'en','[StudentQuestion]','Are you enrolled as a student?','2011-09-07 16:26:52',0,NULL),(756,76,'zh-Hans','[StudentQuestion]','&#20197;&#23398;&#29983;&#36523;&#20221;&#21152;&#20837;&#30340;&#65311;','2011-09-07 16:26:52',0,NULL),(757,76,'en','[GovernmentIDQuestion]','If you are Chinese, enter your shenfenzheng number.','2011-09-07 16:26:52',0,NULL),(758,76,'zh-Hans','[GovernmentIDQuestion]','&#22914;&#26524;&#20320;&#26159;&#20013;&#22269;&#20154;&#65292;&#35831;&#36755;&#20837;&#20320;&#30340;&#36523;&#20221;&#35777;&#21495;.','2011-09-07 16:26:52',0,NULL),(759,76,'en','[HukouQuestion]','If you are Chinese, enter your hukou location.','2011-09-07 16:26:52',0,NULL),(760,76,'zh-Hans','[HukouQuestion]','&#22914;&#26524;&#20320;&#26159;&#20013;&#22269;&#20154;&#65292;&#35831;&#36755;&#20837;&#20320;&#30340;&#25143;&#21475;&#25152;&#22312;&#22320;.','2011-09-07 16:26:52',0,NULL),(761,76,'en','[VocationQuestion]','If you are part-time, what is your other vocation?','2011-09-07 16:26:52',0,NULL),(762,76,'zh-Hans','[VocationQuestion]','&#22914;&#26524;&#20320;&#19981;&#26159;&#20840;&#32844;&#30340;&#65292;&#20320;&#21478;&#22806;&#30340;&#32844;&#19994;&#26159;&#20160;&#20040;&#65311;','2011-09-07 16:26:52',0,NULL),(763,76,'en','[TaxQuestion]','If you are an American, are you enrolled in an entity to pay local taxes?','2011-09-07 16:26:52',0,NULL),(764,76,'zh-Hans','[TaxQuestion]','&#22914;&#26524;&#20320;&#26159;&#32654;&#22269;&#20154;&#65292;&#20320;&#26159;&#21542;&#24050;&#22312;&#24403;&#22320;&#30331;&#35760;&#32564;&#31246;&#65311;','2011-09-07 16:26:52',0,NULL),(765,76,'en','[Title_insurance]','Insurance Information','2011-09-07 16:26:52',0,NULL),(766,76,'zh-Hans','[Title_insurance]','&#20445;&#38505;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(767,76,'en','[StepTitle_insurance]','Insurance','2011-09-07 16:26:52',0,NULL),(768,76,'zh-Hans','[StepTitle_insurance]','&#20445;&#38505;','2011-09-07 16:26:52',0,NULL),(769,76,'en','[Description_insurance]','Enter insurance information for your family.','2011-09-07 16:26:52',0,NULL),(770,76,'zh-Hans','[Description_insurance]','&#35831;&#36755;&#20837;&#23478;&#24237;&#30340;&#20445;&#38505;&#20449;&#24687;.','2011-09-07 16:26:52',0,NULL),(771,76,'en','[ContactNameQuestion]','Name of person in CCC to contact for information about this policy','2011-09-07 16:26:52',0,NULL),(772,76,'zh-Hans','[ContactNameQuestion]','&#32852;&#31995;&#20445;&#38505;&#20449;&#24687;&#30340;&#20844;&#21496;&#20869;&#32852;&#31995;&#20154;&#22995;&#21517;','2011-09-07 16:26:52',0,NULL),(773,76,'en','[Title_medical]','Medical Information','2011-09-07 16:26:52',0,NULL),(774,76,'zh-Hans','[Title_medical]','&#20445;&#38505;&#31867;&#22411;','2011-09-07 16:26:52',0,NULL),(775,76,'en','[StepTitle_medical]','Medical','2011-09-07 16:26:52',0,NULL),(776,76,'zh-Hans','[StepTitle_medical]','&#20445;&#38505;','2011-09-07 16:26:52',0,NULL),(777,76,'en','[Description_medical]','Enter medical information for your family members.','2011-09-07 16:26:52',0,NULL),(778,76,'zh-Hans','[Description_medical]','&#35831;&#36755;&#20837;&#23478;&#24237;&#25104;&#21592;&#30340;&#21307;&#30103;&#20449;&#24687;.','2011-09-07 16:26:52',0,NULL),(779,77,'en','[Available]','Available:','2011-09-07 16:26:52',0,NULL),(780,77,'zh-Hans','[Available]','[zh-Hans]Available:','2011-09-07 16:26:52',1,NULL),(781,77,'en','[OnReport]','On Report:','2011-09-07 16:26:52',0,NULL),(782,77,'zh-Hans','[OnReport]','[zh-Hans]On Report:','2011-09-07 16:26:52',1,NULL),(783,77,'en','[Fields]','Fields','2011-09-07 16:26:52',0,NULL),(784,77,'zh-Hans','[Fields]','[zh-Hans]Fields','2011-09-07 16:26:52',1,NULL),(785,77,'en','[SortBy]','Sort By','2011-09-07 16:26:52',0,NULL),(786,77,'zh-Hans','[SortBy]','[zh-Hans]Sort By','2011-09-07 16:26:52',1,NULL),(787,77,'en','[GroupBy]','Group By','2011-09-07 16:26:52',0,NULL),(788,77,'zh-Hans','[GroupBy]','[zh-Hans]Group By','2011-09-07 16:26:52',1,NULL),(789,77,'en','[Chosen]','Chosen Options','2011-09-07 16:26:52',0,NULL),(790,77,'zh-Hans','[Chosen]','[zh-Hans]Chosen Options','2011-09-07 16:26:52',1,NULL),(791,77,'en','[AvailableActions]','Available Actions','2011-09-07 16:26:52',0,NULL),(792,77,'zh-Hans','[AvailableActions]','[zh-Hans]Available Actions','2011-09-07 16:26:52',1,NULL),(793,77,'en','[ActionsAllowed]','Actions Allowed for this role','2011-09-07 16:26:52',0,NULL),(794,77,'zh-Hans','[ActionsAllowed]','[zh-Hans]Actions Allowed for this role','2011-09-07 16:26:52',1,NULL),(795,77,'en','[Actions]','Actions','2011-09-07 16:26:52',0,NULL),(796,77,'zh-Hans','[Actions]','[zh-Hans]Actions','2011-09-07 16:26:52',1,NULL),(797,78,'en','[AvailableActions]','Available Actions','2011-09-07 16:26:52',0,NULL),(798,78,'zh-Hans','[AvailableActions]','[zh-Hans]Available Actions','2011-09-07 16:26:52',1,NULL),(799,78,'en','[ActionsAllowed]','Actions Allowed for this role','2011-09-07 16:26:52',0,NULL),(800,78,'zh-Hans','[ActionsAllowed]','[zh-Hans]Actions Allowed for this role','2011-09-07 16:26:52',1,NULL),(801,78,'en','[Actions]','Actions','2011-09-07 16:26:52',0,NULL),(802,78,'zh-Hans','[Actions]','[zh-Hans]Actions','2011-09-07 16:26:52',1,NULL),(803,79,'en','[SummaryFormTitleRoot]','User Summary','2011-09-07 16:26:52',0,NULL),(804,79,'zh-Hans','[SummaryFormTitleRoot]','用户基本信息','2011-09-07 16:26:52',0,NULL),(805,79,'en','[SummaryFormDesc]','Double click an existing value to edit','2011-09-07 16:26:52',0,NULL),(806,79,'zh-Hans','[SummaryFormDesc]','双击一个值进行编辑','2011-09-07 16:26:52',0,NULL),(807,79,'en','[dialog_submit]','Submit','2011-09-07 16:26:52',0,NULL),(808,79,'zh-Hans','[dialog_submit]','提交','2011-09-07 16:26:52',0,NULL),(809,79,'en','[dialog_cancel]','Cancel','2011-09-07 16:26:52',0,NULL),(810,79,'zh-Hans','[dialog_cancel]','取消','2011-09-07 16:26:52',0,NULL),(811,79,'en','[dialog_delete]','Delete!','2011-09-07 16:26:52',0,NULL),(812,79,'zh-Hans','[dialog_delete]','删除!','2011-09-07 16:26:52',0,NULL),(813,79,'en','[confirm_delete]','Confirm Delete','2011-09-07 16:26:52',0,NULL),(814,79,'zh-Hans','[confirm_delete]','确认删除','2011-09-07 16:26:52',0,NULL),(815,79,'en','[error_required]','Please make sure all the required fields are entered.','2011-09-07 16:26:52',0,NULL),(816,79,'zh-Hans','[error_required]','请确认所有要求的信息已输入.','2011-09-07 16:26:52',0,NULL),(817,79,'en','[cannot_add_more_to]','Cannot add any more to','2011-09-07 16:26:52',0,NULL),(818,79,'zh-Hans','[cannot_add_more_to]','不能再添加更多的信息','2011-09-07 16:26:52',0,NULL),(819,79,'en','[are_you_sure]','Really delete this entry?','2011-09-07 16:26:52',0,NULL),(820,79,'zh-Hans','[are_you_sure]','真要删除该项吗?','2011-09-07 16:26:52',0,NULL),(821,79,'en','[upload_instructions]','Enter the \"type\" and \"description\" for the file you are uploading, and then click the Upload button.','2011-09-07 16:26:52',0,NULL),(822,79,'zh-Hans','[upload_instructions]','请为你上载的文件输入类型和描述信息，然后单击提交按钮。','2011-09-07 16:26:52',0,NULL),(823,79,'en','[required_fields_asterisk]','* required fields','2011-09-07 16:26:52',0,NULL),(824,79,'zh-Hans','[required_fields_asterisk]','*必须','2011-09-07 16:26:52',0,NULL),(825,79,'en','[download]','Download','2011-09-07 16:26:52',0,NULL),(826,79,'zh-Hans','[download]','下载','2011-09-07 16:26:52',0,NULL),(827,79,'en','[toggle_all]','Toggle All','2011-09-07 16:26:52',0,NULL),(828,79,'zh-Hans','[toggle_all]','全部打开/关闭','2011-09-07 16:26:52',0,NULL),(829,79,'en','[requires_approval]','<span class=\'red\'>Changes or additions to this section will be queued for HR approval.</span>','2011-09-07 16:26:52',0,NULL),(830,79,'zh-Hans','[requires_approval]','<span class=\'red\'>对该功能的修改或改进正在等待HR的批准！</span>','2011-09-07 16:26:52',0,NULL),(831,79,'en','[coming_soon]','This function will be added in a later version of HRIS.','2011-09-07 16:26:52',0,NULL),(832,79,'zh-Hans','[coming_soon]','该功能将在以后的版本发布.','2011-09-07 16:26:52',0,NULL),(833,79,'en','[admin_comment]','Admin comment:','2011-09-07 16:26:52',0,NULL),(834,79,'zh-Hans','[admin_comment]','[zh-Hans]Admin comment:','2011-09-07 16:26:52',1,NULL),(835,79,'en','[AccountHeading]','Account Information','2011-09-07 16:26:52',0,NULL),(836,79,'zh-Hans','[AccountHeading]','账户信息','2011-09-07 16:26:52',0,NULL),(837,79,'en','[FamilyAddressHeading]','Address Information','2011-09-07 16:26:52',0,NULL),(838,79,'zh-Hans','[FamilyAddressHeading]','地址信息','2011-09-07 16:26:52',0,NULL),(839,79,'en','[FamilyAssignmentHeading]','Assignment Information','2011-09-07 16:26:52',0,NULL),(840,79,'zh-Hans','[FamilyAssignmentHeading]','事工分配信息','2011-09-07 16:26:52',0,NULL),(841,79,'en','[assignment_instructions]','','2011-09-07 16:26:52',0,NULL),(842,79,'zh-Hans','[assignment_instructions]','[zh-Hans]','2011-09-07 16:26:52',1,NULL),(843,79,'en','[position_instr]','Please select the position taken under this assignment.','2011-09-07 16:26:52',0,NULL),(844,79,'zh-Hans','[position_instr]','[zh-Hans]Please select the position taken under this assignment.','2011-09-07 16:26:52',1,NULL),(845,79,'en','[FamilyAttachmentHeading]','Attachment Information','2011-09-07 16:26:52',0,NULL),(846,79,'zh-Hans','[FamilyAttachmentHeading]','附件信息','2011-09-07 16:26:52',0,NULL),(847,79,'en','[UploadAttachmentHeading]','Upload Attachment','2011-09-07 16:26:52',0,NULL),(848,79,'zh-Hans','[UploadAttachmentHeading]','上传附件','2011-09-07 16:26:52',0,NULL),(849,79,'en','[FamilyDependentHeading]','Dependent Information','2011-09-07 16:26:52',0,NULL),(850,79,'zh-Hans','[FamilyDependentHeading]','受抚养者信息','2011-09-07 16:26:52',0,NULL),(851,79,'en','[FamilyEducationHeading]','Education Information','2011-09-07 16:26:52',0,NULL),(852,79,'zh-Hans','[FamilyEducationHeading]','受教育信息','2011-09-07 16:26:52',0,NULL),(853,79,'en','[FamilyEmailHeading]','Email Information','2011-09-07 16:26:52',0,NULL),(854,79,'zh-Hans','[FamilyEmailHeading]','电子邮件信息','2011-09-07 16:26:52',0,NULL),(855,79,'en','[AltContactHeading]','Skype Information','2011-09-07 16:26:52',0,NULL),(856,79,'zh-Hans','[AltContactHeading]','Skype信息','2011-09-07 16:26:52',0,NULL),(857,79,'en','[FamilyEmergencyContactHeading]','Emergency Contact Information','2011-09-07 16:26:52',0,NULL),(858,79,'zh-Hans','[FamilyEmergencyContactHeading]','紧急情况联系信息','2011-09-07 16:26:52',0,NULL),(859,79,'en','[FamilyMembersHeading]','Family Members','2011-09-07 16:26:52',0,NULL),(860,79,'zh-Hans','[FamilyMembersHeading]','家庭成员','2011-09-07 16:26:52',0,NULL),(861,79,'en','[FamilyInfoHeading]','Family Information','2011-09-07 16:26:52',0,NULL),(862,79,'zh-Hans','[FamilyInfoHeading]','家庭信息','2011-09-07 16:26:52',0,NULL),(863,79,'en','[formLabel_picture]','ID Picture','2011-09-07 16:26:52',0,NULL),(864,79,'zh-Hans','[formLabel_picture]','身份照片','2011-09-07 16:26:52',0,NULL),(865,79,'en','[id_picture_instructions]','Use the <b>Attachments</b> section to add or remove an ID picture','2011-09-07 16:26:52',0,NULL),(866,79,'zh-Hans','[id_picture_instructions]','请使用<b>附件</b>部分来添加或者删除身份照片','2011-09-07 16:26:52',0,NULL),(867,79,'en','[FamilyInsuranceHeading]','Insurance Information','2011-09-07 16:26:52',0,NULL),(868,79,'zh-Hans','[FamilyInsuranceHeading]','保险信息','2011-09-07 16:26:52',0,NULL),(869,79,'en','[insurance_instructions]','The <i>Contact Name</i> and <i>Contact Phone</i> are for a person within the company who knows about the insurance policy.','2011-09-07 16:26:52',0,NULL),(870,79,'zh-Hans','[insurance_instructions]','<i>联系人姓名</i>和<i>联系人电话</i>是公司内部并了解保险政策的人的联系信息。','2011-09-07 16:26:52',0,NULL),(871,79,'en','[FamilyLanguageHeading]','Language Proficiency Information','2011-09-07 16:26:52',0,NULL),(872,79,'zh-Hans','[FamilyLanguageHeading]','语言熟练度信息','2011-09-07 16:26:52',0,NULL),(873,79,'en','[FamilyMedicalHeading]','Medical Information','2011-09-07 16:26:52',0,NULL),(874,79,'zh-Hans','[FamilyMedicalHeading]','医疗信息','2011-09-07 16:26:52',0,NULL),(875,79,'en','[PassportsHeading]','Passport Information','2011-09-07 16:26:52',0,NULL),(876,79,'zh-Hans','[PassportsHeading]','护照信息','2011-09-07 16:26:52',0,NULL),(877,79,'en','[PassportVisaHeading]','Passport Visa Information','2011-09-07 16:26:52',0,NULL),(878,79,'zh-Hans','[PassportVisaHeading]','护照签证信息','2011-09-07 16:26:52',0,NULL),(879,79,'en','[visa_instructions]','Note that the passport needs to be entered first in the <b>Passport</b> section before any visas can be added for it.','2011-09-07 16:26:52',0,NULL),(880,79,'zh-Hans','[visa_instructions]','注意：在输入签证信息之前，需要首先在<b>护照</b>部分，输入护照信息。','2011-09-07 16:26:52',0,NULL),(881,79,'en','[FamilyPhoneHeading]','Phone Information','2011-09-07 16:26:52',0,NULL),(882,79,'zh-Hans','[FamilyPhoneHeading]','电话信息','2011-09-07 16:26:52',0,NULL),(883,79,'en','[TrainingHeading]','Training Information','2011-09-07 16:26:52',0,NULL),(884,79,'zh-Hans','[TrainingHeading]','培训信息','2011-09-07 16:26:52',0,NULL),(885,79,'en','[TalentHeading]','Talent Information','2011-09-07 16:26:52',0,NULL),(886,79,'zh-Hans','[TalentHeading]','特长信息','2011-09-07 16:26:52',0,NULL),(887,79,'en','[WorkerHeading]','Worker Information','2011-09-07 16:26:52',0,NULL),(888,79,'zh-Hans','[WorkerHeading]','事工人员信息','2011-09-07 16:26:52',0,NULL),(889,80,'en','[PersonListTitle]','People','2011-09-07 16:26:52',0,NULL),(890,80,'zh-Hans','[PersonListTitle]','[zh-Hans]People','2011-09-07 16:26:52',1,NULL),(891,80,'en','[GroupListTitle]','Groups','2011-09-07 16:26:52',0,NULL),(892,80,'zh-Hans','[GroupListTitle]','[zh-Hans]Groups','2011-09-07 16:26:52',1,NULL),(893,80,'en','[GroupColHeading]','Group Name','2011-09-07 16:26:52',0,NULL),(894,80,'zh-Hans','[GroupColHeading]','[zh-Hans]Group Name','2011-09-07 16:26:52',1,NULL),(895,80,'en','[PersonSurnameColHeading]','Surname','2011-09-07 16:26:52',0,NULL),(896,80,'zh-Hans','[PersonSurnameColHeading]','[zh-Hans]Surname','2011-09-07 16:26:52',1,NULL),(897,80,'en','[PersonGivenNameColHeading]','Given Name','2011-09-07 16:26:52',0,NULL),(898,80,'zh-Hans','[PersonGivenNameColHeading]','[zh-Hans]Given Name','2011-09-07 16:26:52',1,NULL),(899,80,'en','[PersonFilterText]','Search ... (NOT IMPLEMENTED)','2011-09-07 16:26:52',0,NULL),(900,80,'zh-Hans','[PersonFilterText]','[zh-Hans]Search ... (NOT IMPLEMENTED)','2011-09-07 16:26:52',1,NULL),(901,80,'en','[AddPersonTooltip]','Add a person to HRIS','2011-09-07 16:26:52',0,NULL),(902,80,'zh-Hans','[AddPersonTooltip]','[zh-Hans]Add a person to HRIS','2011-09-07 16:26:52',1,NULL),(903,80,'en','[RemPersonTooltip]','Remove a person from HRIS','2011-09-07 16:26:52',0,NULL),(904,80,'zh-Hans','[RemPersonTooltip]','[zh-Hans]Remove a person from HRIS','2011-09-07 16:26:52',1,NULL),(905,80,'en','[RemoveSelectedPerson]','Delete a Person','2011-09-07 16:26:52',0,NULL),(906,80,'zh-Hans','[RemoveSelectedPerson]','[zh-Hans]Delete a Person','2011-09-07 16:26:52',1,NULL),(907,80,'en','[RemoveSelectedPersonQuestion]','Are you sure you want to delete the selected person?','2011-09-07 16:26:52',0,NULL),(908,80,'zh-Hans','[RemoveSelectedPersonQuestion]','[zh-Hans]Are you sure you want to delete the selected person?','2011-09-07 16:26:52',1,NULL),(909,80,'en','[AddGroupTooltip]','Add a group filter','2011-09-07 16:26:52',0,NULL),(910,80,'zh-Hans','[AddGroupTooltip]','[zh-Hans]Add a group filter','2011-09-07 16:26:52',1,NULL),(911,80,'en','[RemGroupTooltip]','Remove a group filter','2011-09-07 16:26:52',0,NULL),(912,80,'zh-Hans','[RemGroupTooltip]','[zh-Hans]Remove a group filter','2011-09-07 16:26:52',1,NULL),(913,80,'en','[LoadErrorMsg]','Load Error','2011-09-07 16:26:52',0,NULL),(914,80,'zh-Hans','[LoadErrorMsg]','[zh-Hans]Load Error','2011-09-07 16:26:52',1,NULL),(915,80,'en','[LoadExceptionMsg]','Loading Exception','2011-09-07 16:26:52',0,NULL),(916,80,'zh-Hans','[LoadExceptionMsg]','[zh-Hans]Loading Exception','2011-09-07 16:26:52',1,NULL),(917,80,'en','[LoadingMsg]','Loading ...','2011-09-07 16:26:52',0,NULL),(918,80,'zh-Hans','[LoadingMsg]','[zh-Hans]Loading ...','2011-09-07 16:26:52',1,NULL),(919,80,'en','[confirm_delete]','Really delete this?','2011-09-07 16:26:52',0,NULL),(920,80,'zh-Hans','[confirm_delete]','[zh-Hans]Really delete this?','2011-09-07 16:26:52',1,NULL),(921,81,'en','[formLabel_ren_surname]','Surname','2011-09-07 16:26:52',0,NULL),(922,81,'zh-Hans','[formLabel_ren_surname]','[zh-Hans]Surname','2011-09-07 16:26:52',1,NULL),(923,81,'en','[formLabel_ren_givenname]','Given Name','2011-09-07 16:26:52',0,NULL),(924,81,'zh-Hans','[formLabel_ren_givenname]','[zh-Hans]Given Name','2011-09-07 16:26:52',1,NULL),(925,81,'en','[formLabel_ren_birthdate]','Birthdate','2011-09-07 16:26:52',0,NULL),(926,81,'zh-Hans','[formLabel_ren_birthdate]','[zh-Hans]Birthdate','2011-09-07 16:26:52',1,NULL),(927,81,'en','[formLabel_gender_id]','Gender','2011-09-07 16:26:52',0,NULL),(928,81,'zh-Hans','[formLabel_gender_id]','[zh-Hans]Gender','2011-09-07 16:26:52',1,NULL),(929,81,'en','[formLabel_ethnicity_id]','Ethnicity','2011-09-07 16:26:52',0,NULL),(930,81,'zh-Hans','[formLabel_ethnicity_id]','[zh-Hans]Ethnicity','2011-09-07 16:26:52',1,NULL),(931,82,'en','[condition]','Condition','2011-09-07 16:26:52',0,NULL),(932,82,'zh-Hans','[condition]','[zh-Hans]Condition','2011-09-07 16:26:52',1,NULL),(933,82,'en','[rules]','Rules','2011-09-07 16:26:52',0,NULL),(934,82,'zh-Hans','[rules]','[zh-Hans]Rules','2011-09-07 16:26:52',1,NULL),(935,82,'en','[matches]','Matches','2011-09-07 16:26:52',0,NULL),(936,82,'zh-Hans','[matches]','[zh-Hans]Matches','2011-09-07 16:26:52',1,NULL),(937,82,'en','[all]','All','2011-09-07 16:26:52',0,NULL),(938,82,'zh-Hans','[all]','[zh-Hans]All','2011-09-07 16:26:52',1,NULL),(939,82,'en','[any]','Any','2011-09-07 16:26:52',0,NULL),(940,82,'zh-Hans','[any]','[zh-Hans]Any','2011-09-07 16:26:52',1,NULL),(941,82,'en','[title_rule_field]','Field','2011-09-07 16:26:52',0,NULL),(942,82,'zh-Hans','[title_rule_field]','[zh-Hans]Field','2011-09-07 16:26:52',1,NULL),(943,82,'en','[title_rule_condition]','Condition','2011-09-07 16:26:52',0,NULL),(944,82,'zh-Hans','[title_rule_condition]','[zh-Hans]Condition','2011-09-07 16:26:52',1,NULL),(945,82,'en','[title_rule_value]','Value','2011-09-07 16:26:52',0,NULL),(946,82,'zh-Hans','[title_rule_value]','[zh-Hans]Value','2011-09-07 16:26:52',1,NULL),(947,82,'en','[unexpected_error]','Unexpected Error','2011-09-07 16:26:52',0,NULL),(948,82,'zh-Hans','[unexpected_error]','[zh-Hans]Unexpected Error','2011-09-07 16:26:52',1,NULL),(949,82,'en','[invalid_selection]','Invalid Selection','2011-09-07 16:26:52',0,NULL),(950,82,'zh-Hans','[invalid_selection]','[zh-Hans]Invalid Selection','2011-09-07 16:26:52',1,NULL),(951,83,'en','[confirm_delete]','Really delete this?','2011-09-07 16:26:52',0,NULL),(952,83,'zh-Hans','[confirm_delete]','[zh-Hans]Really delete this?','2011-09-07 16:26:52',1,NULL),(953,84,'en','[TestingToolbarTitle]','Testing Tools','2011-09-07 16:26:52',0,NULL),(954,84,'zh-Hans','[TestingToolbarTitle]','&#27979;&#35797;&#24037;&#20855;','2011-09-07 16:26:52',0,NULL),(955,84,'en','[FAQBtnLabel]',' Testing Wiki (Start Here)','2011-09-07 16:26:52',0,NULL),(956,84,'zh-Hans','[FAQBtnLabel]',' Wiki&#27979;&#35797;&#32593;&#31449;(&#20174;&#36825;&#37324;&#24320;&#22987;)','2011-09-07 16:26:52',0,NULL),(957,84,'en','[FAQBtnToolTip]','Information about HRIS testing','2011-09-07 16:26:52',0,NULL),(958,84,'zh-Hans','[FAQBtnToolTip]','HRIS&#27979;&#35797;&#30456;&#20851;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(959,84,'en','[FAQPageTitle]','HRIS Testing Wiki','2011-09-07 16:26:52',0,NULL),(960,84,'zh-Hans','[FAQPageTitle]','HRIS&#27979;&#35797;Wiki','2011-09-07 16:26:52',0,NULL),(961,84,'en','[CreateUserBtnLabel]','Create New User','2011-09-07 16:26:52',0,NULL),(962,84,'zh-Hans','[CreateUserBtnLabel]','&#21019;&#24314;&#26032;&#29992;&#25143;','2011-09-07 16:26:52',0,NULL),(963,84,'en','[CreateUserBtnToolTip]','Create a new HRIS user (using local authentication)','2011-09-07 16:26:52',0,NULL),(964,84,'zh-Hans','[CreateUserBtnToolTip]','&#21019;&#24314;&#26032;&#30340;HRIS&#29992;&#25143;&#65288;&#20351;&#29992;&#26412;&#22320;&#35748;&#35777;&#65289;','2011-09-07 16:26:52',0,NULL),(965,84,'en','[SwitchUserBtnLabel]','Switch User','2011-09-07 16:26:52',0,NULL),(966,84,'zh-Hans','[SwitchUserBtnLabel]','&#20999;&#25442;&#29992;&#25143;','2011-09-07 16:26:52',0,NULL),(967,84,'en','[SwitchUserBtnToolTip]','Log out and log back in as another user','2011-09-07 16:26:52',0,NULL),(968,84,'zh-Hans','[SwitchUserBtnToolTip]','&#27880;&#38144;&#24182;&#21478;&#19968;&#20010;&#29992;&#25143;&#30331;&#24405;','2011-09-07 16:26:52',0,NULL),(969,84,'en','[SendEmailMenuLabel]','Report Bug/Send Email','2011-09-07 16:26:52',0,NULL),(970,84,'zh-Hans','[SendEmailMenuLabel]','&#25253;&#21578;&#31243;&#24207;&#38169;&#35823;/&#21457;&#36865;&#30005;&#37038;','2011-09-07 16:26:52',0,NULL),(971,84,'zh-Hans','[hris_testers]','&#25152;&#26377;HRIS&#27979;&#35797;&#20154;&#21592;','2011-09-07 16:26:52',0,NULL),(972,84,'en','[hris_testers]','[en]&#25152;&#26377;HRIS&#27979;&#35797;&#20154;&#21592;','2011-09-07 16:26:52',1,NULL),(973,84,'en','[CreateUserTitle]','Create New User','2011-09-07 16:26:52',0,NULL),(974,84,'zh-Hans','[CreateUserTitle]','&#21019;&#24314;&#26032;&#29992;&#25143;','2011-09-07 16:26:52',0,NULL),(975,84,'en','[user_id]','User ID','2011-09-07 16:26:52',0,NULL),(976,84,'zh-Hans','[user_id]','&#29992;&#25143;ID','2011-09-07 16:26:52',0,NULL),(977,84,'en','[password]','Password','2011-09-07 16:26:52',0,NULL),(978,84,'zh-Hans','[password]','&#23494;&#30721;','2011-09-07 16:26:52',0,NULL),(979,84,'en','[confirm_password]','Confirm Password','2011-09-07 16:26:52',0,NULL),(980,84,'zh-Hans','[confirm_password]','&#30830;&#35748;&#23494;&#30721;','2011-09-07 16:26:52',0,NULL),(981,84,'en','[preferred_language]','Preferred Language','2011-09-07 16:26:52',0,NULL),(982,84,'zh-Hans','[preferred_language]','&#39318;&#36873;&#35821;&#35328;','2011-09-07 16:26:52',0,NULL),(983,84,'en','[submit]','Create!','2011-09-07 16:26:52',0,NULL),(984,84,'zh-Hans','[submit]','&#21019;&#24314;!','2011-09-07 16:26:52',0,NULL),(985,84,'en','[send_to]','Send To','2011-09-07 16:26:52',0,NULL),(986,84,'zh-Hans','[send_to]','&#21457;&#36865;&#32473;','2011-09-07 16:26:52',0,NULL),(987,84,'en','[from]','From','2011-09-07 16:26:52',0,NULL),(988,84,'zh-Hans','[from]','&#26469;&#33258;','2011-09-07 16:26:52',0,NULL),(989,84,'en','[subject]','Subject','2011-09-07 16:26:52',0,NULL),(990,84,'zh-Hans','[subject]','&#20027;&#39064;','2011-09-07 16:26:52',0,NULL),(991,84,'en','[os]','Operating System','2011-09-07 16:26:52',0,NULL),(992,84,'zh-Hans','[os]','&#25805;&#20316;&#31995;&#32479;','2011-09-07 16:26:52',0,NULL),(993,84,'en','[browser]','Browser','2011-09-07 16:26:52',0,NULL),(994,84,'zh-Hans','[browser]','&#27983;&#35272;&#22120;','2011-09-07 16:26:52',0,NULL),(995,84,'en','[hris_version]','HRIS Version','2011-09-07 16:26:52',0,NULL),(996,84,'zh-Hans','[hris_version]','HRIS&#29256;&#26412;','2011-09-07 16:26:52',0,NULL),(997,84,'en','[message]','Message','2011-09-07 16:26:52',0,NULL),(998,84,'zh-Hans','[message]','&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(999,84,'en','[debug_info]','Debug Info','2011-09-07 16:26:52',0,NULL),(1000,84,'zh-Hans','[debug_info]','&#35843;&#35797;&#20449;&#24687;','2011-09-07 16:26:52',0,NULL),(1001,84,'en','[send]','Send!','2011-09-07 16:26:52',0,NULL),(1002,84,'zh-Hans','[send]','&#21457;&#36865;!','2011-09-07 16:26:52',0,NULL),(1003,84,'en','[email_instructions]','This email form is meant to make it easier for you to communicate to the HRIS development and testing teams. You may of course use your own email software instead. But do try to provide the <i>Operating System,</i> <i>Browser,</i> and <i>HRIS Version</i> information in your email if possible. Bug reports and questions should be sent to Bill Oliver and optionally the test team. Informational messages should be sent to the test team (Bill will get a copy). Thanks!','2011-09-07 16:26:52',0,NULL),(1004,84,'zh-Hans','[email_instructions]','&#21019;&#24314;&#35813;&#30005;&#23376;&#37038;&#20214;&#21457;&#36865;&#39029;&#38754;&#30340;&#30446;&#30340;&#26159;&#20026;&#20102; &#26377;&#21161;&#20320;&#21487;&#33021;&#26041;&#20415;&#30340;&#36319; HRIS&#24320;&#21457;&#20197;&#21450;&#27979;&#35797;&#22242;&#38431;&#27807;&#36890;&#12290;&#20320; &#20063;&#21487;&#20197;&#20351;&#29992;&#33258;&#24049;&#30340;&#37038;&#20214;&#23458;&#25143;&#31471;&#21457; &#36865;&#37038;&#20214;&#65292;&#20294;&#26159;&#20320;&#38656;&#35201;&#22312;&#20320;&#37038;&#20214;&#20013;&#25552;&#20379;&#20197;&#19979;&#20449;&#24687;&#65306; <i>HRIS&#29256;&#26412;</i>&#12289;<i>&#27983;&#35272;&#22120;</i>&#20197;&#21450;<i>&#25805;&#20316;&#31995;&#32479;</i>&#12290;Bug&#25253;&#21578;&#21644;&#38382;&#39064;&#24212;&#35813;&#21457;&#36865;&#32473; Bill Oliver&#65292;&#21487;&#36873;&#25321;&#21457;&#36865;&#32473;&#27979;&#35797;&#22242;&#38431;&#12290;&#36890;&#30693;&#28040;&#24687;&#35831;&#21457;&#36865;&#32473;&#27979;&#35797;&#22242;&#38431; (Bill&#20063;&#20250;&#25910;&#21040;)&#12290;&#35874;&#35874;&#65281;','2011-09-07 16:26:52',0,NULL),(1005,84,'en','[Switcheroo]','Switcheroo','2011-09-07 16:26:52',0,NULL),(1006,84,'zh-Hans','[Switcheroo]','[zh-Hans]Switcheroo','2011-09-07 16:26:52',1,NULL),(1007,84,'en','[tooltipSwitcheroo]','Impersonate another account.','2011-09-07 16:26:52',0,NULL),(1008,84,'zh-Hans','[tooltipSwitcheroo]','[zh-Hans]Impersonate another account.','2011-09-07 16:26:52',1,NULL),(1009,84,'en','[switcherooFakeID]','Impersonate another account.','2011-09-07 16:26:52',0,NULL),(1010,84,'zh-Hans','[switcherooFakeID]','[zh-Hans]Impersonate another account.','2011-09-07 16:26:52',1,NULL),(1011,84,'en','[DoSwitcherooTitle]','Make the Switch.','2011-09-07 16:26:52',0,NULL),(1012,84,'zh-Hans','[DoSwitcherooTitle]','[zh-Hans]Make the Switch.','2011-09-07 16:26:52',1,NULL),(1013,84,'en','[switch]','Switch','2011-09-07 16:26:52',0,NULL),(1014,84,'zh-Hans','[switch]','[zh-Hans]Switch','2011-09-07 16:26:52',1,NULL),(1015,84,'en','[errorNoID]','I need an ID to switch to','2011-09-07 16:26:52',0,NULL),(1016,84,'zh-Hans','[errorNoID]','[zh-Hans]I need an ID to switch to','2011-09-07 16:26:52',1,NULL),(1017,85,'en','[formLabel_assignment_id]','Assignment','2011-09-07 16:26:52',0,NULL),(1018,85,'zh-Hans','[formLabel_assignment_id]','[zh-Hans]Assignment','2011-09-07 16:26:52',1,NULL),(1019,85,'en','[formLabel_assignment_isprimary]','Is primary assignment?','2011-09-07 16:26:52',0,NULL),(1020,85,'zh-Hans','[formLabel_assignment_isprimary]','[zh-Hans]Is primary assignment?','2011-09-07 16:26:52',1,NULL),(1021,85,'en','[title_supervisor_ren_id]','Supervisor','2011-09-07 16:26:52',0,NULL),(1022,85,'zh-Hans','[title_supervisor_ren_id]','监督人','2011-09-07 16:26:52',0,NULL),(1023,85,'en','[title_rptlvl_id]','Reporting Level','2011-09-07 16:26:52',0,NULL),(1024,85,'zh-Hans','[title_rptlvl_id]','报告等级','2011-09-07 16:26:52',0,NULL),(1025,85,'en','[title_mcc_id]','MCC','2011-09-07 16:26:52',0,NULL),(1026,85,'zh-Hans','[title_mcc_id]','MCC','2011-09-07 16:26:52',0,NULL),(1027,85,'en','[title_position_id]','Position','2011-09-07 16:26:52',0,NULL),(1028,85,'zh-Hans','[title_position_id]','职位','2011-09-07 16:26:52',0,NULL),(1029,85,'en','[title_team_id]','Team','2011-09-07 16:26:52',0,NULL),(1030,85,'zh-Hans','[title_team_id]','团队','2011-09-07 16:26:52',0,NULL),(1031,85,'en','[title_assignment_startdate]','Assignment Start Date','2011-09-07 16:26:52',0,NULL),(1032,85,'zh-Hans','[title_assignment_startdate]','开始日期','2011-09-07 16:26:52',0,NULL),(1033,85,'en','[title_assignment_enddate]','Assignment End Date','2011-09-07 16:26:52',0,NULL),(1034,85,'zh-Hans','[title_assignment_enddate]','截止日期','2011-09-07 16:26:52',0,NULL),(1035,85,'en','[title_location_id]','Location','2011-09-07 16:26:52',0,NULL),(1036,85,'zh-Hans','[title_location_id]','地址','2011-09-07 16:26:52',0,NULL),(1037,85,'en','[formLabel_supervisor_ren_id]','Supervisor','2011-09-07 16:26:52',0,NULL),(1038,85,'zh-Hans','[formLabel_supervisor_ren_id]','监督人','2011-09-07 16:26:52',0,NULL),(1039,85,'en','[formLabel_rptlvl_id]','Reporting Level','2011-09-07 16:26:52',0,NULL),(1040,85,'zh-Hans','[formLabel_rptlvl_id]','报告等级','2011-09-07 16:26:52',0,NULL),(1041,85,'en','[formLabel_mcc_id]','MCC','2011-09-07 16:26:52',0,NULL),(1042,85,'zh-Hans','[formLabel_mcc_id]','MCC','2011-09-07 16:26:52',0,NULL),(1043,85,'en','[formLabel_position_id]','Position','2011-09-07 16:26:52',0,NULL),(1044,85,'zh-Hans','[formLabel_position_id]','职位','2011-09-07 16:26:52',0,NULL),(1045,85,'en','[formLabel_team_id]','Team','2011-09-07 16:26:52',0,NULL),(1046,85,'zh-Hans','[formLabel_team_id]','团队','2011-09-07 16:26:52',0,NULL),(1047,85,'en','[formLabel_assignment_startdate]','Assignment Start Date','2011-09-07 16:26:52',0,NULL),(1048,85,'zh-Hans','[formLabel_assignment_startdate]','开始日期','2011-09-07 16:26:52',0,NULL),(1049,85,'en','[formLabel_assignment_enddate]','Assignment End Date','2011-09-07 16:26:52',0,NULL),(1050,85,'zh-Hans','[formLabel_assignment_enddate]','截止日期','2011-09-07 16:26:52',0,NULL),(1051,85,'en','[formLabel_location_id]','Location','2011-09-07 16:26:52',0,NULL),(1052,85,'zh-Hans','[formLabel_location_id]','地址','2011-09-07 16:26:52',0,NULL),(1053,85,'en','[formLabel_team_label]','Team Name','2011-09-07 16:26:52',0,NULL),(1054,85,'zh-Hans','[formLabel_team_label]','[zh-Hans]Team Name','2011-09-07 16:26:52',1,NULL),(1055,85,'en','[formLabel_gmaLocationID]','GMA Location ID','2011-09-07 16:26:52',0,NULL),(1056,85,'zh-Hans','[formLabel_gmaLocationID]','[zh-Hans]GMA Location ID','2011-09-07 16:26:52',1,NULL),(1057,85,'en','[formLabel_team_type]','Team Type','2011-09-07 16:26:52',0,NULL),(1058,85,'zh-Hans','[formLabel_team_type]','[zh-Hans]Team Type','2011-09-07 16:26:52',1,NULL),(1059,85,'en','[team_type_PHYSICAL]','Physical','2011-09-07 16:26:52',0,NULL),(1060,85,'zh-Hans','[team_type_PHYSICAL]','[zh-Hans]Physical','2011-09-07 16:26:52',1,NULL),(1061,85,'en','[formLabel_account_number]','Account Number','2011-09-07 16:26:52',0,NULL),(1062,85,'zh-Hans','[formLabel_account_number]','帐号','2011-09-07 16:26:52',0,NULL),(1063,85,'en','[title_account_number]','Account Number','2011-09-07 16:26:52',0,NULL),(1064,85,'zh-Hans','[title_account_number]','帐号','2011-09-07 16:26:52',0,NULL),(1065,85,'en','[formLabel_account_country]','Country','2011-09-07 16:26:52',0,NULL),(1066,85,'zh-Hans','[formLabel_account_country]','[zh-Hans]Country','2011-09-07 16:26:52',1,NULL),(1067,85,'zh-Hans','[formLabel_country_id]','国家','2011-09-07 16:26:52',0,NULL),(1068,85,'en','[formLabel_country_id]','Country','2011-09-07 16:26:52',0,NULL),(1069,85,'en','[formLabel_account_type]','Type','2011-09-07 16:26:52',0,NULL),(1070,85,'zh-Hans','[formLabel_account_type]','&#31867;&#22411;','2011-09-07 16:26:52',0,NULL),(1071,85,'en','[formLabel_account_isprimary]','Primary Account?','2011-09-07 16:26:52',0,NULL),(1072,85,'zh-Hans','[formLabel_account_isprimary]','首选账户?','2011-09-07 16:26:52',0,NULL),(1073,85,'en','[title_account_isprimary]','Primary Account?','2011-09-07 16:26:52',0,NULL),(1074,85,'zh-Hans','[title_account_isprimary]','首选账户?','2011-09-07 16:26:52',0,NULL),(1075,85,'en','[formLabel_address_street]','Street','2011-09-07 16:26:52',0,NULL),(1076,85,'zh-Hans','[formLabel_address_street]','街道','2011-09-07 16:26:52',0,NULL),(1077,85,'en','[formLabel_addresstype_id]','Address Type','2011-09-07 16:26:52',0,NULL),(1078,85,'zh-Hans','[formLabel_addresstype_id]','地址类型','2011-09-07 16:26:52',0,NULL),(1079,85,'en','[formLabel_address_province]','Province/State','2011-09-07 16:26:52',0,NULL),(1080,85,'zh-Hans','[formLabel_address_province]','省份/州','2011-09-07 16:26:52',0,NULL),(1081,85,'en','[formLabel_address_city]','City','2011-09-07 16:26:52',0,NULL),(1082,85,'zh-Hans','[formLabel_address_city]','城市','2011-09-07 16:26:52',0,NULL),(1083,85,'en','[formLabel_address_postalcode]','Postal Code','2011-09-07 16:26:52',0,NULL),(1084,85,'zh-Hans','[formLabel_address_postalcode]','邮政编码','2011-09-07 16:26:52',0,NULL),(1085,85,'en','[formLabel_altcontact_contact]','User Name','2011-09-07 16:26:52',0,NULL),(1086,85,'zh-Hans','[formLabel_altcontact_contact]','用户名','2011-09-07 16:26:52',0,NULL),(1087,85,'en','[formLabel_attachment_description]','Description','2011-09-07 16:26:52',0,NULL),(1088,85,'zh-Hans','[formLabel_attachment_description]','描述','2011-09-07 16:26:52',0,NULL),(1089,85,'en','[formLabel_attachment_timestamp]','Last Updated','2011-09-07 16:26:52',0,NULL),(1090,85,'zh-Hans','[formLabel_attachment_timestamp]','最近更新日期','2011-09-07 16:26:52',0,NULL),(1091,85,'en','[formLabel_attachment_filename]','File Name','2011-09-07 16:26:52',0,NULL),(1092,85,'zh-Hans','[formLabel_attachment_filename]','文件名','2011-09-07 16:26:52',0,NULL),(1093,85,'en','[formLabel_attachment_access]','Access','2011-09-07 16:26:52',0,NULL),(1094,85,'zh-Hans','[formLabel_attachment_access]','访问权限','2011-09-07 16:26:52',0,NULL),(1095,85,'en','[formLabel_attachmenttype_id]','Type','2011-09-07 16:26:52',0,NULL),(1096,85,'zh-Hans','[formLabel_attachmenttype_id]','类型','2011-09-07 16:26:52',0,NULL),(1097,85,'en','[formLabel_attachment_content]','File','2011-09-07 16:26:52',0,NULL),(1098,85,'zh-Hans','[formLabel_attachment_content]','文件','2011-09-07 16:26:52',0,NULL),(1099,86,'en','[new]','New Pending','2011-09-07 16:26:52',0,NULL),(1100,86,'zh-Hans','[new]','[zh-Hans]New Pending','2011-09-07 16:26:52',1,NULL),(1101,86,'en','[feedback]','Awaiting Feedback','2011-09-07 16:26:52',0,NULL),(1102,86,'zh-Hans','[feedback]','[zh-Hans]Awaiting Feedback','2011-09-07 16:26:52',1,NULL),(1103,86,'en','[approved]','Approved','2011-09-07 16:26:52',0,NULL),(1104,86,'zh-Hans','[approved]','[zh-Hans]Approved','2011-09-07 16:26:52',1,NULL),(1105,86,'en','[rejected]','Rejected','2011-09-07 16:26:52',0,NULL),(1106,86,'zh-Hans','[rejected]','[zh-Hans]Rejected','2011-09-07 16:26:52',1,NULL),(1107,86,'en','[add]','Add','2011-09-07 16:26:52',0,NULL),(1108,86,'zh-Hans','[add]','[zh-Hans]Add','2011-09-07 16:26:52',1,NULL),(1109,86,'en','[edit]','Edit','2011-09-07 16:26:52',0,NULL),(1110,86,'zh-Hans','[edit]','[zh-Hans]Edit','2011-09-07 16:26:52',1,NULL),(1111,86,'en','[delete]','Delete','2011-09-07 16:26:52',0,NULL),(1112,86,'zh-Hans','[delete]','[zh-Hans]Delete','2011-09-07 16:26:52',1,NULL),(1113,86,'en','[title_changegroup_timestamp]','Time stamp','2011-09-07 16:26:52',0,NULL),(1114,86,'zh-Hans','[title_changegroup_timestamp]','[zh-Hans]Time stamp','2011-09-07 16:26:52',1,NULL),(1115,86,'en','[title_changegroup_status]','Status','2011-09-07 16:26:52',0,NULL),(1116,86,'zh-Hans','[title_changegroup_status]','[zh-Hans]Status','2011-09-07 16:26:52',1,NULL),(1117,86,'en','[title_changegroup_requested_id]','Requested by','2011-09-07 16:26:52',0,NULL),(1118,86,'zh-Hans','[title_changegroup_requested_id]','[zh-Hans]Requested by','2011-09-07 16:26:52',1,NULL),(1119,86,'en','[title_changegroup_approver_id]','Approved by','2011-09-07 16:26:52',0,NULL),(1120,86,'zh-Hans','[title_changegroup_approver_id]','[zh-Hans]Approved by','2011-09-07 16:26:52',1,NULL),(1121,86,'en','[title_changegroup_comment]','Comment','2011-09-07 16:26:52',0,NULL),(1122,86,'zh-Hans','[title_changegroup_comment]','[zh-Hans]Comment','2011-09-07 16:26:52',1,NULL),(1123,85,'en','[title_country_id]','Country','2011-09-07 16:26:52',0,NULL),(1124,85,'zh-Hans','[title_country_id]','国家','2011-09-07 16:26:52',0,NULL),(1125,85,'en','[title_country_code]','Country Code','2011-09-07 16:26:52',0,NULL),(1126,85,'zh-Hans','[title_country_code]','[zh-Hans]Country Code','2011-09-07 16:26:52',1,NULL),(1127,85,'en','[formLabel_country_code]','Country Code','2011-09-07 16:26:52',0,NULL),(1128,85,'zh-Hans','[formLabel_country_code]','[zh-Hans]Country Code','2011-09-07 16:26:52',1,NULL),(1129,85,'en','[formLabel_schoolingmethod_id]','Schooling Method','2011-09-07 16:26:52',0,NULL),(1130,85,'zh-Hans','[formLabel_schoolingmethod_id]','教育方式','2011-09-07 16:26:52',0,NULL),(1131,85,'en','[formLabel_degree_id]','Degree','2011-09-07 16:26:52',0,NULL),(1132,85,'zh-Hans','[formLabel_degree_id]','学位','2011-09-07 16:26:52',0,NULL),(1133,85,'en','[formLabel_educationmajor_id]','Major','2011-09-07 16:26:52',0,NULL),(1134,85,'zh-Hans','[formLabel_educationmajor_id]','专业','2011-09-07 16:26:52',0,NULL),(1135,85,'en','[formLabel_education_gradyr]','Graduation Year','2011-09-07 16:26:52',0,NULL),(1136,85,'zh-Hans','[formLabel_education_gradyr]','毕业年份','2011-09-07 16:26:52',0,NULL),(1137,85,'en','[formLabel_education_school]','School','2011-09-07 16:26:52',0,NULL),(1138,85,'zh-Hans','[formLabel_education_school]','学校','2011-09-07 16:26:52',0,NULL),(1139,85,'en','[formLabel_education_comment]','Comment','2011-09-07 16:26:52',0,NULL),(1140,85,'zh-Hans','[formLabel_education_comment]','注释','2011-09-07 16:26:52',0,NULL),(1141,85,'en','[formLabel_email_address]','Email Address','2011-09-07 16:26:52',0,NULL),(1142,85,'zh-Hans','[formLabel_email_address]','电邮地址','2011-09-07 16:26:52',0,NULL),(1143,85,'en','[title_email_address]','Email Address','2011-09-07 16:26:52',0,NULL),(1144,85,'zh-Hans','[title_email_address]','电邮地址','2011-09-07 16:26:52',0,NULL),(1145,85,'en','[formLabel_ec_name]','Name','2011-09-07 16:26:52',0,NULL),(1146,85,'zh-Hans','[formLabel_ec_name]','姓名','2011-09-07 16:26:52',0,NULL),(1147,85,'en','[formLabel_relationship_id]','Relationship','2011-09-07 16:26:52',0,NULL),(1148,85,'zh-Hans','[formLabel_relationship_id]','关系','2011-09-07 16:26:52',0,NULL),(1149,85,'en','[formLabel_attitude_id]','Attitude','2011-09-07 16:26:52',0,NULL),(1150,85,'zh-Hans','[formLabel_attitude_id]','态度','2011-09-07 16:26:52',0,NULL),(1151,85,'en','[formLabel_ec_specialinstructions]','Special Instructions','2011-09-07 16:26:52',0,NULL),(1152,85,'zh-Hans','[formLabel_ec_specialinstructions]','特殊说明','2011-09-07 16:26:52',0,NULL),(1153,85,'en','[formLabel_ec_languagesspoken]','Languages Spoken','2011-09-07 16:26:52',0,NULL),(1154,85,'zh-Hans','[formLabel_ec_languagesspoken]','沟通语言','2011-09-07 16:26:52',0,NULL),(1155,85,'en','[formLabel_ec_address]','Address','2011-09-07 16:26:52',0,NULL),(1156,85,'zh-Hans','[formLabel_ec_address]','邮寄地址','2011-09-07 16:26:52',0,NULL),(1157,85,'en','[formLabel_ec_phone1]','Phone','2011-09-07 16:26:52',0,NULL),(1158,85,'zh-Hans','[formLabel_ec_phone1]','电话','2011-09-07 16:26:52',0,NULL),(1159,85,'en','[formLabel_ec_phone1_type]','Phone Type','2011-09-07 16:26:52',0,NULL),(1160,85,'zh-Hans','[formLabel_ec_phone1_type]','电话类型','2011-09-07 16:26:52',0,NULL),(1161,85,'en','[formLabel_ec_phone2]','Alternate Phone','2011-09-07 16:26:52',0,NULL),(1162,85,'zh-Hans','[formLabel_ec_phone2]','备选电话','2011-09-07 16:26:52',0,NULL),(1163,85,'en','[formLabel_ec_phone2_type]','Alt. Phone Type','2011-09-07 16:26:52',0,NULL),(1164,85,'zh-Hans','[formLabel_ec_phone2_type]','备选电话类型','2011-09-07 16:26:52',0,NULL),(1165,85,'en','[formLabel_ec_email]','Email','2011-09-07 16:26:52',0,NULL),(1166,85,'zh-Hans','[formLabel_ec_email]','电子邮件','2011-09-07 16:26:52',0,NULL),(1167,85,'en','[title_family_id]','id','2011-09-07 16:26:52',0,NULL),(1168,85,'zh-Hans','[title_family_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1169,85,'en','[formLabel_family_id]','id','2011-09-07 16:26:52',0,NULL),(1170,85,'zh-Hans','[formLabel_family_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1171,85,'en','[formLabel_family_anniversary]','Wedding Anniversary (if applicable)','2011-09-07 16:26:52',0,NULL),(1172,85,'zh-Hans','[formLabel_family_anniversary]','结婚周年纪念日(如已婚)','2011-09-07 16:26:52',0,NULL),(1173,85,'en','[title_family_anniversary]','Anniversary','2011-09-07 16:26:52',0,NULL),(1174,85,'zh-Hans','[title_family_anniversary]','&#32467;&#23130;&#21608;&#24180;&#32426;&#24565;&#26085;','2011-09-07 16:26:52',0,NULL),(1175,85,'en','[formLabel_family_isregwithembassy]','Is family registered with home country embassy?','2011-09-07 16:26:52',0,NULL),(1176,85,'zh-Hans','[formLabel_family_isregwithembassy]','家庭是否已在本国大使馆登记？','2011-09-07 16:26:52',0,NULL),(1177,85,'en','[formLabel_insurancetype_id]','Type','2011-09-07 16:26:52',0,NULL),(1178,85,'zh-Hans','[formLabel_insurancetype_id]','类型','2011-09-07 16:26:52',0,NULL),(1179,85,'en','[formLabel_insurance_providername]','Provider Name','2011-09-07 16:26:52',0,NULL),(1180,85,'zh-Hans','[formLabel_insurance_providername]','投保人姓名','2011-09-07 16:26:52',0,NULL),(1181,85,'en','[formLabel_insurance_providerphone]','Provider Phone','2011-09-07 16:26:52',0,NULL),(1182,85,'zh-Hans','[formLabel_insurance_providerphone]','投保人电话','2011-09-07 16:26:52',0,NULL),(1183,85,'en','[formLabel_insurance_policynumber]','Policy Number','2011-09-07 16:26:52',0,NULL),(1184,85,'zh-Hans','[formLabel_insurance_policynumber]','保险单号','2011-09-07 16:26:52',0,NULL),(1185,85,'en','[formLabel_insurance_contactname]','Contact Name','2011-09-07 16:26:52',0,NULL),(1186,85,'zh-Hans','[formLabel_insurance_contactname]','联系人姓名','2011-09-07 16:26:52',0,NULL),(1187,85,'en','[formLabel_insurance_contactphone]','Contact Phone','2011-09-07 16:26:52',0,NULL),(1188,85,'zh-Hans','[formLabel_insurance_contactphone]','联系人电话','2011-09-07 16:26:52',0,NULL),(1189,85,'en','[formLabel_insurance_effectivedate]','Effective Date','2011-09-07 16:26:52',0,NULL),(1190,85,'zh-Hans','[formLabel_insurance_effectivedate]','生效日期','2011-09-07 16:26:52',0,NULL),(1191,85,'en','[formLabel_insurance_expirationdate]','Expiration Date','2011-09-07 16:26:52',0,NULL),(1192,85,'zh-Hans','[formLabel_insurance_expirationdate]','截止日期','2011-09-07 16:26:52',0,NULL),(1193,85,'en','[formLabel_interesttype_id]','Interest Area','2011-09-07 16:26:52',0,NULL),(1194,85,'zh-Hans','[formLabel_interesttype_id]','&#20852;&#36259;&#33539;&#22260;','2011-09-07 16:26:52',0,NULL),(1195,85,'en','[formLabel_interest_comment]','Comment','2011-09-07 16:26:52',0,NULL),(1196,85,'zh-Hans','[formLabel_interest_comment]','&#27880;&#37322;','2011-09-07 16:26:52',0,NULL),(1197,85,'en','[formLabel_bloodtype_id]','Blood Type','2011-09-07 16:26:52',0,NULL),(1198,85,'zh-Hans','[formLabel_bloodtype_id]','血型','2011-09-07 16:26:52',0,NULL),(1199,85,'en','[formLabel_medical_healthissues]','Health Issues','2011-09-07 16:26:52',0,NULL),(1200,85,'zh-Hans','[formLabel_medical_healthissues]','健康问题','2011-09-07 16:26:52',0,NULL),(1201,85,'en','[formLabel_medical_allergies]','Allergies','2011-09-07 16:26:52',0,NULL),(1202,85,'zh-Hans','[formLabel_medical_allergies]','[zh-Hans]Allergies','2011-09-07 16:26:52',1,NULL),(1203,85,'en','[formLabel_passport_id]','Passport','2011-09-07 16:26:52',0,NULL),(1204,85,'zh-Hans','[formLabel_passport_id]','护照','2011-09-07 16:26:52',0,NULL),(1205,85,'en','[title_passport_givenname]','Passport','2011-09-07 16:26:52',0,NULL),(1206,85,'zh-Hans','[title_passport_givenname]','护照','2011-09-07 16:26:52',0,NULL),(1207,85,'en','[formLabel_passport_number]','Number','2011-09-07 16:26:52',0,NULL),(1208,85,'zh-Hans','[formLabel_passport_number]','护照号','2011-09-07 16:26:52',0,NULL),(1209,85,'en','[formLabel_passport_issuedate]','Issue Date','2011-09-07 16:26:52',0,NULL),(1210,85,'zh-Hans','[formLabel_passport_issuedate]','签发日期','2011-09-07 16:26:52',0,NULL),(1211,85,'en','[formLabel_passport_expirationdate]','Expiration Date','2011-09-07 16:26:52',0,NULL),(1212,85,'zh-Hans','[formLabel_passport_expirationdate]','有效日期','2011-09-07 16:26:52',0,NULL),(1213,85,'en','[formLabel_passport_surname]','Passport Surname','2011-09-07 16:26:52',0,NULL),(1214,85,'zh-Hans','[formLabel_passport_surname]','护照姓','2011-09-07 16:26:52',0,NULL),(1215,85,'en','[formLabel_passport_givenname]','Passport Given Name','2011-09-07 16:26:52',0,NULL),(1216,85,'zh-Hans','[formLabel_passport_givenname]','护照名','2011-09-07 16:26:52',0,NULL),(1217,85,'en','[formLabel_visa_passport]','Passport','2011-09-07 16:26:52',0,NULL),(1218,85,'zh-Hans','[formLabel_visa_passport]','护照','2011-09-07 16:26:52',0,NULL),(1219,85,'en','[formLabel_visatype_id]','Visa Type','2011-09-07 16:26:52',0,NULL),(1220,85,'zh-Hans','[formLabel_visatype_id]','签证类型','2011-09-07 16:26:52',0,NULL),(1221,85,'en','[formLabel_rpv_visaexpirationdate]','Expiration','2011-09-07 16:26:52',0,NULL),(1222,85,'zh-Hans','[formLabel_rpv_visaexpirationdate]','签证有效期','2011-09-07 16:26:52',0,NULL),(1223,85,'en','[formLabel_phonetype_id]','Phone Type','2011-09-07 16:26:52',0,NULL),(1224,85,'zh-Hans','[formLabel_phonetype_id]','电话类型','2011-09-07 16:26:52',0,NULL),(1225,85,'en','[formLabel_phone_number]','Phone Number','2011-09-07 16:26:52',0,NULL),(1226,85,'zh-Hans','[formLabel_phone_number]','电话号码','2011-09-07 16:26:52',0,NULL),(1227,85,'en','[formLabel_phone_countrycode]','Country Code','2011-09-07 16:26:52',0,NULL),(1228,85,'zh-Hans','[formLabel_phone_countrycode]','国家代码','2011-09-07 16:26:52',0,NULL),(1229,85,'en','[formLabel_ren_surname]','Surname','2011-09-07 16:26:52',0,NULL),(1230,85,'zh-Hans','[formLabel_ren_surname]','姓氏','2011-09-07 16:26:52',0,NULL),(1231,85,'en','[formLabel_ren_givenname]','Given Name(s)','2011-09-07 16:26:52',0,NULL),(1232,85,'zh-Hans','[formLabel_ren_givenname]','名','2011-09-07 16:26:52',0,NULL),(1233,85,'en','[formLabel_rentype_id]','Person Type','2011-09-07 16:26:52',0,NULL),(1234,85,'zh-Hans','[formLabel_rentype_id]','个人类型','2011-09-07 16:26:52',0,NULL),(1235,85,'en','[formLabel_ren_namecharacters]','Name (Chinese characters)','2011-09-07 16:26:52',0,NULL),(1236,85,'zh-Hans','[formLabel_ren_namecharacters]','中文名','2011-09-07 16:26:52',0,NULL),(1237,85,'en','[formLabel_ren_namepinyin]','Name (Pinyin)','2011-09-07 16:26:52',0,NULL),(1238,85,'zh-Hans','[formLabel_ren_namepinyin]','名字 (拼音)','2011-09-07 16:26:52',0,NULL),(1239,85,'en','[formLabel_ren_preferredname]','Preferred Name','2011-09-07 16:26:52',0,NULL),(1240,85,'zh-Hans','[formLabel_ren_preferredname]','常用名','2011-09-07 16:26:52',0,NULL),(1241,85,'en','[formLabel_ethnicity_id]','Ethnicity','2011-09-07 16:26:52',0,NULL),(1242,85,'zh-Hans','[formLabel_ethnicity_id]','种族','2011-09-07 16:26:52',0,NULL),(1243,85,'en','[formLabel_ren_primarycitizenship]','Primary Citizenship','2011-09-07 16:26:52',0,NULL),(1244,85,'zh-Hans','[formLabel_ren_primarycitizenship]','首选国籍','2011-09-07 16:26:52',0,NULL),(1245,85,'en','[formLabel_ren_birthdate]','Birth Date','2011-09-07 16:26:52',0,NULL),(1246,85,'zh-Hans','[formLabel_ren_birthdate]','出生日期','2011-09-07 16:26:52',0,NULL),(1247,85,'en','[formLabel_gender_id]','Gender','2011-09-07 16:26:52',0,NULL),(1248,85,'zh-Hans','[formLabel_gender_id]','性别','2011-09-07 16:26:52',0,NULL),(1249,85,'en','[formLabel_maritalstatus_id]','Marital Status','2011-09-07 16:26:52',0,NULL),(1250,85,'zh-Hans','[formLabel_maritalstatus_id]','婚姻情况','2011-09-07 16:26:52',0,NULL),(1251,85,'en','[formLabel_ren_preferredlang]','Preferred Language','2011-09-07 16:26:52',0,NULL),(1252,85,'zh-Hans','[formLabel_ren_preferredlang]','[zh-Hans]Preferred Language','2011-09-07 16:26:52',1,NULL),(1253,85,'en','[formLabel_ren_isfamilypoc]','Is Point Of Contact','2011-09-07 16:26:52',0,NULL),(1254,85,'zh-Hans','[formLabel_ren_isfamilypoc]','[zh-Hans]Is Point Of Contact','2011-09-07 16:26:52',1,NULL),(1255,85,'en','[title_ren_guid]','GUID','2011-09-07 16:26:52',0,NULL),(1256,85,'zh-Hans','[title_ren_guid]','[zh-Hans]GUID','2011-09-07 16:26:52',1,NULL),(1257,85,'en','[title_ren_surname]','Surname','2011-09-07 16:26:52',0,NULL),(1258,85,'zh-Hans','[title_ren_surname]','[zh-Hans]Surname','2011-09-07 16:26:52',1,NULL),(1259,85,'en','[title_ren_givenname]','Givenname','2011-09-07 16:26:52',0,NULL),(1260,85,'zh-Hans','[title_ren_givenname]','[zh-Hans]Givenname','2011-09-07 16:26:52',1,NULL),(1261,85,'en','[title_ren_preferredname]','Preferred name','2011-09-07 16:26:52',0,NULL),(1262,85,'zh-Hans','[title_ren_preferredname]','[zh-Hans]Preferred name','2011-09-07 16:26:52',1,NULL),(1263,85,'en','[title_gender_id]','Gender','2011-09-07 16:26:52',0,NULL),(1264,85,'zh-Hans','[title_gender_id]','[zh-Hans]Gender','2011-09-07 16:26:52',1,NULL),(1265,85,'en','[title_ethnicity_id]','Ethnicity','2011-09-07 16:26:52',0,NULL),(1266,85,'zh-Hans','[title_ethnicity_id]','[zh-Hans]Ethnicity','2011-09-07 16:26:52',1,NULL),(1267,85,'en','[title_ren_primarycitizenship]','Citizenship','2011-09-07 16:26:52',0,NULL),(1268,85,'zh-Hans','[title_ren_primarycitizenship]','[zh-Hans]Citizenship','2011-09-07 16:26:52',1,NULL),(1269,85,'en','[title_ren_birthdate]','Birthdate','2011-09-07 16:26:52',0,NULL),(1270,85,'zh-Hans','[title_ren_birthdate]','[zh-Hans]Birthdate','2011-09-07 16:26:52',1,NULL),(1271,85,'en','[title_ren_deathdate]','Death date','2011-09-07 16:26:52',0,NULL),(1272,85,'zh-Hans','[title_ren_deathdate]','[zh-Hans]Death date','2011-09-07 16:26:52',1,NULL),(1273,85,'en','[title_maritalstatus_id]','Marital Status','2011-09-07 16:26:52',0,NULL),(1274,85,'zh-Hans','[title_maritalstatus_id]','[zh-Hans]Marital Status','2011-09-07 16:26:52',1,NULL),(1275,85,'en','[title_statustype_id]','Worker Status','2011-09-07 16:26:52',0,NULL),(1276,85,'zh-Hans','[title_statustype_id]','[zh-Hans]Worker Status','2011-09-07 16:26:52',1,NULL),(1277,85,'en','[title_ren_preferredlang]','Preferred Language','2011-09-07 16:26:52',0,NULL),(1278,85,'zh-Hans','[title_ren_preferredlang]','[zh-Hans]Preferred Language','2011-09-07 16:26:52',1,NULL),(1279,85,'en','[title_renID]','ID','2011-09-07 16:26:52',0,NULL),(1280,85,'zh-Hans','[title_renID]','[zh-Hans]ID','2011-09-07 16:26:52',1,NULL),(1281,85,'en','[title_guid]','GUID','2011-09-07 16:26:52',0,NULL),(1282,85,'zh-Hans','[title_guid]','[zh-Hans]GUID','2011-09-07 16:26:52',1,NULL),(1283,85,'en','[title_familyID]','Family ID','2011-09-07 16:26:52',0,NULL),(1284,85,'zh-Hans','[title_familyID]','[zh-Hans]Family ID','2011-09-07 16:26:52',1,NULL),(1285,85,'en','[title_surname]','Surname','2011-09-07 16:26:52',0,NULL),(1286,85,'zh-Hans','[title_surname]','[zh-Hans]Surname','2011-09-07 16:26:52',1,NULL),(1287,85,'en','[title_givenname]','Given Name','2011-09-07 16:26:52',0,NULL),(1288,85,'zh-Hans','[title_givenname]','[zh-Hans]Given Name','2011-09-07 16:26:52',1,NULL),(1289,85,'en','[title_preferredname]','Preferred Name','2011-09-07 16:26:52',0,NULL),(1290,85,'zh-Hans','[title_preferredname]','[zh-Hans]Preferred Name','2011-09-07 16:26:52',1,NULL),(1291,85,'en','[title_ethnicity]','Ethnicity','2011-09-07 16:26:52',0,NULL),(1292,85,'zh-Hans','[title_ethnicity]','[zh-Hans]Ethnicity','2011-09-07 16:26:52',1,NULL),(1293,85,'en','[title_isfamilypoc]','Family Point of Contact','2011-09-07 16:26:52',0,NULL),(1294,85,'zh-Hans','[title_isfamilypoc]','[zh-Hans]Family Point of Contact','2011-09-07 16:26:52',1,NULL),(1295,85,'en','[title_birthdate]','Birthdate','2011-09-07 16:26:52',0,NULL),(1296,85,'zh-Hans','[title_birthdate]','[zh-Hans]Birthdate','2011-09-07 16:26:52',1,NULL),(1297,85,'en','[title_deathdate]','Death date','2011-09-07 16:26:52',0,NULL),(1298,85,'zh-Hans','[title_deathdate]','[zh-Hans]Death date','2011-09-07 16:26:52',1,NULL),(1299,85,'en','[title_mobilePhone]','Mobile Phone','2011-09-07 16:26:52',0,NULL),(1300,85,'zh-Hans','[title_mobilePhone]','[zh-Hans]Mobile Phone','2011-09-07 16:26:52',1,NULL),(1301,85,'en','[title_homePhone]','Home Phone','2011-09-07 16:26:52',0,NULL),(1302,85,'zh-Hans','[title_homePhone]','[zh-Hans]Home Phone','2011-09-07 16:26:52',1,NULL),(1303,85,'en','[title_primaryAccount]','Primary Account','2011-09-07 16:26:52',0,NULL),(1304,85,'zh-Hans','[title_primaryAccount]','[zh-Hans]Primary Account','2011-09-07 16:26:52',1,NULL),(1305,85,'en','[title_rentype_id]','Ren Type','2011-09-07 16:26:52',0,NULL),(1306,85,'zh-Hans','[title_rentype_id]','[zh-Hans]Ren Type','2011-09-07 16:26:52',1,NULL),(1307,85,'en','[title_gender]','Gender','2011-09-07 16:26:52',0,NULL),(1308,85,'zh-Hans','[title_gender]','[zh-Hans]Gender','2011-09-07 16:26:52',1,NULL),(1309,85,'en','[title_status]','Status','2011-09-07 16:26:52',0,NULL),(1310,85,'zh-Hans','[title_status]','[zh-Hans]Status','2011-09-07 16:26:52',1,NULL),(1311,85,'en','[title_otherAccounts]','Other Accounts','2011-09-07 16:26:52',0,NULL),(1312,85,'zh-Hans','[title_otherAccounts]','[zh-Hans]Other Accounts','2011-09-07 16:26:52',1,NULL),(1313,85,'en','[title_paySystem]','Pay System','2011-09-07 16:26:52',0,NULL),(1314,85,'zh-Hans','[title_paySystem]','[zh-Hans]Pay System','2011-09-07 16:26:52',1,NULL),(1315,85,'en','[title_primaryAccountCountry]','Primary Account Country','2011-09-07 16:26:52',0,NULL),(1316,85,'zh-Hans','[title_primaryAccountCountry]','[zh-Hans]Primary Account Country','2011-09-07 16:26:52',1,NULL),(1317,85,'en','[title_dateJoined]','Date Joined Company','2011-09-07 16:26:52',0,NULL),(1318,85,'zh-Hans','[title_dateJoined]','[zh-Hans]Date Joined Company','2011-09-07 16:26:52',1,NULL),(1319,85,'en','[title_isDependent]','Is a Dependent?','2011-09-07 16:26:52',0,NULL),(1320,85,'zh-Hans','[title_isDependent]','[zh-Hans]Is a Dependent?','2011-09-07 16:26:52',1,NULL),(1321,85,'en','[title_skypeAccount]','Skype Account','2011-09-07 16:26:52',0,NULL),(1322,85,'zh-Hans','[title_skypeAccount]','[zh-Hans]Skype Account','2011-09-07 16:26:52',1,NULL),(1323,85,'en','[title_secureEmail]','Secure Email','2011-09-07 16:26:52',0,NULL),(1324,85,'zh-Hans','[title_secureEmail]','[zh-Hans]Secure Email','2011-09-07 16:26:52',1,NULL),(1325,85,'en','[title_maritalStatus]','Marital Status','2011-09-07 16:26:52',0,NULL),(1326,85,'zh-Hans','[title_maritalStatus]','[zh-Hans]Marital Status','2011-09-07 16:26:52',1,NULL),(1327,85,'en','[title_isPointOfContact]','is Family Point of Contact?','2011-09-07 16:26:52',0,NULL),(1328,85,'zh-Hans','[title_isPointOfContact]','[zh-Hans]is Family Point of Contact?','2011-09-07 16:26:52',1,NULL),(1329,85,'en','[title_assignmentIsPrimary]','is Primary Assignment','2011-09-07 16:26:52',0,NULL),(1330,85,'zh-Hans','[title_assignmentIsPrimary]','[zh-Hans]is Primary Assignment','2011-09-07 16:26:52',1,NULL),(1331,85,'en','[title_assignmentTeam]','Team','2011-09-07 16:26:52',0,NULL),(1332,85,'zh-Hans','[title_assignmentTeam]','[zh-Hans]Team','2011-09-07 16:26:52',1,NULL),(1333,85,'en','[title_assignmentLocation]','Team Location','2011-09-07 16:26:52',0,NULL),(1334,85,'zh-Hans','[title_assignmentLocation]','[zh-Hans]Team Location','2011-09-07 16:26:52',1,NULL),(1335,85,'en','[title_assignmentReportLevel]','Team Report Level','2011-09-07 16:26:52',0,NULL),(1336,85,'zh-Hans','[title_assignmentReportLevel]','[zh-Hans]Team Report Level','2011-09-07 16:26:52',1,NULL),(1337,85,'en','[title_addressLocation]','Address Location','2011-09-07 16:26:52',0,NULL),(1338,85,'zh-Hans','[title_addressLocation]','[zh-Hans]Address Location','2011-09-07 16:26:52',1,NULL),(1339,85,'en','[title_addressType]','Address Type','2011-09-07 16:26:52',0,NULL),(1340,85,'zh-Hans','[title_addressType]','[zh-Hans]Address Type','2011-09-07 16:26:52',1,NULL),(1341,85,'en','[pocYes]','Yes','2011-09-07 16:26:52',0,NULL),(1342,85,'zh-Hans','[pocYes]','[zh-Hans]Yes','2011-09-07 16:26:52',1,NULL),(1343,85,'en','[pocNo]','No','2011-09-07 16:26:52',0,NULL),(1344,85,'zh-Hans','[pocNo]','[zh-Hans]No','2011-09-07 16:26:52',1,NULL),(1345,85,'en','[formLabel_talenttype_id]','Talent Type','2011-09-07 16:26:52',0,NULL),(1346,85,'zh-Hans','[formLabel_talenttype_id]','特长类型','2011-09-07 16:26:52',0,NULL),(1347,85,'en','[formLabel_talent_comment]','Comments','2011-09-07 16:26:52',0,NULL),(1348,85,'zh-Hans','[formLabel_talent_comment]','注释','2011-09-07 16:26:52',0,NULL),(1349,85,'en','[formLabel_ren_id]','Name','2011-09-07 16:26:52',0,NULL),(1350,85,'zh-Hans','[formLabel_ren_id]','姓名','2011-09-07 16:26:52',0,NULL),(1351,85,'en','[formLabel_course_id]','Course','2011-09-07 16:26:52',0,NULL),(1352,85,'zh-Hans','[formLabel_course_id]','课程','2011-09-07 16:26:52',0,NULL),(1353,85,'en','[formLabel_training_startdate]','Start Date','2011-09-07 16:26:52',0,NULL),(1354,85,'zh-Hans','[formLabel_training_startdate]','开始日期','2011-09-07 16:26:52',0,NULL),(1355,85,'en','[formLabel_training_enddate]','Completion Date','2011-09-07 16:26:52',0,NULL),(1356,85,'zh-Hans','[formLabel_training_enddate]','完成日期','2011-09-07 16:26:52',0,NULL),(1357,85,'en','[title_version_id]','id','2011-09-07 16:26:52',0,NULL),(1358,85,'zh-Hans','[title_version_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1359,85,'en','[formLabel_version_id]','id','2011-09-07 16:26:52',0,NULL),(1360,85,'zh-Hans','[formLabel_version_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1361,85,'en','[title_version_num]','id','2011-09-07 16:26:52',0,NULL),(1362,85,'zh-Hans','[title_version_num]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1363,85,'en','[formLabel_version_num]','id','2011-09-07 16:26:52',0,NULL),(1364,85,'zh-Hans','[formLabel_version_num]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1365,85,'en','[title_version_date]','id','2011-09-07 16:26:52',0,NULL),(1366,85,'zh-Hans','[title_version_date]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1367,85,'en','[formLabel_version_date]','id','2011-09-07 16:26:52',0,NULL),(1368,85,'zh-Hans','[formLabel_version_date]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1369,85,'en','[title_version_desc]','desc','2011-09-07 16:26:52',0,NULL),(1370,85,'zh-Hans','[title_version_desc]','[zh-Hans]desc','2011-09-07 16:26:52',1,NULL),(1371,85,'en','[formLabel_version_desc]','desc','2011-09-07 16:26:52',0,NULL),(1372,85,'zh-Hans','[formLabel_version_desc]','[zh-Hans]desc','2011-09-07 16:26:52',1,NULL),(1373,85,'en','[formLabel_sendingregion_id]','Sending Region','2011-09-07 16:26:52',0,NULL),(1374,85,'zh-Hans','[formLabel_sendingregion_id]','差派地区','2011-09-07 16:26:52',0,NULL),(1375,85,'en','[formLabel_worker_acceptancedate]','Acceptance Date','2011-09-07 16:26:52',0,NULL),(1376,85,'zh-Hans','[formLabel_worker_acceptancedate]','接受日期','2011-09-07 16:26:52',0,NULL),(1377,85,'en','[formLabel_worker_datejoinedstaff]','Date Joined Staff','2011-09-07 16:26:52',0,NULL),(1378,85,'zh-Hans','[formLabel_worker_datejoinedstaff]','加入同工日期','2011-09-07 16:26:52',0,NULL),(1379,85,'en','[formLabel_worker_datejoinedchinamin]','Date Joined China Min','2011-09-07 16:26:52',0,NULL),(1380,85,'zh-Hans','[formLabel_worker_datejoinedchinamin]','加入中国事工日期','2011-09-07 16:26:52',0,NULL),(1381,85,'en','[formLabel_worker_dateleftchinamin]','Date Left China Min','2011-09-07 16:26:52',0,NULL),(1382,85,'zh-Hans','[formLabel_worker_dateleftchinamin]','离开中国事工日期','2011-09-07 16:26:52',0,NULL),(1383,85,'en','[formLabel_worker_terminationdate]','Termination Date','2011-09-07 16:26:52',0,NULL),(1384,85,'zh-Hans','[formLabel_worker_terminationdate]','终止日期','2011-09-07 16:26:52',0,NULL),(1385,85,'en','[formLabel_worker_motherattitude]','Mother\'s Attitude','2011-09-07 16:26:52',0,NULL),(1386,85,'zh-Hans','[formLabel_worker_motherattitude]','妈妈态度','2011-09-07 16:26:52',0,NULL),(1387,85,'en','[formLabel_worker_fatherattitude]','Father\'s Attitude','2011-09-07 16:26:52',0,NULL),(1388,85,'zh-Hans','[formLabel_worker_fatherattitude]','爸爸态度','2011-09-07 16:26:52',0,NULL),(1389,85,'en','[formLabel_statustype_id]','Status','2011-09-07 16:26:52',0,NULL),(1390,85,'zh-Hans','[formLabel_statustype_id]','状态','2011-09-07 16:26:52',0,NULL),(1391,85,'en','[formLabel_fundingsource_id]','Funding Source','2011-09-07 16:26:52',0,NULL),(1392,85,'zh-Hans','[formLabel_fundingsource_id]','资金来源','2011-09-07 16:26:52',0,NULL),(1393,85,'en','[formLabel_worker_enrolledasstudent]','Student','2011-09-07 16:26:52',0,NULL),(1394,85,'zh-Hans','[formLabel_worker_enrolledasstudent]','以学生身份加入?','2011-09-07 16:26:52',0,NULL),(1395,85,'en','[formLabel_worker_governmentid]','Shenfenzheng','2011-09-07 16:26:52',0,NULL),(1396,85,'zh-Hans','[formLabel_worker_governmentid]','身份证号','2011-09-07 16:26:52',0,NULL),(1397,85,'en','[formLabel_worker_hukoulocation]','Hukou','2011-09-07 16:26:52',0,NULL),(1398,85,'zh-Hans','[formLabel_worker_hukoulocation]','户口所在地','2011-09-07 16:26:52',0,NULL),(1399,85,'en','[formLabel_worker_vocation]','Vocation','2011-09-07 16:26:52',0,NULL),(1400,85,'zh-Hans','[formLabel_worker_vocation]','职业','2011-09-07 16:26:52',0,NULL),(1401,85,'en','[formLabel_worker_isenrolledfortax]','Enrolled For Tax?','2011-09-07 16:26:52',0,NULL),(1402,85,'zh-Hans','[formLabel_worker_isenrolledfortax]','已登记纳税?','2011-09-07 16:26:52',0,NULL),(1403,85,'en','[formLabel_paysys_id]','Pay System','2011-09-07 16:26:52',0,NULL),(1404,85,'zh-Hans','[formLabel_paysys_id]','支付系统','2011-09-07 16:26:52',0,NULL),(1405,85,'en','[title_sh_id]','id','2011-09-07 16:26:52',0,NULL),(1406,85,'zh-Hans','[title_sh_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1407,85,'en','[formLabel_sh_id]','id','2011-09-07 16:26:52',0,NULL),(1408,85,'zh-Hans','[formLabel_sh_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1409,85,'en','[formLabel_language_id]','Language','2011-09-07 16:26:52',0,NULL),(1410,85,'zh-Hans','[formLabel_language_id]','语言','2011-09-07 16:26:52',0,NULL),(1411,85,'en','[formLabel_proficiency_id]','Proficiency','2011-09-07 16:26:52',0,NULL),(1412,85,'zh-Hans','[formLabel_proficiency_id]','熟练度','2011-09-07 16:26:52',0,NULL),(1413,87,'en','[Admin]','Ability to create and assign permissions to other people.','2011-09-07 16:26:52',0,NULL),(1414,87,'zh-Hans','[Admin]','[zh-Hans]Ability to create and assign permissions to other people.','2011-09-07 16:26:52',1,NULL),(1415,87,'en','[EditRoles]','Ability to create/edit/delete roles','2011-09-07 16:26:52',0,NULL),(1416,87,'zh-Hans','[EditRoles]','[zh-Hans]Ability to create/edit/delete roles','2011-09-07 16:26:52',1,NULL),(1417,87,'en','[title_dro_id]','id','2011-09-07 16:26:52',0,NULL),(1418,87,'zh-Hans','[title_dro_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1419,87,'en','[formLabel_dro_id]','id','2011-09-07 16:26:52',0,NULL),(1420,87,'zh-Hans','[formLabel_dro_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1421,87,'en','[title_dbfield_id]','id','2011-09-07 16:26:52',0,NULL),(1422,87,'zh-Hans','[title_dbfield_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1423,87,'en','[formLabel_dbfield_id]','id','2011-09-07 16:26:52',0,NULL),(1424,87,'zh-Hans','[formLabel_dbfield_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1425,87,'en','[title_role_id]','id','2011-09-07 16:26:52',0,NULL),(1426,87,'zh-Hans','[title_role_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1427,87,'en','[formLabel_role_id]','id','2011-09-07 16:26:52',0,NULL),(1428,87,'zh-Hans','[formLabel_role_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1429,87,'en','[title_optiontype_id]','id','2011-09-07 16:26:52',0,NULL),(1430,87,'zh-Hans','[title_optiontype_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1431,87,'en','[formLabel_optiontype_id]','id','2011-09-07 16:26:52',0,NULL),(1432,87,'zh-Hans','[formLabel_optiontype_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1433,87,'en','[title_roleaction_id]','id','2011-09-07 16:26:52',0,NULL),(1434,87,'zh-Hans','[title_roleaction_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1435,87,'en','[formLabel_roleaction_id]','id','2011-09-07 16:26:52',0,NULL),(1436,87,'zh-Hans','[formLabel_roleaction_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1437,87,'en','[title_action_key]','key','2011-09-07 16:26:52',0,NULL),(1438,87,'zh-Hans','[title_action_key]','[zh-Hans]key','2011-09-07 16:26:52',1,NULL),(1439,87,'en','[formLabel_action_key]','key','2011-09-07 16:26:52',0,NULL),(1440,87,'zh-Hans','[formLabel_action_key]','[zh-Hans]key','2011-09-07 16:26:52',1,NULL),(1441,87,'en','[title_rsv_id]','id','2011-09-07 16:26:52',0,NULL),(1442,87,'zh-Hans','[title_rsv_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1443,87,'en','[formLabel_rsv_id]','id','2011-09-07 16:26:52',0,NULL),(1444,87,'zh-Hans','[formLabel_rsv_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1445,87,'en','[title_access_id]','id','2011-09-07 16:26:52',0,NULL),(1446,87,'zh-Hans','[title_access_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1447,87,'en','[formLabel_access_id]','id','2011-09-07 16:26:52',0,NULL),(1448,87,'zh-Hans','[formLabel_access_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1449,87,'en','[title_filter_id]','id','2011-09-07 16:26:52',0,NULL),(1450,87,'zh-Hans','[title_filter_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1451,87,'en','[formLabel_filter_id]','id','2011-09-07 16:26:52',0,NULL),(1452,87,'zh-Hans','[formLabel_filter_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1453,85,'en','[title_rule_id]','Rule#','2011-09-07 16:26:52',0,NULL),(1454,85,'zh-Hans','[title_rule_id]','[zh-Hans]Rule#','2011-09-07 16:26:52',1,NULL),(1455,85,'en','[formLabel_rule_id]','id','2011-09-07 16:26:52',0,NULL),(1456,85,'zh-Hans','[formLabel_rule_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1457,85,'en','[title_ruleset_id]','Ruleset#','2011-09-07 16:26:52',0,NULL),(1458,85,'zh-Hans','[title_ruleset_id]','[zh-Hans]Ruleset#','2011-09-07 16:26:52',1,NULL),(1459,85,'en','[formLabel_ruleset_id]','id','2011-09-07 16:26:52',0,NULL),(1460,85,'zh-Hans','[formLabel_ruleset_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1461,85,'en','[title_rule_field]','Field','2011-09-07 16:26:52',0,NULL),(1462,85,'zh-Hans','[title_rule_field]','[zh-Hans]Field','2011-09-07 16:26:52',1,NULL),(1463,85,'en','[formLabel_rule_field]','Field','2011-09-07 16:26:52',0,NULL),(1464,85,'zh-Hans','[formLabel_rule_field]','[zh-Hans]Field','2011-09-07 16:26:52',1,NULL),(1465,85,'en','[title_rule_condition]','Condition','2011-09-07 16:26:52',0,NULL),(1466,85,'zh-Hans','[title_rule_condition]','[zh-Hans]Condition','2011-09-07 16:26:52',1,NULL),(1467,85,'en','[formLabel_rule_condition]','Condition','2011-09-07 16:26:52',0,NULL),(1468,85,'zh-Hans','[formLabel_rule_condition]','[zh-Hans]Condition','2011-09-07 16:26:52',1,NULL),(1469,85,'en','[title_rule_value]','Value','2011-09-07 16:26:52',0,NULL),(1470,85,'zh-Hans','[title_rule_value]','[zh-Hans]Value','2011-09-07 16:26:52',1,NULL),(1471,85,'en','[formLabel_rule_value]','Value','2011-09-07 16:26:52',0,NULL),(1472,85,'zh-Hans','[formLabel_rule_value]','[zh-Hans]Value','2011-09-07 16:26:52',1,NULL),(1473,85,'en','[=]','=','2011-09-07 16:26:52',0,NULL),(1474,85,'zh-Hans','[=]','[zh-Hans]=','2011-09-07 16:26:52',1,NULL),(1475,85,'en','[!=]','!=','2011-09-07 16:26:52',0,NULL),(1476,85,'zh-Hans','[!=]','[zh-Hans]!=','2011-09-07 16:26:52',1,NULL),(1477,85,'en','[<]','&lt;','2011-09-07 16:26:52',0,NULL),(1478,85,'zh-Hans','[<]','[zh-Hans]&lt;','2011-09-07 16:26:52',1,NULL),(1479,85,'en','[>]','&gt;','2011-09-07 16:26:52',0,NULL),(1480,85,'zh-Hans','[>]','[zh-Hans]&gt;','2011-09-07 16:26:52',1,NULL),(1481,85,'en','[<=]','&lt;=','2011-09-07 16:26:52',0,NULL),(1482,85,'zh-Hans','[<=]','[zh-Hans]&lt;=','2011-09-07 16:26:52',1,NULL),(1483,85,'en','[>=]','&gt;=','2011-09-07 16:26:52',0,NULL),(1484,85,'zh-Hans','[>=]','[zh-Hans]&gt;=','2011-09-07 16:26:52',1,NULL),(1485,85,'en','[contains]','Contains','2011-09-07 16:26:52',0,NULL),(1486,85,'zh-Hans','[contains]','[zh-Hans]Contains','2011-09-07 16:26:52',1,NULL),(1487,85,'en','[!contains]','Does not contain','2011-09-07 16:26:52',0,NULL),(1488,85,'zh-Hans','[!contains]','[zh-Hans]Does not contain','2011-09-07 16:26:52',1,NULL),(1489,85,'en','[before/after]','Before / After','2011-09-07 16:26:52',0,NULL),(1490,85,'zh-Hans','[before/after]','[zh-Hans]Before / After','2011-09-07 16:26:52',1,NULL),(1491,85,'en','[same as viewer]','Same as viewer','2011-09-07 16:26:52',0,NULL),(1492,85,'zh-Hans','[same as viewer]','[zh-Hans]Same as viewer','2011-09-07 16:26:52',1,NULL),(1493,85,'en','[title_ruleset_label]','label','2011-09-07 16:26:52',0,NULL),(1494,85,'zh-Hans','[title_ruleset_label]','[zh-Hans]label','2011-09-07 16:26:52',1,NULL),(1495,85,'en','[formLabel_ruleset_label]','label','2011-09-07 16:26:52',0,NULL),(1496,85,'zh-Hans','[formLabel_ruleset_label]','[zh-Hans]label','2011-09-07 16:26:52',1,NULL),(1497,85,'en','[title_scope_id]','id','2011-09-07 16:26:52',0,NULL),(1498,85,'zh-Hans','[title_scope_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1499,85,'en','[formLabel_scope_id]','id','2011-09-07 16:26:52',0,NULL),(1500,85,'zh-Hans','[formLabel_scope_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1501,85,'en','[title_report_id]','Report ID','2011-09-07 16:26:52',0,NULL),(1502,85,'zh-Hans','[title_report_id]','[zh-Hans]Report ID','2011-09-07 16:26:52',1,NULL),(1503,85,'en','[formLabel_report_id]','Report ID','2011-09-07 16:26:52',0,NULL),(1504,85,'zh-Hans','[formLabel_report_id]','[zh-Hans]Report ID','2011-09-07 16:26:52',1,NULL),(1505,85,'en','[title_ren_id]','id','2011-09-07 16:26:52',0,NULL),(1506,85,'zh-Hans','[title_ren_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1507,85,'en','[title_report_name]','Report Name','2011-09-07 16:26:52',0,NULL),(1508,85,'zh-Hans','[title_report_name]','[zh-Hans]Report Name','2011-09-07 16:26:52',1,NULL),(1509,85,'en','[formLabel_report_name]','Report Name','2011-09-07 16:26:52',0,NULL),(1510,85,'zh-Hans','[formLabel_report_name]','[zh-Hans]Report Name','2011-09-07 16:26:52',1,NULL),(1511,85,'en','[title_report_type]','Report Type','2011-09-07 16:26:52',0,NULL),(1512,85,'zh-Hans','[title_report_type]','[zh-Hans]Report Type','2011-09-07 16:26:52',1,NULL),(1513,85,'en','[formLabel_report_type]','Report Type','2011-09-07 16:26:52',0,NULL),(1514,85,'zh-Hans','[formLabel_report_type]','[zh-Hans]Report Type','2011-09-07 16:26:52',1,NULL),(1515,85,'en','[title_report_view]','Report View','2011-09-07 16:26:52',0,NULL),(1516,85,'zh-Hans','[title_report_view]','[zh-Hans]Report View','2011-09-07 16:26:52',1,NULL),(1517,85,'en','[formLabel_report_view]','Default Report View','2011-09-07 16:26:52',0,NULL),(1518,85,'zh-Hans','[formLabel_report_view]','[zh-Hans]Default Report View','2011-09-07 16:26:52',1,NULL),(1519,85,'en','[title_report_shareable]','Shareable?','2011-09-07 16:26:52',0,NULL),(1520,85,'zh-Hans','[title_report_shareable]','[zh-Hans]Shareable?','2011-09-07 16:26:52',1,NULL),(1521,85,'en','[formLabel_report_shareable]','Shareable?','2011-09-07 16:26:52',0,NULL),(1522,85,'zh-Hans','[formLabel_report_shareable]','[zh-Hans]Shareable?','2011-09-07 16:26:52',1,NULL),(1523,85,'en','[title_reportfield_id]','id','2011-09-07 16:26:52',0,NULL),(1524,85,'zh-Hans','[title_reportfield_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1525,85,'en','[formLabel_reportfield_id]','id','2011-09-07 16:26:52',0,NULL),(1526,85,'zh-Hans','[formLabel_reportfield_id]','[zh-Hans]id','2011-09-07 16:26:52',1,NULL),(1527,85,'en','[title_reportfield_weight]','Weight','2011-09-07 16:26:52',0,NULL),(1528,85,'zh-Hans','[title_reportfield_weight]','[zh-Hans]Weight','2011-09-07 16:26:52',1,NULL),(1529,85,'en','[formLabel_reportfield_weight]','Weight','2011-09-07 16:26:52',0,NULL),(1530,85,'zh-Hans','[formLabel_reportfield_weight]','[zh-Hans]Weight','2011-09-07 16:26:52',1,NULL),(1531,85,'en','[title_reportfield_type]','Type','2011-09-07 16:26:52',0,NULL),(1532,85,'zh-Hans','[title_reportfield_type]','[zh-Hans]Type','2011-09-07 16:26:52',1,NULL),(1533,85,'en','[formLabel_reportfield_type]','Type','2011-09-07 16:26:52',0,NULL),(1534,85,'zh-Hans','[formLabel_reportfield_type]','[zh-Hans]Type','2011-09-07 16:26:52',1,NULL),(1535,85,'en','[title_reportfield_name]','Field','2011-09-07 16:26:52',0,NULL),(1536,85,'zh-Hans','[title_reportfield_name]','[zh-Hans]Field','2011-09-07 16:26:52',1,NULL),(1537,85,'en','[formLabel_reportfield_name]','Field','2011-09-07 16:26:52',0,NULL),(1538,85,'zh-Hans','[formLabel_reportfield_name]','[zh-Hans]Field','2011-09-07 16:26:52',1,NULL),(1539,1,'','[reset]','[] [reset]',NULL,1,NULL),(1540,1,'','[formLabel_altcontacttype_id]','[] [formLabel_altcontacttype_id]',NULL,1,NULL),(1541,1,'','[required_maritalstatus_id]','[] [required_maritalstatus_id]',NULL,1,NULL),(1542,1,'','[required_viewer_password]','[] [required_viewer_password]',NULL,1,NULL),(1543,1,'','[required_ren_surname]','[] [required_ren_surname]',NULL,1,NULL),(1544,1,'','[required_ren_givenname]','[] [required_ren_givenname]',NULL,1,NULL),(1545,1,'','Actions','[] Actions',NULL,1,NULL),(1546,1,'','Available actions','[] Available actions',NULL,1,NULL),(1547,1,'','Actions allowed for this role','[] Actions allowed for this role',NULL,1,NULL),(1548,1,'','[formLabel_report_sharewith]','[] [formLabel_report_sharewith]',NULL,1,NULL),(1549,0,'en','[TitleViewerList]','Viewer',NULL,1,'/page/test/viewer'),(1550,0,'zh-Hans','[Title]','[cn]Viewer',NULL,1,'/page/test/viewer'),(1551,0,'en','[Delete:]','Delete:',NULL,0,'/site/widget/appdev-list-searchable');
/*!40000 ALTER TABLE `site_multilingual_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_multilingual_language`
--

DROP TABLE IF EXISTS `site_multilingual_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_language` (
  `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `language_code` varchar(10) NOT NULL,
  `language_label` text,
  PRIMARY KEY (`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_language`
--

LOCK TABLES `site_multilingual_language` WRITE;
/*!40000 ALTER TABLE `site_multilingual_language` DISABLE KEYS */;
INSERT INTO `site_multilingual_language` VALUES (1,'en','English'),(2,'zh-Hans','中文');
/*!40000 ALTER TABLE `site_multilingual_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_multilingual_set`
--

DROP TABLE IF EXISTS `site_multilingual_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_set` (
  `set_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `application_id` int(11) unsigned NOT NULL DEFAULT '0',
  `set_key` text NOT NULL,
  PRIMARY KEY (`set_id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_set`
--

LOCK TABLES `site_multilingual_set` WRITE;
/*!40000 ALTER TABLE `site_multilingual_set` DISABLE KEYS */;
INSERT INTO `site_multilingual_set` VALUES (1,1,'multilingual'),(2,1,'Validator'),(3,1,'widgetForm'),(4,1,'WidgetFormHTMLAdmin'),(5,1,'AdminBackupDB'),(6,1,'AdminDeleteBackup'),(7,1,'AdminRestoreBackup'),(8,1,'actionPUXViewForm'),(9,1,'PageAdmin'),(10,1,'pageLogin'),(11,2,'AccountAdd'),(12,2,'AccountUpdate'),(13,2,'AddressListFamilyByRen'),(14,2,'AssignmentListFamilyByRen'),(15,2,'AttachmentListFamilyByRen'),(16,2,'AttachmentUpload'),(17,2,'OneTableService'),(18,2,'DefTableDelete'),(19,2,'DefTableList'),(20,2,'cloneHrisReport'),(21,2,'createHrisReport'),(22,2,'deleteHrisReport'),(23,2,'generateHrisReport'),(24,2,'listHrisReports'),(25,2,'reportLoadFields'),(26,2,'loadHrisReport'),(27,2,'saveHrisReport'),(28,2,'reportUpdateFields'),(29,2,'updateReportWeights'),(30,2,'scopeAddRule'),(31,2,'scopeDeleteFilter'),(32,2,'scopeDeleteRule'),(33,2,'RulesetMatches'),(34,2,'scopeLoadFilter'),(35,2,'scopeLoadRuleset'),(36,2,'scopeSaveFilter'),(37,2,'scopeSaveFilterLabel'),(38,2,'TableList'),(39,2,'TestCreateNewUser'),(40,2,'WorkerAdd'),(41,2,'SaveRole'),(42,2,'AssignmentAdd'),(43,2,'AssignmentList'),(44,2,'HRIS::PanelRoleFilterAssignment'),(45,2,'HRIS::ToolAdminAssignment'),(46,2,'HRIS::PanelAdminFilter'),(47,2,'HRIS::PanelListFilter'),(48,2,'HRIS::ToolAdminFilter'),(49,2,'HRIS::PanelEditRole'),(50,2,'HRIS::ToolAdminRole'),(51,2,'HRIS::ToolFieldUserMarryStaff'),(52,2,'HRIS::ToolFieldUserSummary'),(53,2,'hrisLayout'),(54,2,'HRIS::PanelListDefinitionTables'),(55,2,'HRIS::PanelListTableFields'),(56,2,'HRIS::ToolEditDefinitionFields'),(57,2,'SaveAssignmentTeam'),(58,2,'HRIS::PanelListTeams'),(59,2,'HRIS::PanelTeamEditForm'),(60,2,'ApprovalTool_LoadChangeRequests'),(61,2,'ApprovalTool_SaveChangeRequests'),(62,2,'ApprovalTool_UpdateFamilyRegistration'),(63,2,'HRIS::ToolApproveEntry'),(64,2,'HRIS::PanelApproveRegistration'),(65,2,'HRIS::PanelFilterEntry'),(66,2,'ManageOthers_AddRen'),(67,2,'ManageOthers_CheckUserID'),(68,2,'HRIS::PanelAddRen'),(69,2,'HRIS::PanelGroupEditor'),(70,2,'HRIS::ToolManageOthers'),(71,2,'Reports_BeginFieldEdit'),(72,2,'Reports_SaveFieldEdit'),(73,2,'HRIS::PanelReportFields'),(74,2,'HRIS::PanelReportLists'),(75,2,'HRIS::ToolReports'),(76,2,'HRIS::WizardNewUser'),(77,2,'base_WidgetOptionChooser'),(78,2,'WidgetOptionChooser'),(79,2,'HRIS::WidgetFamilySummary'),(80,2,'HRIS::WidgetGroupPeople'),(81,2,'HRIS::WidgetHTMLSummary'),(82,2,'WidgetScopeEditor'),(83,2,'HRIS::WidgetSearchableList'),(84,2,'WidgetTestingToolbar'),(85,2,'HRIS'),(86,2,'HRISChangeGroup'),(87,2,'HRIS::HRISActionDefinitions');
/*!40000 ALTER TABLE `site_multilingual_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_multilingual_xlation`
--

DROP TABLE IF EXISTS `site_multilingual_xlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_xlation` (
  `xlation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`xlation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_xlation`
--

LOCK TABLES `site_multilingual_xlation` WRITE;
/*!40000 ALTER TABLE `site_multilingual_xlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_multilingual_xlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_page_modules`
--

DROP TABLE IF EXISTS `site_page_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_page_modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_key` varchar(50) NOT NULL DEFAULT '',
  `module_path` text NOT NULL,
  `module_app` varchar(50) NOT NULL DEFAULT '',
  `module_include` varchar(50) NOT NULL DEFAULT '',
  `module_name` varchar(50) NOT NULL DEFAULT '',
  `module_systemAccessFile` varchar(50) NOT NULL DEFAULT '',
  `module_systemAccessObj` varchar(50) NOT NULL DEFAULT '',
  `module_cronFile` varchar(50) NOT NULL DEFAULT '',
  `module_cronObj` varchar(50) NOT NULL DEFAULT '',
  `module_parameters` text NOT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_page_modules`
--

LOCK TABLES `site_page_modules` WRITE;
/*!40000 ALTER TABLE `site_page_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_page_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_perm_actions`
--

DROP TABLE IF EXISTS `site_perm_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_perm_actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action_key` varchar(25) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_perm_actions`
--

LOCK TABLES `site_perm_actions` WRITE;
/*!40000 ALTER TABLE `site_perm_actions` DISABLE KEYS */;
INSERT INTO `site_perm_actions` VALUES (1,'manageViewers');
/*!40000 ALTER TABLE `site_perm_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_perm_role_actions`
--

DROP TABLE IF EXISTS `site_perm_role_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_perm_role_actions` (
  `roleaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL,
  PRIMARY KEY (`roleaction_id`),
  KEY `role_id` (`role_id`),
  KEY `action_id` (`action_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_perm_role_actions`
--

LOCK TABLES `site_perm_role_actions` WRITE;
/*!40000 ALTER TABLE `site_perm_role_actions` DISABLE KEYS */;
INSERT INTO `site_perm_role_actions` VALUES (1,1,1);
/*!40000 ALTER TABLE `site_perm_role_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_perm_roles`
--

DROP TABLE IF EXISTS `site_perm_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_perm_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_label` text NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_perm_roles`
--

LOCK TABLES `site_perm_roles` WRITE;
/*!40000 ALTER TABLE `site_perm_roles` DISABLE KEYS */;
INSERT INTO `site_perm_roles` VALUES (1,'Admin'),(2,'Guest');
/*!40000 ALTER TABLE `site_perm_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_perm_viewer_roles`
--

DROP TABLE IF EXISTS `site_perm_viewer_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_perm_viewer_roles` (
  `viewerroles_id` int(11) NOT NULL AUTO_INCREMENT,
  `viewer_guid` text NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`viewerroles_id`),
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_perm_viewer_roles`
--

LOCK TABLES `site_perm_viewer_roles` WRITE;
/*!40000 ALTER TABLE `site_perm_viewer_roles` DISABLE KEYS */;
INSERT INTO `site_perm_viewer_roles` VALUES (1,'admin',1);
/*!40000 ALTER TABLE `site_perm_viewer_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_searchablefields`
--

DROP TABLE IF EXISTS `site_searchablefields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_searchablefields` (
  `searchablefields_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `searchablefields_fieldname` text NOT NULL,
  `searchablefields_rowmanager_class` text NOT NULL,
  `searchablefields_rowmanager_path` text NOT NULL,
  PRIMARY KEY (`searchablefields_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_searchablefields`
--

LOCK TABLES `site_searchablefields` WRITE;
/*!40000 ALTER TABLE `site_searchablefields` DISABLE KEYS */;
INSERT INTO `site_searchablefields` VALUES (1,'renID','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(2,'guid','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(3,'surname','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(4,'familyID','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(5,'givenname','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(6,'preferredname','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(7,'birthdate','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(8,'deathdate','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(9,'isPointOfContact','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(10,'ren_primarycitizenship','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(11,'rentype_id','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(12,'ren_preferredlang','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(13,'gender','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(14,'ethnicity','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(15,'status','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(16,'maritalStatus','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(17,'mobilePhone','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(18,'homePhone','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(19,'primaryAccount','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(20,'secureEmail','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(21,'skypeAccount','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(22,'isDependent','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(23,'dateJoined','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(24,'assignmentIsPrimary','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(25,'otherAccounts','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(26,'primaryAccountCountry','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(27,'paySystem','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(28,'assignmentTeam','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(29,'assignmentLocation','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(30,'assignmentReportLevel','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(31,'addressLocation','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(32,'addressType','HRISRen','modules/HRIS/objects_bl/HRISRen.php'),(33,'test_lookup','RowManager_TestingSearchableFields',''),(34,'test_droplist','RowManager_TestingSearchableFields',''),(35,'test_text','RowManager_TestingSearchableFields',''),(36,'test_date','RowManager_TestingSearchableFields',''),(37,'rentype_id','RowManager_TestingSearchableFields','');
/*!40000 ALTER TABLE `site_searchablefields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_session`
--

DROP TABLE IF EXISTS `site_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_session` (
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `session_data` text NOT NULL,
  `session_expiration` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_session`
--

LOCK TABLES `site_session` WRITE;
/*!40000 ALTER TABLE `site_session` DISABLE KEYS */;
INSERT INTO `site_session` VALUES ('77324cc9f888a29f20223c152f714e0b','vID|s:1:\"1\";',1315562866);
/*!40000 ALTER TABLE `site_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_settings`
--

DROP TABLE IF EXISTS `site_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_settings` (
  `settings_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `settings_key` text,
  `settings_value` text,
  PRIMARY KEY (`settings_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_settings`
--

LOCK TABLES `site_settings` WRITE;
/*!40000 ALTER TABLE `site_settings` DISABLE KEYS */;
INSERT INTO `site_settings` VALUES (1,'siteDefaultModuleKey','HRIS'),(2,'siteDefaultActionKey','HRIS'),(3,'siteDefaultLanguage','en'),(4,'siteDefaultTheme','default');
/*!40000 ALTER TABLE `site_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_settings_viewer`
--

DROP TABLE IF EXISTS `site_settings_viewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_settings_viewer` (
  `settingsviewer_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `viewer_globalUserID` text,
  `settingsviewer_key` text,
  `settingsviewer_value` text,
  PRIMARY KEY (`settingsviewer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_settings_viewer`
--

LOCK TABLES `site_settings_viewer` WRITE;
/*!40000 ALTER TABLE `site_settings_viewer` DISABLE KEYS */;
INSERT INTO `site_settings_viewer` VALUES (1,'admin','lastViewModule','AC');
/*!40000 ALTER TABLE `site_settings_viewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_viewer`
--

DROP TABLE IF EXISTS `site_viewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_viewer` (
  `viewer_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `language_key` varchar(12) NOT NULL DEFAULT 'en',
  `viewer_userID` text,
  `viewer_passWord` text,
  `viewer_isActive` int(1) NOT NULL DEFAULT '0',
  `viewer_lastLogin` datetime DEFAULT NULL,
  `viewer_globalUserID` text,
  PRIMARY KEY (`viewer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_viewer`
--

LOCK TABLES `site_viewer` WRITE;
/*!40000 ALTER TABLE `site_viewer` DISABLE KEYS */;
INSERT INTO `site_viewer` VALUES (1,'en',NULL,'21232f297a57a5a743894a0e4a801fc3',1,'2011-09-09 17:37:38','admin'),(2,'en',NULL,NULL,1,NULL,'skipper');
/*!40000 ALTER TABLE `site_viewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_viewer_switcheroo`
--

DROP TABLE IF EXISTS `site_viewer_switcheroo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_viewer_switcheroo` (
  `switcheroo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `switcheroo_realID` text,
  `switcheroo_fakeID` text,
  PRIMARY KEY (`switcheroo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_viewer_switcheroo`
--

LOCK TABLES `site_viewer_switcheroo` WRITE;
/*!40000 ALTER TABLE `site_viewer_switcheroo` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_viewer_switcheroo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitecreator_htmlblock`
--

DROP TABLE IF EXISTS `sitecreator_htmlblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitecreator_htmlblock` (
  `htmlblock_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `language_code` varchar(10) NOT NULL,
  `htmlblock_content` text,
  `htmlblock_appkey` text,
  `htmlblock_createdAt` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`htmlblock_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitecreator_htmlblock`
--

LOCK TABLES `sitecreator_htmlblock` WRITE;
/*!40000 ALTER TABLE `sitecreator_htmlblock` DISABLE KEYS */;
/*!40000 ALTER TABLE `sitecreator_htmlblock` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-09-14 13:00:39
