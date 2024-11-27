-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projekt_VS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projekt_VS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projekt_VS` DEFAULT CHARACTER SET utf8 ;
USE `projekt_VS` ;

-- -----------------------------------------------------
-- Table `projekt_VS`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projekt_VS`.`Student` (
  `idStudent` INT NOT NULL AUTO_INCREMENT,
  `jmeno` VARCHAR(45) NULL,
  `prijmeni` VARCHAR(45) NULL,
  `vek` INT NULL,
  PRIMARY KEY (`idStudent`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projekt_VS`.`Predmet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projekt_VS`.`Predmet` (
  `idPredmet` INT NOT NULL AUTO_INCREMENT,
  `nazev` VARCHAR(45) NULL,
  PRIMARY KEY (`idPredmet`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projekt_VS`.`Ucitel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projekt_VS`.`Ucitel` (
  `idUcitel` INT NOT NULL AUTO_INCREMENT,
  `jmeno` VARCHAR(45) NULL,
  `prijmeni` VARCHAR(45) NULL,
  `vek` INT NULL,
  PRIMARY KEY (`idUcitel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projekt_VS`.`Ucebna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projekt_VS`.`Ucebna` (
  `idUcebna` INT NOT NULL AUTO_INCREMENT,
  `jmeno` VARCHAR(45) NULL,
  `stat` VARCHAR(45) NULL,
  `mesto` VARCHAR(45) NULL,
  `adresa` VARCHAR(45) NULL,
  PRIMARY KEY (`idUcebna`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projekt_VS`.`Zkouska`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projekt_VS`.`Zkouska` (
  `idZkouska` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NULL,
  `Ucebna_id` INT NOT NULL,
  `Student_id` INT NOT NULL,
  `Predmet_id` INT NOT NULL,
  `Ucitel_id` INT NOT NULL,
  PRIMARY KEY (`idZkouska`),
  INDEX `fk_Zkouska_Ucebna1_idx` (`Ucebna_id` ASC) VISIBLE,
  INDEX `fk_Zkouska_Student1_idx` (`Student_id` ASC) VISIBLE,
  INDEX `fk_Zkouska_Predmet1_idx` (`Predmet_id` ASC) VISIBLE,
  INDEX `fk_Zkouska_Ucitel1_idx` (`Ucitel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Zkouska_Ucebna1`
    FOREIGN KEY (`Ucebna_id`)
    REFERENCES `projekt_VS`.`Ucebna` (`idUcebna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zkouska_Student1`
    FOREIGN KEY (`Student_id`)
    REFERENCES `projekt_VS`.`Student` (`idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zkouska_Predmet1`
    FOREIGN KEY (`Predmet_id`)
    REFERENCES `projekt_VS`.`Predmet` (`idPredmet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zkouska_Ucitel1`
    FOREIGN KEY (`Ucitel_id`)
    REFERENCES `projekt_VS`.`Ucitel` (`idUcitel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projekt_VS`.`Vysledek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projekt_VS`.`Vysledek` (
  `idVysledek` INT NOT NULL AUTO_INCREMENT,
  `prosel` TINYINT NULL,
  `pocet_bodu` INT NULL,
  `Zkouska_id` INT NOT NULL,
  PRIMARY KEY (`idVysledek`),
  INDEX `fk_Vysledek_Zkouska1_idx` (`Zkouska_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vysledek_Zkouska1`
    FOREIGN KEY (`Zkouska_id`)
    REFERENCES `projekt_VS`.`Zkouska` (`idZkouska`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
