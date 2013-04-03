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
-- Current Database: `live_db2`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `live_db2` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `live_db2`;



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


DROP TABLE IF EXISTS `site_multilingual_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_multilingual_label` (
  `label_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `language_code` varchar(10) NOT NULL,
  `label_key` text,
  `label_label` text,
  `label_lastMod` datetime DEFAULT NULL,
  `label_needs_translation` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `label_path` text,
  PRIMARY KEY (`label_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_multilingual_label`
--

LOCK TABLES `site_multilingual_label` WRITE;
/*!40000 ALTER TABLE `site_multilingual_label` DISABLE KEYS */;
INSERT INTO `site_multilingual_label` VALUES (1,'en','[yes]','Yes','2011-09-07 16:26:31',0,NULL),(2,'zh-Hans','[yes]','是','2011-09-07 16:26:31',0,NULL),(3,'en','[no]','No','2011-09-07 16:26:31',0,NULL),(4,'zh-Hans','[no]','否','2011-09-07 16:26:31',0,NULL),(5,'en','[save]','Save','2011-09-07 16:26:31',0,NULL),(6,'zh-Hans','[save]','‰øùÂ≠ò','2011-09-07 16:26:31',0,NULL),(7,'en','[submit]','Submit','2011-09-07 16:26:31',0,NULL),(8,'zh-Hans','[submit]','[zh-Hans]Submit','2011-09-07 16:26:31',1,NULL),(9,'en','[ok]','OK','2011-09-07 16:26:31',0,NULL),(10,'zh-Hans','[ok]','&#30830;&#23450;','2011-09-07 16:26:31',0,NULL),(11,'en','[cancel]','Cancel','2011-09-07 16:26:31',0,NULL),(12,'zh-Hans','[cancel]','ÂèñÊ∂à','2011-09-07 16:26:31',0,NULL),(13,'en','[close]','Close','2011-09-07 16:26:31',0,NULL),(14,'zh-Hans','[close]','[zh-Hans]Close','2011-09-07 16:26:31',1,NULL),(15,'en','[delete]','Delete','2011-09-07 16:26:31',0,NULL),(16,'zh-Hans','[delete]','&#21024;&#38500;','2011-09-07 16:26:31',0,NULL),(17,'en','[add]','Add','2011-09-07 16:26:31',0,NULL),(18,'zh-Hans','[add]','Ê∑ªÂä†','2011-09-07 16:26:31',0,NULL),(19,'en','[edit]','Edit','2011-09-07 16:26:31',0,NULL),(20,'zh-Hans','[edit]','&#32534;&#36753;','2011-09-07 16:26:31',0,NULL),(21,'en','[error]','Error','2011-09-07 16:26:31',0,NULL),(22,'zh-Hans','[error]','&#38169;&#35823;','2011-09-07 16:26:31',0,NULL),(23,'en','[translation]','Translation','2011-09-07 16:26:31',0,NULL),(24,'zh-Hans','[translation]','[zh-Hans]Translation','2011-09-07 16:26:31',1,NULL),(25,'en','[puxMissingLabels]','Missing Labels','2011-09-07 16:26:31',0,NULL),(26,'zh-Hans','[puxMissingLabels]','[zh-Hans]Missing Labels','2011-09-07 16:26:31',1,NULL),(27,'en','[puxMissingLanguage]','Missing Language','2011-09-07 16:26:31',0,NULL),(28,'zh-Hans','[puxMissingLanguage]','[zh-Hans]Missing Language','2011-09-07 16:26:31',1,NULL),(29,'en','[puxAllLabels]','All Labels','2011-09-07 16:26:31',0,NULL),(30,'zh-Hans','[puxAllLabels]','[zh-Hans]All Labels','2011-09-07 16:26:31',1,NULL),(31,'en','[puxOff]','Off','2011-09-07 16:26:31',0,NULL),(32,'zh-Hans','[puxOff]','[zh-Hans]Off','2011-09-07 16:26:31',1,NULL),(123,'en','[formLabel_userID]','Username','2011-09-07 16:26:31',0,'/page/site/login'),(124,'zh-Hans','[formLabel_userID]','&#29992;&#25143;&#21517;','2011-09-07 16:26:31',0,'/page/site/login'),(125,'en','[formLabel_pWord]','Password','2011-09-07 16:26:31',0,'/page/site/login'),(126,'zh-Hans','[formLabel_pWord]','&#23494;&#30721;','2011-09-07 16:26:31',0,'/page/site/login'),(127,'en','[login]','Login','2011-09-07 16:26:31',0,'/page/site/login'),(128,'zh-Hans','[login]','&#30331;&#24405;','2011-09-07 16:26:31',0,'/page/site/login'),(129,'en','[submit]','Submit','2011-09-07 16:26:31',0,'/page/site/login'),(130,'zh-Hans','[submit]','&#25552;&#20132;','2011-09-07 16:26:31',0,'/page/site/login'),(1549,'en','[TitleViewerList]','Viewer',NULL,1,'/page/test/viewer'),(1550,'zh-Hans','[Title]','[cn]Viewer',NULL,1,'/page/test/viewer'),(1551,'en','[Delete:]','Delete:',NULL,0,'/site/widget/appdev-list-searchable');
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
INSERT INTO `site_viewer` VALUES (1,'en','21232f297a57a5a743894a0e4a801fc3',1,'2011-09-09 17:37:38','admin'),(2,'en',NULL,1,NULL,'skipper');
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

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-09-14 13:00:39
