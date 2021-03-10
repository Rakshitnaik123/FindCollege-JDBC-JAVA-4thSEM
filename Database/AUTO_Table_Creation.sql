-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema find_college_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema find_college_db
-- -----------------------------------------------------
DROP DATABASE FIND_COLLEGE_DB;
CREATE SCHEMA IF NOT EXISTS `find_college_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `find_college_db` ;

-- -----------------------------------------------------
-- Table `find_college_db`.`colleges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `find_college_db`.`colleges` (
  `COLLEGE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CNAME` VARCHAR(255) NOT NULL,
  `MIN_PERCENTAGE` DECIMAL(4,2) NOT NULL,
  `FEES` INT(11) NOT NULL,
  `LOCATION` VARCHAR(255) NOT NULL,
  `CONTACT` VARCHAR(10) NOT NULL,
  `EMAIL` VARCHAR(255) NOT NULL,
  `WEBSITE` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`COLLEGE_ID`, `CNAME`, `EMAIL`),
  INDEX `EMAIL_idx` (`EMAIL` ASC) INVISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `find_college_db`.`login_colleges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `find_college_db`.`login_colleges` (
  `COLLEGE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(255) NOT NULL,
  `PASSWRD` VARCHAR(255) NOT NULL,
  INDEX `COLLEGE_ID` (`COLLEGE_ID` ASC) VISIBLE,
  INDEX `EMAIL` (`EMAIL` ASC) VISIBLE,
  PRIMARY KEY (`COLLEGE_ID`, `EMAIL`),
  CONSTRAINT `login_colleges_ibfk_1`
    FOREIGN KEY (`COLLEGE_ID`)
    REFERENCES `find_college_db`.`colleges` (`COLLEGE_ID`)
    ON DELETE CASCADE,
  CONSTRAINT `login_colleges_ibfk_2`
    FOREIGN KEY (`EMAIL`)
    REFERENCES `find_college_db`.`colleges` (`EMAIL`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `find_college_db`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `find_college_db`.`students` (
  `STUDENT_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `FNAME` VARCHAR(255) NOT NULL,
  `MNAME` VARCHAR(255) NULL DEFAULT NULL,
  `LNAME` VARCHAR(255) NOT NULL,
  `DOB` DATE NOT NULL,
  `GENDER` VARCHAR(10) NOT NULL,
  `AGE` TINYINT(4) NULL DEFAULT NULL,
  `CONTACT` VARCHAR(10) NOT NULL,
  `EMAIL` VARCHAR(255) NOT NULL,
  `LOCATION` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`STUDENT_ID`, `EMAIL`),
  INDEX `EMAIL_idx` (`EMAIL` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `find_college_db`.`login_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `find_college_db`.`login_students` (
  `STUDENT_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(255) NOT NULL,
  `PASSWRD` VARCHAR(255) NOT NULL,
  INDEX `STUDENT_ID` (`STUDENT_ID` ASC) VISIBLE,
  INDEX `EMAIL` (`EMAIL` ASC) INVISIBLE,
  PRIMARY KEY (`STUDENT_ID`, `EMAIL`),
  CONSTRAINT `login_students_ibfk_1`
    FOREIGN KEY (`STUDENT_ID`)
    REFERENCES `find_college_db`.`students` (`STUDENT_ID`)
    ON DELETE CASCADE,
  CONSTRAINT `login_students_ibfk_2`
    FOREIGN KEY (`EMAIL`)
    REFERENCES `find_college_db`.`students` (`EMAIL`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `find_college_db`.`marks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `find_college_db`.`marks` (
  `STUDENT_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ENGLISH` INT(3) NOT NULL,
  `HINDI_KANNADA` INT(3) NOT NULL,
  `MATHS` INT(3) NOT NULL,
  `PHYSICS` INT(3) NOT NULL,
  `CHEMISTRY` INT(3) NOT NULL,
  `COMPUTER_BIOLOGY` INT(3) NOT NULL,
  `TOTAL_MARKS` INT(3) NULL DEFAULT NULL,
  `PERCENTAGE` DECIMAL(5,2) NULL DEFAULT NULL,
  INDEX `STUDENT_ID_idx` (`STUDENT_ID` ASC) VISIBLE,
  PRIMARY KEY (`STUDENT_ID`),
  CONSTRAINT `marks_ibfk_1`
    FOREIGN KEY (`STUDENT_ID`)
    REFERENCES `find_college_db`.`students` (`STUDENT_ID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `find_college_db` ;

-- -----------------------------------------------------
-- procedure GetAvgPer
-- -----------------------------------------------------

DELIMITER $$
USE `find_college_db`$$
CREATE DEFINER=`Mayank`@`%` PROCEDURE `GetAvgPer`()
BEGIN
	UPDATE MARKS set TOTAL_MARKS = (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY);
	UPDATE MARKS set PERCENTAGE = (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY) /6 ;
END$$

DELIMITER ;
USE `find_college_db`;

DELIMITER $$
USE `find_college_db`$$
CREATE
DEFINER=`Mayank`@`%`
TRIGGER `find_college_db`.`find_age`
BEFORE INSERT ON `find_college_db`.`students`
FOR EACH ROW
BEGIN
set new.age = TIMESTAMPDIFF(YEAR, new.DOB, CURDATE());
END$$

USE `find_college_db`$$
CREATE
DEFINER=`Mayank`@`%`
TRIGGER `find_college_db`.`marks_check`
BEFORE INSERT ON `find_college_db`.`marks`
FOR EACH ROW
BEGIN
IF NEW.ENGLISH < 0 OR NEW.ENGLISH > 100 THEN
SET NEW.ENGLISH = 0; END IF;
IF NEW.HINDI_KANNADA < 0 OR NEW.HINDI_KANNADA > 100 THEN 
SET NEW.HINDI_KANNADA = 0; END IF;
IF NEW.MATHS < 0 OR NEW.MATHS > 100 THEN 
SET NEW.MATHS = 0; END IF;
IF NEW.PHYSICS < 0 OR NEW.PHYSICS > 100 THEN 
SET NEW.PHYSICS = 0; END IF;
IF NEW.CHEMISTRY < 0 OR NEW.CHEMISTRY > 100 THEN 
SET NEW.CHEMISTRY = 0; END IF;
IF NEW.COMPUTER_BIOLOGY < 0 OR NEW.COMPUTER_BIOLOGY > 100 THEN 
SET NEW.COMPUTER_BIOLOGY = 0; END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
