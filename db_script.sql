-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS =@@ UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS =@@ FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE =@@ SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema movierating
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movierating
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movierating` DEFAULT CHARACTER SET utf8;
USE `movierating`;

-- -----------------------------------------------------
-- Table `movierating`.`director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`director` (
`id` INT (10) UNSIGNED NOT NULL AUTO_INCREMENT
COMMENT 'ID is used as a Primary key of the director table.',
` NAME ` VARCHAR (255) NOT NULL COMMENT 'Film directors\' FIRST NAME.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `fullname_index` (`name` ASC)  COMMENT ' INDEX, that represents directors\' full name. Also, can be used as an independent index for lastname.')
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = UTF8
COMMENT = 'Table of film directors. Every director has a first name and a last name.';

-- -----------------------------------------------------
-- Table `movierating`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`film` (
`idFilm` INT (10) UNSIGNED NOT NULL AUTO_INCREMENT
COMMENT 'ID is used as a Primary key of the film table.',
` NAME ` VARCHAR (255) NOT NULL COMMENT 'Film (TV series) name.',
`release_year` YEAR (4) NOT NULL COMMENT 'Year of the first release.',
`duration` DOUBLE UNSIGNED NOT NULL COMMENT 'Movie (ot TV series) duration. For TV-series - the duration of the all series.',
`poster` VARCHAR (1000) NOT NULL DEFAULT 'http://i0.kym-cdn.com/photos/images/facebook/001/000/423/442.png' COMMENT 'Movie posters\' id TO CONNECT WITH a poster TABLE.',
  `id`           INT(10) UNSIGNED NOT NULL
  COMMENT 'Directors id TO CONNECT WITH a director TABLE.',
  `description`  VARCHAR(1000)    NOT NULL DEFAULT ' NO description',
  PRIMARY KEY (`idFilm`),
  INDEX `name_release_year_idx` (`name` ASC, `release_year` ASC)  COMMENT ' INDEX TO find film (TV series) BY its NAME AND RELEASE YEAR OR just BY its NAME, because NAME can be used AS independently indexed.',
  INDEX `director_name_idx` (`id` ASC, `name` ASC)
    COMMENT ' INDEX TO find film (TV series) BY its NAME AND director OR just BY its director, because director can be used AS independently indexed.',
  CONSTRAINT `iddirector_film_fk`
  FOREIGN KEY (`id`)
  REFERENCES `movierating`.`director` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8
COMMENT = ' TABLE OF films.Every film has a NAME, YEAR OF RELEASE, duration, poster AND director.';


-- -----------------------------------------------------
-- Table `movierating`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`genre` (
  `name` VARCHAR(255) NOT NULL COMMENT 'Genre NAME ',
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = ' TABLE OF genres.';


-- -----------------------------------------------------
-- Table `movierating`.`film_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`film_genre` (
  `idFilm`    INT(10) UNSIGNED NOT NULL,
  `genrename` VARCHAR(255)     NOT NULL,
  PRIMARY KEY (`idFilm`, `genrename`)
    COMMENT ' PRIMARY KEY OF the TABLE.',
  INDEX `genrename_idx` (`genrename` ASC)  COMMENT 'Auto-created INDEX FOR FK ON genre TABLE.',
  CONSTRAINT `genrename_fg_fk`
    FOREIGN KEY (`genrename`)
    REFERENCES `movierating`.`genre` (`name`),
  CONSTRAINT `idfilm_fg_fk`
  FOREIGN KEY (`idFilm`)
  REFERENCES `movierating`.`film` (`idFilm`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = ' TABLE, which helps TO establish many- TO -many relationship BETWEEN the TABLE OF films AND the TABLE OF genres.';


-- -----------------------------------------------------
-- Table `movierating`.`poster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`poster` (
  `idposter` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID IS used AS a PRIMARY KEY OF the poster TABLE.',
  `content` LONGBLOB NOT NULL COMMENT ' CONTENT OF the FILE.',
  `filename` VARCHAR(255) NOT NULL COMMENT ' FULL filename.',
  `extension` VARCHAR(45) NOT NULL COMMENT ' FILE EXTENSION.',
  PRIMARY KEY (`idposter`),
  INDEX `filename_extension_idx` (`filename` ASC, `extension` ASC)  COMMENT ' INDEX TO find FILE BY its\' filename (because it can be used as an individual index). Also to find posters\' filename AND EXTENSION.',
  INDEX `extension_idx` (`extension` ASC)  COMMENT ' INDEX TO find FILE BY its EXTENSION.')
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8
COMMENT = ' TABLE OF posters.Every poster has a filename, an EXTENSION AND a CONTENT IN a blob FORMAT.';


-- -----------------------------------------------------
-- Table `movierating`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`user` (
  `idUser`               INT(10) UNSIGNED                        NOT NULL AUTO_INCREMENT
  COMMENT 'ID IS used AS a PRIMARY KEY OF the USER TABLE.',
  `login`                VARCHAR(255)                            NOT NULL COMMENT ' LOGIN TO enter the SYSTEM.IF real_name IS NOT present it\'s used as a default on a page as users\' NAME.',
  `password`             VARCHAR(255)                            NOT NULL COMMENT ' PASSWORD TO enter the SYSTEM ',
  `email`                VARCHAR(255)                            NULL DEFAULT NULL COMMENT 'e-mail',
  `real_name`            VARCHAR(255)                            NULL DEFAULT NULL COMMENT 'Users REAL NAME, which would be shown ON the film page IN a review.IF real_name IS NOT present LOGIN IS used AS a DEFAULT ON a page AS users\' name.',
`date_of_registration` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of registration on a website',
`date_of_birth`        DATE NULL DEFAULT NULL COMMENT 'Date of Birth',
` ROLE ` ENUM ('user', 'admin') NOT NULL DEFAULT 'user' COMMENT 'User role - Administrator or User',
`status` ENUM ('baned', 'unbaned', 'unconfirmed') NOT NULL DEFAULT 'unconfirmed' COMMENT 'User status - baned or not',
`ban_expiration_date`  DATE NULL DEFAULT NULL COMMENT 'Ban expiration date',
`avatar` VARCHAR (1000) NULL DEFAULT 'https://image.flaticon.com/icons/svg/145/145850.svg',
PRIMARY KEY (`idUser`),
UNIQUE INDEX `login_UNIQUE` (` LOGIN ` ASC ),
INDEX `status_banday_idx` (`status` ASC, `ban_expiration_date` ASC ) COMMENT 'Index to find baned or not baned users, as the first field in the index can be used as an independent index . Also used to find baned users with some ban expiration day.',
INDEX `birthday_email_login_idx` (`date_of_birth` ASC, `email` ASC, ` LOGIN ` ASC ) COMMENT 'This index helps to find users by date of birth, email and login. So we can also find users by date of birth as an independent index. Can be used to wish a happy bithday to users.',
INDEX `login_password_idx` (` LOGIN ` ASC, ` PASSWORD ` ASC ) COMMENT 'This index helps to find users by login and password. So we can also find users by login as an independent index. Can be used to enter the system by login.',
INDEX `email_password_idx` (`email` ASC, ` PASSWORD ` ASC ) COMMENT 'This index helps to find users by email and password. So we can also find users by email as an independent index. Can be used to enter the system by email.',
INDEX `realname_idx` (`real_name` ASC ) COMMENT 'Index to find a user by his realname.',
INDEX `role_idx` (` ROLE ` ASC ) COMMENT 'Index to find user by his role.')
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = UTF8
COMMENT = 'Table of users. Every user has a login and a password. Also he can specify an e-mail and his realname, which would be shown on a page. New user is marked with a \' USER \' role and is unbaned by default. Date of registration is set up once, when he is added in a database, by default.';

-- -----------------------------------------------------
-- Table `movierating`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`rating` (
`id` INT (10) UNSIGNED NOT NULL AUTO_INCREMENT
COMMENT 'ID is used as a Primary key of the ratin table.',
`idUser` INT (10) UNSIGNED NOT NULL
COMMENT 'User ID, which is used as a FK to connect with a user table.',
`idFilm` INT (10) UNSIGNED NOT NULL
COMMENT 'User ID, which is used as a FK to connect with a film table.',
`is_seen`       TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Represents if the film (TV series) is seen.',
`rating_amount` INT (1) UNSIGNED NULL DEFAULT '0' COMMENT 'Rating amount, which is in bounds from 0 to 10.',
PRIMARY KEY (`id`),
UNIQUE INDEX `idfilm_iduser_idx` (`idFilm` ASC, `idUser` ASC ),
INDEX `iduser_idx` (`idUser` ASC )
COMMENT 'Auto-created index for FK on user table.',
INDEX `idfilm_idx` (`idFilm` ASC )
COMMENT 'Auto-created index for FK on film table.',
INDEX `rating_idfilm_idx` (`rating_amount` ASC, `idFilm` ASC )
COMMENT 'Index can be used as an independent one for rating field and also to find films with a selected rating. In a such way users rating can be automatically increased or decreased.',
CONSTRAINT `idfilm_rating_fk`
FOREIGN KEY (`idFilm`)
REFERENCES `movierating`.`film` (`idFilm`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `iduser_rating_fk`
FOREIGN KEY (`idUser`)
REFERENCES `movierating`.` USER ` (`idUser`)
ON DELETE CASCADE
ON UPDATE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 102
DEFAULT CHARACTER SET = UTF8
COMMENT = 'Table of ratings. Every user can rate selected film.';

-- -----------------------------------------------------
-- Table `movierating`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movierating`.`review` (
`id` INT (11) NOT NULL AUTO_INCREMENT
COMMENT 'ID is used as a Primary key of the review table.',
`idUser` INT (10) UNSIGNED NOT NULL
COMMENT 'User ID, which is used as a FK to connect with a user table.',
`idFilm` INT (10) UNSIGNED NOT NULL
COMMENT 'User ID, which is used as a FK to connect with a film table.',
` TEXT ` VARCHAR (1000) NOT NULL COMMENT 'Text of the review.',
`date`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date, when review was written. Current date and time is used as a default value.',
PRIMARY KEY (`id`),
INDEX `iduser_idx` (`idUser` ASC ),
INDEX `idfilm_idx` (`idFilm` ASC ),
INDEX `film_user_idx` (`idFilm` ASC, `idUser` ASC )
COMMENT 'Index, that helps to find review to the selected film by some user.',
INDEX `user_date_idx` (`idUser` ASC, `date` ASC )
COMMENT 'Index, which helps to find review of the selected user on a certain date. Also it can be used as an index to find review by certain users.',
INDEX `date_idx` (`date` ASC ) COMMENT 'Index to find reviews by selected date.',
CONSTRAINT `idfilm_review_fk`
FOREIGN KEY (`idFilm`)
REFERENCES `movierating`.`film` (`idFilm`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `iduser_review_fk`
FOREIGN KEY (`idUser`)
REFERENCES `movierating`.` USER ` (`idUser`)
ON DELETE CASCADE
ON UPDATE CASCADE )
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = UTF8
COMMENT = 'Table of reviews. Every user can post a review for selected film.';


SET SQL_MODE =@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS =@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS =@OLD_UNIQUE_CHECKS;
