-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_test
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_carts`
--

DROP TABLE IF EXISTS `tb_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_carts` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int NOT NULL,
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_cart_user` (`user_ID`),
  CONSTRAINT `tb_carts_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_carts_ai` AFTER INSERT ON `tb_carts` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_carts', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_carts: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_carts_au` AFTER UPDATE ON `tb_carts` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_carts', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_carts: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_carts_ad` AFTER DELETE ON `tb_carts` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_carts', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_carts: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_logs`
--

DROP TABLE IF EXISTS `tb_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `table_name` varchar(50) NOT NULL,
  `operation` varchar(20) NOT NULL,
  `db_user` varchar(100) NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `record_id` varchar(150) DEFAULT NULL,
  `description` text NOT NULL,
  `operation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation_status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `idx_logs_table_record` (`table_name`,`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76429 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_order_cancellations`
--

DROP TABLE IF EXISTS `tb_order_cancellations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_order_cancellations` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `user_ID` int NOT NULL,
  `reason` text NOT NULL,
  `cancellation_status` enum('Requested','Approved','Rejected') NOT NULL DEFAULT 'Requested',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_oc_order` (`order_ID`),
  KEY `idx_oc_user` (`user_ID`),
  CONSTRAINT `fk_oc_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `fk_oc_user` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_order_cancellations_ai` AFTER INSERT ON `tb_order_cancellations` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_order_cancellations', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_order_cancellations: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('cancellation_status=', IFNULL(NEW.`cancellation_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_order_cancellations_au` AFTER UPDATE ON `tb_order_cancellations` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_order_cancellations', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_order_cancellations: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('cancellation_status (antes)=', IFNULL(OLD.`cancellation_status`, 'NULL'), '; cancellation_status (despues)=', IFNULL(NEW.`cancellation_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_order_cancellations_ad` AFTER DELETE ON `tb_order_cancellations` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_order_cancellations', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_order_cancellations: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('cancellation_status=', IFNULL(OLD.`cancellation_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_orders`
--

DROP TABLE IF EXISTS `tb_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_orders` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `buyer_ID` int NOT NULL,
  `address_ID` bigint unsigned NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `shipping_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `order_status` enum('Pending','Processing','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_order_number` (`order_number`),
  KEY `idx_orders_buyer` (`buyer_ID`),
  KEY `idx_orders_address` (`address_ID`),
  CONSTRAINT `fk_orders_address` FOREIGN KEY (`address_ID`) REFERENCES `tb_user_addresses` (`ID`),
  CONSTRAINT `fk_orders_buyer` FOREIGN KEY (`buyer_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_orders_ai` AFTER INSERT ON `tb_orders` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_orders', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.buyer_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_orders: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('buyer_ID=', IFNULL(NEW.`buyer_ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('order_number=', IFNULL(NEW.`order_number`, 'NULL')), '; ', CONCAT('total_amount=', IFNULL(NEW.`total_amount`, 'NULL')), '; ', CONCAT('order_status=', IFNULL(NEW.`order_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_orders_au` AFTER UPDATE ON `tb_orders` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_orders', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.buyer_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_orders: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('buyer_ID (antes)=', IFNULL(OLD.`buyer_ID`, 'NULL'), '; buyer_ID (despues)=', IFNULL(NEW.`buyer_ID`, 'NULL')), '; ', CONCAT('address_ID (antes)=', IFNULL(OLD.`address_ID`, 'NULL'), '; address_ID (despues)=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('order_number (antes)=', IFNULL(OLD.`order_number`, 'NULL'), '; order_number (despues)=', IFNULL(NEW.`order_number`, 'NULL')), '; ', CONCAT('total_amount (antes)=', IFNULL(OLD.`total_amount`, 'NULL'), '; total_amount (despues)=', IFNULL(NEW.`total_amount`, 'NULL')), '; ', CONCAT('order_status (antes)=', IFNULL(OLD.`order_status`, 'NULL'), '; order_status (despues)=', IFNULL(NEW.`order_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_orders_ad` AFTER DELETE ON `tb_orders` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_orders', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.buyer_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_orders: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('buyer_ID=', IFNULL(OLD.`buyer_ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(OLD.`address_ID`, 'NULL')), '; ', CONCAT('order_number=', IFNULL(OLD.`order_number`, 'NULL')), '; ', CONCAT('total_amount=', IFNULL(OLD.`total_amount`, 'NULL')), '; ', CONCAT('order_status=', IFNULL(OLD.`order_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_payment_methods`
--

DROP TABLE IF EXISTS `tb_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payment_methods` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_method_type_ID` int unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_pm_type` (`payment_method_type_ID`),
  CONSTRAINT `fk_pm_type` FOREIGN KEY (`payment_method_type_ID`) REFERENCES `tbc_payment_methods_types` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payment_methods_ai` AFTER INSERT ON `tb_payment_methods` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_methods', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('name=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('provider=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payment_methods_au` AFTER UPDATE ON `tb_payment_methods` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_methods', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_payment_methods: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID (antes)=', IFNULL(OLD.`payment_method_type_ID`, 'NULL'), '; payment_method_type_ID (despues)=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('name (antes)=', IFNULL(OLD.`name`, 'NULL'), '; name (despues)=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('provider (antes)=', IFNULL(OLD.`provider`, 'NULL'), '; provider (despues)=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payment_methods_ad` AFTER DELETE ON `tb_payment_methods` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_methods', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(OLD.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('name=', IFNULL(OLD.`name`, 'NULL')), '; ', CONCAT('provider=', IFNULL(OLD.`provider`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_payment_transaction`
--

DROP TABLE IF EXISTS `tb_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payment_transaction` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_ID` int unsigned NOT NULL,
  `gateway_transaction_id` varchar(150) DEFAULT NULL,
  `gateway_status` varchar(50) NOT NULL,
  `gateway_response` json DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_pt_payment` (`payment_ID`),
  CONSTRAINT `fk_pt_payment` FOREIGN KEY (`payment_ID`) REFERENCES `tb_payments` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payment_transaction_ai` AFTER INSERT ON `tb_payment_transaction` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_transaction', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_payment_transaction: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('gateway_status=', IFNULL(NEW.`gateway_status`, 'NULL')), '; ', CONCAT('amount=', IFNULL(NEW.`amount`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payment_transaction_au` AFTER UPDATE ON `tb_payment_transaction` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_transaction', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_payment_transaction: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID (antes)=', IFNULL(OLD.`payment_ID`, 'NULL'), '; payment_ID (despues)=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('gateway_status (antes)=', IFNULL(OLD.`gateway_status`, 'NULL'), '; gateway_status (despues)=', IFNULL(NEW.`gateway_status`, 'NULL')), '; ', CONCAT('amount (antes)=', IFNULL(OLD.`amount`, 'NULL'), '; amount (despues)=', IFNULL(NEW.`amount`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payment_transaction_ad` AFTER DELETE ON `tb_payment_transaction` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_transaction', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_payment_transaction: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(OLD.`payment_ID`, 'NULL')), '; ', CONCAT('gateway_status=', IFNULL(OLD.`gateway_status`, 'NULL')), '; ', CONCAT('amount=', IFNULL(OLD.`amount`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_payments`
--

DROP TABLE IF EXISTS `tb_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payments` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `payment_method_ID` int unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'MXN',
  `payment_status` enum('Pending','Completed','Failed','Refunded') NOT NULL DEFAULT 'Pending',
  `payment_date` datetime DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_payments_order` (`order_ID`),
  KEY `idx_payments_method` (`payment_method_ID`),
  CONSTRAINT `fk_payments_method` FOREIGN KEY (`payment_method_ID`) REFERENCES `tb_payment_methods` (`ID`),
  CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payments_ai` AFTER INSERT ON `tb_payments` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payments', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_payments: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('payment_method_ID=', IFNULL(NEW.`payment_method_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('payment_status=', IFNULL(NEW.`payment_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payments_au` AFTER UPDATE ON `tb_payments` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payments', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_payments: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('payment_method_ID (antes)=', IFNULL(OLD.`payment_method_ID`, 'NULL'), '; payment_method_ID (despues)=', IFNULL(NEW.`payment_method_ID`, 'NULL')), '; ', CONCAT('amount (antes)=', IFNULL(OLD.`amount`, 'NULL'), '; amount (despues)=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('payment_status (antes)=', IFNULL(OLD.`payment_status`, 'NULL'), '; payment_status (despues)=', IFNULL(NEW.`payment_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_payments_ad` AFTER DELETE ON `tb_payments` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payments', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_payments: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('payment_method_ID=', IFNULL(OLD.`payment_method_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(OLD.`amount`, 'NULL')), '; ', CONCAT('payment_status=', IFNULL(OLD.`payment_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_people`
--

DROP TABLE IF EXISTS `tb_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_people` (
  `person_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int DEFAULT NULL,
  `courtesy_title` varchar(20) DEFAULT NULL,
  `given_names` varchar(150) NOT NULL,
  `family_names` varchar(150) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('Hombre','Mujer','Prefiero no decirlo') NOT NULL DEFAULT 'Prefiero no decirlo',
  `country_code` char(2) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`person_ID`),
  UNIQUE KEY `user_ID` (`user_ID`),
  CONSTRAINT `fk_people_users` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_people_ai` AFTER INSERT ON `tb_people` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_people', 'INSERT', USER(), CAST(NEW.`person_ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_people: ', CONCAT(CONCAT('person_ID=', IFNULL(NEW.`person_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('given_names=', IFNULL(NEW.`given_names`, 'NULL')), '; ', CONCAT('family_names=', IFNULL(NEW.`family_names`, 'NULL')), '; ', CONCAT('birth_date=', IFNULL(NEW.`birth_date`, 'NULL')), '; ', CONCAT('gender=', IFNULL(NEW.`gender`, 'NULL')), '; ', CONCAT('country_code=', IFNULL(NEW.`country_code`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_people_au` AFTER UPDATE ON `tb_people` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_people', 'UPDATE', USER(), CAST(NEW.`person_ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_people: ', CONCAT(CONCAT('person_ID (antes)=', IFNULL(OLD.`person_ID`, 'NULL'), '; person_ID (despues)=', IFNULL(NEW.`person_ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('given_names (antes)=', IFNULL(OLD.`given_names`, 'NULL'), '; given_names (despues)=', IFNULL(NEW.`given_names`, 'NULL')), '; ', CONCAT('family_names (antes)=', IFNULL(OLD.`family_names`, 'NULL'), '; family_names (despues)=', IFNULL(NEW.`family_names`, 'NULL')), '; ', CONCAT('birth_date (antes)=', IFNULL(OLD.`birth_date`, 'NULL'), '; birth_date (despues)=', IFNULL(NEW.`birth_date`, 'NULL')), '; ', CONCAT('gender (antes)=', IFNULL(OLD.`gender`, 'NULL'), '; gender (despues)=', IFNULL(NEW.`gender`, 'NULL')), '; ', CONCAT('country_code (antes)=', IFNULL(OLD.`country_code`, 'NULL'), '; country_code (despues)=', IFNULL(NEW.`country_code`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_people_ad` AFTER DELETE ON `tb_people` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_people', 'DELETE', USER(), CAST(OLD.`person_ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_people: ', CONCAT(CONCAT('person_ID=', IFNULL(OLD.`person_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('given_names=', IFNULL(OLD.`given_names`, 'NULL')), '; ', CONCAT('family_names=', IFNULL(OLD.`family_names`, 'NULL')), '; ', CONCAT('birth_date=', IFNULL(OLD.`birth_date`, 'NULL')), '; ', CONCAT('gender=', IFNULL(OLD.`gender`, 'NULL')), '; ', CONCAT('country_code=', IFNULL(OLD.`country_code`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_products`
--

DROP TABLE IF EXISTS `tb_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_products` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SKU` varchar(50) NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` text,
  `current_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `current_stock` int unsigned NOT NULL DEFAULT '0',
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SKU` (`SKU`)
) ENGINE=InnoDB AUTO_INCREMENT=12006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_products_ai` AFTER INSERT ON `tb_products` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_products', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NEW.ID,
    NULL,
    CONCAT('INSERT en tb_products: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('SKU=', IFNULL(NEW.`SKU`, 'NULL')), '; ', CONCAT('name=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('current_price=', IFNULL(NEW.`current_price`, 'NULL')), '; ', CONCAT('current_stock=', IFNULL(NEW.`current_stock`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_products_au` AFTER UPDATE ON `tb_products` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_products', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NEW.ID,
    NULL,
    CONCAT('UPDATE en tb_products: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('SKU (antes)=', IFNULL(OLD.`SKU`, 'NULL'), '; SKU (despues)=', IFNULL(NEW.`SKU`, 'NULL')), '; ', CONCAT('name (antes)=', IFNULL(OLD.`name`, 'NULL'), '; name (despues)=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('current_price (antes)=', IFNULL(OLD.`current_price`, 'NULL'), '; current_price (despues)=', IFNULL(NEW.`current_price`, 'NULL')), '; ', CONCAT('current_stock (antes)=', IFNULL(OLD.`current_stock`, 'NULL'), '; current_stock (despues)=', IFNULL(NEW.`current_stock`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_products_ad` AFTER DELETE ON `tb_products` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_products', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    OLD.ID,
    NULL,
    CONCAT('DELETE en tb_products: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('SKU=', IFNULL(OLD.`SKU`, 'NULL')), '; ', CONCAT('name=', IFNULL(OLD.`name`, 'NULL')), '; ', CONCAT('current_price=', IFNULL(OLD.`current_price`, 'NULL')), '; ', CONCAT('current_stock=', IFNULL(OLD.`current_stock`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_refunds`
--

DROP TABLE IF EXISTS `tb_refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_refunds` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_ID` int unsigned NOT NULL,
  `return_ID` int unsigned DEFAULT NULL,
  `cancellation_ID` int unsigned DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `refund_status` enum('Pending','Processed','Failed') NOT NULL DEFAULT 'Pending',
  `refund_reference` varchar(150) DEFAULT NULL,
  `refund_date` datetime DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_refunds_payment` (`payment_ID`),
  KEY `idx_refunds_return` (`return_ID`),
  KEY `idx_refunds_cancellation` (`cancellation_ID`),
  CONSTRAINT `fk_refunds_cancellation` FOREIGN KEY (`cancellation_ID`) REFERENCES `tb_order_cancellations` (`ID`),
  CONSTRAINT `fk_refunds_payment` FOREIGN KEY (`payment_ID`) REFERENCES `tb_payments` (`ID`),
  CONSTRAINT `fk_refunds_return` FOREIGN KEY (`return_ID`) REFERENCES `tb_returns` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_refunds_ai` AFTER INSERT ON `tb_refunds` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_refunds', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_refunds: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('refund_status=', IFNULL(NEW.`refund_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_refunds_au` AFTER UPDATE ON `tb_refunds` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_refunds', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_refunds: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID (antes)=', IFNULL(OLD.`payment_ID`, 'NULL'), '; payment_ID (despues)=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('return_ID (antes)=', IFNULL(OLD.`return_ID`, 'NULL'), '; return_ID (despues)=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('cancellation_ID (antes)=', IFNULL(OLD.`cancellation_ID`, 'NULL'), '; cancellation_ID (despues)=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('amount (antes)=', IFNULL(OLD.`amount`, 'NULL'), '; amount (despues)=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('refund_status (antes)=', IFNULL(OLD.`refund_status`, 'NULL'), '; refund_status (despues)=', IFNULL(NEW.`refund_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_refunds_ad` AFTER DELETE ON `tb_refunds` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_refunds', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_refunds: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(OLD.`payment_ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(OLD.`return_ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(OLD.`cancellation_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(OLD.`amount`, 'NULL')), '; ', CONCAT('refund_status=', IFNULL(OLD.`refund_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_returns`
--

DROP TABLE IF EXISTS `tb_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_returns` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `user_ID` int NOT NULL,
  `reason` text NOT NULL,
  `return_status` enum('Requested','Approved','In Transit','Received','Rejected') NOT NULL DEFAULT 'Requested',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_returns_order` (`order_ID`),
  KEY `idx_returns_user` (`user_ID`),
  CONSTRAINT `fk_returns_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `fk_returns_user` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_returns_ai` AFTER INSERT ON `tb_returns` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_returns', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_returns: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('return_status=', IFNULL(NEW.`return_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_returns_au` AFTER UPDATE ON `tb_returns` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_returns', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_returns: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('return_status (antes)=', IFNULL(OLD.`return_status`, 'NULL'), '; return_status (despues)=', IFNULL(NEW.`return_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_returns_ad` AFTER DELETE ON `tb_returns` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_returns', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_returns: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('return_status=', IFNULL(OLD.`return_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_shipments`
--

DROP TABLE IF EXISTS `tb_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_shipments` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `carrier` varchar(100) NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `shipment_status` enum('Preparing','In Transit','Out for Delivery','Delivered','Failed') NOT NULL DEFAULT 'Preparing',
  `shipped_date` datetime DEFAULT NULL,
  `estimated_delivery` datetime DEFAULT NULL,
  `delivered_date` datetime DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_shipments_order` (`order_ID`),
  CONSTRAINT `fk_shipments_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_shipments_ai` AFTER INSERT ON `tb_shipments` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_shipments', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_shipments: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('carrier=', IFNULL(NEW.`carrier`, 'NULL')), '; ', CONCAT('tracking_number=', IFNULL(NEW.`tracking_number`, 'NULL')), '; ', CONCAT('shipment_status=', IFNULL(NEW.`shipment_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_shipments_au` AFTER UPDATE ON `tb_shipments` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_shipments', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_shipments: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('carrier (antes)=', IFNULL(OLD.`carrier`, 'NULL'), '; carrier (despues)=', IFNULL(NEW.`carrier`, 'NULL')), '; ', CONCAT('tracking_number (antes)=', IFNULL(OLD.`tracking_number`, 'NULL'), '; tracking_number (despues)=', IFNULL(NEW.`tracking_number`, 'NULL')), '; ', CONCAT('shipment_status (antes)=', IFNULL(OLD.`shipment_status`, 'NULL'), '; shipment_status (despues)=', IFNULL(NEW.`shipment_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_shipments_ad` AFTER DELETE ON `tb_shipments` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_shipments', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_shipments: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('carrier=', IFNULL(OLD.`carrier`, 'NULL')), '; ', CONCAT('tracking_number=', IFNULL(OLD.`tracking_number`, 'NULL')), '; ', CONCAT('shipment_status=', IFNULL(OLD.`shipment_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_user_addresses`
--

DROP TABLE IF EXISTS `tb_user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user_addresses` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int NOT NULL,
  `address_label` varchar(100) NOT NULL,
  `recipient_name` varchar(150) DEFAULT NULL,
  `recipient_phone` varchar(25) DEFAULT NULL,
  `delivery_instructions` varchar(500) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_user_addresses` (`user_ID`),
  CONSTRAINT `fk_addresses_users` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`),
  CONSTRAINT `chk_coordinates` CHECK ((((`latitude` is null) and (`longitude` is null)) or ((`latitude` is not null) and (`longitude` is not null)))),
  CONSTRAINT `chk_latitude` CHECK ((`latitude` between -(90) and 90)),
  CONSTRAINT `chk_longitude` CHECK ((`longitude` between -(180) and 180))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_user_addresses_ai` AFTER INSERT ON `tb_user_addresses` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_user_addresses', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_user_addresses: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('address_label=', IFNULL(NEW.`address_label`, 'NULL')), '; ', CONCAT('recipient_name=', IFNULL(NEW.`recipient_name`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_user_addresses_au` AFTER UPDATE ON `tb_user_addresses` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_user_addresses', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_user_addresses: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('address_label (antes)=', IFNULL(OLD.`address_label`, 'NULL'), '; address_label (despues)=', IFNULL(NEW.`address_label`, 'NULL')), '; ', CONCAT('recipient_name (antes)=', IFNULL(OLD.`recipient_name`, 'NULL'), '; recipient_name (despues)=', IFNULL(NEW.`recipient_name`, 'NULL')), '; ', CONCAT('is_default (antes)=', IFNULL(OLD.`is_default`, 'NULL'), '; is_default (despues)=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_user_addresses_ad` AFTER DELETE ON `tb_user_addresses` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_user_addresses', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_user_addresses: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('address_label=', IFNULL(OLD.`address_label`, 'NULL')), '; ', CONCAT('recipient_name=', IFNULL(OLD.`recipient_name`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(OLD.`is_default`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `nick` varchar(50) NOT NULL,
  `roles` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nick` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=9516 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_users_ai` AFTER INSERT ON `tb_users` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_users', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_users: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('email=', IFNULL(NEW.`email`, 'NULL')), '; ', CONCAT('nick=', IFNULL(NEW.`nick`, 'NULL')), '; ', CONCAT('roles=', IFNULL(NEW.`roles`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_users_au` AFTER UPDATE ON `tb_users` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_users', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_users: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('email (antes)=', IFNULL(OLD.`email`, 'NULL'), '; email (despues)=', IFNULL(NEW.`email`, 'NULL')), '; ', CONCAT('nick (antes)=', IFNULL(OLD.`nick`, 'NULL'), '; nick (despues)=', IFNULL(NEW.`nick`, 'NULL')), '; ', CONCAT('roles (antes)=', IFNULL(OLD.`roles`, 'NULL'), '; roles (despues)=', IFNULL(NEW.`roles`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tb_users_ad` AFTER DELETE ON `tb_users` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_users', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_users: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('email=', IFNULL(OLD.`email`, 'NULL')), '; ', CONCAT('nick=', IFNULL(OLD.`nick`, 'NULL')), '; ', CONCAT('roles=', IFNULL(OLD.`roles`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbc_categories`
--

DROP TABLE IF EXISTS `tbc_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) DEFAULT NULL,
  `description` text,
  `sup_id_category` int unsigned DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbc_categories_ai` AFTER INSERT ON `tbc_categories` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_categories', 'INSERT', USER(), CAST(NEW.`id` AS CHAR),
    NULL,
    NULL,
    NEW.id,
    CONCAT('INSERT en tbc_categories: ', CONCAT(CONCAT('id=', IFNULL(NEW.`id`, 'NULL')), '; ', CONCAT('name=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('sup_id_category=', IFNULL(NEW.`sup_id_category`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbc_categories_au` AFTER UPDATE ON `tbc_categories` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_categories', 'UPDATE', USER(), CAST(NEW.`id` AS CHAR),
    NULL,
    NULL,
    NEW.id,
    CONCAT('UPDATE en tbc_categories: ', CONCAT(CONCAT('id (antes)=', IFNULL(OLD.`id`, 'NULL'), '; id (despues)=', IFNULL(NEW.`id`, 'NULL')), '; ', CONCAT('name (antes)=', IFNULL(OLD.`name`, 'NULL'), '; name (despues)=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('sup_id_category (antes)=', IFNULL(OLD.`sup_id_category`, 'NULL'), '; sup_id_category (despues)=', IFNULL(NEW.`sup_id_category`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbc_categories_ad` AFTER DELETE ON `tbc_categories` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_categories', 'DELETE', USER(), CAST(OLD.`id` AS CHAR),
    NULL,
    NULL,
    OLD.id,
    CONCAT('DELETE en tbc_categories: ', CONCAT(CONCAT('id=', IFNULL(OLD.`id`, 'NULL')), '; ', CONCAT('name=', IFNULL(OLD.`name`, 'NULL')), '; ', CONCAT('sup_id_category=', IFNULL(OLD.`sup_id_category`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbc_payment_methods_types`
--

DROP TABLE IF EXISTS `tbc_payment_methods_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_payment_methods_types` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbc_payment_methods_types_ai` AFTER INSERT ON `tbc_payment_methods_types` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_payment_methods_types', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbc_payment_methods_types: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('code=', IFNULL(NEW.`code`, 'NULL')), '; ', CONCAT('description=', IFNULL(NEW.`description`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbc_payment_methods_types_au` AFTER UPDATE ON `tbc_payment_methods_types` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_payment_methods_types', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbc_payment_methods_types: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('code (antes)=', IFNULL(OLD.`code`, 'NULL'), '; code (despues)=', IFNULL(NEW.`code`, 'NULL')), '; ', CONCAT('description (antes)=', IFNULL(OLD.`description`, 'NULL'), '; description (despues)=', IFNULL(NEW.`description`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbc_payment_methods_types_ad` AFTER DELETE ON `tbc_payment_methods_types` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_payment_methods_types', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbc_payment_methods_types: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('code=', IFNULL(OLD.`code`, 'NULL')), '; ', CONCAT('description=', IFNULL(OLD.`description`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_address_components`
--

DROP TABLE IF EXISTS `tbd_address_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_address_components` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address_ID` bigint unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `address_sup_ID` bigint unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_address_component` (`address_ID`,`ID`),
  KEY `idx_address_parent` (`address_ID`,`address_sup_ID`),
  CONSTRAINT `fk_component_address` FOREIGN KEY (`address_ID`) REFERENCES `tb_user_addresses` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_component_parent` FOREIGN KEY (`address_ID`, `address_sup_ID`) REFERENCES `tbd_address_components` (`address_ID`, `ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_address_components_ai` AFTER INSERT ON `tbd_address_components` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_address_components', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_address_components: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('component_type=', IFNULL(NEW.`component_type`, 'NULL')), '; ', CONCAT('address_sup_ID=', IFNULL(NEW.`address_sup_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_address_components_au` AFTER UPDATE ON `tbd_address_components` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_address_components', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_address_components: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('address_ID (antes)=', IFNULL(OLD.`address_ID`, 'NULL'), '; address_ID (despues)=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('component_type (antes)=', IFNULL(OLD.`component_type`, 'NULL'), '; component_type (despues)=', IFNULL(NEW.`component_type`, 'NULL')), '; ', CONCAT('address_sup_ID (antes)=', IFNULL(OLD.`address_sup_ID`, 'NULL'), '; address_sup_ID (despues)=', IFNULL(NEW.`address_sup_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_address_components_ad` AFTER DELETE ON `tbd_address_components` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_address_components', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_address_components: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(OLD.`address_ID`, 'NULL')), '; ', CONCAT('component_type=', IFNULL(OLD.`component_type`, 'NULL')), '; ', CONCAT('address_sup_ID=', IFNULL(OLD.`address_sup_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_cancellation_items`
--

DROP TABLE IF EXISTS `tbd_cancellation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_cancellation_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `cancellation_ID` int unsigned NOT NULL,
  `order_item_ID` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_ci_cancellation` (`cancellation_ID`),
  KEY `idx_ci_order_item` (`order_item_ID`),
  CONSTRAINT `fk_ci_cancellation` FOREIGN KEY (`cancellation_ID`) REFERENCES `tb_order_cancellations` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_ci_order_item` FOREIGN KEY (`order_item_ID`) REFERENCES `tbd_order_items` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_cancellation_items_ai` AFTER INSERT ON `tbd_cancellation_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cancellation_items', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_cancellation_items: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_cancellation_items_au` AFTER UPDATE ON `tbd_cancellation_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cancellation_items', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_cancellation_items: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('cancellation_ID (antes)=', IFNULL(OLD.`cancellation_ID`, 'NULL'), '; cancellation_ID (despues)=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('order_item_ID (antes)=', IFNULL(OLD.`order_item_ID`, 'NULL'), '; order_item_ID (despues)=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_cancellation_items_ad` AFTER DELETE ON `tbd_cancellation_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cancellation_items', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_cancellation_items: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(OLD.`cancellation_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(OLD.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_cart_items`
--

DROP TABLE IF EXISTS `tbd_cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_cart_items` (
  `cart_ID` int unsigned NOT NULL,
  `provider_ID` int NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_ID`,`provider_ID`,`product_ID`),
  KEY `provider_ID` (`provider_ID`),
  KEY `product_ID` (`product_ID`),
  CONSTRAINT `tbd_cart_items_ibfk_1` FOREIGN KEY (`cart_ID`) REFERENCES `tb_carts` (`ID`),
  CONSTRAINT `tbd_cart_items_ibfk_2` FOREIGN KEY (`provider_ID`) REFERENCES `tbd_products_users_providers` (`user_ID`),
  CONSTRAINT `tbd_cart_items_ibfk_3` FOREIGN KEY (`product_ID`) REFERENCES `tbd_products_users_providers` (`product_ID`),
  CONSTRAINT `chk_cart_quantity` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_cart_items_ai` AFTER INSERT ON `tbd_cart_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cart_items', 'INSERT', USER(), CONCAT(NEW.cart_ID, '-', NEW.provider_ID, '-', NEW.product_ID),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_cart_items: ', CONCAT(CONCAT('cart_ID=', IFNULL(NEW.`cart_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_cart_items_au` AFTER UPDATE ON `tbd_cart_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cart_items', 'UPDATE', USER(), CONCAT(NEW.cart_ID, '-', NEW.provider_ID, '-', NEW.product_ID),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_cart_items: ', CONCAT(CONCAT('cart_ID (antes)=', IFNULL(OLD.`cart_ID`, 'NULL'), '; cart_ID (despues)=', IFNULL(NEW.`cart_ID`, 'NULL')), '; ', CONCAT('provider_ID (antes)=', IFNULL(OLD.`provider_ID`, 'NULL'), '; provider_ID (despues)=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_cart_items_ad` AFTER DELETE ON `tbd_cart_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cart_items', 'DELETE', USER(), CONCAT(OLD.cart_ID, '-', OLD.provider_ID, '-', OLD.product_ID),
    OLD.provider_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_cart_items: ', CONCAT(CONCAT('cart_ID=', IFNULL(OLD.`cart_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(OLD.`provider_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_order_items`
--

DROP TABLE IF EXISTS `tbd_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_order_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `seller_order_ID` int unsigned NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `provider_ID` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS ((`quantity` * `unit_price`)) STORED,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `seller_order_ID` (`seller_order_ID`),
  KEY `product_ID` (`product_ID`),
  KEY `provider_ID` (`provider_ID`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`seller_order_ID`) REFERENCES `tb_orders` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbd_order_items_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `tbd_products_users_providers` (`product_ID`),
  CONSTRAINT `tbd_order_items_ibfk_3` FOREIGN KEY (`provider_ID`) REFERENCES `tbd_products_users_providers` (`user_ID`),
  CONSTRAINT `tbd_order_items_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `tbd_order_items_chk_2` CHECK ((`unit_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_order_items_ai` AFTER INSERT ON `tbd_order_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_order_items', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_order_items: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('seller_order_ID=', IFNULL(NEW.`seller_order_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_name=', IFNULL(NEW.`product_name`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')), '; ', CONCAT('unit_price=', IFNULL(NEW.`unit_price`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_order_items_au` AFTER UPDATE ON `tbd_order_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_order_items', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_order_items: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('seller_order_ID (antes)=', IFNULL(OLD.`seller_order_ID`, 'NULL'), '; seller_order_ID (despues)=', IFNULL(NEW.`seller_order_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('provider_ID (antes)=', IFNULL(OLD.`provider_ID`, 'NULL'), '; provider_ID (despues)=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_name (antes)=', IFNULL(OLD.`product_name`, 'NULL'), '; product_name (despues)=', IFNULL(NEW.`product_name`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')), '; ', CONCAT('unit_price (antes)=', IFNULL(OLD.`unit_price`, 'NULL'), '; unit_price (despues)=', IFNULL(NEW.`unit_price`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_order_items_ad` AFTER DELETE ON `tbd_order_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_order_items', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.provider_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_order_items: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('seller_order_ID=', IFNULL(OLD.`seller_order_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(OLD.`provider_ID`, 'NULL')), '; ', CONCAT('product_name=', IFNULL(OLD.`product_name`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')), '; ', CONCAT('unit_price=', IFNULL(OLD.`unit_price`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_products_categories`
--

DROP TABLE IF EXISTS `tbd_products_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_products_categories` (
  `product_ID` int unsigned NOT NULL,
  `category_ID` int unsigned NOT NULL,
  `status` bit(1) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`product_ID`,`category_ID`),
  KEY `fk_products_categorias_category` (`category_ID`),
  CONSTRAINT `fk_products_categorias_category` FOREIGN KEY (`category_ID`) REFERENCES `tbc_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_products_categorias_product` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_products_categories_ai` AFTER INSERT ON `tbd_products_categories` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_categories', 'INSERT', USER(), CONCAT(NEW.product_ID, '-', NEW.category_ID),
    NULL,
    NEW.product_ID,
    NEW.category_ID,
    CONCAT('INSERT en tbd_products_categories: ', CONCAT(CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('category_ID=', IFNULL(NEW.`category_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_products_categories_au` AFTER UPDATE ON `tbd_products_categories` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_categories', 'UPDATE', USER(), CONCAT(NEW.product_ID, '-', NEW.category_ID),
    NULL,
    NEW.product_ID,
    NEW.category_ID,
    CONCAT('UPDATE en tbd_products_categories: ', CONCAT(CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('category_ID (antes)=', IFNULL(OLD.`category_ID`, 'NULL'), '; category_ID (despues)=', IFNULL(NEW.`category_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_products_categories_ad` AFTER DELETE ON `tbd_products_categories` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_categories', 'DELETE', USER(), CONCAT(OLD.product_ID, '-', OLD.category_ID),
    NULL,
    OLD.product_ID,
    OLD.category_ID,
    CONCAT('DELETE en tbd_products_categories: ', CONCAT(CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('category_ID=', IFNULL(OLD.`category_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_products_users_providers`
--

DROP TABLE IF EXISTS `tbd_products_users_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_products_users_providers` (
  `user_ID` int NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `type_ownership` enum('Owner','Reseller','Distributor') DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `available_date` datetime NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`,`product_ID`),
  KEY `fk_products2` (`product_ID`),
  CONSTRAINT `fk_products2` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`),
  CONSTRAINT `fk_user1` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_products_users_providers_ai` AFTER INSERT ON `tbd_products_users_providers` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_users_providers', 'INSERT', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_products_users_providers: ', CONCAT(CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('type_ownership=', IFNULL(NEW.`type_ownership`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_products_users_providers_au` AFTER UPDATE ON `tbd_products_users_providers` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_users_providers', 'UPDATE', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_products_users_providers: ', CONCAT(CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('type_ownership (antes)=', IFNULL(OLD.`type_ownership`, 'NULL'), '; type_ownership (despues)=', IFNULL(NEW.`type_ownership`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_products_users_providers_ad` AFTER DELETE ON `tbd_products_users_providers` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_users_providers', 'DELETE', USER(), CONCAT(OLD.user_ID, '-', OLD.product_ID),
    OLD.user_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_products_users_providers: ', CONCAT(CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('type_ownership=', IFNULL(OLD.`type_ownership`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_return_items`
--

DROP TABLE IF EXISTS `tbd_return_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_return_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `return_ID` int unsigned NOT NULL,
  `order_item_ID` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  `condition_notes` varchar(255) DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_ri_return` (`return_ID`),
  KEY `idx_ri_order_item` (`order_item_ID`),
  CONSTRAINT `fk_ri_order_item` FOREIGN KEY (`order_item_ID`) REFERENCES `tbd_order_items` (`ID`),
  CONSTRAINT `fk_ri_return` FOREIGN KEY (`return_ID`) REFERENCES `tb_returns` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_return_items_ai` AFTER INSERT ON `tbd_return_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_return_items', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_return_items: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_return_items_au` AFTER UPDATE ON `tbd_return_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_return_items', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_return_items: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('return_ID (antes)=', IFNULL(OLD.`return_ID`, 'NULL'), '; return_ID (despues)=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('order_item_ID (antes)=', IFNULL(OLD.`order_item_ID`, 'NULL'), '; order_item_ID (despues)=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_return_items_ad` AFTER DELETE ON `tbd_return_items` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_return_items', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_return_items: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(OLD.`return_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(OLD.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_user_payment_methods`
--

DROP TABLE IF EXISTS `tbd_user_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_user_payment_methods` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int NOT NULL,
  `payment_method_type_ID` int unsigned NOT NULL,
  `provider` varchar(60) NOT NULL,
  `provider_method_ref` varchar(255) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `last_four` char(4) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_provider_method` (`provider`,`provider_method_ref`),
  KEY `fk_user_idx` (`user_ID`),
  KEY `fk_payment_type_idx` (`payment_method_type_ID`),
  CONSTRAINT `fk_user_payment_type` FOREIGN KEY (`payment_method_type_ID`) REFERENCES `tbc_payment_methods_types` (`ID`),
  CONSTRAINT `fk_user_payment_user` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_user_payment_methods_ai` AFTER INSERT ON `tbd_user_payment_methods` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_user_payment_methods', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_user_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('provider=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('label=', IFNULL(NEW.`label`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_user_payment_methods_au` AFTER UPDATE ON `tbd_user_payment_methods` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_user_payment_methods', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_user_payment_methods: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID (antes)=', IFNULL(OLD.`payment_method_type_ID`, 'NULL'), '; payment_method_type_ID (despues)=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('provider (antes)=', IFNULL(OLD.`provider`, 'NULL'), '; provider (despues)=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('label (antes)=', IFNULL(OLD.`label`, 'NULL'), '; label (despues)=', IFNULL(NEW.`label`, 'NULL')), '; ', CONCAT('is_default (antes)=', IFNULL(OLD.`is_default`, 'NULL'), '; is_default (despues)=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_user_payment_methods_ad` AFTER DELETE ON `tbd_user_payment_methods` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_user_payment_methods', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_user_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(OLD.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('provider=', IFNULL(OLD.`provider`, 'NULL')), '; ', CONCAT('label=', IFNULL(OLD.`label`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(OLD.`is_default`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_users_wishlist_products`
--

DROP TABLE IF EXISTS `tbd_users_wishlist_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_users_wishlist_products` (
  `user_ID` int NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`,`product_ID`),
  KEY `fk_products3` (`product_ID`),
  CONSTRAINT `fk_products3` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`),
  CONSTRAINT `fk_user2` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_users_wishlist_products_ai` AFTER INSERT ON `tbd_users_wishlist_products` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_users_wishlist_products', 'INSERT', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_users_wishlist_products: ', CONCAT(CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_users_wishlist_products_au` AFTER UPDATE ON `tbd_users_wishlist_products` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_users_wishlist_products', 'UPDATE', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_users_wishlist_products: ', CONCAT(CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_tbd_users_wishlist_products_ad` AFTER DELETE ON `tbd_users_wishlist_products` FOR EACH ROW INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_users_wishlist_products', 'DELETE', USER(), CONCAT(OLD.user_ID, '-', OLD.product_ID),
    OLD.user_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_users_wishlist_products: ', CONCAT(CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_productos_por_categoria`
--

DROP TABLE IF EXISTS `vw_productos_por_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_por_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_por_categoria` AS SELECT 
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `parent_category_id`,
 1 AS `parent_category_name`,
 1 AS `category_level`,
 1 AS `category_status`,
 1 AS `total_products`,
 1 AS `active_products`,
 1 AS `discontinued_products`,
 1 AS `total_stock`,
 1 AS `min_price`,
 1 AS `max_price`,
 1 AS `avg_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_address_components`
--

DROP TABLE IF EXISTS `vw_trazabilidad_address_components`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_address_components`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_address_components` AS SELECT 
 1 AS `ID`,
 1 AS `address_ID`,
 1 AS `value`,
 1 AS `component_type`,
 1 AS `status`,
 1 AS `address_sup_ID`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_cancellation_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_cancellation_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_cancellation_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_cancellation_items` AS SELECT 
 1 AS `ID`,
 1 AS `cancellation_ID`,
 1 AS `order_item_ID`,
 1 AS `quantity`,
 1 AS `creation_date`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_cart_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_cart_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_cart_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_cart_items` AS SELECT 
 1 AS `cart_ID`,
 1 AS `provider_ID`,
 1 AS `product_ID`,
 1 AS `quantity`,
 1 AS `creation_date`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_carts`
--

DROP TABLE IF EXISTS `vw_trazabilidad_carts`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_carts` AS SELECT 
 1 AS `ID`,
 1 AS `user_ID`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_categorias`
--

DROP TABLE IF EXISTS `vw_trazabilidad_categorias`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_categorias` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `description`,
 1 AS `sup_id_category`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_order_cancellations`
--

DROP TABLE IF EXISTS `vw_trazabilidad_order_cancellations`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_cancellations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_order_cancellations` AS SELECT 
 1 AS `ID`,
 1 AS `order_ID`,
 1 AS `user_ID`,
 1 AS `reason`,
 1 AS `cancellation_status`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_order_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_order_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_order_items` AS SELECT 
 1 AS `ID`,
 1 AS `seller_order_ID`,
 1 AS `product_ID`,
 1 AS `provider_ID`,
 1 AS `product_name`,
 1 AS `quantity`,
 1 AS `unit_price`,
 1 AS `subtotal`,
 1 AS `creation_date`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_orders`
--

DROP TABLE IF EXISTS `vw_trazabilidad_orders`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_orders` AS SELECT 
 1 AS `ID`,
 1 AS `buyer_ID`,
 1 AS `address_ID`,
 1 AS `order_number`,
 1 AS `subtotal`,
 1 AS `shipping_total`,
 1 AS `total_amount`,
 1 AS `order_status`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payment_methods` AS SELECT 
 1 AS `ID`,
 1 AS `payment_method_type_ID`,
 1 AS `name`,
 1 AS `provider`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payment_methods_types`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payment_methods_types`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payment_methods_types` AS SELECT 
 1 AS `ID`,
 1 AS `code`,
 1 AS `description`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payment_transaction`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payment_transaction`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_transaction`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payment_transaction` AS SELECT 
 1 AS `ID`,
 1 AS `payment_ID`,
 1 AS `gateway_transaction_id`,
 1 AS `gateway_status`,
 1 AS `amount`,
 1 AS `creation_date`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payments`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payments`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payments` AS SELECT 
 1 AS `ID`,
 1 AS `order_ID`,
 1 AS `payment_method_ID`,
 1 AS `amount`,
 1 AS `currency`,
 1 AS `payment_status`,
 1 AS `payment_date`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_people`
--

DROP TABLE IF EXISTS `vw_trazabilidad_people`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_people`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_people` AS SELECT 
 1 AS `person_ID`,
 1 AS `user_ID`,
 1 AS `courtesy_title`,
 1 AS `given_names`,
 1 AS `family_names`,
 1 AS `birth_date`,
 1 AS `gender`,
 1 AS `country_code`,
 1 AS `phone`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_productos`
--

DROP TABLE IF EXISTS `vw_trazabilidad_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_productos` AS SELECT 
 1 AS `ID`,
 1 AS `SKU`,
 1 AS `name`,
 1 AS `description`,
 1 AS `current_price`,
 1 AS `current_stock`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_productos_categorias`
--

DROP TABLE IF EXISTS `vw_trazabilidad_productos_categorias`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos_categorias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_productos_categorias` AS SELECT 
 1 AS `product_ID`,
 1 AS `category_ID`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_products_users_providers`
--

DROP TABLE IF EXISTS `vw_trazabilidad_products_users_providers`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products_users_providers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_products_users_providers` AS SELECT 
 1 AS `user_ID`,
 1 AS `product_ID`,
 1 AS `type_ownership`,
 1 AS `status`,
 1 AS `available_date`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_refunds`
--

DROP TABLE IF EXISTS `vw_trazabilidad_refunds`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_refunds`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_refunds` AS SELECT 
 1 AS `ID`,
 1 AS `payment_ID`,
 1 AS `return_ID`,
 1 AS `cancellation_ID`,
 1 AS `amount`,
 1 AS `refund_status`,
 1 AS `refund_reference`,
 1 AS `refund_date`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_return_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_return_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_return_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_return_items` AS SELECT 
 1 AS `ID`,
 1 AS `return_ID`,
 1 AS `order_item_ID`,
 1 AS `quantity`,
 1 AS `condition_notes`,
 1 AS `creation_date`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_returns`
--

DROP TABLE IF EXISTS `vw_trazabilidad_returns`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_returns`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_returns` AS SELECT 
 1 AS `ID`,
 1 AS `order_ID`,
 1 AS `user_ID`,
 1 AS `reason`,
 1 AS `return_status`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_shipments`
--

DROP TABLE IF EXISTS `vw_trazabilidad_shipments`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_shipments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_shipments` AS SELECT 
 1 AS `ID`,
 1 AS `order_ID`,
 1 AS `carrier`,
 1 AS `tracking_number`,
 1 AS `shipment_status`,
 1 AS `shipped_date`,
 1 AS `estimated_delivery`,
 1 AS `delivered_date`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_user_addresses`
--

DROP TABLE IF EXISTS `vw_trazabilidad_user_addresses`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_user_addresses` AS SELECT 
 1 AS `ID`,
 1 AS `user_ID`,
 1 AS `address_label`,
 1 AS `recipient_name`,
 1 AS `recipient_phone`,
 1 AS `delivery_instructions`,
 1 AS `latitude`,
 1 AS `longitude`,
 1 AS `is_default`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_user_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_user_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_user_payment_methods` AS SELECT 
 1 AS `ID`,
 1 AS `user_ID`,
 1 AS `payment_method_type_ID`,
 1 AS `provider`,
 1 AS `provider_method_ref`,
 1 AS `label`,
 1 AS `last_four`,
 1 AS `is_default`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_users_wishlist_products`
--

DROP TABLE IF EXISTS `vw_trazabilidad_users_wishlist_products`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_users_wishlist_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_users_wishlist_products` AS SELECT 
 1 AS `user_ID`,
 1 AS `product_ID`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_usuarios`
--

DROP TABLE IF EXISTS `vw_trazabilidad_usuarios`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_usuarios` AS SELECT 
 1 AS `ID`,
 1 AS `email`,
 1 AS `username`,
 1 AS `roles`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `last_login`,
 1 AS `status`,
 1 AS `log_id`,
 1 AS `log_operation`,
 1 AS `log_db_user`,
 1 AS `log_record_id`,
 1 AS `log_description`,
 1 AS `log_date`,
 1 AS `log_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'db_test'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `ev_cerrar_carritos_inactivos` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ev_cerrar_carritos_inactivos` ON SCHEDULE EVERY 1 DAY STARTS '2026-11-13 02:00:00' ON COMPLETION PRESERVE ENABLE COMMENT 'Desactiva carritos sin actividad y sin ordenes despues de 90 dias' DO UPDATE tb_carts c
    SET c.status = b'0',
        c.last_update = NOW()
    WHERE c.status = b'1'
      AND c.creation_date < NOW() - INTERVAL 90 DAY
      AND NOT EXISTS (
          SELECT 1 FROM tb_orders o WHERE o.buyer_ID = c.user_ID
      ) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_purgar_logs_antiguos` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ev_purgar_logs_antiguos` ON SCHEDULE EVERY 1 WEEK STARTS '2026-11-19 03:00:00' ON COMPLETION PRESERVE ENABLE COMMENT 'Elimina registros de auditoria con mas de 180 dias' DO DELETE FROM tb_logs
    WHERE operation_date < NOW() - INTERVAL 180 DAY */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'db_test'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_aleatorio_entero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_aleatorio_entero`(p_min INT, p_max INT) RETURNS int
    READS SQL DATA
BEGIN
    IF p_min IS NULL OR p_max IS NULL OR p_max < p_min THEN
        RETURN NULL;
    END IF;
    RETURN p_min + FLOOR(RAND() * (p_max - p_min + 1));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_apellido_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_apellido_aleatorio`() RETURNS varchar(150) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    RETURN ELT(fn_aleatorio_entero(1, 24),
        'Garcia','Hernandez','Martinez','Lopez','Gonzalez','Perez','Rodriguez',
        'Sanchez','Ramirez','Torres','Flores','Rivera','Gomez','Diaz','Cruz',
        'Morales','Ortiz','Gutierrez','Chavez','Ramos','Vargas','Castillo',
        'Jimenez','Mendoza');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_estado_probabilidad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_estado_probabilidad`(p_prob_activo DECIMAL(5,2)) RETURNS bit(1)
    READS SQL DATA
BEGIN
    IF p_prob_activo IS NULL OR p_prob_activo >= 100 THEN
        RETURN b'1';
    END IF;
    IF p_prob_activo <= 0 THEN
        RETURN b'0';
    END IF;
    IF (RAND() * 100) < p_prob_activo THEN
        RETURN b'1';
    END IF;
    RETURN b'0';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_fecha_nacimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_fecha_nacimiento`(p_edad_min INT, p_edad_max INT) RETURNS date
    READS SQL DATA
BEGIN
    DECLARE v_fecha_min DATE;
    DECLARE v_fecha_max DATE;
    IF p_edad_min IS NULL OR p_edad_max IS NULL OR p_edad_min > p_edad_max THEN
        RETURN NULL;
    END IF;
    
    SET v_fecha_min = DATE_SUB(CURDATE(), INTERVAL p_edad_min YEAR);
    
    SET v_fecha_max = DATE_ADD(
        DATE_SUB(CURDATE(), INTERVAL (p_edad_max + 1) YEAR),
        INTERVAL 1 DAY
    );
    RETURN DATE_ADD(
        v_fecha_max,
        INTERVAL fn_aleatorio_entero(0, DATEDIFF(v_fecha_min, v_fecha_max)) DAY
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genero_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_genero_aleatorio`() RETURNS varchar(20) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    RETURN ELT(fn_aleatorio_entero(1, 3),
               'Hombre', 'Mujer', 'Prefiero no decirlo');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_nombre_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_nombre_aleatorio`(p_genero VARCHAR(20)) RETURNS varchar(150) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    IF p_genero = 'Hombre' THEN
        RETURN ELT(fn_aleatorio_entero(1, 20),
            'Carlos','Jose','Luis','Miguel','Jorge','Fernando','Ricardo','Alejandro',
            'Daniel','Andres','Roberto','Eduardo','Javier','Sergio','Raul','Marco',
            'Diego','Ivan','Pablo','Hector');
    ELSEIF p_genero = 'Mujer' THEN
        RETURN ELT(fn_aleatorio_entero(1, 20),
            'Maria','Ana','Laura','Sofia','Carmen','Lucia','Elena','Patricia',
            'Gabriela','Fernanda','Valeria','Daniela','Paola','Monica','Silvia',
            'Rosa','Adriana','Claudia','Isabel','Veronica');
    ELSE
        RETURN ELT(fn_aleatorio_entero(1, 10),
            'Alex','Sam','Jordan','Taylor','Casey','Robin','Dani','Andrea','Noel','Guille');
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_pais_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_pais_aleatorio`() RETURNS char(2) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    RETURN ELT(fn_aleatorio_entero(1, 24),
        'US','MX','CA','BR','AR','CO','CL','PE','ES','FR',
        'DE','IT','GB','PT','JP','CN','IN','KR','AU','NZ',
        'UY','EC','CR','PA');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generar_72_triggers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_generar_72_triggers`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_tabla VARCHAR(100);
    DECLARE cur CURSOR FOR 
        SELECT TABLE_NAME 
        FROM information_schema.TABLES 
        WHERE TABLE_SCHEMA = 'db_test' 
          AND TABLE_TYPE = 'BASE TABLE' 
          AND TABLE_NAME <> 'tb_logs';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_tabla;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Eliminar triggers previos si existieran
        SET @drop_ai = CONCAT('DROP TRIGGER IF EXISTS `trg_', v_tabla, '_ai`;');
        PREPARE stmt FROM @drop_ai; EXECUTE stmt; DEALLOCATE PREPARE stmt;

        SET @drop_au = CONCAT('DROP TRIGGER IF EXISTS `trg_', v_tabla, '_au`;');
        PREPARE stmt FROM @drop_au; EXECUTE stmt; DEALLOCATE PREPARE stmt;

        SET @drop_ad = CONCAT('DROP TRIGGER IF EXISTS `trg_', v_tabla, '_ad`;');
        PREPARE stmt FROM @drop_ad; EXECUTE stmt; DEALLOCATE PREPARE stmt;

        -- 1. AFTER INSERT
        SET @sql_ins = CONCAT(
            'CREATE TRIGGER `trg_', v_tabla, '_ai` AFTER INSERT ON `', v_tabla, '` FOR EACH ROW ',
            'INSERT INTO `tb_logs` (`table_name`, `operation`, `db_user`, `description`, `operation_date`) ',
            'VALUES (''', v_tabla, ''', ''INSERT'', USER(), CONCAT(''Registro insertado ID: '', NEW.ID), NOW());'
        );
        PREPARE stmt FROM @sql_ins; EXECUTE stmt; DEALLOCATE PREPARE stmt;

        -- 2. AFTER UPDATE
        SET @sql_upd = CONCAT(
            'CREATE TRIGGER `trg_', v_tabla, '_au` AFTER UPDATE ON `', v_tabla, '` FOR EACH ROW ',
            'INSERT INTO `tb_logs` (`table_name`, `operation`, `db_user`, `description`, `operation_date`) ',
            'VALUES (''', v_tabla, ''', ''UPDATE'', USER(), CONCAT(''Registro actualizado ID: '', NEW.ID), NOW());'
        );
        PREPARE stmt FROM @sql_upd; EXECUTE stmt; DEALLOCATE PREPARE stmt;

        -- 3. AFTER DELETE
        SET @sql_del = CONCAT(
            'CREATE TRIGGER `trg_', v_tabla, '_ad` AFTER DELETE ON `', v_tabla, '` FOR EACH ROW ',
            'INSERT INTO `tb_logs` (`table_name`, `operation`, `db_user`, `description`, `operation_date`) ',
            'VALUES (''', v_tabla, ''', ''DELETE'', USER(), CONCAT(''Registro eliminado ID: '', OLD.ID), NOW());'
        );
        PREPARE stmt FROM @sql_del; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    END LOOP;
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_poblar_productos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_poblar_productos`(
    IN p_cantidad          INT,
    IN p_seller_email      VARCHAR(100),
    IN p_prefijo_sku       VARCHAR(20),
    IN p_pct_descontinuado DECIMAL(5,2),
    IN p_precio_min        DECIMAL(10,2),
    IN p_precio_max        DECIMAL(10,2)
)
BEGIN
    DECLARE v_i             INT DEFAULT 0;
    DECLARE v_product_id    INT UNSIGNED;
    DECLARE v_seller_id     INT;
    DECLARE v_seller_nick   VARCHAR(50);
    DECLARE v_num_cats      INT;
    DECLARE v_cat_seq       INT;
    DECLARE v_cat_id        INT UNSIGNED;
    DECLARE v_cat_name      VARCHAR(120);
    DECLARE v_parent_id     INT UNSIGNED;
    DECLARE v_parent_name   VARCHAR(120);
    DECLARE v_prefijo       VARCHAR(20);
    DECLARE v_pct           DECIMAL(5,2);
    DECLARE v_pmin          DECIMAL(10,2);
    DECLARE v_pmax          DECIMAL(10,2);
    DECLARE v_price         DECIMAL(10,2);
    DECLARE v_stock         INT;
    DECLARE v_status        BIT(1);
    DECLARE v_db_user       VARCHAR(100);
    DECLARE v_role_ok       INT DEFAULT 0;
    DECLARE v_descontinuados INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);
    SELECT COUNT(*) INTO v_role_ok
    FROM mysql.role_edges
    WHERE TO_USER = v_db_user
      AND FROM_USER IN ('superadmin', 'admin', 'seller');

    IF v_db_user <> 'root' AND v_role_ok = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: se requiere rol seller, admin o superadmin';
    END IF;

    IF p_cantidad IS NULL OR p_cantidad <= 0 OR p_cantidad > 100000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad de productos debe estar entre 1 y 100000';
    END IF;

    SELECT ID, nick INTO v_seller_id, v_seller_nick
    FROM tb_users
    WHERE email = p_seller_email
      AND status = b'1'
    LIMIT 1;

    IF v_seller_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El vendedor indicado no existe o esta inactivo';
    END IF;

    SELECT COUNT(*) INTO v_num_cats FROM tbc_categories;
    IF v_num_cats = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existen categorias para asignar productos';
    END IF;

    SET v_prefijo = LEFT(COALESCE(NULLIF(TRIM(p_prefijo_sku), ''), 'PROD'), 12);
    SET v_pct     = COALESCE(p_pct_descontinuado, 10);
    SET v_pmin    = COALESCE(p_precio_min, 10);
    SET v_pmax    = COALESCE(p_precio_max, 5000);

    IF v_pct < 0 OR v_pct > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El porcentaje de descontinuados debe estar entre 0 y 100';
    END IF;
    IF v_pmin < 0 OR v_pmax < v_pmin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rango de precios invalido';
    END IF;

    START TRANSACTION;

    WHILE v_i < p_cantidad DO
        SET v_cat_seq = v_i MOD v_num_cats;
        SELECT id, name INTO v_cat_id, v_cat_name
        FROM (
            SELECT id, name, ROW_NUMBER() OVER (ORDER BY id) AS rn
            FROM tbc_categories
        ) AS x
        WHERE rn = v_cat_seq + 1;

        SELECT sup_id_category INTO v_parent_id
        FROM tbc_categories WHERE id = v_cat_id;

        SET v_parent_name = NULL;
        IF v_parent_id IS NOT NULL THEN
            SELECT name INTO v_parent_name FROM tbc_categories WHERE id = v_parent_id;
        END IF;

        SET v_price  = v_pmin + ROUND(RAND() * (v_pmax - v_pmin), 2);
        SET v_stock  = fn_aleatorio_entero(0, 500);
        SET v_status = IF((RAND() * 100) < v_pct, b'0', b'1');

        INSERT INTO tb_products (
            SKU, name, description, current_price, current_stock, status
        ) VALUES (
            CONCAT(v_prefijo, '-', LPAD(v_i + 1, 6, '0'), '-', v_seller_id),
            CONCAT(v_cat_name, ' ', v_prefijo, ' ', LPAD(v_i + 1, 5, '0')),
            CONCAT('Producto generado para ', v_seller_nick,
                   '. Categoria: ', v_cat_name,
                   IF(v_parent_name IS NULL, '', CONCAT(' / ', v_parent_name))),
            v_price,
            v_stock,
            v_status
        );

        SET v_product_id = LAST_INSERT_ID();
        IF v_status = b'0' THEN
            SET v_descontinuados = v_descontinuados + 1;
        END IF;

        INSERT INTO tbd_products_users_providers (
            user_ID, product_ID, type_ownership, status, available_date, last_update
        ) VALUES (
            v_seller_id, v_product_id, 'Owner', b'1', NOW(), NOW()
        );

        INSERT INTO tbd_products_categories (
            product_ID, category_ID, status, creation_date, last_update
        ) VALUES (
            v_product_id, v_cat_id, b'1', NOW(), NOW()
        );

        
        IF v_parent_id IS NOT NULL AND (v_i MOD 3 = 0) THEN
            INSERT IGNORE INTO tbd_products_categories (
                product_ID, category_ID, status, creation_date, last_update
            ) VALUES (
                v_product_id, v_parent_id, b'1', NOW(), NOW()
            );
        END IF;

        SET v_i = v_i + 1;
    END WHILE;

    COMMIT;

    SELECT
        v_i                  AS productos_insertados,
        v_seller_id          AS seller_id,
        p_seller_email       AS seller_email,
        v_descontinuados     AS productos_descontinuados,
        v_db_user            AS ejecutado_por,
        CURRENT_TIMESTAMP    AS fecha_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_register_new_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_new_user`(
    IN p_email          VARCHAR(100),
    IN p_nick           VARCHAR(50),
    IN p_password       VARCHAR(100),
    IN p_courtesy_title VARCHAR(20),
    IN p_given_names    VARCHAR(150),
    IN p_family_names   VARCHAR(150),
    IN p_birth_date     DATE,
    IN p_gender         VARCHAR(30),
    IN p_country_code   VARCHAR(50),
    IN p_phone          VARCHAR(25)
)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_db_user   VARCHAR(32);
    DECLARE v_has_role  INT DEFAULT 0;
    DECLARE v_count     INT DEFAULT 0;
    DECLARE v_user_id   INT UNSIGNED;
    DECLARE v_person_id BIGINT UNSIGNED;

    -- Manejo de excepciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo o el nick ya se encuentran registrados';
    END;

    -- Obtener el usuario actual
    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);

    -- Validar si el usuario tiene asignado un rol permitido
    SELECT COUNT(*)
    INTO v_has_role
    FROM mysql.role_edges re
    WHERE re.TO_USER = v_db_user
      AND re.FROM_USER IN (
          'superadmin',
          'admin',
          'support',
          'user_not_registered'
      );

    -- Si es root, le permitimos el acceso directo
    IF v_db_user = 'root' THEN
        SET v_has_role = 1;
    END IF;

    IF v_has_role = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: rol no autorizado para registrar usuarios';
    END IF;

    -- Sanitización de entradas
    SET p_email          = LOWER(TRIM(p_email));
    SET p_nick           = TRIM(p_nick);
    SET p_given_names    = TRIM(p_given_names);
    SET p_family_names   = NULLIF(TRIM(p_family_names), '');
    SET p_courtesy_title = NULLIF(TRIM(p_courtesy_title), '');
    SET p_gender         = COALESCE(NULLIF(TRIM(p_gender), ''), 'Prefiero no decirlo');
    SET p_country_code   = NULLIF(UPPER(TRIM(p_country_code)), '');
    SET p_phone          = NULLIF(TRIM(p_phone), '');

    -- Validaciones de formato y reglas de negocio
    IF p_email IS NULL OR p_email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico es inválido';
    END IF;

    IF p_nick IS NULL OR CHAR_LENGTH(p_nick) < 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nick debe tener al menos 3 caracteres';
    END IF;

    IF p_password IS NULL OR CHAR_LENGTH(p_password) < 8 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña debe tener al menos 8 caracteres';
    END IF;

    IF p_given_names IS NULL OR p_given_names = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre es obligatorio';
    END IF;

    IF p_birth_date IS NOT NULL AND (p_birth_date > CURRENT_DATE OR p_birth_date < '1900-01-01') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de nacimiento es inválida';
    END IF;

    IF p_gender NOT IN ('Hombre', 'Mujer', 'Prefiero no decirlo') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El género debe ser Hombre, Mujer o Prefiero no decirlo';
    END IF;

    IF p_country_code IS NOT NULL AND p_country_code NOT REGEXP '^[A-Z]{2}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El código de país debe tener 2 letras (ISO)';
    END IF;

    IF p_phone IS NOT NULL AND p_phone NOT REGEXP '^[0-9+() -]{7,25}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono es inválido';
    END IF;

    -- Comprobar duplicados
    SELECT COUNT(*) INTO v_count FROM tb_users WHERE email = p_email;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico ya se encuentra registrado';
    END IF;

    SELECT COUNT(*) INTO v_count FROM tb_users WHERE nick = p_nick;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nick ya se encuentra en uso';
    END IF;

    -- Inserción transaccional
    START TRANSACTION;

    INSERT INTO tb_users (email, nick, password)
    VALUES (p_email, p_nick, SHA2(p_password, 256));

    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO tb_people (
        user_ID, courtesy_title, given_names, family_names,
        birth_date, gender, country_code, phone
    )
    VALUES (
        v_user_id, p_courtesy_title, p_given_names, p_family_names,
        p_birth_date, p_gender, p_country_code, p_phone
    );

    SET v_person_id = LAST_INSERT_ID();

    COMMIT;

    -- Resultado de la operación
    SELECT
        'Usuario y persona registrados correctamente' AS mensaje,
        v_user_id AS user_id,
        v_person_id AS person_id,
        p_email AS email,
        p_nick AS nick,
        v_db_user AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_restore_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_restore_product`(
    IN p_product_id INT UNSIGNED
)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_db_user  VARCHAR(32);
    DECLARE v_has_role INT DEFAULT 0;

    -- Manejo de excepciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Obtener el usuario en sesión activa
    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);

    -- Validar rol (sellers, admins y superadmins pueden restaurar productos)
    SELECT COUNT(*)
    INTO v_has_role
    FROM mysql.role_edges re
    WHERE re.TO_USER = v_db_user
      AND re.FROM_USER IN ('superadmin', 'admin', 'seller');

    -- Permitir acceso directo al usuario root
    IF v_db_user = 'root' THEN
        SET v_has_role = 1;
    END IF;

    IF v_has_role = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: no tienes permisos para restaurar productos';
    END IF;

    -- Validar si el producto existe
    IF NOT EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto especificado no existe';
    END IF;

    -- Validar si el producto ya está activo
    IF EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
          AND status = b'1'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto ya se encuentra activo';
    END IF;

    -- Iniciar transacción y actualizar estado a activo (b'1')
    START TRANSACTION;

    UPDATE tb_products
    SET status = b'1'
    WHERE ID = p_product_id;

    COMMIT;

    -- Confirmación de salida
    SELECT 
        'Producto restaurado / reactivado correctamente' AS mensaje,
        p_product_id AS product_id,
        v_db_user AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_simular_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_simular_usuarios`(
    IN p_cantidad     INT,
    IN p_genero       VARCHAR(20),
    IN p_pais         VARCHAR(2),
    IN p_edad_min     INT,
    IN p_edad_max     INT,
    IN p_prob_activo  DECIMAL(5,2),
    IN p_prefijo      VARCHAR(20),
    IN p_rol          VARCHAR(20)
)
BEGIN
    DECLARE v_i              INT DEFAULT 0;
    DECLARE v_user_id        INT;
    DECLARE v_token          VARCHAR(40);
    DECLARE v_email          VARCHAR(100);
    DECLARE v_nick           VARCHAR(50);
    DECLARE v_genero         VARCHAR(20);
    DECLARE v_genero_fila    VARCHAR(20);
    DECLARE v_pais           CHAR(2);
    DECLARE v_pais_fila      CHAR(2);
    DECLARE v_edad_min       INT;
    DECLARE v_edad_max       INT;
    DECLARE v_prob           DECIMAL(5,2);
    DECLARE v_prefijo        VARCHAR(20);
    DECLARE v_rol            VARCHAR(20);
    DECLARE v_status         BIT(1);
    DECLARE v_birth          DATE;
    DECLARE v_genero_rand    BOOLEAN DEFAULT FALSE;
    DECLARE v_pais_rand      BOOLEAN DEFAULT FALSE;
    DECLARE v_db_user        VARCHAR(100);
    DECLARE v_role_ok        INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    
    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);
    SELECT COUNT(*) INTO v_role_ok
    FROM mysql.role_edges
    WHERE TO_USER = v_db_user
      AND FROM_USER IN ('superadmin', 'admin', 'support');

    IF v_db_user <> 'root' AND v_role_ok = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: se requiere rol superadmin, admin o support';
    END IF;

    
    IF p_cantidad IS NULL OR p_cantidad <= 0 OR p_cantidad > 100000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad debe estar entre 1 y 100000';
    END IF;

    SET v_genero = NULLIF(TRIM(p_genero), '');
    IF v_genero IS NULL OR v_genero = '*' THEN
        SET v_genero_rand = TRUE;
    ELSEIF v_genero NOT IN ('Hombre', 'Mujer', 'Prefiero no decirlo') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Genero invalido: use Hombre, Mujer, Prefiero no decirlo o *';
    END IF;

    SET v_pais = UPPER(NULLIF(TRIM(p_pais), ''));
    IF v_pais IS NULL OR v_pais = '*' THEN
        SET v_pais_rand = TRUE;
    ELSEIF v_pais NOT REGEXP '^[A-Z]{2}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pais invalido: use un codigo ISO de 2 letras o *';
    END IF;

    SET v_edad_min = COALESCE(p_edad_min, 18);
    SET v_edad_max = COALESCE(p_edad_max, 65);
    IF v_edad_min < 18 OR v_edad_max > 100 OR v_edad_min > v_edad_max THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rango de edad invalido (18 a 100 y minimo <= maximo)';
    END IF;

    SET v_prob = COALESCE(p_prob_activo, 100);
    IF v_prob < 0 OR v_prob > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La probabilidad de cuenta activa debe estar entre 0 y 100';
    END IF;

    SET v_prefijo = LEFT(COALESCE(NULLIF(TRIM(p_prefijo), ''), 'sim'), 12);
    SET v_rol = COALESCE(NULLIF(TRIM(p_rol), ''), 'common_user');

    START TRANSACTION;

    WHILE v_i < p_cantidad DO
        SET v_token = REPLACE(UUID(), '-', '');
        SET v_email = CONCAT(v_prefijo, '_', LEFT(v_token, 24), '@sim.test');
        SET v_nick  = CONCAT(v_prefijo, '_', LEFT(v_token, 12));

        IF v_genero_rand THEN
            SET v_genero_fila = fn_genero_aleatorio();
        ELSE
            SET v_genero_fila = v_genero;
        END IF;

        IF v_pais_rand THEN
            SET v_pais_fila = fn_pais_aleatorio();
        ELSE
            SET v_pais_fila = v_pais;
        END IF;

        SET v_birth  = fn_fecha_nacimiento(v_edad_min, v_edad_max);
        SET v_status = fn_estado_probabilidad(v_prob);

        INSERT INTO tb_users (email, nick, roles, password, status)
        VALUES (v_email, v_nick, v_rol, SHA2(v_token, 256), v_status);

        SET v_user_id = LAST_INSERT_ID();

        INSERT INTO tb_people (
            user_ID, given_names, family_names, birth_date, gender,
            country_code, phone, status
        ) VALUES (
            v_user_id,
            fn_nombre_aleatorio(v_genero_fila),
            fn_apellido_aleatorio(),
            v_birth,
            v_genero_fila,
            v_pais_fila,
            CONCAT('+', fn_aleatorio_entero(1, 99),
                   LPAD(fn_aleatorio_entero(0, 99999999), 8, '0')),
            v_status
        );

        SET v_i = v_i + 1;
    END WHILE;

    COMMIT;

    SELECT
        v_i              AS usuarios_generados,
        v_prefijo        AS prefijo,
        v_rol            AS rol_asignado,
        v_edad_min       AS edad_minima,
        v_edad_max       AS edad_maxima,
        v_prob           AS porcentaje_activo_objetivo,
        v_db_user        AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_soft_delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_soft_delete_product`(
    IN p_product_id INT UNSIGNED
)
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_db_user  VARCHAR(32);
    DECLARE v_has_role INT DEFAULT 0;

    -- Manejo de excepciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Obtener usuario en sesión
    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);

    -- Validar rol (sellers, admins y superadmins pueden desactivar productos)
    SELECT COUNT(*)
    INTO v_has_role
    FROM mysql.role_edges re
    WHERE re.TO_USER = v_db_user
      AND re.FROM_USER IN ('superadmin', 'admin', 'seller');

    -- Permitir acceso directo a root
    IF v_db_user = 'root' THEN
        SET v_has_role = 1;
    END IF;

    IF v_has_role = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: no tienes permisos para desactivar o eliminar productos';
    END IF;

    -- Validar existencia del producto
    IF NOT EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto especificado no existe';
    END IF;

    -- Validar si ya está desactivado
    IF EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
          AND status = b'0'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto ya se encuentra eliminado / desactivado';
    END IF;

    -- Iniciar transacción y actualizar estado
    START TRANSACTION;

    UPDATE tb_products
    SET status = b'0'
    WHERE ID = p_product_id;

    COMMIT;

    -- Confirmación de salida
    SELECT 
        'Producto desactivado correctamente' AS mensaje,
        p_product_id AS product_id,
        v_db_user AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_productos_por_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_por_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_por_categoria` AS select `c`.`id` AS `category_id`,`c`.`name` AS `category_name`,`c`.`sup_id_category` AS `parent_category_id`,`pc`.`name` AS `parent_category_name`,(case when (`c`.`sup_id_category` is null) then 'Categoria' else 'Subcategoria' end) AS `category_level`,(`c`.`status` + 0) AS `category_status`,count(distinct `p`.`ID`) AS `total_products`,sum((case when (`p`.`status` = 0x01) then 1 else 0 end)) AS `active_products`,sum((case when (`p`.`status` = 0x00) then 1 else 0 end)) AS `discontinued_products`,coalesce(sum(`p`.`current_stock`),0) AS `total_stock`,coalesce(min(`p`.`current_price`),0) AS `min_price`,coalesce(max(`p`.`current_price`),0) AS `max_price`,coalesce(round(avg(`p`.`current_price`),2),0) AS `avg_price` from (((`tbc_categories` `c` left join `tbc_categories` `pc` on((`pc`.`id` = `c`.`sup_id_category`))) left join `tbd_products_categories` `pcat` on(((`pcat`.`category_ID` = `c`.`id`) and (`pcat`.`status` = 0x01)))) left join `tb_products` `p` on((`p`.`ID` = `pcat`.`product_ID`))) group by `c`.`id`,`c`.`name`,`c`.`sup_id_category`,`pc`.`name`,`c`.`status` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_address_components`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_address_components`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_address_components` AS select `t`.`ID` AS `ID`,`t`.`address_ID` AS `address_ID`,`t`.`value` AS `value`,`t`.`component_type` AS `component_type`,`t`.`status` AS `status`,`t`.`address_sup_ID` AS `address_sup_ID`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_address_components` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_address_components') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_cancellation_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_cancellation_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_cancellation_items` AS select `t`.`ID` AS `ID`,`t`.`cancellation_ID` AS `cancellation_ID`,`t`.`order_item_ID` AS `order_item_ID`,`t`.`quantity` AS `quantity`,`t`.`creation_date` AS `creation_date`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_cancellation_items` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_cancellation_items') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_cart_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_cart_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_cart_items` AS select `t`.`cart_ID` AS `cart_ID`,`t`.`provider_ID` AS `provider_ID`,`t`.`product_ID` AS `product_ID`,`t`.`quantity` AS `quantity`,`t`.`creation_date` AS `creation_date`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_cart_items` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_cart_items') and (`l`.`record_id` = cast(concat(`t`.`cart_ID`,'-',`t`.`provider_ID`,'-',`t`.`product_ID`) as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_carts`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_carts` AS select `t`.`ID` AS `ID`,`t`.`user_ID` AS `user_ID`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_carts` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_carts') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_categorias`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_categorias` AS select `t`.`id` AS `id`,`t`.`name` AS `name`,`t`.`description` AS `description`,`t`.`sup_id_category` AS `sup_id_category`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbc_categories` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbc_categories') and (`l`.`record_id` = cast(`t`.`id` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_order_cancellations`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_cancellations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_order_cancellations` AS select `t`.`ID` AS `ID`,`t`.`order_ID` AS `order_ID`,`t`.`user_ID` AS `user_ID`,`t`.`reason` AS `reason`,`t`.`cancellation_status` AS `cancellation_status`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_order_cancellations` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_order_cancellations') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_order_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_order_items` AS select `t`.`ID` AS `ID`,`t`.`seller_order_ID` AS `seller_order_ID`,`t`.`product_ID` AS `product_ID`,`t`.`provider_ID` AS `provider_ID`,`t`.`product_name` AS `product_name`,`t`.`quantity` AS `quantity`,`t`.`unit_price` AS `unit_price`,`t`.`subtotal` AS `subtotal`,`t`.`creation_date` AS `creation_date`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_order_items` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_order_items') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_orders`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_orders` AS select `t`.`ID` AS `ID`,`t`.`buyer_ID` AS `buyer_ID`,`t`.`address_ID` AS `address_ID`,`t`.`order_number` AS `order_number`,`t`.`subtotal` AS `subtotal`,`t`.`shipping_total` AS `shipping_total`,`t`.`total_amount` AS `total_amount`,`t`.`order_status` AS `order_status`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_orders` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_orders') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payment_methods` AS select `t`.`ID` AS `ID`,`t`.`payment_method_type_ID` AS `payment_method_type_ID`,`t`.`name` AS `name`,`t`.`provider` AS `provider`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_payment_methods` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_payment_methods') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payment_methods_types`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payment_methods_types` AS select `t`.`ID` AS `ID`,`t`.`code` AS `code`,`t`.`description` AS `description`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbc_payment_methods_types` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbc_payment_methods_types') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payment_transaction`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_transaction`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payment_transaction` AS select `t`.`ID` AS `ID`,`t`.`payment_ID` AS `payment_ID`,`t`.`gateway_transaction_id` AS `gateway_transaction_id`,`t`.`gateway_status` AS `gateway_status`,`t`.`amount` AS `amount`,`t`.`creation_date` AS `creation_date`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_payment_transaction` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_payment_transaction') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payments`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payments` AS select `t`.`ID` AS `ID`,`t`.`order_ID` AS `order_ID`,`t`.`payment_method_ID` AS `payment_method_ID`,`t`.`amount` AS `amount`,`t`.`currency` AS `currency`,`t`.`payment_status` AS `payment_status`,`t`.`payment_date` AS `payment_date`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_payments` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_payments') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_people`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_people`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_people` AS select `t`.`person_ID` AS `person_ID`,`t`.`user_ID` AS `user_ID`,`t`.`courtesy_title` AS `courtesy_title`,`t`.`given_names` AS `given_names`,`t`.`family_names` AS `family_names`,`t`.`birth_date` AS `birth_date`,`t`.`gender` AS `gender`,`t`.`country_code` AS `country_code`,`t`.`phone` AS `phone`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_people` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_people') and (`l`.`record_id` = cast(`t`.`person_ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_productos` AS select `t`.`ID` AS `ID`,`t`.`SKU` AS `SKU`,`t`.`name` AS `name`,`t`.`description` AS `description`,`t`.`current_price` AS `current_price`,`t`.`current_stock` AS `current_stock`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_products` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_products') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_productos_categorias`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos_categorias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_productos_categorias` AS select `t`.`product_ID` AS `product_ID`,`t`.`category_ID` AS `category_ID`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_products_categories` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_products_categories') and (`l`.`record_id` = cast(concat(`t`.`product_ID`,'-',`t`.`category_ID`) as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_products_users_providers`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_products_users_providers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_products_users_providers` AS select `t`.`user_ID` AS `user_ID`,`t`.`product_ID` AS `product_ID`,`t`.`type_ownership` AS `type_ownership`,`t`.`status` AS `status`,`t`.`available_date` AS `available_date`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_products_users_providers` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_products_users_providers') and (`l`.`record_id` = cast(concat(`t`.`user_ID`,'-',`t`.`product_ID`) as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_refunds`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_refunds`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_refunds` AS select `t`.`ID` AS `ID`,`t`.`payment_ID` AS `payment_ID`,`t`.`return_ID` AS `return_ID`,`t`.`cancellation_ID` AS `cancellation_ID`,`t`.`amount` AS `amount`,`t`.`refund_status` AS `refund_status`,`t`.`refund_reference` AS `refund_reference`,`t`.`refund_date` AS `refund_date`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_refunds` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_refunds') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_return_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_return_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_return_items` AS select `t`.`ID` AS `ID`,`t`.`return_ID` AS `return_ID`,`t`.`order_item_ID` AS `order_item_ID`,`t`.`quantity` AS `quantity`,`t`.`condition_notes` AS `condition_notes`,`t`.`creation_date` AS `creation_date`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_return_items` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_return_items') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_returns`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_returns`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_returns` AS select `t`.`ID` AS `ID`,`t`.`order_ID` AS `order_ID`,`t`.`user_ID` AS `user_ID`,`t`.`reason` AS `reason`,`t`.`return_status` AS `return_status`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_returns` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_returns') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_shipments`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_shipments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_shipments` AS select `t`.`ID` AS `ID`,`t`.`order_ID` AS `order_ID`,`t`.`carrier` AS `carrier`,`t`.`tracking_number` AS `tracking_number`,`t`.`shipment_status` AS `shipment_status`,`t`.`shipped_date` AS `shipped_date`,`t`.`estimated_delivery` AS `estimated_delivery`,`t`.`delivered_date` AS `delivered_date`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_shipments` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_shipments') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_user_addresses`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_user_addresses` AS select `t`.`ID` AS `ID`,`t`.`user_ID` AS `user_ID`,`t`.`address_label` AS `address_label`,`t`.`recipient_name` AS `recipient_name`,`t`.`recipient_phone` AS `recipient_phone`,`t`.`delivery_instructions` AS `delivery_instructions`,`t`.`latitude` AS `latitude`,`t`.`longitude` AS `longitude`,`t`.`is_default` AS `is_default`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_user_addresses` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_user_addresses') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_user_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_user_payment_methods` AS select `t`.`ID` AS `ID`,`t`.`user_ID` AS `user_ID`,`t`.`payment_method_type_ID` AS `payment_method_type_ID`,`t`.`provider` AS `provider`,concat('****',right(`t`.`provider_method_ref`,4)) AS `provider_method_ref`,`t`.`label` AS `label`,`t`.`last_four` AS `last_four`,`t`.`is_default` AS `is_default`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_user_payment_methods` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_user_payment_methods') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_users_wishlist_products`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_users_wishlist_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_users_wishlist_products` AS select `t`.`user_ID` AS `user_ID`,`t`.`product_ID` AS `product_ID`,`t`.`status` AS `status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tbd_users_wishlist_products` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tbd_users_wishlist_products') and (`l`.`record_id` = cast(concat(`t`.`user_ID`,'-',`t`.`product_ID`) as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_usuarios`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_usuarios` AS select `t`.`ID` AS `ID`,`t`.`email` AS `email`,`t`.`nick` AS `username`,`t`.`roles` AS `roles`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update`,`t`.`last_login` AS `last_login`,`t`.`status` AS `status`,`l`.`id` AS `log_id`,`l`.`operation` AS `log_operation`,`l`.`db_user` AS `log_db_user`,`l`.`record_id` AS `log_record_id`,`l`.`description` AS `log_description`,`l`.`operation_date` AS `log_date`,`l`.`operation_status` AS `log_status` from (`tb_users` `t` left join `tb_logs` `l` on(((`l`.`table_name` = 'tb_users') and (`l`.`record_id` = cast(`t`.`ID` as char charset utf8mb4))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12 13:02:52
