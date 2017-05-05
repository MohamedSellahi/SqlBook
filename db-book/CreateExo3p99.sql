-- MySQL Script generated by MySQL Workbench
-- Fri May  5 11:29:48 2017
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
-- Table `db-book`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`branch` (
  `branch_name` VARCHAR(8) NOT NULL,
  `branch_city` VARCHAR(45) NOT NULL,
  `assets` DECIMAL(8,2) NULL,
  PRIMARY KEY (`branch_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`customer` (
  `customer_name` VARCHAR(8) NOT NULL,
  `customer_street` VARCHAR(45) NULL,
  `customer_city` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`loan` (
  `loan_number` INT NOT NULL,
  `branch_name` VARCHAR(45) NULL,
  `ammount` DECIMAL(8,2) NULL,
  PRIMARY KEY (`loan_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`borrower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`borrower` (
  `customer_name` VARCHAR(8) NOT NULL,
  `loan_loan_number` INT NOT NULL,
  PRIMARY KEY (`customer_name`, `loan_loan_number`),
  INDEX `fk_customer_has_loan_loan1_idx` (`loan_loan_number` ASC),
  INDEX `fk_customer_has_loan_customer_idx` (`customer_name` ASC),
  CONSTRAINT `fk_customer_has_loan_customer`
    FOREIGN KEY (`customer_name`)
    REFERENCES `db-book`.`customer` (`customer_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_has_loan_loan1`
    FOREIGN KEY (`loan_loan_number`)
    REFERENCES `db-book`.`loan` (`loan_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`account` (
  `account_number` VARCHAR(8) NOT NULL,
  `balance` DECIMAL(8,2) NULL,
  `branch_branch_name` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`account_number`),
  INDEX `fk_account_branch1_idx` (`branch_branch_name` ASC),
  CONSTRAINT `fk_account_branch1`
    FOREIGN KEY (`branch_branch_name`)
    REFERENCES `db-book`.`branch` (`branch_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-book`.`depositor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-book`.`depositor` (
  `account_number` VARCHAR(8) NOT NULL,
  `customer_name` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`account_number`, `customer_name`),
  INDEX `fk_account_has_customer_customer1_idx` (`customer_name` ASC),
  INDEX `fk_account_has_customer_account1_idx` (`account_number` ASC),
  CONSTRAINT `fk_account_has_customer_account1`
    FOREIGN KEY (`account_number`)
    REFERENCES `db-book`.`account` (`account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_account_has_customer_customer1`
    FOREIGN KEY (`customer_name`)
    REFERENCES `db-book`.`customer` (`customer_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;