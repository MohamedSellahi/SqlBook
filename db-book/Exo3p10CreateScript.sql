-- MySQL Script generated by MySQL Workbench
-- Fri May  5 14:15:51 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db-book
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-book
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-book` DEFAULT CHARACTER SET utf8 ;
USE `db-book` ;

-- -----------------------------------------------------
-- Table `db-book`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`Employee` (
  `employee_name` VARCHAR(8) NOT NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(15) NULL,
  PRIMARY KEY (`employee_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`Company` (
  `company_name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(15) NULL,
  PRIMARY KEY (`company_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`works`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`works` (
  `employee_name` VARCHAR(8) NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(8,2) NULL,
  PRIMARY KEY (`employee_name`),
  INDEX `fk_works_Employee_idx` (`employee_name` ASC),
  INDEX `fk_works_Company1_idx` (`company_name` ASC),
  CONSTRAINT `fk_works_Employee`
    FOREIGN KEY (`employee_name`)
    REFERENCES `db-book`.`Employee` (`employee_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_works_Company1`
    FOREIGN KEY (`company_name`)
    REFERENCES `db-book`.`Company` (`company_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`manager` (
  `employee_name` VARCHAR(8) NOT NULL,
  `manager_name` VARCHAR(8) NULL,
  PRIMARY KEY (`employee_name`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;