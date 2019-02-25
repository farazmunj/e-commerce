-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: system_core
-- ------------------------------------------------------
-- Server version	5.7.25-1

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
-- Table structure for table `Basket`
--

DROP TABLE IF EXISTS `Basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Basket` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(45) CHARACTER SET latin1 NOT NULL,
  `productId` int(10) unsigned NOT NULL,
  `quantity` double(10,2) NOT NULL DEFAULT '0.00',
  `unitPrice` double(10,2) NOT NULL DEFAULT '0.00',
  `total` double(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Basket`
--

LOCK TABLES `Basket` WRITE;
/*!40000 ALTER TABLE `Basket` DISABLE KEYS */;
/*!40000 ALTER TABLE `Basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BasketDiscount`
--

DROP TABLE IF EXISTS `BasketDiscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BasketDiscount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `total` double(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BasketDiscount`
--

LOCK TABLES `BasketDiscount` WRITE;
/*!40000 ALTER TABLE `BasketDiscount` DISABLE KEYS */;
/*!40000 ALTER TABLE `BasketDiscount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DiscountType`
--

DROP TABLE IF EXISTS `DiscountType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DiscountType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf16 NOT NULL,
  `key` char(2) CHARACTER SET utf16 NOT NULL,
  `formatString` varchar(45) COLLATE utf16_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `key_UNIQUE` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DiscountType`
--

LOCK TABLES `DiscountType` WRITE;
/*!40000 ALTER TABLE `DiscountType` DISABLE KEYS */;
INSERT INTO `DiscountType` VALUES (1,'Quanity % discount','p','Buy {quantity}, get {quantity}% discount'),(2,'Quantity discount','d','Buy {quantity}, get {quantity} free'),(3,'quantity for fix price','f','Buy {quantity} for {quantity}');
/*!40000 ALTER TABLE `DiscountType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group`
--

DROP TABLE IF EXISTS `Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf16 NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group`
--

LOCK TABLES `Group` WRITE;
/*!40000 ALTER TABLE `Group` DISABLE KEYS */;
INSERT INTO `Group` VALUES (1,'Biscuits',1),(2,'USB cable ',1),(3,'Cerials',1),(4,'Fruits',1);
/*!40000 ALTER TABLE `Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupDiscount`
--

DROP TABLE IF EXISTS `GroupDiscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupDiscount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discountTypeId` int(10) unsigned NOT NULL,
  `groupId` int(10) unsigned NOT NULL,
  `name` varchar(45) CHARACTER SET utf16 DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_GroupDiscount_1_idx` (`discountTypeId`),
  KEY `fk_GroupDiscount_group_idx` (`groupId`),
  CONSTRAINT `fk_GroupDiscount_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_GroupDiscount_type` FOREIGN KEY (`discountTypeId`) REFERENCES `DiscountType` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupDiscount`
--

LOCK TABLES `GroupDiscount` WRITE;
/*!40000 ALTER TABLE `GroupDiscount` DISABLE KEYS */;
INSERT INTO `GroupDiscount` VALUES (1,2,1,'Buy two, get one free',1),(2,3,2,'3 for 10 NOK',1);
/*!40000 ALTER TABLE `GroupDiscount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupDiscountQty`
--

DROP TABLE IF EXISTS `GroupDiscountQty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupDiscountQty` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `GroupDiscountId` int(10) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `discount` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_GroupDiscountQty_group_idx` (`GroupDiscountId`),
  CONSTRAINT `fk_GroupDiscountQty_group` FOREIGN KEY (`GroupDiscountId`) REFERENCES `GroupDiscount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupDiscountQty`
--

LOCK TABLES `GroupDiscountQty` WRITE;
/*!40000 ALTER TABLE `GroupDiscountQty` DISABLE KEYS */;
INSERT INTO `GroupDiscountQty` VALUES (1,1,3,1.00),(2,2,3,10.00);
/*!40000 ALTER TABLE `GroupDiscountQty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupProduct`
--

DROP TABLE IF EXISTS `GroupProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupProduct` (
  `groupId` int(10) unsigned NOT NULL,
  `productId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`groupId`,`productId`),
  KEY `fk_GroupProduct_product_idx` (`productId`),
  CONSTRAINT `fk_GroupProduct_group` FOREIGN KEY (`groupId`) REFERENCES `Group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_GroupProduct_product` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupProduct`
--

LOCK TABLES `GroupProduct` WRITE;
/*!40000 ALTER TABLE `GroupProduct` DISABLE KEYS */;
INSERT INTO `GroupProduct` VALUES (1,1),(1,2),(2,3),(2,4),(2,5),(2,6),(1,7),(3,8),(4,9);
/*!40000 ALTER TABLE `GroupProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf16 NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `unitId` int(10) unsigned NOT NULL,
  `price` double(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_Product_unit_idx` (`unitId`),
  CONSTRAINT `fk_Product_unit` FOREIGN KEY (`unitId`) REFERENCES `ProductUnit` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'biscuits chocolate',1,3,1.10),(2,'biscuits strassburger',1,3,1.10),(3,'usb cable Type A',1,1,4.00),(4,'usb cable Mini A',1,1,4.00),(5,'usb cable Micro A',1,1,4.00),(6,'usb cable Type-C',1,1,4.00),(7,'Caramel Sandwich Biscuits',1,3,1.10),(8,'Rice',1,2,19.90),(9,'apple',1,2,1.69);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductDiscount`
--

DROP TABLE IF EXISTS `ProductDiscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductDiscount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discountTypeId` int(10) unsigned NOT NULL,
  `productId` int(10) unsigned NOT NULL,
  `name` varchar(45) CHARACTER SET utf16 DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_ProductDiscount_product_idx` (`productId`),
  KEY `fk_ProductDiscount_type_idx` (`discountTypeId`),
  CONSTRAINT `fk_ProductDiscount_product` FOREIGN KEY (`productId`) REFERENCES `Product` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_ProductDiscount_type` FOREIGN KEY (`discountTypeId`) REFERENCES `DiscountType` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductDiscount`
--

LOCK TABLES `ProductDiscount` WRITE;
/*!40000 ALTER TABLE `ProductDiscount` DISABLE KEYS */;
INSERT INTO `ProductDiscount` VALUES (1,3,9,'Apple Discount',1);
/*!40000 ALTER TABLE `ProductDiscount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductDiscountQty`
--

DROP TABLE IF EXISTS `ProductDiscountQty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductDiscountQty` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `productDiscountId` int(10) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `discount` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_GroupDiscountQty_group0_idx` (`productDiscountId`),
  CONSTRAINT `fk_GroupDiscountQty_group0` FOREIGN KEY (`productDiscountId`) REFERENCES `ProductDiscount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductDiscountQty`
--

LOCK TABLES `ProductDiscountQty` WRITE;
/*!40000 ALTER TABLE `ProductDiscountQty` DISABLE KEYS */;
INSERT INTO `ProductDiscountQty` VALUES (1,1,2,3.00);
/*!40000 ALTER TABLE `ProductDiscountQty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductUnit`
--

DROP TABLE IF EXISTS `ProductUnit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductUnit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf16 NOT NULL,
  `multiply` double(10,2) NOT NULL DEFAULT '1.00',
  `symbol` varchar(10) COLLATE utf16_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductUnit`
--

LOCK TABLES `ProductUnit` WRITE;
/*!40000 ALTER TABLE `ProductUnit` DISABLE KEYS */;
INSERT INTO `ProductUnit` VALUES (1,'default',1.00,'default'),(2,'Kg',0.01,'Kg'),(3,'gram',0.10,'g'),(4,'box',1.00,'box');
/*!40000 ALTER TABLE `ProductUnit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-25 23:22:27
