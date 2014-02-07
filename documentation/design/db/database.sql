SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `pba` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `pba` ;

-- -----------------------------------------------------
-- Table `pba`.`intake`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pba`.`intake` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pba`.`period`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pba`.`period` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pba`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pba`.`user` (
  `id` INT NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `pass` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pba`.`budget`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pba`.`budget` (
  `id` INT NOT NULL,
  `quantity` DOUBLE NOT NULL,
  `period` INT NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_budget_period1_idx` (`period` ASC),
  INDEX `fk_budget_user1_idx` (`user` ASC),
  CONSTRAINT `fk_budget_period1`
    FOREIGN KEY (`period`)
    REFERENCES `pba`.`period` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_budget_user1`
    FOREIGN KEY (`user`)
    REFERENCES `pba`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pba`.`expense`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pba`.`expense` (
  `id` INT NOT NULL,
  `date` DATE NOT NULL,
  `quantity` DOUBLE NOT NULL,
  `intake` INT NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_expense_intake_idx` (`intake` ASC),
  INDEX `fk_expense_budget1_idx` (`budget` ASC),
  CONSTRAINT `fk_expense_intake`
    FOREIGN KEY (`intake`)
    REFERENCES `pba`.`intake` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_expense_budget1`
    FOREIGN KEY (`budget`)
    REFERENCES `pba`.`budget` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
