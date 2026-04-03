-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: lunar_livewire
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint unsigned DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint unsigned DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2674 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_addresses`
--

DROP TABLE IF EXISTS `lunar_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_one` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `line_two` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_three` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_instructions` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `shipping_default` tinyint(1) NOT NULL DEFAULT '0',
  `billing_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_addresses_customer_id_foreign` (`customer_id`),
  KEY `lunar_addresses_country_id_foreign` (`country_id`),
  CONSTRAINT `lunar_addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`),
  CONSTRAINT `lunar_addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `lunar_customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_assets`
--

DROP TABLE IF EXISTS `lunar_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_assets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_attributables`
--

DROP TABLE IF EXISTS `lunar_attributables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_attributables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attributable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attributable_id` bigint unsigned NOT NULL,
  `attribute_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_attributables_attributable_type_attributable_id_index` (`attributable_type`,`attributable_id`),
  KEY `lunar_attributables_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `lunar_attributables_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `lunar_attributes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_attribute_groups`
--

DROP TABLE IF EXISTS `lunar_attribute_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_attribute_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attributable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` json NOT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_attribute_groups_handle_unique` (`handle`),
  KEY `lunar_attribute_groups_attributable_type_index` (`attributable_type`),
  KEY `lunar_attribute_groups_position_index` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_attributes`
--

DROP TABLE IF EXISTS `lunar_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_group_id` bigint unsigned NOT NULL,
  `position` int NOT NULL,
  `name` json NOT NULL,
  `description` json DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL,
  `default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `configuration` json NOT NULL,
  `system` tinyint(1) NOT NULL,
  `validation_rules` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filterable` tinyint(1) NOT NULL DEFAULT '0',
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_attributes_attribute_type_handle_unique` (`attribute_type`,`handle`),
  KEY `lunar_attributes_attribute_group_id_foreign` (`attribute_group_id`),
  KEY `lunar_attributes_attribute_type_index` (`attribute_type`),
  KEY `lunar_attributes_position_index` (`position`),
  KEY `lunar_attributes_type_index` (`type`),
  KEY `lunar_attributes_searchable_index` (`searchable`),
  KEY `lunar_attributes_filterable_index` (`filterable`),
  CONSTRAINT `lunar_attributes_attribute_group_id_foreign` FOREIGN KEY (`attribute_group_id`) REFERENCES `lunar_attribute_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_brand_collection`
--

DROP TABLE IF EXISTS `lunar_brand_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_brand_collection` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` bigint unsigned NOT NULL,
  `collection_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_brand_collection_brand_id_foreign` (`brand_id`),
  KEY `lunar_brand_collection_collection_id_foreign` (`collection_id`),
  CONSTRAINT `lunar_brand_collection_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `lunar_brands` (`id`),
  CONSTRAINT `lunar_brand_collection_collection_id_foreign` FOREIGN KEY (`collection_id`) REFERENCES `lunar_collections` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_brand_discount`
--

DROP TABLE IF EXISTS `lunar_brand_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_brand_discount` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` bigint unsigned NOT NULL,
  `discount_id` bigint unsigned NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'limitation',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_brand_discount_brand_id_foreign` (`brand_id`),
  KEY `lunar_brand_discount_discount_id_foreign` (`discount_id`),
  CONSTRAINT `lunar_brand_discount_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `lunar_brands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lunar_brand_discount_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_brands`
--

DROP TABLE IF EXISTS `lunar_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_cart_addresses`
--

DROP TABLE IF EXISTS `lunar_cart_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_cart_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` bigint unsigned NOT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_one` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_two` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_three` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_instructions` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'shipping',
  `shipping_option` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_cart_addresses_cart_id_foreign` (`cart_id`),
  KEY `lunar_cart_addresses_country_id_foreign` (`country_id`),
  KEY `lunar_cart_addresses_type_index` (`type`),
  CONSTRAINT `lunar_cart_addresses_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `lunar_carts` (`id`),
  CONSTRAINT `lunar_cart_addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_cart_line_discount`
--

DROP TABLE IF EXISTS `lunar_cart_line_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_cart_line_discount` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_line_id` bigint unsigned NOT NULL,
  `discount_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_cart_line_discount_cart_line_id_foreign` (`cart_line_id`),
  KEY `lunar_cart_line_discount_discount_id_foreign` (`discount_id`),
  CONSTRAINT `lunar_cart_line_discount_cart_line_id_foreign` FOREIGN KEY (`cart_line_id`) REFERENCES `lunar_carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lunar_cart_line_discount_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_cart_lines`
--

DROP TABLE IF EXISTS `lunar_cart_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_cart_lines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` bigint unsigned NOT NULL,
  `purchasable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchasable_id` bigint unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_cart_lines_cart_id_foreign` (`cart_id`),
  KEY `lunar_cart_lines_purchasable_type_purchasable_id_index` (`purchasable_type`,`purchasable_id`),
  CONSTRAINT `lunar_cart_lines_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `lunar_carts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_carts`
--

DROP TABLE IF EXISTS `lunar_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `merged_id` bigint unsigned DEFAULT NULL,
  `currency_id` bigint unsigned NOT NULL,
  `channel_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `coupon_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_carts_user_id_foreign` (`user_id`),
  KEY `lunar_carts_merged_id_foreign` (`merged_id`),
  KEY `lunar_carts_currency_id_foreign` (`currency_id`),
  KEY `lunar_carts_channel_id_foreign` (`channel_id`),
  KEY `lunar_carts_order_id_foreign` (`order_id`),
  KEY `lunar_carts_coupon_code_index` (`coupon_code`),
  KEY `lunar_carts_completed_at_index` (`completed_at`),
  KEY `lunar_carts_customer_id_foreign` (`customer_id`),
  CONSTRAINT `lunar_carts_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `lunar_channels` (`id`),
  CONSTRAINT `lunar_carts_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `lunar_currencies` (`id`),
  CONSTRAINT `lunar_carts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `lunar_customers` (`id`),
  CONSTRAINT `lunar_carts_merged_id_foreign` FOREIGN KEY (`merged_id`) REFERENCES `lunar_carts` (`id`),
  CONSTRAINT `lunar_carts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `lunar_orders` (`id`),
  CONSTRAINT `lunar_carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_channelables`
--

DROP TABLE IF EXISTS `lunar_channelables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_channelables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint unsigned NOT NULL,
  `channelable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channelable_id` bigint unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_channelables_channel_id_foreign` (`channel_id`),
  KEY `lunar_channelables_channelable_type_channelable_id_index` (`channelable_type`,`channelable_id`),
  KEY `lunar_channelables_ends_at_index` (`ends_at`),
  KEY `lunar_channelables_enabled_index` (`enabled`),
  KEY `lunar_channelables_starts_at_index` (`starts_at`),
  CONSTRAINT `lunar_channelables_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `lunar_channels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_channels`
--

DROP TABLE IF EXISTS `lunar_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_channels_handle_unique` (`handle`),
  KEY `lunar_channels_default_index` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_collection_customer_group`
--

DROP TABLE IF EXISTS `lunar_collection_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_collection_customer_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `collection_id` bigint unsigned NOT NULL,
  `customer_group_id` bigint unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_collection_customer_group_collection_id_foreign` (`collection_id`),
  KEY `lunar_collection_customer_group_customer_group_id_foreign` (`customer_group_id`),
  KEY `lunar_collection_customer_group_enabled_index` (`enabled`),
  KEY `lunar_collection_customer_group_starts_at_index` (`starts_at`),
  KEY `lunar_collection_customer_group_ends_at_index` (`ends_at`),
  KEY `lunar_collection_customer_group_visible_index` (`visible`),
  CONSTRAINT `lunar_collection_customer_group_collection_id_foreign` FOREIGN KEY (`collection_id`) REFERENCES `lunar_collections` (`id`),
  CONSTRAINT `lunar_collection_customer_group_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_collection_discount`
--

DROP TABLE IF EXISTS `lunar_collection_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_collection_discount` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` bigint unsigned NOT NULL,
  `collection_id` bigint unsigned NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'limitation',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_collection_discount_discount_id_foreign` (`discount_id`),
  KEY `lunar_collection_discount_collection_id_foreign` (`collection_id`),
  CONSTRAINT `lunar_collection_discount_collection_id_foreign` FOREIGN KEY (`collection_id`) REFERENCES `lunar_collections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lunar_collection_discount_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_collection_groups`
--

DROP TABLE IF EXISTS `lunar_collection_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_collection_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_collection_groups_handle_unique` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_collection_product`
--

DROP TABLE IF EXISTS `lunar_collection_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_collection_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `collection_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `position` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_collection_product_collection_id_foreign` (`collection_id`),
  KEY `lunar_collection_product_product_id_foreign` (`product_id`),
  KEY `lunar_collection_product_position_index` (`position`),
  CONSTRAINT `lunar_collection_product_collection_id_foreign` FOREIGN KEY (`collection_id`) REFERENCES `lunar_collections` (`id`),
  CONSTRAINT `lunar_collection_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `lunar_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_collections`
--

DROP TABLE IF EXISTS `lunar_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_collections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `collection_group_id` bigint unsigned NOT NULL,
  `_lft` int unsigned NOT NULL DEFAULT '0',
  `_rgt` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'static',
  `attribute_data` json NOT NULL,
  `sort` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_collections_collection_group_id_foreign` (`collection_group_id`),
  KEY `lunar_collections__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`),
  KEY `lunar_collections_type_index` (`type`),
  KEY `lunar_collections_sort_index` (`sort`),
  CONSTRAINT `lunar_collections_collection_group_id_foreign` FOREIGN KEY (`collection_group_id`) REFERENCES `lunar_collection_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_countries`
--

DROP TABLE IF EXISTS `lunar_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_countries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iso3` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iso2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phonecode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capital` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `native` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emoji` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `emoji_u` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_countries_iso3_unique` (`iso3`),
  UNIQUE KEY `lunar_countries_iso2_unique` (`iso2`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_country_shipping_zone`
--

DROP TABLE IF EXISTS `lunar_country_shipping_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_country_shipping_zone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country_id` bigint unsigned NOT NULL,
  `shipping_zone_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_country_shipping_zone_country_id_foreign` (`country_id`),
  KEY `lunar_country_shipping_zone_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `lunar_country_shipping_zone_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`),
  CONSTRAINT `lunar_country_shipping_zone_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `lunar_shipping_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_currencies`
--

DROP TABLE IF EXISTS `lunar_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` decimal(10,4) NOT NULL,
  `decimal_places` int NOT NULL DEFAULT '2',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `sync_prices` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_currencies_code_unique` (`code`),
  KEY `lunar_currencies_decimal_places_index` (`decimal_places`),
  KEY `lunar_currencies_enabled_index` (`enabled`),
  KEY `lunar_currencies_default_index` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_customer_group`
--

DROP TABLE IF EXISTS `lunar_customer_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_customer_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `customer_group_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customer_customer_group_customer_id_foreign` (`customer_id`),
  KEY `lunar_customer_customer_group_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `lunar_customer_customer_group_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`),
  CONSTRAINT `lunar_customer_customer_group_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `lunar_customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_discount`
--

DROP TABLE IF EXISTS `lunar_customer_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_discount` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customer_discount_discount_id_foreign` (`discount_id`),
  KEY `lunar_customer_discount_customer_id_foreign` (`customer_id`),
  CONSTRAINT `lunar_customer_discount_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `lunar_customers` (`id`),
  CONSTRAINT `lunar_customer_discount_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_group_discount`
--

DROP TABLE IF EXISTS `lunar_customer_group_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_group_discount` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` bigint unsigned NOT NULL,
  `customer_group_id` bigint unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customer_group_discount_discount_id_foreign` (`discount_id`),
  KEY `lunar_customer_group_discount_customer_group_id_foreign` (`customer_group_id`),
  KEY `lunar_customer_group_discount_enabled_index` (`enabled`),
  KEY `lunar_customer_group_discount_starts_at_index` (`starts_at`),
  KEY `lunar_customer_group_discount_ends_at_index` (`ends_at`),
  KEY `lunar_customer_group_discount_visible_index` (`visible`),
  CONSTRAINT `lunar_customer_group_discount_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`),
  CONSTRAINT `lunar_customer_group_discount_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_group_product`
--

DROP TABLE IF EXISTS `lunar_customer_group_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_group_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `purchasable` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customer_group_product_customer_group_id_foreign` (`customer_group_id`),
  KEY `lunar_customer_group_product_product_id_foreign` (`product_id`),
  KEY `lunar_customer_group_product_enabled_index` (`enabled`),
  KEY `lunar_customer_group_product_starts_at_index` (`starts_at`),
  KEY `lunar_customer_group_product_ends_at_index` (`ends_at`),
  KEY `lunar_customer_group_product_visible_index` (`visible`),
  KEY `lunar_customer_group_product_purchasable_index` (`purchasable`),
  CONSTRAINT `lunar_customer_group_product_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`),
  CONSTRAINT `lunar_customer_group_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `lunar_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_group_shipping_method`
--

DROP TABLE IF EXISTS `lunar_customer_group_shipping_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_group_shipping_method` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_id` bigint unsigned NOT NULL,
  `shipping_method_id` bigint unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customer_group_shipping_method_customer_group_id_foreign` (`customer_group_id`),
  KEY `lunar_customer_group_shipping_method_shipping_method_id_foreign` (`shipping_method_id`),
  KEY `lunar_customer_group_shipping_method_enabled_index` (`enabled`),
  KEY `lunar_customer_group_shipping_method_starts_at_index` (`starts_at`),
  KEY `lunar_customer_group_shipping_method_ends_at_index` (`ends_at`),
  KEY `lunar_customer_group_shipping_method_visible_index` (`visible`),
  CONSTRAINT `lunar_customer_group_shipping_method_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`),
  CONSTRAINT `lunar_customer_group_shipping_method_shipping_method_id_foreign` FOREIGN KEY (`shipping_method_id`) REFERENCES `lunar_shipping_methods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_groups`
--

DROP TABLE IF EXISTS `lunar_customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `attribute_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_customer_groups_handle_unique` (`handle`),
  KEY `lunar_customer_groups_default_index` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customer_user`
--

DROP TABLE IF EXISTS `lunar_customer_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customer_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customer_user_customer_id_foreign` (`customer_id`),
  KEY `lunar_customer_user_user_id_foreign` (`user_id`),
  CONSTRAINT `lunar_customer_user_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `lunar_customers` (`id`),
  CONSTRAINT `lunar_customer_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=378 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_customers`
--

DROP TABLE IF EXISTS `lunar_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_ref` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_data` json DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_customers_account_ref_index` (`account_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_discount_user`
--

DROP TABLE IF EXISTS `lunar_discount_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_discount_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_discount_user_discount_id_foreign` (`discount_id`),
  KEY `lunar_discount_user_user_id_foreign` (`user_id`),
  CONSTRAINT `lunar_discount_user_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lunar_discount_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_discountables`
--

DROP TABLE IF EXISTS `lunar_discountables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_discountables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` bigint unsigned NOT NULL,
  `discountable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discountable_id` bigint unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'condition',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_discount_purchasables_discount_id_foreign` (`discount_id`),
  KEY `purchasable_idx` (`discountable_type`,`discountable_id`),
  KEY `lunar_discount_purchasables_type_index` (`type`),
  CONSTRAINT `lunar_discount_purchasables_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `lunar_discounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_discounts`
--

DROP TABLE IF EXISTS `lunar_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime DEFAULT NULL,
  `uses` int unsigned NOT NULL DEFAULT '0',
  `max_uses` mediumint unsigned DEFAULT NULL,
  `max_uses_per_user` mediumint unsigned DEFAULT NULL,
  `priority` mediumint unsigned NOT NULL DEFAULT '1',
  `stop` tinyint(1) NOT NULL DEFAULT '0',
  `restriction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_discounts_handle_unique` (`handle`),
  UNIQUE KEY `lunar_discounts_coupon_unique` (`coupon`),
  KEY `lunar_discounts_type_index` (`type`),
  KEY `lunar_discounts_starts_at_index` (`starts_at`),
  KEY `lunar_discounts_ends_at_index` (`ends_at`),
  KEY `lunar_discounts_uses_index` (`uses`),
  KEY `lunar_discounts_priority_index` (`priority`),
  KEY `lunar_discounts_stop_index` (`stop`),
  KEY `lunar_discounts_restriction_index` (`restriction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_exclusion_list_shipping_zone`
--

DROP TABLE IF EXISTS `lunar_exclusion_list_shipping_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_exclusion_list_shipping_zone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `exclusion_id` bigint unsigned NOT NULL,
  `shipping_zone_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_exclusion_list_shipping_zone_exclusion_id_foreign` (`exclusion_id`),
  KEY `lunar_exclusion_list_shipping_zone_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `lunar_exclusion_list_shipping_zone_exclusion_id_foreign` FOREIGN KEY (`exclusion_id`) REFERENCES `lunar_shipping_exclusion_lists` (`id`),
  CONSTRAINT `lunar_exclusion_list_shipping_zone_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `lunar_shipping_zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_languages`
--

DROP TABLE IF EXISTS `lunar_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_languages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_languages_code_unique` (`code`),
  KEY `lunar_languages_default_index` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_media_product_variant`
--

DROP TABLE IF EXISTS `lunar_media_product_variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_media_product_variant` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_id` bigint unsigned NOT NULL,
  `product_variant_id` bigint unsigned NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `position` smallint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_media_product_variant_media_id_foreign` (`media_id`),
  KEY `lunar_media_product_variant_product_variant_id_foreign` (`product_variant_id`),
  KEY `lunar_media_product_variant_primary_index` (`primary`),
  KEY `lunar_media_product_variant_position_index` (`position`),
  CONSTRAINT `lunar_media_product_variant_media_id_foreign` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lunar_media_product_variant_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `lunar_product_variants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_order_addresses`
--

DROP TABLE IF EXISTS `lunar_order_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_order_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_one` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_two` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_three` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_instructions` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'shipping',
  `shipping_option` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_order_addresses_order_id_foreign` (`order_id`),
  KEY `lunar_order_addresses_country_id_foreign` (`country_id`),
  KEY `lunar_order_addresses_type_index` (`type`),
  CONSTRAINT `lunar_order_addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`),
  CONSTRAINT `lunar_order_addresses_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `lunar_orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_order_lines`
--

DROP TABLE IF EXISTS `lunar_order_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_order_lines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `purchasable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchasable_id` bigint unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` bigint unsigned NOT NULL,
  `unit_quantity` smallint unsigned NOT NULL DEFAULT '1',
  `quantity` int unsigned NOT NULL,
  `sub_total` bigint unsigned NOT NULL,
  `discount_total` bigint unsigned NOT NULL,
  `tax_breakdown` json NOT NULL,
  `tax_total` bigint unsigned NOT NULL,
  `total` bigint unsigned NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_order_lines_order_id_foreign` (`order_id`),
  KEY `lunar_order_lines_purchasable_type_purchasable_id_index` (`purchasable_type`,`purchasable_id`),
  KEY `lunar_order_lines_type_index` (`type`),
  KEY `lunar_order_lines_identifier_index` (`identifier`),
  KEY `lunar_order_lines_unit_price_index` (`unit_price`),
  KEY `lunar_order_lines_unit_quantity_index` (`unit_quantity`),
  KEY `lunar_order_lines_sub_total_index` (`sub_total`),
  KEY `lunar_order_lines_discount_total_index` (`discount_total`),
  KEY `lunar_order_lines_tax_total_index` (`tax_total`),
  KEY `lunar_order_lines_total_index` (`total`),
  CONSTRAINT `lunar_order_lines_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `lunar_orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1643 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_order_shipping_zone`
--

DROP TABLE IF EXISTS `lunar_order_shipping_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_order_shipping_zone` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `shipping_zone_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_order_shipping_zone_order_id_foreign` (`order_id`),
  KEY `lunar_order_shipping_zone_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `lunar_order_shipping_zone_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `lunar_orders` (`id`),
  CONSTRAINT `lunar_order_shipping_zone_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `lunar_shipping_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_orders`
--

DROP TABLE IF EXISTS `lunar_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `cart_id` bigint unsigned DEFAULT NULL,
  `channel_id` bigint unsigned NOT NULL,
  `new_customer` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total` bigint unsigned NOT NULL,
  `discount_breakdown` json DEFAULT NULL,
  `discount_total` bigint unsigned NOT NULL,
  `shipping_breakdown` json DEFAULT NULL,
  `shipping_total` bigint unsigned NOT NULL,
  `tax_breakdown` json NOT NULL,
  `tax_total` bigint unsigned NOT NULL,
  `total` bigint unsigned NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `currency_code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `compare_currency_code` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_rate` decimal(10,4) NOT NULL DEFAULT '1.0000',
  `placed_at` datetime DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fingerprint` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_orders_reference_unique` (`reference`),
  KEY `lunar_orders_user_id_foreign` (`user_id`),
  KEY `lunar_orders_channel_id_foreign` (`channel_id`),
  KEY `lunar_orders_status_index` (`status`),
  KEY `lunar_orders_sub_total_index` (`sub_total`),
  KEY `lunar_orders_discount_total_index` (`discount_total`),
  KEY `lunar_orders_shipping_total_index` (`shipping_total`),
  KEY `lunar_orders_tax_total_index` (`tax_total`),
  KEY `lunar_orders_total_index` (`total`),
  KEY `lunar_orders_placed_at_index` (`placed_at`),
  KEY `lunar_orders_customer_id_foreign` (`customer_id`),
  KEY `lunar_orders_new_customer_index` (`new_customer`),
  KEY `lunar_orders_cart_id_foreign` (`cart_id`),
  KEY `lunar_orders_fingerprint_index` (`fingerprint`),
  CONSTRAINT `lunar_orders_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `lunar_carts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lunar_orders_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `lunar_channels` (`id`),
  CONSTRAINT `lunar_orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `lunar_customers` (`id`),
  CONSTRAINT `lunar_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_prices`
--

DROP TABLE IF EXISTS `lunar_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_id` bigint unsigned DEFAULT NULL,
  `currency_id` bigint unsigned NOT NULL,
  `priceable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priceable_id` bigint unsigned NOT NULL,
  `price` bigint unsigned NOT NULL,
  `compare_price` bigint unsigned DEFAULT NULL,
  `min_quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_prices_customer_group_id_foreign` (`customer_group_id`),
  KEY `lunar_prices_currency_id_foreign` (`currency_id`),
  KEY `lunar_prices_priceable_type_priceable_id_index` (`priceable_type`,`priceable_id`),
  KEY `lunar_prices_price_index` (`price`),
  KEY `lunar_prices_tier_index` (`min_quantity`),
  CONSTRAINT `lunar_prices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `lunar_currencies` (`id`),
  CONSTRAINT `lunar_prices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_associations`
--

DROP TABLE IF EXISTS `lunar_product_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_associations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_parent_id` bigint unsigned NOT NULL,
  `product_target_id` bigint unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_product_associations_product_parent_id_foreign` (`product_parent_id`),
  KEY `lunar_product_associations_product_target_id_foreign` (`product_target_id`),
  KEY `lunar_product_associations_type_index` (`type`),
  CONSTRAINT `lunar_product_associations_product_parent_id_foreign` FOREIGN KEY (`product_parent_id`) REFERENCES `lunar_products` (`id`),
  CONSTRAINT `lunar_product_associations_product_target_id_foreign` FOREIGN KEY (`product_target_id`) REFERENCES `lunar_products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_option_value_product_variant`
--

DROP TABLE IF EXISTS `lunar_product_option_value_product_variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_option_value_product_variant` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `value_id` bigint unsigned NOT NULL,
  `variant_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_product_option_value_product_variant_value_id_foreign` (`value_id`),
  KEY `lunar_product_option_value_product_variant_variant_id_foreign` (`variant_id`),
  CONSTRAINT `lunar_product_option_value_product_variant_value_id_foreign` FOREIGN KEY (`value_id`) REFERENCES `lunar_product_option_values` (`id`),
  CONSTRAINT `lunar_product_option_value_product_variant_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `lunar_product_variants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_option_values`
--

DROP TABLE IF EXISTS `lunar_product_option_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_option_values` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_option_id` bigint unsigned NOT NULL,
  `name` json NOT NULL,
  `position` int NOT NULL DEFAULT '0',
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_product_option_values_product_option_id_foreign` (`product_option_id`),
  KEY `lunar_product_option_values_position_index` (`position`),
  CONSTRAINT `lunar_product_option_values_product_option_id_foreign` FOREIGN KEY (`product_option_id`) REFERENCES `lunar_product_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_options`
--

DROP TABLE IF EXISTS `lunar_product_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` json NOT NULL,
  `label` json DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_product_options_shared_index` (`shared`),
  KEY `lunar_product_options_handle_index` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_product_option`
--

DROP TABLE IF EXISTS `lunar_product_product_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_product_option` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `product_option_id` bigint unsigned NOT NULL,
  `position` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_product_product_option_product_id_foreign` (`product_id`),
  KEY `lunar_product_product_option_product_option_id_foreign` (`product_option_id`),
  KEY `lunar_product_product_option_position_index` (`position`),
  CONSTRAINT `lunar_product_product_option_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `lunar_products` (`id`),
  CONSTRAINT `lunar_product_product_option_product_option_id_foreign` FOREIGN KEY (`product_option_id`) REFERENCES `lunar_product_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_types`
--

DROP TABLE IF EXISTS `lunar_product_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_product_variants`
--

DROP TABLE IF EXISTS `lunar_product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_product_variants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `tax_class_id` bigint unsigned NOT NULL,
  `attribute_data` json DEFAULT NULL,
  `tax_ref` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_quantity` int unsigned NOT NULL DEFAULT '1',
  `min_quantity` int unsigned NOT NULL DEFAULT '1',
  `quantity_increment` int unsigned NOT NULL DEFAULT '1',
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gtin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mpn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ean` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `length_value` decimal(10,4) DEFAULT '0.0000',
  `length_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'mm',
  `width_value` decimal(10,4) DEFAULT '0.0000',
  `width_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'mm',
  `height_value` decimal(10,4) DEFAULT '0.0000',
  `height_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'mm',
  `weight_value` decimal(10,4) DEFAULT '0.0000',
  `weight_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'mm',
  `volume_value` decimal(10,4) DEFAULT '0.0000',
  `volume_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'mm',
  `shippable` tinyint(1) NOT NULL DEFAULT '1',
  `stock` int NOT NULL DEFAULT '0',
  `backorder` int NOT NULL DEFAULT '0',
  `purchasable` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'always',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_product_variants_product_id_foreign` (`product_id`),
  KEY `lunar_product_variants_tax_class_id_foreign` (`tax_class_id`),
  KEY `lunar_product_variants_tax_ref_index` (`tax_ref`),
  KEY `lunar_product_variants_unit_quantity_index` (`unit_quantity`),
  KEY `lunar_product_variants_sku_index` (`sku`),
  KEY `lunar_product_variants_gtin_index` (`gtin`),
  KEY `lunar_product_variants_mpn_index` (`mpn`),
  KEY `lunar_product_variants_ean_index` (`ean`),
  KEY `lunar_product_variants_length_value_index` (`length_value`),
  KEY `lunar_product_variants_width_value_index` (`width_value`),
  KEY `lunar_product_variants_height_value_index` (`height_value`),
  KEY `lunar_product_variants_weight_value_index` (`weight_value`),
  KEY `lunar_product_variants_volume_value_index` (`volume_value`),
  KEY `lunar_product_variants_shippable_index` (`shippable`),
  KEY `lunar_product_variants_stock_index` (`stock`),
  KEY `lunar_product_variants_backorder_index` (`backorder`),
  KEY `lunar_product_variants_purchasable_index` (`purchasable`),
  KEY `lunar_product_variants_quantity_increment_index` (`quantity_increment`),
  KEY `lunar_product_variants_min_quantity_index` (`min_quantity`),
  KEY `lunar_product_variants_deleted_at_index` (`deleted_at`),
  CONSTRAINT `lunar_product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `lunar_products` (`id`),
  CONSTRAINT `lunar_product_variants_tax_class_id_foreign` FOREIGN KEY (`tax_class_id`) REFERENCES `lunar_tax_classes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_products`
--

DROP TABLE IF EXISTS `lunar_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` bigint unsigned DEFAULT NULL,
  `product_type_id` bigint unsigned NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_products_product_type_id_foreign` (`product_type_id`),
  KEY `lunar_products_status_index` (`status`),
  KEY `lunar_products_brand_id_foreign` (`brand_id`),
  KEY `lunar_products_deleted_at_index` (`deleted_at`),
  CONSTRAINT `lunar_products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `lunar_brands` (`id`),
  CONSTRAINT `lunar_products_product_type_id_foreign` FOREIGN KEY (`product_type_id`) REFERENCES `lunar_product_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_shipping_exclusion_lists`
--

DROP TABLE IF EXISTS `lunar_shipping_exclusion_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_shipping_exclusion_lists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_shipping_exclusion_lists_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_shipping_exclusions`
--

DROP TABLE IF EXISTS `lunar_shipping_exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_shipping_exclusions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipping_exclusion_list_id` bigint unsigned NOT NULL,
  `purchasable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchasable_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_shipping_exclusions_shipping_exclusion_list_id_foreign` (`shipping_exclusion_list_id`),
  KEY `shipping_exclusions_purchasable_type_purchasable_id_index` (`purchasable_type`,`purchasable_id`),
  CONSTRAINT `lunar_shipping_exclusions_shipping_exclusion_list_id_foreign` FOREIGN KEY (`shipping_exclusion_list_id`) REFERENCES `lunar_shipping_exclusion_lists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_shipping_methods`
--

DROP TABLE IF EXISTS `lunar_shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_shipping_methods` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `stock_available` tinyint(1) NOT NULL DEFAULT '0',
  `cutoff` time DEFAULT NULL,
  `data` json DEFAULT NULL,
  `driver` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_shipping_methods_code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_shipping_rates`
--

DROP TABLE IF EXISTS `lunar_shipping_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_shipping_rates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipping_method_id` bigint unsigned NOT NULL,
  `shipping_zone_id` bigint unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_shipping_rates_shipping_method_id_foreign` (`shipping_method_id`),
  KEY `lunar_shipping_rates_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `lunar_shipping_rates_shipping_method_id_foreign` FOREIGN KEY (`shipping_method_id`) REFERENCES `lunar_shipping_methods` (`id`),
  CONSTRAINT `lunar_shipping_rates_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `lunar_shipping_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_shipping_zone_postcodes`
--

DROP TABLE IF EXISTS `lunar_shipping_zone_postcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_shipping_zone_postcodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipping_zone_id` bigint unsigned NOT NULL,
  `postcode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_shipping_zone_postcodes_shipping_zone_id_foreign` (`shipping_zone_id`),
  KEY `lunar_shipping_zone_postcodes_postcode_index` (`postcode`),
  CONSTRAINT `lunar_shipping_zone_postcodes_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `lunar_shipping_zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_shipping_zones`
--

DROP TABLE IF EXISTS `lunar_shipping_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_shipping_zones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_shipping_zones_type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_staff`
--

DROP TABLE IF EXISTS `lunar_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_staff` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lunar_staff_email_unique` (`email`),
  KEY `lunar_staff_admin_index` (`admin`),
  KEY `lunar_staff_firstname_index` (`first_name`),
  KEY `lunar_staff_lastname_index` (`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_state_shipping_zone`
--

DROP TABLE IF EXISTS `lunar_state_shipping_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_state_shipping_zone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `state_id` bigint unsigned NOT NULL,
  `shipping_zone_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_state_shipping_zone_state_id_foreign` (`state_id`),
  KEY `lunar_state_shipping_zone_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `lunar_state_shipping_zone_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `lunar_shipping_zones` (`id`),
  CONSTRAINT `lunar_state_shipping_zone_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `lunar_states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_states`
--

DROP TABLE IF EXISTS `lunar_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_states` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_states_country_id_foreign` (`country_id`),
  CONSTRAINT `lunar_states_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4889 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_stripe_payment_intents`
--

DROP TABLE IF EXISTS `lunar_stripe_payment_intents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_stripe_payment_intents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `intent_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processing_at` timestamp NULL DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_stripe_payment_intents_cart_id_foreign` (`cart_id`),
  KEY `lunar_stripe_payment_intents_order_id_foreign` (`order_id`),
  KEY `lunar_stripe_payment_intents_intent_id_index` (`intent_id`),
  KEY `lunar_stripe_payment_intents_event_id_index` (`event_id`),
  CONSTRAINT `lunar_stripe_payment_intents_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `lunar_carts` (`id`),
  CONSTRAINT `lunar_stripe_payment_intents_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `lunar_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_taggables`
--

DROP TABLE IF EXISTS `lunar_taggables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_taggables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` bigint unsigned NOT NULL,
  `taggable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taggable_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_taggables_tag_id_foreign` (`tag_id`),
  KEY `lunar_taggables_taggable_type_taggable_id_index` (`taggable_type`,`taggable_id`),
  CONSTRAINT `lunar_taggables_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `lunar_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tags`
--

DROP TABLE IF EXISTS `lunar_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tags_value_index` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_classes`
--

DROP TABLE IF EXISTS `lunar_tax_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_classes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_classes_default_index` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_rate_amounts`
--

DROP TABLE IF EXISTS `lunar_tax_rate_amounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_rate_amounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_class_id` bigint unsigned DEFAULT NULL,
  `tax_rate_id` bigint unsigned DEFAULT NULL,
  `percentage` decimal(7,3) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_rate_amounts_tax_class_id_foreign` (`tax_class_id`),
  KEY `lunar_tax_rate_amounts_tax_rate_id_foreign` (`tax_rate_id`),
  KEY `lunar_tax_rate_amounts_percentage_index` (`percentage`),
  CONSTRAINT `lunar_tax_rate_amounts_tax_class_id_foreign` FOREIGN KEY (`tax_class_id`) REFERENCES `lunar_tax_classes` (`id`),
  CONSTRAINT `lunar_tax_rate_amounts_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `lunar_tax_rates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_rates`
--

DROP TABLE IF EXISTS `lunar_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_rates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_zone_id` bigint unsigned DEFAULT NULL,
  `priority` tinyint unsigned NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_rates_tax_zone_id_foreign` (`tax_zone_id`),
  KEY `lunar_tax_rates_priority_index` (`priority`),
  CONSTRAINT `lunar_tax_rates_tax_zone_id_foreign` FOREIGN KEY (`tax_zone_id`) REFERENCES `lunar_tax_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_zone_countries`
--

DROP TABLE IF EXISTS `lunar_tax_zone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_zone_countries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_zone_id` bigint unsigned DEFAULT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_zone_countries_tax_zone_id_foreign` (`tax_zone_id`),
  KEY `lunar_tax_zone_countries_country_id_foreign` (`country_id`),
  CONSTRAINT `lunar_tax_zone_countries_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`),
  CONSTRAINT `lunar_tax_zone_countries_tax_zone_id_foreign` FOREIGN KEY (`tax_zone_id`) REFERENCES `lunar_tax_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_zone_customer_groups`
--

DROP TABLE IF EXISTS `lunar_tax_zone_customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_zone_customer_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_zone_id` bigint unsigned DEFAULT NULL,
  `customer_group_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_zone_customer_groups_tax_zone_id_foreign` (`tax_zone_id`),
  KEY `lunar_tax_zone_customer_groups_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `lunar_tax_zone_customer_groups_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `lunar_customer_groups` (`id`),
  CONSTRAINT `lunar_tax_zone_customer_groups_tax_zone_id_foreign` FOREIGN KEY (`tax_zone_id`) REFERENCES `lunar_tax_zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_zone_postcodes`
--

DROP TABLE IF EXISTS `lunar_tax_zone_postcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_zone_postcodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_zone_id` bigint unsigned DEFAULT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `postcode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_zone_postcodes_tax_zone_id_foreign` (`tax_zone_id`),
  KEY `lunar_tax_zone_postcodes_country_id_foreign` (`country_id`),
  KEY `lunar_tax_zone_postcodes_postcode_index` (`postcode`),
  CONSTRAINT `lunar_tax_zone_postcodes_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `lunar_countries` (`id`),
  CONSTRAINT `lunar_tax_zone_postcodes_tax_zone_id_foreign` FOREIGN KEY (`tax_zone_id`) REFERENCES `lunar_tax_zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_zone_states`
--

DROP TABLE IF EXISTS `lunar_tax_zone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_zone_states` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_zone_id` bigint unsigned DEFAULT NULL,
  `state_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_zone_states_tax_zone_id_foreign` (`tax_zone_id`),
  KEY `lunar_tax_zone_states_state_id_foreign` (`state_id`),
  CONSTRAINT `lunar_tax_zone_states_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `lunar_states` (`id`),
  CONSTRAINT `lunar_tax_zone_states_tax_zone_id_foreign` FOREIGN KEY (`tax_zone_id`) REFERENCES `lunar_tax_zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_tax_zones`
--

DROP TABLE IF EXISTS `lunar_tax_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_tax_zones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_display` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `default` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_tax_zones_zone_type_index` (`zone_type`),
  KEY `lunar_tax_zones_active_index` (`active`),
  KEY `lunar_tax_zones_default_index` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_transactions`
--

DROP TABLE IF EXISTS `lunar_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_transaction_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned NOT NULL,
  `success` tinyint(1) NOT NULL,
  `type` enum('refund','intent','capture') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'capture',
  `driver` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int unsigned NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_four` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `captured_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_transactions_order_id_foreign` (`order_id`),
  KEY `lunar_transactions_success_index` (`success`),
  KEY `lunar_transactions_amount_index` (`amount`),
  KEY `lunar_transactions_reference_index` (`reference`),
  KEY `lunar_transactions_card_type_index` (`card_type`),
  KEY `lunar_transactions_parent_transaction_id_foreign` (`parent_transaction_id`),
  KEY `lunar_transactions_captured_at_index` (`captured_at`),
  KEY `lunar_transactions_type_index` (`type`),
  CONSTRAINT `lunar_transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `lunar_orders` (`id`),
  CONSTRAINT `lunar_transactions_parent_transaction_id_foreign` FOREIGN KEY (`parent_transaction_id`) REFERENCES `lunar_transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lunar_urls`
--

DROP TABLE IF EXISTS `lunar_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lunar_urls` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint unsigned NOT NULL,
  `element_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `element_id` bigint unsigned NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lunar_urls_language_id_foreign` (`language_id`),
  KEY `lunar_urls_element_type_element_id_index` (`element_type`,`element_id`),
  KEY `lunar_urls_slug_index` (`slug`),
  KEY `lunar_urls_default_index` (`default`),
  CONSTRAINT `lunar_urls_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `lunar_languages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=378 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-03 13:57:41
