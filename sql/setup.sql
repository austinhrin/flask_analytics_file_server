-- MySQL Script generated by MySQL Workbench
-- Tue Aug  4 00:30:39 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema web_hosting
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `web_hosting` ;

-- -----------------------------------------------------
-- Schema web_hosting
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `web_hosting` DEFAULT CHARACTER SET utf8 ;
USE `web_hosting` ;

-- -----------------------------------------------------
-- Table `web_hosting`.`websites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`websites` ;
CREATE TABLE IF NOT EXISTS `web_hosting`.`websites` (
  `website_id` INT NOT NULL AUTO_INCREMENT,
  `domain` VARCHAR(100) NULL,
  `folder` VARCHAR(100) NULL,
  `cms` TINYINT NULL,
  `forum` TINYINT NULL,
  `is_active` TINYINT NULL,
  `theme` VARCHAR(45) NULL,
  `added_date_time` DATETIME NULL,
  PRIMARY KEY (`website_id`),
  UNIQUE INDEX `id_UNIQUE` (`website_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`users` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(128) NULL,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `password_hash` VARCHAR(75) NULL,
  `stripe_id` VARCHAR(45) NULL,
  `join_date_time` DATETIME NULL,
  `last_login` DATETIME NULL,
  `google_id` VARCHAR(45) NULL,
  `facebook_id` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`analytics_user_agent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`analytics_user_agent` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`analytics_user_agent` (
  `user_agent_id` INT NOT NULL AUTO_INCREMENT,
  `user_agent` VARCHAR(512) NULL,
  PRIMARY KEY (`user_agent_id`),
  UNIQUE INDEX `id_UNIQUE` (`user_agent_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`analytics_url_path`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`analytics_url_path` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`analytics_url_path` (
  `url_path_id` INT NOT NULL AUTO_INCREMENT,
  `url_path` VARCHAR(1024) NULL,
  PRIMARY KEY (`url_path_id`),
  UNIQUE INDEX `id_UNIQUE` (`url_path_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`analytics_browser_fingerprint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`analytics_browser_fingerprint` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`analytics_browser_fingerprint` (
  `browser_fingerprint_id` INT NOT NULL AUTO_INCREMENT,
  `browser_fingerprint` VARCHAR(45) NULL,
  PRIMARY KEY (`browser_fingerprint_id`),
  UNIQUE INDEX `id_UNIQUE` (`browser_fingerprint_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`analytics_screen_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`analytics_screen_info` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`analytics_screen_info` (
  `screen_info_id` INT NOT NULL AUTO_INCREMENT,
  `screen_info` VARCHAR(45) NULL,
  PRIMARY KEY (`screen_info_id`),
  UNIQUE INDEX `id_UNIQUE` (`screen_info_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`analytics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`analytics` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`analytics` (
  `analytic_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `website_id` INT NOT NULL,
  `url_path_id` INT NULL,
  `ip` VARCHAR(45) NOT NULL,
  `date_time` DATETIME NOT NULL,
  `cookie` VARCHAR(45) NULL,
  `user_agent_id` INT NULL,
  `browser_fingerprint_id` INT NULL,
  `screen_info_id` INT NULL,
  PRIMARY KEY (`analytic_id`),
  UNIQUE INDEX `id_UNIQUE` (`analytic_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `website_id_idx` (`website_id` ASC),
  INDEX `user_agent_id_idx` (`user_agent_id` ASC),
  INDEX `url_path_id_idx` (`url_path_id` ASC),
  INDEX `browser_fingerprint_id_idx` (`browser_fingerprint_id` ASC),
  INDEX `screen_info_id_idx` (`screen_info_id` ASC),
  CONSTRAINT `analytics_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `web_hosting`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `analytics_website_id`
    FOREIGN KEY (`website_id`)
    REFERENCES `web_hosting`.`websites` (`website_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `analytics_user_agent_id`
    FOREIGN KEY (`user_agent_id`)
    REFERENCES `web_hosting`.`analytics_user_agent` (`user_agent_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `analytics_url_path_id`
    FOREIGN KEY (`url_path_id`)
    REFERENCES `web_hosting`.`analytics_url_path` (`url_path_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `analytics_browser_fingerprint_id`
    FOREIGN KEY (`browser_fingerprint_id`)
    REFERENCES `web_hosting`.`analytics_browser_fingerprint` (`browser_fingerprint_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `analytics_screen_info_id`
    FOREIGN KEY (`screen_info_id`)
    REFERENCES `web_hosting`.`analytics_screen_info` (`screen_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`website_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`website_permissions` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`website_permissions` (
  `permission_id` INT NOT NULL AUTO_INCREMENT,
  `website_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `permission` VARCHAR(128) NULL,
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `website_id_idx` (`website_id` ASC),
  PRIMARY KEY (`permission_id`),
  UNIQUE INDEX `id_UNIQUE` (`permission_id` ASC),
  CONSTRAINT `website_permissions_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `web_hosting`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `website_permissions_website_id`
    FOREIGN KEY (`website_id`)
    REFERENCES `web_hosting`.`websites` (`website_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`forum_sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`forum_sections` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`forum_sections` (
  `forum_section_id` INT NOT NULL AUTO_INCREMENT,
  `website_id` INT NULL,
  `parent_section_id` INT NULL COMMENT 'allows you to specify if the forum section listed is a child of another section',
  `title` VARCHAR(128) NULL,
  `description` VARCHAR(255) NULL,
  `date_created` DATETIME NULL,
  PRIMARY KEY (`forum_section_id`),
  UNIQUE INDEX `id_UNIQUE` (`forum_section_id` ASC),
  INDEX `website_id_idx` (`website_id` ASC),
  CONSTRAINT `forum_section_website_id`
    FOREIGN KEY (`website_id`)
    REFERENCES `web_hosting`.`websites` (`website_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_hosting`.`forum_posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_hosting`.`forum_posts` ;

CREATE TABLE IF NOT EXISTS `web_hosting`.`forum_posts` (
  `forum_post_id` INT NOT NULL AUTO_INCREMENT,
  `section_id` INT NULL,
  `title` VARCHAR(128) NULL,
  `date_created` DATETIME NULL,
  `date_updated` DATETIME NULL,
  `user_id` INT NULL,
  `post_body` VARCHAR(2048) NULL,
  PRIMARY KEY (`forum_post_id`),
  UNIQUE INDEX `id_UNIQUE` (`forum_post_id` ASC),
  INDEX `section_id_idx` (`section_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `forum_section_id`
    FOREIGN KEY (`section_id`)
    REFERENCES `web_hosting`.`forum_sections` (`forum_section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `forum_post_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `web_hosting`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO python; -- change the username here
DROP USER python; -- change the username here
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
-- -----------------------------------------------------
-- CHANGE THE USERNAME AND PASSWORD BELOW!!!!!!!
-- -----------------------------------------------------
CREATE USER 'python' IDENTIFIED BY 'SuperSecret!`';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;