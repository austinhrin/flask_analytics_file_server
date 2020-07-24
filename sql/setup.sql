CREATE DATABASE analytics;

CREATE USER 'analytics'@'localhost' IDENTIFIED BY 'supersecretpassword';

GRANT ALL ON analytics.* to 'analytics'@'localhost';

FLUSH PRIVILEGES;

USE analytics;

CREATE TABLE `MAIN` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `USER_AGENT` varchar(255) DEFAULT NULL,
  `REFERER` varchar(2083) DEFAULT NULL,
  `URL` varchar(2083) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `EPOCHTIME` int(10) DEFAULT NULL,
  `COOKIE` varchar(42) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;