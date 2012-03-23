SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `ds` ;
CREATE SCHEMA IF NOT EXISTS `ds` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `ds` ;

-- -----------------------------------------------------
-- Table `ds`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`school` ;

CREATE  TABLE IF NOT EXISTS `ds`.`school` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(80) NOT NULL ,
  `address` VARCHAR(25) NOT NULL ,
  `postcode` VARCHAR(6) NOT NULL ,
  `city` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`person` ;

CREATE  TABLE IF NOT EXISTS `ds`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `first_name` VARCHAR(12) NOT NULL ,
  `last_name` VARCHAR(25) NOT NULL ,
  `adress` VARCHAR(25) NOT NULL ,
  `postcode` VARCHAR(6) NOT NULL ,
  `city` VARCHAR(20) NOT NULL ,
  `email` VARCHAR(30) NOT NULL ,
  `phone` INT NOT NULL ,
  `school_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `school_id` (`school_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`school_id` )
    REFERENCES `ds`.`school` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`employee` ;

CREATE  TABLE IF NOT EXISTS `ds`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `position` VARCHAR(25) NOT NULL ,
  `person_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `ds`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`teacher` ;

CREATE  TABLE IF NOT EXISTS `ds`.`teacher` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `person_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `ds`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`class` ;

CREATE  TABLE IF NOT EXISTS `ds`.`class` (
  `id` INT NOT NULL ,
  `class_teacher_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `class_teacher_id` (`class_teacher_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`class_teacher_id` )
    REFERENCES `ds`.`teacher` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`student` ;

CREATE  TABLE IF NOT EXISTS `ds`.`student` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `person_id` INT NOT NULL ,
  `class_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  INDEX `class_id` (`class_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`person_id` )
    REFERENCES `ds`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`class_id` )
    REFERENCES `ds`.`class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`subject` ;

CREATE  TABLE IF NOT EXISTS `ds`.`subject` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`grades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`grades` ;

CREATE  TABLE IF NOT EXISTS `ds`.`grades` (
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
    REFERENCES `ds`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`subject_id` )
    REFERENCES `ds`.`subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`role` ;

CREATE  TABLE IF NOT EXISTS `ds`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`access` ;

CREATE  TABLE IF NOT EXISTS `ds`.`access` (
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
    REFERENCES `ds`.`person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`role_id` )
    REFERENCES `ds`.`role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ds`.`teacher_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`teacher_subject` ;

CREATE  TABLE IF NOT EXISTS `ds`.`teacher_subject` (
  `id` INT NOT NULL ,
  `teacher_id` INT NOT NULL ,
  `subject_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `teacher_id` (`teacher_id` ASC) ,
  INDEX `subject_id` (`subject_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`teacher_id` )
    REFERENCES `ds`.`teacher` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`subject_id` )
    REFERENCES `ds`.`subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`classroom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`classroom` ;

CREATE  TABLE IF NOT EXISTS `ds`.`classroom` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(5) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`lesson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`lesson` ;

CREATE  TABLE IF NOT EXISTS `ds`.`lesson` (
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
    REFERENCES `ds`.`teacher_subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`class_id` )
    REFERENCES `ds`.`class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`classroom_id` )
    REFERENCES `ds`.`classroom` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`attendance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`attendance` ;

CREATE  TABLE IF NOT EXISTS `ds`.`attendance` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` INT NOT NULL ,
  `lesson_id` INT NOT NULL ,
  `student_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `student_id` (`student_id` ASC) ,
  INDEX `lesson_id` (`lesson_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `ds`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`lesson_id` )
    REFERENCES `ds`.`lesson` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`resource` ;

CREATE  TABLE IF NOT EXISTS `ds`.`resource` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`role_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`role_resource` ;

CREATE  TABLE IF NOT EXISTS `ds`.`role_resource` (
  `role_id` INT NOT NULL ,
  `resource_id` INT NOT NULL ,
  INDEX `role_id` (`role_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`role_id` )
    REFERENCES `ds`.`role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`resource_id` )
    REFERENCES `ds`.`resource` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`comment` ;

CREATE  TABLE IF NOT EXISTS `ds`.`comment` (
  `id` INT NOT NULL ,
  `content` BLOB NOT NULL ,
  `type` ENUM('P', 'N') NOT NULL ,
  `student_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `student_id` (`student_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `ds`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`group` ;

CREATE  TABLE IF NOT EXISTS `ds`.`group` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `class_id` INT NOT NULL ,
  `teacher_subject_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `teacher_subject_id` (`teacher_subject_id` ASC) ,
  INDEX `class_id` (`class_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`teacher_subject_id` )
    REFERENCES `ds`.`teacher_subject` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`class_id` )
    REFERENCES `ds`.`class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`student_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`student_group` ;

CREATE  TABLE IF NOT EXISTS `ds`.`student_group` (
  `student_id` INT NOT NULL ,
  `group_id` INT NOT NULL ,
  INDEX `student_id` (`student_id` ASC) ,
  INDEX `group_id` (`group_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`student_id` )
    REFERENCES `ds`.`student` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 
    FOREIGN KEY (`group_id` )
    REFERENCES `ds`.`group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ds`.`lesson_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ds`.`lesson_history` ;

CREATE  TABLE IF NOT EXISTS `ds`.`lesson_history` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` INT NOT NULL ,
  `topic` VARCHAR(255) NOT NULL ,
  `lesson_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `lesson_id` (`lesson_id` ASC) ,
  CONSTRAINT 
    FOREIGN KEY (`lesson_id` )
    REFERENCES `ds`.`lesson` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
