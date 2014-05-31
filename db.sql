# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.37-0ubuntu0.12.04.1)
# Database: sensors_bare
# Generation Time: 2014-05-31 10:14:20 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table calibration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `calibration`;

CREATE TABLE `calibration` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sensor_type_id` int(11) DEFAULT NULL,
  `datestart` date DEFAULT NULL,
  `dateend` date DEFAULT NULL,
  `gradient` double DEFAULT NULL,
  `intercept` double DEFAULT NULL,
  `ppm_calibrated_to` double DEFAULT NULL,
  `reference_resistance` double DEFAULT NULL,
  `supply_voltage` double DEFAULT NULL,
  `gain` double DEFAULT NULL,
  `resistance` double DEFAULT NULL,
  `calibrated_reading_voltage` double DEFAULT NULL,
  `sensor_resistance` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `calibration` WRITE;
/*!40000 ALTER TABLE `calibration` DISABLE KEYS */;

INSERT INTO `calibration` (`id`, `sensor_type_id`, `datestart`, `dateend`, `gradient`, `intercept`, `ppm_calibrated_to`, `reference_resistance`, `supply_voltage`, `gain`, `resistance`, `calibrated_reading_voltage`, `sensor_resistance`)
VALUES
	(1,4,NULL,NULL,0.480506592,1.003306937,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,4,NULL,NULL,0.46250665,1.096757696,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,4,NULL,NULL,1.48908095,-2.451791462,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,4,NULL,NULL,0.739241432,-0.492626325,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,NULL,NULL,1.871456699,2.698970004,5,0.013200948658692,1.8,1.88,33,0.668,134.174),
	(6,5,NULL,NULL,1.871456699,2.698970004,5,0.024390464822806,1.8,1.88,25,0.31,247.903),
	(7,5,NULL,NULL,1.871456699,2.698970004,5,0.012676528568544,1.8,1.88,33,0.69,128.843),
	(8,5,NULL,NULL,1.871456699,2.698970004,5,0.013840440144276,1.8,1.88,33,0.643,140.673),
	(9,5,NULL,NULL,1.871456699,2.698970004,5,0.020265348898501,1.8,1.88,50,0.661,205.976),
	(10,4,NULL,NULL,0.740623489,-0.11173659,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,5,NULL,NULL,1.871456699,2.698970004,5,0.012619043727681,1.8,1.88,33,0.693,128.259),
	(12,4,NULL,NULL,1.139330465,-1.171459304,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,5,NULL,NULL,1.871456699,2.698970004,5,0.020690215959183,1.8,1.88,33,0.459,210.294);

/*!40000 ALTER TABLE `calibration` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table device_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `device_types`;

CREATE TABLE `device_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sensor_type_id` (`device_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `device_types` WRITE;
/*!40000 ALTER TABLE `device_types` DISABLE KEYS */;

INSERT INTO `device_types` (`id`, `device_type_id`, `name`, `model`)
VALUES
	(1,1,'Waspmote','v1.1'),
	(2,2,'Arduino','Freetronics Etherten');

/*!40000 ALTER TABLE `device_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table devices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `devices`;

CREATE TABLE `devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `elevation_above_ground` float DEFAULT NULL,
  `date_deployed` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;

INSERT INTO `devices` (`id`, `device_id`, `location_name`, `latitude`, `longitude`, `elevation_above_ground`, `date_deployed`)
VALUES
	(1,'WASP0010','Manchester Town Hall Moat',53.4792,-2.24481,0,'2014-01-16'),
	(2,'WASP0011','Manchester Town Hall Clock Tower',53.4793,-2.24454,77,'2014-01-16'),
	(3,'WASP0012','MadLab',53.4842,-2.23628,6,'2014-01-17'),
	(4,'WASP0013','Grosvenor Park',53.4703,-2.23934,6,'2014-02-12'),
	(5,'WASP0016','Royal Exchange Theatre',53.4828,-2.24516,12,'2014-02-06'),
	(6,'WASP0014','Oxford Road Mancunian Way',53.4716,-2.23824,6,'2014-03-12'),
	(7,'WASP0015','Oxford Road Aquatics Centre',53.4688,-2.23577,6,'2014-03-12');

/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table readings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `readings`;

CREATE TABLE `readings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `sensor_id` int(11) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  `reading` varchar(255) NOT NULL,
  `minreading` varchar(255) DEFAULT NULL,
  `maxreading` varchar(255) DEFAULT NULL,
  `nodecounter` int(11) unsigned DEFAULT NULL,
  `coordcounter` int(11) unsigned DEFAULT NULL,
  `value` double DEFAULT NULL,
  `bounds_flag` int(11) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `elevation_above_ground` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `readings` WRITE;
/*!40000 ALTER TABLE `readings` DISABLE KEYS */;

INSERT INTO `readings` (`id`, `device_id`, `sensor_id`, `datetime`, `reading`, `minreading`, `maxreading`, `nodecounter`, `coordcounter`, `value`, `bounds_flag`, `latitude`, `longitude`, `elevation_above_ground`)
VALUES
	(1,'WASP0011',999,'2014-01-16 14:00:43','27.0000','27.0000','27.0000',1,1,27,0,53.4793,-2.24454,77);

/*!40000 ALTER TABLE `readings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sensor_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sensor_types`;

CREATE TABLE `sensor_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sensor_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `data_type` varchar(255) DEFAULT NULL,
  `bounds_low` double DEFAULT NULL,
  `bounds_high` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sensor_type_id` (`sensor_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sensor_types` WRITE;
/*!40000 ALTER TABLE `sensor_types` DISABLE KEYS */;

INSERT INTO `sensor_types` (`id`, `sensor_type_id`, `name`, `data_type`, `bounds_low`, `bounds_high`)
VALUES
	(1,1,'Temperature','Centigrade',-20,40),
	(2,2,'Humidity','Relative Humidity %',0,100),
	(3,3,'Carbon monoxide','Parts Per Million',30,1000),
	(4,4,'Carbon dioxide','Parts Per Million',350,10000),
	(5,5,'Nitrogen dioxide','Parts Per Million',0.05,5),
	(6,999,'Battery level','Charge %',0,100);

/*!40000 ALTER TABLE `sensor_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sensors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sensors`;

CREATE TABLE `sensors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `sensor_type_id` int(11) DEFAULT NULL,
  `available` tinyint(1) NOT NULL DEFAULT '0',
  `convert_reading_to_value` tinyint(1) NOT NULL DEFAULT '0',
  `calibration_id` int(11) DEFAULT NULL,
  `xively_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;

INSERT INTO `sensors` (`id`, `device_id`, `sensor_type_id`, `available`, `convert_reading_to_value`, `calibration_id`, `xively_id`)
VALUES
	(1,'WASP0010',1,1,1,NULL,1),
	(2,'WASP0010',2,0,0,NULL,NULL),
	(3,'WASP0010',3,0,0,NULL,NULL),
	(4,'WASP0010',4,0,0,NULL,NULL),
	(5,'WASP0010',5,1,1,5,2);

/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table xively
# ------------------------------------------------------------

DROP TABLE IF EXISTS `xively`;

CREATE TABLE `xively` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feed_id` varchar(255) DEFAULT '',
  `channel_id` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `xively` WRITE;
/*!40000 ALTER TABLE `xively` DISABLE KEYS */;

INSERT INTO `xively` (`id`, `feed_id`, `channel_id`, `api_key`)
VALUES
	(1,'INSERT-XIVELY-FEED-ID-HERE','INSERT-XIVELY-CHANNEL-ID-NAME-HERE','INSERT-XIVELY-CHANNEL-API-KEY-HERE');

/*!40000 ALTER TABLE `xively` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
