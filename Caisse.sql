-- MySQL Script generated by MySQL Workbench
-- Thu May 19 16:34:54 2022
-- Model: Sakila Full    Version: 2.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hanouti
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hanouti
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hanouti` ;
USE `hanouti` ;

-- -----------------------------------------------------
-- Table `hanouti`.`utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hanouti`.`utilisateur` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(60) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `password` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(10) NULL,
  `adresse` VARCHAR(45) NULL,
  `Role` VARCHAR(1) NOT NULL DEFAULT 'C',
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hanouti`.`type_produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hanouti`.`type_produit` (
  `idtype` INT NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  `localisation` VARCHAR(45) NULL,
  PRIMARY KEY (`idtype`),
  UNIQUE INDEX `idtype_UNIQUE` (`idtype` ASC),
  UNIQUE INDEX `label_UNIQUE` (`label` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hanouti`.`produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hanouti`.`produit` (
  `id` INT NOT NULL,
  `codeProd` VARCHAR(12) NULL,
  `nom` VARCHAR(45) NOT NULL,
  `designation` TEXT(200) NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `prix_achat` DOUBLE NOT NULL,
  `prix_vente` DOUBLE NOT NULL DEFAULT 0,
  `idtype` INT NOT NULL,
  PRIMARY KEY (`id`, `codeProd`),
  UNIQUE INDEX `id_UNIQUE` (`codeProd` ASC),
  INDEX `fk_product_product_type_idx` (`idtype` ASC),
  CONSTRAINT `fk_product_product_type`
    FOREIGN KEY (`idtype`)
    REFERENCES `hanouti`.`type_produit` (`idtype`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hanouti`.`vente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hanouti`.`vente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `total` DOUBLE NOT NULL,
  `date` DATE NOT NULL,
  `seller_id` INT NOT NULL,
  UNIQUE INDEX `code_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_vente_users1_idx` (`seller_id` ASC),
  CONSTRAINT `fk_vente_users1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `hanouti`.`utilisateur` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hanouti`.`ligne_vente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hanouti`.`ligne_vente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL,
  `unite_price` DOUBLE NOT NULL,
  `sub_total` DOUBLE NOT NULL,
  `vente_id` INT NOT NULL,
  `product_id` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_ligne_vente_vente1_idx` (`vente_id` ASC),
  INDEX `fk_ligne_vente_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_ligne_vente_vente1`
    FOREIGN KEY (`vente_id`)
    REFERENCES `hanouti`.`vente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ligne_vente_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `hanouti`.`produit` (`codeProd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hanouti`.`Caisse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hanouti`.`Caisse` (
  `id` INT NOT NULL,
  `sold_initial` DOUBLE NULL DEFAULT 0,
  `date_init` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
