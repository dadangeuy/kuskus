/*
SQLyog Community v12.4.1 (64 bit)
MySQL - 10.1.21-MariaDB : Database - yzjvincb_kuskus
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`yzjvincb_kuskus` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `yzjvincb_kuskus`;

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `id_post` int(10) unsigned NOT NULL,
  `upload` datetime NOT NULL,
  `caption` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_post` (`id_post`),
  KEY `id_user` (`id_user`),
  KEY `upload` (`upload`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`id_post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `comment` */

/*Table structure for table `follow` */

DROP TABLE IF EXISTS `follow`;

CREATE TABLE `follow` (
  `id_user` int(10) unsigned NOT NULL,
  `id_user_2` int(10) unsigned NOT NULL,
  KEY `id_user` (`id_user`),
  KEY `id_user_2` (`id_user_2`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`id_user_2`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `follow` */

insert  into `follow`(`id_user`,`id_user_2`) values 
(1,5),
(5,1),
(5,2);

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `id_post` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_post` (`id_post`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`id_post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `notification` */

insert  into `notification`(`id`,`id_user`,`id_post`) values 
(1,1,9);

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id post',
  `id_user` int(10) unsigned NOT NULL COMMENT 'id user',
  `upload` datetime NOT NULL COMMENT 'waktu upload',
  `caption` text NOT NULL COMMENT 'caption',
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`,`upload`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `post` */

insert  into `post`(`id`,`id_user`,`upload`,`caption`) values 
(1,1,'2017-05-11 15:05:47','PERTAMAX'),
(2,1,'2017-05-11 15:05:49','PERTAMAX'),
(3,1,'2017-05-11 15:06:04','PERTAMAX GAN'),
(4,1,'2017-05-11 15:06:34','PERTAMAX GAN'),
(5,1,'2017-05-11 15:09:14','test'),
(6,4,'2017-05-11 15:15:06','akun ujicoba'),
(7,4,'2017-05-11 15:15:21','mencoba mengirim sesuatu'),
(8,2,'2017-05-11 15:33:01','aku cinta iwaw'),
(9,2,'2017-05-11 15:45:31','waw'),
(10,5,'2017-05-11 15:59:32','aku sayang nuzul'),
(11,5,'2017-05-11 15:59:41','blabla bla'),
(12,5,'2017-05-11 15:59:52','ini kurang masif');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id user',
  `name` varchar(64) NOT NULL COMMENT 'nama lengkap',
  `email` varchar(64) NOT NULL COMMENT 'email',
  `pass` char(32) NOT NULL COMMENT 'password',
  `gender` char(1) NOT NULL COMMENT 'M(male) or F(female)',
  `avatar` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`email`,`pass`,`gender`,`avatar`) values 
(1,'Irsyad Rizaldi','irsyad@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','M','img/avatar/default_male.png'),
(2,'Nuzul Ristyantika','nuzul@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','F','img/avatar/default_female.png'),
(3,'Frieda Uswatun','frieda@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','F','img/avatar/default_female.png'),
(4,'tester','tes@tes.com','28b662d883b6d76fd96e4ddc5e9ba780','M','img/avatar/default_male.png'),
(5,'iwaw','iwaw@mami.com','eaccb8ea6090a40a98aa28c071810371','F','img/avatar/default_female.png');

/* Trigger structure for table `post` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `send_notification` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `send_notification` AFTER INSERT ON `post` FOR EACH ROW BEGIN
	DECLARE done bool DEFAULT false;
	declare c_id_user int;
	declare cur cursor for select `id_user_2` as `id_user` from `follow` where `id_user` = new.`id_user`;
	declare continue handler for not found set done = true;
	open cur;
	while not done do
		fetch cur into c_id_user;
		if not done then
			call tr_add_notification(c_id_user, new.`id`);
		end if;
	end while;
	close cur;
    END */$$


DELIMITER ;

/* Procedure structure for procedure `add_comment` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_comment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_comment`(
	p_id_user int,
	p_id_post int,
	p_caption text
)
BEGIN
/*
	SYARAT BISA COMMENT
	- id user ada
	- id post ada
	- caption tidak kosong
*/
	if not exists (select * from `user` where `id` = p_id_user) then
		select 1 as `errno`, 'user not exist' as `msg`;
	elseif not exists (select * from `post` where `id` = p_id_post) then
		select 2 as `errno`, 'post not exist' as `msg`;
	else
		insert into `comment` value (null, p_id_user, p_id_post, now(), p_caption);
		select 0 as `errno`, 'success' as `msg`;
	end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `add_follow` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_follow` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_follow`(
	p_id_user int,
	p_id_user_2 int
)
BEGIN
	insert into `follow` value (p_id_user, p_id_user_2);
	select 0 as `errno`, 'success' as `msg`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `add_post` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_post` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_post`(
	p_id_user int,
	p_caption text
)
BEGIN
/*
	SYARAT BISA POSTING
	- ID user terdaftar
	- Caption tidak kosong
*/
	if not exists (select * from `user` where `id` = p_id_user) then
		select 1 as `errno`, 'user not found' as `msg`;
	elseif (p_caption is null) then
		select 2 as `errno`, 'caption can\'t be empty' as `msg`;
	else
		insert into `post` value (null, p_id_user, now(), p_caption);
		select 0 as `errno`, 'success' as `msg`;
	end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `add_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user`(
	p_name varchar(64),
	p_email varchar(64),
	p_pass varchar(32),
	p_gender char(1)
)
BEGIN
/*
	SYARAT BISA DAFTAR
	- nama, email, password tidak kosong
	- email unik
	- ber-gender
*/
	if ((p_name is null) or (p_email is null) or (p_pass is null)) then
		select 1 as `errno`, 'name/email/password can\'t be empty' as `msg`;
	elseif exists (select `email` from `user` where `email` = p_email) then
		select 2 as `errno`, 'email is already registered' as `msg`;
	else
		if (p_gender = 'M') then
			INSERT INTO `user` VALUE (NULL, p_name, p_email, MD5(p_pass), p_gender, 'img/avatar/default_male.png');
			SELECT 0 AS `errno`, 'success' AS `msg`;
		elseif (p_gender = 'F') then
			INSERT INTO `user` VALUE (NULL, p_name, p_email, MD5(p_pass), p_gender, 'img/avatar/default_female.png');
			SELECT 0 AS `errno`, 'success' AS `msg`;
		else
			select 1 as `errno`, 'gender not valid' as `msg`;
		end if;
		
	end if;
	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_comment` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_comment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comment`(
	p_id_post int
)
BEGIN
	select * from `comment` where `id_post` = p_id_post
	order by `id` desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_home` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_home` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_home`(
	p_id_user int
	)
BEGIN
/*
	SYARAT BISA ADA DI HOME
	- post dari teman yg sudah di add
	- post dari diri sendiri
*/
	select * from `post` where `id_user` in
	(select `id_user_2` as `id_user` from `follow` where `id_user` = p_id_user
	union select p_id_user as `id_user`)
	order by `id` desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_notification` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_notification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_notification`(
	p_id_user int
)
BEGIN
	select * from `notification` where `id_user` = p_id_user
	order by `id` desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_post` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_post` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_post`(
	p_id_post int
)
BEGIN
	select * from `post` where `id` = p_id_post;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user`(
	p_id_user int
	)
BEGIN
	select * from `user` where `id` = p_id_user;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_post` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_post` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_post`(
	p_id_user int
)
BEGIN
	SELECT * FROM `post` WHERE `id_user` = p_id_user
	order by `id` desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `remove_follow` */

/*!50003 DROP PROCEDURE IF EXISTS  `remove_follow` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_follow`(
	p_id_user int,
	p_id_user_2 int
)
BEGIN
/*
	SYARAT BISA HAPUS TEMAN
	- tidak boleh add diri sendiri
	- id user ada di db
	- belom ada di db teman
*/
	delete from `follow` where `id_user` = p_id_user and `id_user_2` = p_id_user_2;
	SELECT 0 AS `errno`, 'success' AS `msg`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `search` */

/*!50003 DROP PROCEDURE IF EXISTS  `search` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `search`(
	p_keyword text
)
BEGIN
	select * from `user` where instr(`name`, p_keyword)
	order by `name`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `tr_add_notification` */

/*!50003 DROP PROCEDURE IF EXISTS  `tr_add_notification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `tr_add_notification`(
	p_id_user int,
	p_id_post int
)
BEGIN
	insert into `notification` value (null, p_id_user, p_id_post);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `update_avatar` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_avatar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_avatar`(
	p_id_user int,
	p_avatar varchar(64)
)
BEGIN
	if not exists (select * from `user` where `id` = p_id_user) then
		select 1 as `errno`, 'user not found' as `msg`;
	else
		update `user` set `avatar` = p_avatar where `id` = p_id_user;
		select 0 as `errno`, 'success' as `msg`;
	end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `verify_follow` */

/*!50003 DROP PROCEDURE IF EXISTS  `verify_follow` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `verify_follow`(
	p_id_user INT,
	p_id_user_2 INT
)
BEGIN
	if exists (select * from `follow` where `id_user` = p_id_user and `id_user_2` = p_id_user_2) then
		select 0 as `errno`, 'success' as `msg`;
	else
		select 1 as `errno`, 'not found' as `msg`;
	end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `verify_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `verify_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `verify_user`(
	p_email varchar(64),
	p_pass varchar(64)
)
BEGIN
	if not exists (SELECT * FROM `user` WHERE `email` = p_email AND `pass` = MD5(p_pass)) then
		SELECT 1 AS `errno`, 'wrong email/password' AS `msg`;
	else
		set @id_user = (select `id` from `user` where `email` = p_email);
		SELECT 0 AS `errno`, 'success' AS `msg`, @id_user as id_user;
	end if;
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
