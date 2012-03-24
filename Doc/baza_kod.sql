SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `kamilpomyk_baza` ;
CREATE SCHEMA IF NOT EXISTS `kamilpomyk_baza` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `kamilpomyk_baza` ;

-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`school` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`school` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(80) NOT NULL ,
  `address` VARCHAR(25) NOT NULL ,
  `postcode` VARCHAR(6) NOT NULL ,
  `city` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`person` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `first_name` VARCHAR(12) NOT NULL ,
  `last_name` VARCHAR(25) NOT NULL ,
  `adress` VARCHAR(25) NOT NULL ,
  `postcode` VARCHAR(6) NOT NULL ,
  `city` VARCHAR(20) NOT NULL ,
  `email` VARCHAR(30) NOT NULL ,
  `phone` INT NOT NULL ,
  `type` ENUM('T', 'S', 'E') NOT NULL ,
  `school_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `school_id` (`school_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`school_id` )
    REFERENCES `kamilpomyk_baza`.`school` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`employee` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `position` VARCHAR(25) NOT NULL ,
  `person_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `kamilpomyk_baza`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`teacher` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`teacher` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `person_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `kamilpomyk_baza`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`class` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`class` (
  `id` INT NOT NULL ,
  `class_teacher_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `class_teacher_id` (`class_teacher_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`class_teacher_id` )
    REFERENCES `kamilpomyk_baza`.`teacher` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`student` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`student` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `person_id` INT NOT NULL ,
  `class_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  INDEX `class_id` (`class_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `kamilpomyk_baza`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`class_id` )
    REFERENCES `kamilpomyk_baza`.`class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`subject` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`subject` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`grades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`grades` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`grades` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `value` INT NOT NULL ,
  `base` INT NOT NULL ,
  `comment` VARCHAR(255) NOT NULL ,
  `student_id` INT NOT NULL ,
  `subject_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `student_id` (`student_id` ASC) ,
  INDEX `subject_id` (`subject_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `kamilpomyk_baza`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`subject_id` )
    REFERENCES `kamilpomyk_baza`.`subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`role` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`access` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`access` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `person_id` INT NOT NULL ,
  `role_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  INDEX `role_id` (`role_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `kamilpomyk_baza`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`role_id` )
    REFERENCES `kamilpomyk_baza`.`role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`teacher_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`teacher_subject` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`teacher_subject` (
  `id` INT NOT NULL ,
  `teacher_id` INT NOT NULL ,
  `subject_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `teacher_id` (`teacher_id` ASC) ,
  INDEX `subject_id` (`subject_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`teacher_id` )
    REFERENCES `kamilpomyk_baza`.`teacher` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`subject_id` )
    REFERENCES `kamilpomyk_baza`.`subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`classroom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`classroom` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`classroom` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(5) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`lesson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`lesson` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`lesson` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `weekday` TINYINT NOT NULL ,
  `hour` TINYINT NOT NULL ,
  `teacher_subject_id` INT NOT NULL ,
  `class_id` INT NOT NULL ,
  `classroom_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `teacher_subject_id` (`teacher_subject_id` ASC) ,
  INDEX `class-id` (`class_id` ASC) ,
  INDEX `classroom_id` (`classroom_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`teacher_subject_id` )
    REFERENCES `kamilpomyk_baza`.`teacher_subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`class_id` )
    REFERENCES `kamilpomyk_baza`.`class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`classroom_id` )
    REFERENCES `kamilpomyk_baza`.`classroom` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`attendance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`attendance` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`attendance` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` INT NOT NULL ,
  `lesson_id` INT NOT NULL ,
  `student_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `student_id` (`student_id` ASC) ,
  INDEX `lesson_id` (`lesson_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `kamilpomyk_baza`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`lesson_id` )
    REFERENCES `kamilpomyk_baza`.`lesson` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`resource` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`resource` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`role_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`role_resource` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`role_resource` (
  `role_id` INT NOT NULL ,
  `resource_id` INT NOT NULL ,
  INDEX `role_id` (`role_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`role_id` )
    REFERENCES `kamilpomyk_baza`.`role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`resource_id` )
    REFERENCES `kamilpomyk_baza`.`resource` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`comment` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`comment` (
  `id` INT NOT NULL ,
  `content` BLOB NOT NULL ,
  `type` ENUM('P', 'N') NOT NULL ,
  `student_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `student_id` (`student_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `kamilpomyk_baza`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`group` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`group` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `class_id` INT NOT NULL ,
  `teacher_subject_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `teacher_subject_id` (`teacher_subject_id` ASC) ,
  INDEX `class_id` (`class_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`teacher_subject_id` )
    REFERENCES `kamilpomyk_baza`.`teacher_subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`class_id` )
    REFERENCES `kamilpomyk_baza`.`class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`student_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`student_group` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`student_group` (
  `student_id` INT NOT NULL ,
  `group_id` INT NOT NULL ,
  INDEX `student_id` (`student_id` ASC) ,
  INDEX `group_id` (`group_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `kamilpomyk_baza`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`group_id` )
    REFERENCES `kamilpomyk_baza`.`group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kamilpomyk_baza`.`lesson_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kamilpomyk_baza`.`lesson_history` ;

CREATE  TABLE IF NOT EXISTS `kamilpomyk_baza`.`lesson_history` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` INT NOT NULL ,
  `topic` VARCHAR(255) NOT NULL ,
  `lesson_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `lesson_id` (`lesson_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`lesson_id` )
    REFERENCES `kamilpomyk_baza`.`lesson` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
