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

/*Table structure for table `friend` */

DROP TABLE IF EXISTS `friend`;

CREATE TABLE `friend` (
  `id_user` int(10) unsigned NOT NULL,
  `id_user_2` int(10) unsigned NOT NULL,
  KEY `id_user` (`id_user`),
  KEY `id_user_2` (`id_user_2`),
  CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_ibfk_2` FOREIGN KEY (`id_user_2`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `friend` */

insert  into `friend`(`id_user`,`id_user_2`) values 
(1,2),
(2,1),
(2,3),
(3,2);

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `notification` */

insert  into `notification`(`id`,`id_user`,`id_post`) values 
(1,2,1),
(2,1,2),
(3,3,2),
(4,2,3),
(5,2,4),
(6,1,5),
(7,3,5),
(8,1,6),
(9,3,6),
(10,1,7),
(11,3,7),
(12,2,8),
(13,1,9),
(14,3,9),
(15,2,10);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `post` */

insert  into `post`(`id`,`id_user`,`upload`,`caption`) values 
(1,1,'2017-05-09 04:08:19','test'),
(2,2,'2017-05-09 04:08:21','yullyany'),
(3,1,'2017-05-09 04:08:22','iwaw'),
(4,3,'2017-05-09 04:08:23','i love it'),
(5,2,'2017-05-09 04:08:24','hay cynde'),
(6,2,'2017-05-09 04:08:25','hay cynde2'),
(7,2,'2017-05-09 04:08:25','hay cynde3'),
(8,3,'2017-05-09 04:08:26','hay iwaw'),
(9,2,'2017-05-09 04:08:27','hay cyndecynde'),
(10,3,'2017-05-09 04:23:14','i love it');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id user',
  `name` varchar(64) NOT NULL COMMENT 'nama lengkap',
  `email` varchar(64) NOT NULL COMMENT 'email',
  `pass` char(32) NOT NULL COMMENT 'password',
  `avatar` varchar(64) DEFAULT '/img/avatar/default.png',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`email`,`pass`,`avatar`) values 
(1,'admin','admin@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','/img/avatar/default.png'),
(2,'irsyad','irsyad@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','/img/avatar/default.png'),
(3,'nuzul','nuzul@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','/img/avatar/default.png'),
(4,'pisjo','pisjo@kuskus.com','a773a5ec4da12250816a1ce2d3136f3d','/img/avatar/default.png');

/* Trigger structure for table `post` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `send_notification` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `send_notification` AFTER INSERT ON `post` FOR EACH ROW BEGIN
	DECLARE done bool DEFAULT false;
	declare c_id_user int;
	declare cur cursor for select `id_user_2` as `id_user` from `friend` where `id_user` = new.`id_user`;
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

/* Procedure structure for procedure `add_friend` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_friend` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_friend`(
	p_id_user int,
	p_id_user_2 int
)
BEGIN
/*
	SYARAT BISA TAMBAH TEMAN
	- tidak boleh add diri sendiri
	- id user ada di db
	- belom ada di db teman
*/
	if (p_id_user = p_id_user_2) then
		select 1 as `errno`, 'can\'t add yourself as a friend' as `msg`;
	elseif not exists (select * from `user` where `id` = p_id_user) or not exists (select * from `user` where `id` = p_id_user_2) then
		select 2 as `errno`, 'user not found' as `msg`;
	elseif exists (select * from `friend` where `id_user` = p_id_user and `id_user_2` = p_id_user_2) then
		select 3 as `errno`, 'user is already a friend' as `msg`;
	else
		insert into `friend` value (p_id_user, p_id_user_2);
		insert into `friend` value (p_id_user_2, p_id_user);
		select 0 as `errno`, 'success' as `msg`;
	end if;
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
	p_pass varchar(64)
)
BEGIN
/*
	SYARAT BISA DAFTAR
	- nama, email, password tidak kosong
	- panjang password >= 4
	- email unik
*/
	if ((p_name is null) or (p_email is null) or (p_pass is null)) then
		select 1 as `errno`, 'name/email/password can\'t be empty' as `msg`;
	elseif exists (select `email` from `user` where `email` = p_email) then
		select 2 as `errno`, 'email is already registered' as `msg`;
	else
		INSERT INTO `user` VALUE (NULL, p_name, p_email, MD5(p_pass));
		select 0 as `errno`, 'success' as `msg`;
	end if;
	
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

/* Procedure structure for procedure `get_timeline` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_timeline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_timeline`(
	p_id_user int
	)
BEGIN
/*
	SYARAT BISA ADA DI TIMELINE
	- post dari teman yg sudah di add
	- post dari diri sendiri
*/
	select * from `post` where `id_user` in
	(select `id_user_2` as `id_user` from `friend` where `id_user` = p_id_user
	union select p_id_user as `id_user`)
	order by `id` desc;
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

/* Procedure structure for procedure `verify_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `verify_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `verify_login`(
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
