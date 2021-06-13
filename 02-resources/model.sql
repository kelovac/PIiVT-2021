/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `aplikacija`;

CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`, `is_active`) VALUES
	(1, 'dragan', '$2b$11$F6dTnlsNs6ReyhbSoJt8LONWpVJFzF64xbIE5pp/POMRhPH8yJnma', 1);
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `is_promoted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `uq_article_title` (`title`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `created_at`, `title`, `excerpt`, `description`, `is_active`, `is_promoted`, `category_id`) VALUES
	(8, '2021-06-13 13:51:18', 'Moments srebrna narukvica', 'Srebrna narukvica za svaku priliku.', 'Neka Vaši privesci imaju romantičnu pozadinu u vidu naše klasične narukvice za priveske. Izrađena od srebra i sadrži kopču od 18k pozlate jedinstvene mešavine metala sa logom.', 1, 0, 15),
	(10, '2021-06-13 14:23:39', 'Bangle narukvica', 'Bangle narukvica', 'Ako ste tražili pravu Bangle narukvicu koja će Vas izdvojiti iz gomile, upravo ste je pronašli. Ova elegantna, srebrna Bangle narukvica odlikuje se bezvremenskim Pandora izgledom, ona je od zmijskog lanca. Ona će u trenutku transformirati Vaš stil svojim neprolaznim dizajnom.', 1, 0, 16),
	(11, '2021-06-13 14:26:08', 'Ogrlica srce', 'Ogrlica sa priveskom srceta', 'Ova srebrna ogrlica kombinuje dva izgleda u jednom; svetlucave kamenčiće na jednoj strani i Pandora logo na drugoj.', 1, 0, 5),
	(12, '2021-06-13 14:29:18', 'Lančić sajla', 'Shine lančić', 'Naš lančić sajla od Pandora Shine je pravi stožer garderobe koji ćete nositi i obožavati još mnogo godina. Neverovatno svestran i lako prilagodljive dužine, ovo je savršen partner za Vaše omiljene priveske i Pandora medaljone. Posebno kreiran da se nosi sa Moments O priveskom zbog nešto veće debljine lanca, omogućiće Vam da svima pokažete svoje omiljene priveske odjednom na O privesku.', 1, 0, 12),
	(13, '2021-06-13 14:31:41', 'Ispletena srca', 'Visece mindjuse', 'Ove upečatljive minđuše izrađene su od srebra, od kombinacije glatkog metala i pavé kamenčića. Ukrašene su isprepletenim srcem i Pandora silmbolom, slovom O.', 1, 0, 13),
	(14, '2021-06-13 14:32:44', 'Minđuše Beskonačna Ljubav', 'Nevisece mindjuse', 'Ručno završene neviseće minđuše predstavljaju klasičan znak beskonačnosti u blistavom srebru prekrivenom kubnim cirkonima. Nosite ili podelite stil koji simbolizuje večnu ljubav sa ovim minđušama. Mogu se nositi samostalno ili nizati sa drugim komadima koji su odraz Vašeg ličnog stila.', 1, 0, 14),
	(15, '2021-06-13 14:38:07', 'Naviforce Muški ručni sat NF9148 RGBEDB', 'Naviforce Muški ručni sat NF9148 RGBEDB', 'Svaki Naviforce sat pokreće originalni Seiko Epson mehanizam koji garantuje kvalitet i dugotrajnost. Kupovinom Naviforce sata, dobićete po pristupačnoj ceni, kvalitetnu završnu obradu i dopadljiv dizajn kakav možete naći kod mnogo poznatijih brendova.', 1, 0, 6),
	(16, '2021-06-13 14:41:45', 'ESPRIT ES107282011', 'ESPIRIT ženski sat', 'Romantičan ženski ručni sat brenda Esprit, sa kućištem i narukvicom u roze zlatnoj PVD prevlaci. Srebrni brojčanik ulepšavaju srca u roze zlatnoj boji, a koronu beli cirkoni. Sat dolazi u setu sa nežnom narukvicom u istoj boji sa priveskom u obliku srca. Ovaj sat naglašava stranu vašeg stila i podmlađuje svaku situaciju u vašem svakodnevnom životu.', 1, 0, 7);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `article_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `value`, `article_id`, `feature_id`) VALUES
	(17, 'Bez kamena', 8, 5),
	(18, 'Shine', 8, 13),
	(19, 'Bezbojna', 8, 23),
	(23, 'Bez kamena', 10, 5),
	(24, 'Srebro', 10, 13),
	(25, 'Srebrna', 10, 23),
	(26, 'Cirkon', 11, 5),
	(27, 'Srebro', 11, 13),
	(28, 'Srebrna', 11, 23),
	(29, 'Bez kamena', 12, 5),
	(30, 'Shine', 12, 13),
	(31, 'Zlatna', 12, 23),
	(32, 'Cirkon', 13, 5),
	(33, 'Srebro', 13, 13),
	(34, 'Srebrna', 13, 23),
	(35, 'Cirkon', 14, 5),
	(36, 'Srebro', 14, 13),
	(37, 'Srebrna', 14, 23),
	(38, 'Analogni', 15, 7),
	(39, 'Čelik', 15, 9),
	(40, 'Čelična i zamenska od eko kože', 15, 17),
	(41, 'Seiko VX9N kvarcni mehanizam', 15, 18),
	(42, 'Mineralno', 15, 19),
	(43, 'Analogni', 16, 7),
	(44, 'Čelik', 16, 9),
	(45, 'Čelična', 16, 17),
	(46, 'Kvarc', 16, 18),
	(47, 'Mineralno', 16, 19);
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `price` decimal(10,2) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `created_at`, `price`, `article_id`) VALUES
	(7, '2021-06-13 13:51:18', 100.00, 8),
	(9, '2021-06-13 14:23:39', 92.00, 10),
	(10, '2021-06-13 14:26:08', 99.00, 11),
	(11, '2021-06-13 14:29:18', 230.00, 12),
	(12, '2021-06-13 14:31:41', 50.00, 13),
	(13, '2021-06-13 14:32:44', 30.00, 14),
	(14, '2021-06-13 14:38:07', 80.00, 15),
	(15, '2021-06-13 14:41:45', 140.00, 16);
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_id`, `created_at`, `user_id`) VALUES
	(8, '2021-06-13 14:14:28', 2),
	(9, '2021-06-13 14:42:19', 2);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `cart_id` int(10) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
INSERT INTO `cart_article` (`cart_article_id`, `quantity`, `cart_id`, `article_id`) VALUES
	(9, 1, 8, 12),
	(10, 1, 8, 16);
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent__category_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Nakit', '/static/categories/nakit.png', NULL),
	(2, 'Satovi', '/static/categories/satovi.png', NULL),
	(3, 'Narukvice', '/static/categories/narukvice.png', 1),
	(4, 'Ogrlice', '/static/categories/ogrlice.png', 1),
	(5, 'Ogrlice sa priveskom', '/static/categories/privezak.png', 4),
	(6, 'Muški satovi', '/static/categories/msatovi.png', 2),
	(7, 'Ženski satovi', '/static/categories/zsatovi.png', 2),
	(9, 'Minđuše', 'static/categories/mindjuse.png', 1),
	(12, 'Lančići', '/static/categories/lancici.png', 4),
	(13, 'Viseće minđuše', '/static/categories/visece.png', 9),
	(14, 'Neviseće minđuše', '/static/categories/nevisece.png', 9),
	(15, 'Glatke narukvice', 'statc/categories/gnarukvice.png', 3),
	(16, 'Bangle narukvice', 'static/categories/bnarukvice.png', 3);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(23, 'Boja', 1),
	(5, 'Kamenje', 1),
	(9, 'Materijal', 2),
	(18, 'Mehanizam', 2),
	(13, 'Metal', 1),
	(17, 'Narukvica', 2),
	(19, 'Staklo', 2),
	(7, 'Tip', 2);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','rejected','accepted','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `cart_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`order_id`, `created_at`, `status`, `cart_id`) VALUES
	(5, '2021-06-13 14:42:19', 'pending', 8);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `image_path`, `article_id`) VALUES
	(7, 'static/uploads/2021/06/26437368-2532-4727-bd18-43c02caf2e21-narukvica2.png', 8),
	(9, 'static/uploads/2021/06/bb34c475-4e2a-49ae-94ce-3ff0a5b9bd96-banglenarukivca.jpg', 10),
	(10, 'static/uploads/2021/06/a45a06b0-b809-4d15-86cf-6b453f285583-ogrlicasrce.png', 11),
	(11, 'static/uploads/2021/06/a61826c8-7d52-4340-bb6b-09bbdb2ffa73-lancic.jpg', 12),
	(12, 'static/uploads/2021/06/ea838956-cc3c-4856-80c6-b3af1c691719-ispletenasrca.png', 13),
	(13, 'static/uploads/2021/06/ea1a6eb8-7c2c-4f0e-9f74-ef40a1f2508b-beskonacnaljubav.png', 14),
	(14, 'static/uploads/2021/06/efdd7102-5fb3-47b3-b937-3f221f619883-muskisat1.jpg', 15),
	(15, 'static/uploads/2021/06/062cbd56-1702-4e8f-86df-187666aa3776-zenskisat.jpg', 16);
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_reset_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forename` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `created_at`, `email`, `password_hash`, `password_reset_code`, `forename`, `surname`, `phone_number`, `postal_address`, `is_active`) VALUES
	(1, '2021-05-21 15:56:08', 'mtair@singidunum.ac.rs', '$2b$11$Z3F47fcrCqxnWjGQ/8Y8eOIjBeLSMLTR8KvWlRA1ExnjkAKFR91.a', NULL, 'Milan', 'Tair', '+381691281231', 'danijelova 32, 11010 Beograd, R. Srbija', 1),
	(2, '2021-06-03 16:16:17', 'dadokelovac@gmail.com', '$2b$11$o8soWlaFfuv4FvSw5wjANemJM36l.5UvAK0h6N3uZVsEo/Ch3QLgK', NULL, 'Dragan', 'Grujicic', '0695015105', '13. septembra 122', 1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
