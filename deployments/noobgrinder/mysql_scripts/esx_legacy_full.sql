CREATE DATABASE IF NOT EXISTS `es_extended` DEFAULT CHARACTER SET UTF8MB4;
ALTER DATABASE `es_extended` DEFAULT CHARACTER SET UTF8MB4;
ALTER DATABASE `es_extended` DEFAULT COLLATE UTF8MB4_UNICODE_CI;

CREATE TABLE if not exists `users` (
`identifier` VARCHAR(60) NOT NULL,
`accounts` LONGTEXT NULL DEFAULT NULL,
`group` VARCHAR(50) NULL DEFAULT 'user',
`inventory` LONGTEXT NULL DEFAULT NULL,
`job` VARCHAR(20) NULL DEFAULT 'unemployed',
`job_grade` INT NULL DEFAULT 0,
`loadout` LONGTEXT NULL DEFAULT NULL,
`position` VARCHAR(255) NULL DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
PRIMARY KEY (`identifier`)
) ENGINE=InnoDB;

CREATE TABLE if not exists `items` (
`name` VARCHAR(50) NOT NULL,
`label` VARCHAR(50) NOT NULL,
`weight` INT NOT NULL DEFAULT 1,
`rare` TINYINT NOT NULL DEFAULT 0,
`can_remove` TINYINT NOT NULL DEFAULT 1,
PRIMARY KEY (`name`)
) ENGINE=InnoDB;

CREATE TABLE if not exists `jobs` (
`name` VARCHAR(50) NOT NULL,
`label` VARCHAR(50) DEFAULT NULL,
`whitelisted` tinyint(1) NOT NULL DEFAULT 0,
PRIMARY KEY (`name`)
) ENGINE=InnoDB;

CREATE TABLE if not exists `job_grades` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`job_name` varchar(50) DEFAULT NULL,
`grade` int(11) NOT NULL,
`name` varchar(50) NOT NULL,
`label` varchar(50) NOT NULL,
`salary` int(11) NOT NULL,
`skin_male` longtext NOT NULL,
`skin_female` longtext NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `jobs` (name, label) VALUES
('unemployed','Unemployed'),
('ambulance', 'EMS'),
('banker','Banker'),
('cardealer', 'Car Dealer'),
('fisherman', 'Fisherman'),
('fueler', 'Fueler'),
('lumberjack', 'Lumberjack'),
('miner', 'Miner'),
('mechanic', 'Mechanic'),
('police', 'LSPD'),
('realestateagent','Real estate agent'),
('reporter', 'Journalist'),
('slaughterer', 'Slaughterer'),
('tailor', 'Tailor'),
('taxi', 'Taxi')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
('unemployed', 0, 'unemployed', 'Unemployed', 0, '{}', '{}'),
('ambulance', 0, 'ambulance', 'Ambulance', 20, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
('ambulance', 1, 'doctor', 'Medecine', 40, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
('ambulance', 2, 'chief_doctor', 'Chief', 60, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
('ambulance', 3, 'boss', 'Boss', 80, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
('banker', 0, 'advisor', 'Advisor', 10,'{}', '{}'),
('banker', 1, 'banker', 'Banker', 20, '{}', '{}'),
('banker', 2, 'business_banker', "Business Banker", 30, '{}', '{}'),
('banker', 3, 'trader', 'Trader', 40, '{}', '{}'),
('banker', 4, 'boss', 'Boss', 80, '{}', '{}'),
('cardealer', 0, 'recruit', 'Recruit', 10, '{}', '{}'),
('cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
('cardealer', 2, 'experienced', 'Experienced', 40, '{}', '{}'),
('cardealer', 3, 'boss', 'Boss', 80, '{}', '{}'),
('fisherman', 0, 'employee', 'Employee', 30, '{}', '{}'),
('fueler', 0, 'employee', 'Employee', 30, '{}', '{}'),
('lumberjack', 0, 'employee', 'Employee', 50, '{}', '{}'),
('mechanic',0,'rookie','Rookie',12,'{}','{}'),
('mechanic',1,'novice','Novice',24,'{}','{}'),
('mechanic',2,'advanced','Advanced',36,'{}','{}'),
('mechanic',3,'chief',"Chief",48,'{}','{}'),
('mechanic',4,'boss','Boss',100,'{}','{}'),
('miner', 0, 'employee', 'Employee', 80, '{"tshirt_2":1,"ears_1":8,"glasses_1":15,"torso_2":0,"ears_2":2,"glasses_2":3,"shoes_2":1,"pants_1":75,"shoes_1":51,"bags_1":0,"helmet_2":0,"pants_2":7,"torso_1":71,"tshirt_1":59,"arms":2,"bags_2":0,"helmet_1":0}', '{}'),
('police',0,'recruit','Recruit',20,'{}','{}'),
('police',1,'officer','Officer',40,'{}','{}'),
('police',2,'sergeant','Sergeant',60,'{}','{}'),
('police',3,'lieutenant','Lieutenant',85,'{}','{}'),
('police',4,'boss','Commander',100,'{}','{}'),
('realestateagent',0,'location','Location',10,'{}','{}'),
('realestateagent',1,'vendor','Vendor',25,'{}','{}'),
('realestateagent',2,'management','Management',40,'{}','{}'),
('realestateagent',3,'boss','Boss',50,'{}','{}'),
('reporter', 0, 'employee', 'Employee', 50, '{}', '{}'),
('slaughterer',0,'employee','Employee',50,'{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}','{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
('tailor', 0, 'employee', 'Employee', 30, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
('taxi', 0, 'recrue', 'Recruit', 12, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
('taxi', 1, 'novice', 'Cabby', 24, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
('taxi', 2, 'experimente', 'Experienced', 36, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
('taxi', 3, 'uber', 'Uber Cabby', 48, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
('taxi', 4, 'boss', 'Lead Cabby', 90, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":29,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":1,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":4,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}')
;

CREATE TABLE if not exists `addon_account` (
`name` VARCHAR(60) NOT NULL,
`label` VARCHAR(100) NOT NULL,
`shared` INT NOT NULL,
PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `addon_account_data` (
`id` INT NOT NULL AUTO_INCREMENT,
`account_name` VARCHAR(100) DEFAULT NULL,
`money` INT NOT NULL,
`owner` VARCHAR(60) DEFAULT NULL,

PRIMARY KEY (`id`),
UNIQUE INDEX `index_addon_account_data_account_name_owner` (`account_name`, `owner`),
INDEX `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `users`
ADD COLUMN `firstname` VARCHAR(16) NULL DEFAULT NULL,
ADD COLUMN `lastname` VARCHAR(16) NULL DEFAULT NULL,
ADD COLUMN `dateofbirth` VARCHAR(10) NULL DEFAULT NULL,
ADD COLUMN `sex` VARCHAR(1) NULL DEFAULT NULL,
ADD COLUMN `height` INT NULL DEFAULT NULL
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
('slaughtered_chicken', 'Dead chicken', 1),
('fish', 'Fish', 1),
('stone', 'Stone', 1),
('washed_stone', 'Washed Stone', 1),
('iron', 'Iron', 1),
('gold', 'Gold', 1),
('wood', 'Wood', 1),
('oil', 'Oil', 1),
('wool', 'Wool', 1)
;

CREATE TABLE if not exists `licenses` (
`type` varchar(60) NOT NULL,
`label` varchar(60) NOT NULL,

PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `user_licenses` (
`id` int NOT NULL AUTO_INCREMENT,
`type` varchar(60) NOT NULL,
`owner` VARCHAR(60) NOT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE if not exists `addon_account` (
`name` varchar(60) NOT NULL,
`label` varchar(100) NOT NULL,
`shared` int(11) NOT NULL
) ENGINE=InnoDB;

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('caution', 'caution', 0),
('property_black_money', 'Realestate', 0),
('society_ambulance', 'EMS', 1),
('society_cardealer', 'Car Dealer', 1),
('society_mechanic', 'Mechanic', 1),
('society_police', 'Police', 1),
('society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Table structure for table `addon_account_data`
--

CREATE TABLE if not exists `addon_account_data` (
`id` int(11) NOT NULL,
`account_name` varchar(100) DEFAULT NULL,
`money` int(11) NOT NULL,
`owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'society_cardealer', 0, NULL),
(2, 'society_police', 0, NULL),
(3, 'society_ambulance', 0, NULL),
(4, 'society_mechanic', 0, NULL),
(5, 'society_taxi', 0, NULL);
-- --------------------------------------------------------

--
-- Table structure for table `addon_inventory`
--

CREATE TABLE if not exists `addon_inventory` (
`name` varchar(60) NOT NULL,
`label` varchar(100) NOT NULL,
`shared` int(11) NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('property', 'Property', 0),
('society_ambulance', 'EMS', 1),
('society_cardealer', 'Car Dealer', 1),
('society_mechanic', 'Mechanic', 1),
('society_police', 'Police', 1),
('society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Table structure for table `addon_inventory_items`
--

CREATE TABLE if not exists `addon_inventory_items` (
`id` int(11) NOT NULL,
`inventory_name` varchar(100) NOT NULL,
`name` varchar(100) NOT NULL,
`count` int(11) NOT NULL,
`owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE if not exists `billing` (
`id` int(11) NOT NULL,
`identifier` varchar(60) NOT NULL,
`sender` varchar(60) NOT NULL,
`target_type` varchar(50) NOT NULL,
`target` varchar(40) NOT NULL,
`label` varchar(255) NOT NULL,
`amount` int(11) NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `cardealer_vehicles`
--

CREATE TABLE if not exists `cardealer_vehicles` (
`id` int(11) NOT NULL,
`vehicle` varchar(255) NOT NULL,
`price` int(11) NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `multicharacter_slots`
--

CREATE TABLE if not exists `multicharacter_slots` (
`identifier` VARCHAR(60) NOT NULL,
`slots` INT(11) NOT NULL,
PRIMARY KEY (`identifier`) USING BTREE,
INDEX `slots` (`slots`) USING BTREE
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `datastore`
--

CREATE TABLE if not exists `datastore` (
`name` varchar(60) NOT NULL,
`label` varchar(100) NOT NULL,
`shared` int(11) NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('property', 'Property', 0),
('society_ambulance', 'EMS', 1),
('society_mechanic', 'Mechanic', 1),
('society_police', 'Police', 1),
('society_taxi', 'Taxi', 1);


INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('user_ears', 'Ears', 0),
('user_glasses', 'Glasses', 0),
('user_helmet', 'Helmet', 0),
('user_mask', 'Mask', 0);

-- --------------------------------------------------------

--
-- Table structure for table `datastore_data`
--

CREATE TABLE if not exists `datastore_data` (
`id` int(11) NOT NULL,
`name` varchar(60) NOT NULL,
`owner` varchar(60) DEFAULT NULL,
`data` longtext DEFAULT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'society_police', NULL, '{}'),
(2, 'society_ambulance', NULL, '{}'),
(3, 'society_mechanic', NULL, '{}'),
(4, 'society_taxi', NULL, '{}'),
(5, 'property', NULL, '{}');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE if not exists `items` (
`name` varchar(50) NOT NULL,
`label` varchar(50) NOT NULL,
`weight` int(11) NOT NULL DEFAULT 1,
`rare` tinyint(4) NOT NULL DEFAULT 0,
`can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('alive_chicken', 'Living chicken', 1, 0, 1),
('bandage', 'Bandage', 2, 0, 1),
('blowpipe', 'Blowtorch', 2, 0, 1),
('bread', 'Bread', 1, 0, 1),
('cannabis', 'Cannabis', 3, 0, 1),
('carokit', 'Body Kit', 3, 0, 1),
('carotool', 'Tools', 2, 0, 1),
('clothe', 'Cloth', 1, 0, 1),
('copper', 'Copper', 1, 0, 1),
('cutted_wood', 'Cut wood', 1, 0, 1),
('diamond', 'Diamond', 1, 0, 1),
('essence', 'Gas', 1, 0, 1),
('fabric', 'Fabric', 1, 0, 1),
('radio', 'Radio', 1, 0, 1),
('fixkit', 'Repair Kit', 3, 0, 1),
('fixtool', 'Repair Tools', 2, 0, 1),
('gazbottle', 'Gas Bottle', 2, 0, 1),
('marijuana', 'Marijuana', 2, 0, 1),
('medikit', 'medikit', 2, 0, 1),
('packaged_chicken', 'Chicken fillet', 1, 0, 1),
('packaged_plank', 'Packaged wood', 1, 0, 1),
('petrol', 'Oil', 1, 0, 1),
('petrol_raffin', 'Processed oil', 1, 0, 1),
('phone', 'Phone', 1, 0, 1),
('water', 'Water', 1, 0, 1);


-- --------------------------------------------------------

--
-- Table structure for table `licenses`
--

CREATE TABLE if not exists `licenses` (
`type` varchar(60) NOT NULL,
`label` varchar(60) NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('dmv', 'Driving Permit'),
('drive', 'Drivers License'),
('drive_bike', 'Motorcycle License'),
('drive_truck', 'Commercial Drivers License'),
('weed_processing', 'Weed Processing License');

-- --------------------------------------------------------

--
-- Table structure for table `owned_properties`
--

CREATE TABLE if not exists `owned_properties` (
`id` int(11) NOT NULL,
`name` varchar(255) NOT NULL,
`price` double NOT NULL,
`rented` int(11) NOT NULL,
`owner` varchar(60) NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `owned_vehicles`
--

CREATE TABLE if not exists `owned_vehicles` (
`owner` varchar(60) DEFAULT NULL,
`plate` varchar(12) NOT NULL,
`vehicle` longtext DEFAULT NULL,
`type` varchar(20) NOT NULL DEFAULT 'car',
`job` varchar(20) DEFAULT NULL,
`stored` tinyint(4) NOT NULL DEFAULT 0,
`parking` VARCHAR(60) DEFAULT NULL,
`pound` VARCHAR(60) DEFAULT NULL
) ENGINE=InnoDB;


-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE if not exists `properties` (
`id` int(11) NOT NULL,
`name` varchar(255) DEFAULT NULL,
`label` varchar(255) DEFAULT NULL,
`entering` varchar(255) DEFAULT NULL,
`exit` varchar(255) DEFAULT NULL,
`inside` varchar(255) DEFAULT NULL,
`outside` varchar(255) DEFAULT NULL,
`ipls` varchar(255) DEFAULT '[]',
`gateway` varchar(255) DEFAULT NULL,
`is_single` int(11) DEFAULT NULL,
`is_room` int(11) DEFAULT NULL,
`is_gateway` int(11) DEFAULT NULL,
`room_menu` varchar(255) DEFAULT NULL,
`price` int(11) NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{\"y\":564.89,\"z\":182.959,\"x\":119.384}', '{\"x\":117.347,\"y\":559.506,\"z\":183.304}', '{\"y\":557.032,\"z\":183.301,\"x\":118.037}', '{\"y\":567.798,\"z\":182.131,\"x\":119.249}', '[]', NULL, 1, 1, 0, '{\"x\":118.748,\"y\":566.573,\"z\":175.697}', 1500000),
(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{\"x\":372.796,\"y\":428.327,\"z\":144.685}', '{\"x\":373.548,\"y\":422.982,\"z\":144.907}', '{\"y\":420.075,\"z\":145.904,\"x\":372.161}', '{\"x\":372.454,\"y\":432.886,\"z\":143.443}', '[]', NULL, 1, 1, 0, '{\"x\":377.349,\"y\":429.422,\"z\":137.3}', 1500000),
(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}', '{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}', '{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}', '{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}', '[]', NULL, 1, 1, 0, '{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}', 1700000),
(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{\"y\":440.8,\"z\":146.702,\"x\":346.964}', '{\"y\":437.456,\"z\":148.394,\"x\":341.683}', '{\"y\":435.626,\"z\":148.394,\"x\":339.595}', '{\"x\":350.535,\"y\":443.329,\"z\":145.764}', '[]', NULL, 1, 1, 0, '{\"x\":337.726,\"y\":436.985,\"z\":140.77}', 1500000),
(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{\"y\":502.696,\"z\":136.421,\"x\":-176.003}', '{\"y\":497.817,\"z\":136.653,\"x\":-174.349}', '{\"y\":495.069,\"z\":136.666,\"x\":-173.331}', '{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}', '[]', NULL, 1, 1, 0, '{\"x\":-174.725,\"y\":493.095,\"z\":129.043}', 1500000),
(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{\"y\":596.58,\"z\":142.641,\"x\":-686.554}', '{\"y\":591.988,\"z\":144.392,\"x\":-681.728}', '{\"y\":590.608,\"z\":144.392,\"x\":-680.124}', '{\"y\":599.019,\"z\":142.059,\"x\":-689.492}', '[]', NULL, 1, 1, 0, '{\"x\":-680.46,\"y\":588.6,\"z\":136.769}', 1500000),
(7, 'LowEndApartment', 'Appartement de base', '{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}', '{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}', '{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}', '{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}', '[]', NULL, 1, 1, 0, '{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}', 562500),
(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}', '{\"x\":-1289.917,\"y\":449.541,\"z\":96.902}', '{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}', '{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}', '[]', NULL, 1, 1, 0, '{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}', 1500000),
(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{\"x\":-853.346,\"y\":696.678,\"z\":147.782}', '{\"y\":690.875,\"z\":151.86,\"x\":-859.961}', '{\"y\":688.361,\"z\":151.857,\"x\":-859.395}', '{\"y\":701.628,\"z\":147.773,\"x\":-855.007}', '[]', NULL, 1, 1, 0, '{\"x\":-858.543,\"y\":697.514,\"z\":144.253}', 1500000),
(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{\"y\":620.494,\"z\":141.588,\"x\":-752.82}', '{\"y\":618.62,\"z\":143.153,\"x\":-759.317}', '{\"y\":617.629,\"z\":143.153,\"x\":-760.789}', '{\"y\":621.281,\"z\":141.254,\"x\":-750.919}', '[]', NULL, 1, 1, 0, '{\"x\":-762.504,\"y\":618.992,\"z\":135.53}', 1500000),
(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{\"y\":37.025,\"z\":42.58,\"x\":-618.299}', '{\"y\":58.898,\"z\":97.2,\"x\":-603.301}', '{\"y\":58.941,\"z\":97.2,\"x\":-608.741}', '{\"y\":30.603,\"z\":42.524,\"x\":-620.017}', '[]', NULL, 1, 1, 0, '{\"x\":-622.173,\"y\":54.585,\"z\":96.599}', 1700000),
(12, 'MiltonDrive', 'Milton Drive', '{\"x\":-775.17,\"y\":312.01,\"z\":84.658}', NULL, NULL, '{\"x\":-775.346,\"y\":306.776,\"z\":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_01_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.661,\"y\":327.672,\"z\":210.396}', 1300000),
(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_01_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.735,\"y\":326.757,\"z\":186.313}', 1300000),
(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_01_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.386,\"y\":330.782,\"z\":195.08}', 1300000),
(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_02_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.615,\"y\":327.878,\"z\":210.396}', 1300000),
(17, 'Mody2Apartment', 'Appartement Mode 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_02_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.297,\"y\":327.092,\"z\":186.313}', 1300000),
(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_02_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.303,\"y\":330.932,\"z\":195.085}', 1300000),
(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_03_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.885,\"y\":327.641,\"z\":210.396}', 1300000),
(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_03_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.607,\"y\":327.344,\"z\":186.313}', 1300000),
(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_03_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.525,\"y\":330.851,\"z\":195.085}', 1300000),
(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_04_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.527,\"y\":327.89,\"z\":210.396}', 1300000),
(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_04_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.642,\"y\":326.497,\"z\":186.313}', 1300000),
(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_04_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.503,\"y\":331.318,\"z\":195.085}', 1300000),
(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_05_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.289,\"y\":328.086,\"z\":210.396}', 1300000),
(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_05_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.692,\"y\":326.762,\"z\":186.313}', 1300000),
(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_05_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.094,\"y\":330.976,\"z\":195.085}', 1300000),
(28, 'Seductive1Apartment', 'Seductive Apartment 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\ ":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_06_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x \":-766.263,\"y\":328.104,\"z\":210.396}', 1300000),
(29, 'Seductive2Apartment', 'Seductive Apartment 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\ ":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_06_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x \":-795.655,\"y\":326.611,\"z\":186.313}', 1300000),
(30, 'Seductive3Apartment', 'Seductive Apartment 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\ ":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_06_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x \":-765.3,\"y\":331.414,\"z\":195.085}', 1300000),
(31, 'Regal1Apartment', 'Regal Apartment 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\ ":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_07_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x \":-765.956,\"y\":328.257,\"z\":210.396}', 1300000),
(32, 'Regal2Apartment', 'Regal Apartment 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\ ":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_07_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x \":-795.545,\"y\":326.659,\"z\":186.313}', 1300000),
(33, 'Regal3Apartment', 'Regal Apartment 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\ ":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_07_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x \":-765.087,\"y\":331.429,\"z\":195.123}', 1300000),
(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_08_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.187,\"y\":328.47,\"z\":210.396}', 1300000),
(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_08_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.658,\"y\":326.563,\"z\":186.313}', 1300000),
(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_08_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.287,\"y\":331.084,\"z\":195.086}', 1300000),
(37, 'IntegrityWay', '4 Integrity Way', '{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}', NULL, NULL, '{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}', '{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}', 1700000),
(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}', '{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}', 1700000),
(40, 'DellPerroHeights', 'Dell Perro Heights', '{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}', NULL, NULL, '{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
(41, 'DellPerroHeightst4', 'Dell Dog Heights - Apt 28', NULL, '{\"x\":-1452,125,\"y\":-540,591,\"z\":73,044}', '{ \"x\":-1455.435,\"y\":-535.79,\"z\":73,044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x \":-1467,058,\"y\":-527,571,\"z\":72,443}', 1700000),
(42, 'DellPerroHeightst7', 'Dell Dog Heights - Apt 30', NULL, '{\"x\":-1451,562,\"y\":-523,535,\"z\":55,928}', '{ \"x\":-1456.02,\"y\":-519,209,\"z\":55,929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x \":-1457,026,\"y\":-530,219,\"z\":55,937}', 1700000),
(43, 'MazeBankBuilding', 'Maze Bank Building', '{\"x\":-79.18,\"y\":-795.92,\"z\":43.35}', NULL, NULL, '{\"x\":-72.50,\"y\":-786.92,\"z\":43.40}', '[]', NULL, 0, 0, 1, NULL, 0),
(44, 'OldSpiceWarm', 'Old Spice Warm', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(45, 'OldSpiceClassical', 'Old Spice Classical', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(46, 'OldSpiceVintage', 'Old Spice Vintage', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(47, 'ExecutiveRich', 'Executive Rich', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(48, 'ExecutiveCool', 'Executive Cool', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(49, 'ExecutiveContrast', 'Executive Contrast', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(50, 'PowerBrokerIce', 'Power Broker Ice', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(51, 'PowerBrokerConservative', 'Power Broker Conservative', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(52, 'PowerBrokerPolished', 'Power Broker Polished', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(53, 'LomBank', 'Lom Bank', '{\"x\":-1581.36,\"y\":-558.23,\"z\":34.07}', NULL, NULL, '{\"x\":-1583.60,\"y\":-555.12,\"z\":34.07}', '[]', NULL, 0, 0, 1, NULL, 0),
(54, 'LBOldSpiceWarm', 'LB Old Spice Warm', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(55, 'LBOldSpiceClassical', 'LB Old Spice Classical', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(56, 'LBOldSpiceVintage', 'LB Old Spice Vintage', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(57, 'LBExecutiveRich', 'LB Executive Rich', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(58, 'LBExecutiveCool', 'LB Executive Cool', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(59, 'LBExecutiveContrast', 'LB Executive Contrast', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(60, 'LBPowerBrokerIce', 'LB Power Broker Ice', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(61, 'LBPowerBrokerConservative', 'LB Power Broker Conservative', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(62, 'LBPowerBrokerPolished', 'LB Power Broker Polished', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(63, 'MazeBankWest', 'Maze Bank West', '{\"x\":-1379.58,\"y\":-499.63,\"z\":32.22}', NULL, NULL, '{\"x\":-1378.95,\"y\":-502.82,\"z\":32.22}', '[]', NULL, 0, 0, 1, NULL, 0),
(64, 'MBWOldSpiceWarm', 'MBW Old Spice Warm', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(65, 'MBWOldSpiceClassical', 'MBW Old Spice Classical', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(66, 'MBWOldSpiceVintage', 'MBW Old Spice Vintage', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(67, 'MBWExecutiveRich', 'MBW Executive Rich', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(68, 'MBWExecutiveCool', 'MBW Executive Cool', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(69, 'MBWExecutive Contrast', 'MBW Executive Contrast', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(70, 'MBWPowerBrokerIce', 'MBW Power Broker Ice', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(71, 'MBWPowerBrokerConvservative', 'MBW Power Broker Convservative', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(72, 'MBWPowerBrokerPolished', 'MBW Power Broker Polished', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000);

-- --------------------------------------------------------

--
-- Table structure for table `rented_vehicles`
--

CREATE TABLE if not exists `rented_vehicles` (
`vehicle` varchar(60) NOT NULL,
`plate` varchar(12) NOT NULL,
`player_name` varchar(255) NOT NULL,
`base_price` int(11) NOT NULL,
`rent_price` int(11) NOT NULL,
`owner` varchar(22) NOT NULL
) ENGINE=InnoDB;

--
-- Table structure for table `society_moneywash`
--

CREATE TABLE if not exists `society_moneywash` (
`id` int(11) NOT NULL,
`identifier` varchar(60) NOT NULL,
`society` varchar(60) NOT NULL,
`amount` int(11) NOT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE if not exists `users` (
`identifier` varchar(60) NOT NULL,
`accounts` longtext DEFAULT NULL,
`group` varchar(50) DEFAULT 'user',
`inventory` longtext DEFAULT NULL,
`job` varchar(20) DEFAULT 'unemployed',
`job_grade` int(11) DEFAULT 0,
`loadout` longtext DEFAULT NULL,
`position` varchar(255) DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
`firstname` varchar(16) DEFAULT NULL,
`lastname` varchar(16) DEFAULT NULL,
`dateofbirth` varchar(10) DEFAULT NULL,
`sex` varchar(1) DEFAULT NULL,
`height` int(11) DEFAULT NULL,
`skin` longtext DEFAULT NULL,
`status` longtext DEFAULT NULL,
`is_dead` tinyint(1) DEFAULT 0,
`id` int(11) NOT NULL,
`disabled` TINYINT(1) NULL DEFAULT '0',
`last_property` varchar(255) DEFAULT NULL
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `user_licenses`
--

CREATE TABLE if not exists `user_licenses` (
`id` int(11) NOT NULL,
`type` varchar(60) NOT NULL,
`owner` varchar(60) NOT NULL
) ENGINE=InnoDB;


--
-- Table structure for table `vehicles`
--

CREATE TABLE if not exists `vehicles` (
`name` varchar(60) NOT NULL,
`model` varchar(60) NOT NULL,
`price` int(11) NOT NULL,
`category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
('Adder', 'adder', 900000, 'super'),
('Akuma','AKUMA', 7500,'motorcycles'),
('Alpha', 'alpha', 60000, 'sports'),
('Ardent', 'ardent', 1150000, 'sportsclassics'),
('Asea', 'asea', 5500, 'sedans'),
('Autarch', 'autarch', 1955000, 'super'),
('greedy', 'greedy', 18000, 'motorcycles'),
('Bagger', 'bagger', 13500, 'motorcycles'),
('Baller', 'baller2', 40000, 'suvs'),
('Baller Sport', 'baller3', 60000, 'suvs'),
('Banshee', 'banshee', 70000, 'sports'),
('Banshee 900R', 'banshee2', 255000, 'super'),
('Bati 801', 'bati', 12000, 'motorcycles'),
('Bati 801RR', 'bati2', 19000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 55000, 'sports'),
('BF400', 'bf400', 6500, 'motorcycles'),
('Bf Injection', 'bfinjection', 16000, 'offroad'),
('Bifta', 'bifta', 12000, 'offroad'),
('Bison', 'bison', 45000, 'vans'),
('Blade', 'blade', 15000, 'muscle'),
('Blazer', 'blazer', 6500, 'offroad'),
('Blazer Sport', 'blazer4', 8500, 'offroad'),
('blazer5', 'blazer5', 1755600, 'offroad'),
('Blista', 'blista', 8000, 'compacts'),
('BMX (velo)', 'bmx', 160, 'motorcycles'),
('Bobcat XL', 'bobcatxl', 32000, 'vans'),
('Brawler', 'brawler', 45000, 'offroad'),
('Brioso R/A', 'brioso', 18000, 'compacts'),
('Btype', 'btype', 62000, 'sportsclassics'),
('Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
('Btype Luxe', 'btype3', 85000, 'sportsclassics'),
('Buccaneer', 'buccaneer', 18000, 'muscle'),
('Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
('Buffalo', 'buffalo', 12000, 'sports'),
('Buffalo S', 'buffalo2', 20000, 'sports'),
('Bullet', 'bullet', 90000, 'super'),
('Burrito', 'burrito3', 19000, 'vans'),
('Camper', 'camper', 42000, 'vans'),
('Char', 'char', 75000, 'sports'),
('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
('Casco', 'casco', 30000, 'sportsclassics'),
('Cavalcade', 'cavalcade2', 55000, 'suvs'),
('Cheetah', 'cheetah', 375000, 'super'),
('Chimera', 'chimera', 38000, 'motorcycles'),
('Chino', 'chino', 15000, 'muscle'),
('Chino Luxe', 'chino2', 19000, 'muscle'),
('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
('cogcabrio cognizant', 'cogcabrio', 55000, 'coupes'),
('Comet', 'comet2', 65000, 'sports'),
('Comet 5', 'comet5', 1145000, 'sports'),
('Contender', 'contender', 70000, 'suvs'),
('Coquette', 'coquette', 65000, 'sports'),
('Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
('Coquette BlackFin', 'coquette3', 55000, 'muscle'),
('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
('Cyclone', 'cyclone', 1890000, 'super'),
('Daemon', 'daemon', 11500, 'motorcycles'),
('Daemon High', 'daemon2', 13500, 'motorcycles'),
('Defiler', 'defiler', 9800, 'motorcycles'),
('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
('Dominator', 'dominator', 35000, 'muscle'),
('Double T', 'double', 28000, 'motorcycles'),
('Dubsta', 'dubsta', 45000, 'suvs'),
('Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
('Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
('Dukes', 'dukes', 28000, 'muscle'),
('Dune Buggy', 'dune', 8000, 'offroad'),
('Elegy', 'elegy2', 38500, 'sports'),
('Emperor', 'emperor', 8500, 'sedans'),
('Enduro', 'enduro', 5500, 'motorcycles'),
('Entity XF', 'entityxf', 425000, 'super'),
('Esskey', 'esskey', 4200, 'motorcycles'),
('Exemplar', 'exemplar', 32000, 'coupes'),
('F620', 'f620', 40000, 'cuts'),
('Faction', 'faction', 20000, 'muscle'),
('Faction Rider', 'faction2', 30000, 'muscle'),
('Faction XL', 'faction3', 40000, 'muscle'),
('Beech', 'beech', 1900, 'motorcycles'),
('Vespa', 'beech2', 2800, 'motorcycles'),
('Felon', 'felon', 42000, 'coupes'),
('Felon GT', 'felon2', 55000, 'coupes'),
('Feltzer', 'feltzer2', 55000, 'sports'),
('Stirling GT', 'feltzer3', 65000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 225, 'motorcycles'),
('FMJ', 'fmj', 185000, 'super'),
('Fhantom', 'fq2', 17000, 'suvs'),
('Fugitive', 'fugitive', 12000, 'sedans'),
('Furore GT', 'furoregt', 45000, 'sports'),
('Fusilade', 'fusilade', 40000, 'sports'),
('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
('Gauntlet', 'gauntlet', 30000, 'muscle'),
('Gang Burrito', 'gburrito', 45000, 'vans'),
('Burrito', 'gburrito2', 29000, 'vans'),
('Glendale', 'glendale', 6500, 'sedans'),
('Grabger', 'granger', 50000, 'suvs'),
('Gresley', 'gresley', 47500, 'suvs'),
('GT 500', 'gt500', 785000, 'sportsclassics'),
('Guardian', 'guardian', 45000, 'offroad'),
('Hakuchou','hakuchou', 31000,'motorcycles'),
('Hakuchou Sport','hakuchou2', 55000,'motorcycles'),
('Hermes', 'hermes', 535000, 'muscle'),
('Hexer', 'Hexer', 12000, 'motorcycles'),
('Hotknife', 'hotknife', 125000, 'muscle'),
('Huntley S', 'huntley', 40000, 'suvs'),
('Hustler', 'hustler', 625000, 'muscle'),
('Innovation', 'innovation', 23500, 'motorcycles'),
('Intruder', 'intruder', 7500, 'sedans'),
('Issi', 'issi2', 10000, 'compacts'),
('Jackal', 'jackal', 38000, 'coupes'),
('Jester', 'jester', 65000, 'sports'),
('Jester(Racecar)', 'jester2', 135000, 'sports'),
('Journey', 'journey', 6500, 'vans'),
('Bed', 'bed', 345000, 'offroad'),
('Khamelion', 'khamelion', 38000, 'sports'),
('Dry', 'dry', 30000, 'sports'),
('Landstalker', 'landstalker', 35000, 'suvs'),
('RE-7B', 'le7b', 325000, 'super'),
('Lynx', 'lynx', 40000, 'sports'),
('Mamba', 'mamba', 70000, 'sports'),
('Manana', 'manana', 12800, 'sportsclassics'),
('Manchez', 'manchez', 5300, 'motorcycles'),
('Massacre', 'massacre', 65000, 'sports'),
('Massacro(Racecar)', 'massacro2', 130000, 'sports'),
('table', 'table', 16000, 'suvs'),
('Mesa Trail', 'mesa3', 40000, 'suvs'),
('Minivan', 'minivan', 13000, 'vans'),
('Monroe', 'monroe', 55000, 'sportsclassics'),
('The Liberator', 'monster', 210000, 'offroad'),
('Moonbeam', 'moonbeam', 18000, 'vans'),
('Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
('Nemesis', 'nemesis', 5800, 'motorcycles'),
('Neon', 'neon', 1500000, 'sports'),
('Nightblade', 'nightblade', 35000, 'motorcycles'),
('Nightshade', 'nightshade', 65000, 'muscle'),
('9F', 'ninef', 65000, 'sports'),
('9F Cabrio', 'ninef2', 80000, 'sports'),
('Oppressor', 'oppressor', 3524500, 'super'),
('Oracle XS', 'oracle2', 35000, 'coupes'),
('Osiris', 'osiris', 160000, 'super'),
('Panto', 'panto', 10000, 'compacts'),
('Paradise', 'paradise', 19000, 'vans'),
('Pariah', 'pariah', 1420000, 'sports'),
('Patriot', 'patriot', 55000, 'suvs'),
('PCJ-600', 'pcj', 6200, 'motorcycles'),
('Penumbra', 'penumbra', 28000, 'sports'),
('Pfister', 'pfister811', 85000, 'super'),
('Phoenix', 'phoenix', 12500, 'muscle'),
('Picador', 'picador', 18000, 'muscle'),
('Pigalle', 'pigalle', 20000, 'sportsclassics'),
('Prairie', 'prairie', 12000, 'compacts'),
('Premier', 'premier', 8000, 'sedans'),
('Primo Custom', 'primo2', 14000, 'sedans'),
('X80 Proto', 'prototipo', 2500000, 'super'),
('Radius', 'radius', 29000, 'suvs'),
('Rapid GT', 'rapidgt', 35000, 'sports'),
('Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
('Reaper', 'reaper', 150000, 'super'),
('Rebel', 'rebel2', 35000, 'offroad'),
('Regina', 'regina', 5000, 'sedans'),
('Retinue', 'retinue', 615000, 'sportsclassics'),
('Revolt', 'revolt', 1610000, 'sports'),
('Ruffian', 'ruffian', 6800, 'motorcycles'),
('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
('Rumpo', 'Rumpo', 15000, 'vans'),
('Rumpo Trail', 'rumpo3', 19500, 'vans'),
('Saber Turbo', 'sabregt', 20000, 'muscle'),
('Sabre GT', 'sabregt2', 25000, 'muscle'),
('Sanchez', 'sanchez', 5300, 'motorcycles'),
('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
('holy', 'holy', 25000, 'motorcycles'),
('Sandking', 'sandking', 55000, 'offroad'),
('Savestra', 'savestra', 990000, 'sportsclassics'),
('SC 1', 'sc1', 1603000, 'super'),
('schafter', 'schafter2', 25000, 'sedans'),
('Schäter V12', 'schafter3', 50000, 'sports'),
('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
('Seminole', 'seminole', 25000, 'suvs'),
('Sentinel', 'sentinel', 32000, 'coupes'),
('Sentinel XS', 'sentinel2', 40000, 'coupes'),
('Sentinel3', 'sentinel3', 650000, 'sports'),
('Seven 70', 'seven70', 39500, 'sports'),
('ETR1', 'sheava', 220000, 'super'),
('Shotaro Concept','shotaro', 320000,'motorcycles'),
('Slam Van', 'slamvan3', 11500, 'muscle'),
('Sovereign', 'sovereign', 22000, 'motorcycles'),
('Stinger', 'stinger', 80000, 'sportsclassics'),
('Stinger GT', 'stingergt', 75000, 'sportsclassics'),
('contender', 'contender', 500000, 'sports'),
('Stretch', 'stretch', 90000, 'sedans'),
('Stromberg', 'stromberg', 3185350, 'sports'),
('Sultan', 'sultan', 15000, 'sports'),
('Sultan RS', 'sultanrs', 65000, 'super'),
('Super Diamond', 'superd', 130000, 'sedans'),
('Surano', 'surano', 50000, 'sports'),
('Surfer', 'surfer', 12000, 'vans'),
('T20', 't20', 300000, 'great'),
('Tailgater', 'tailgater', 30000, 'sedans'),
('Tampa', 'tampa', 16000, 'muscle'),
('Drift Tampa', 'tampa2', 80000, 'sports'),
('Thrust', 'thrust', 24000, 'motorcycles'),
('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
('Trophy Truck', 'trophytruck', 60000, 'offroad'),
('Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
('Tropos', 'tropos', 40000, 'sports'),
('Turismo R', 'turismor', 350000, 'super'),
('Tyrus', 'Tyrus', 600000, 'Super'),
('Vacca', 'cow', 120000, 'super'),
("Father", "father", 7200, "motorcycles"),
('loser', 'loser2', 70000, 'sports'),
('Vigero', 'vigero', 12500, 'muscle'),
('Virgo', 'virgo', 14000, 'muscle'),
('Viseris', 'viseis', 875000, 'sportsclassics'),
('Vision', 'vision', 2250000, 'super'),
('Voltic', 'voltic', 90000, 'super'),
('Voltic 2', 'voltic2', 3830400, 'super'),
('Voodoo', 'voodoo', 7200, 'muscle'),
('Vortex', 'vortex', 9800, 'motorcycles'),
('Warrener', 'warrener', 4000, 'sedans'),
('Washington', 'washington', 9000, 'sedans'),
('Windsor', 'windsor', 95000, 'coupes'),
('Windsor Drop', 'windsor2', 125000, 'coupes'),
('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
('XLS', 'xls', 32000, 'suvs'),
('Yosemite', 'yosemite', 485000, 'muscle'),
('Youga', 'youga', 10800, 'vans'),
('Youga Luxuary', 'youga2', 14500, 'vans'),
('Z190', 'z190', 900000, 'sportsclassics'),
('Zentorno', 'zentorno', 1500000, 'super'),
('Zion', 'zion', 36000, 'coupes'),
('Zion Cabrio', 'zion2', 45000, 'coupes'),
('Zombie', 'zombiea', 9500, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
('Z-Type', 'ztype', 220000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_categories`
--

CREATE TABLE if not exists `vehicle_categories` (
`name` varchar(60) NOT NULL,
`label` varchar(60) NOT NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('cuts', 'Cuts'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_sold`
--

CREATE TABLE if not exists `vehicle_sold` (
`client` varchar(50) NOT NULL,
`model` varchar(50) NOT NULL,
`plate` varchar(50) NOT NULL,
`soldby` varchar(50) NOT NULL,
`date` varchar(50) NOT NULL
) ENGINE=InnoDB;

--
-- Table structure for table `whitelist`
--

CREATE TABLE if not exists `whitelist` (
`identifier` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addon_inventory`
--
ALTER TABLE `addon_inventory`
ADD PRIMARY KEY (`name`);

--
-- Indexes for table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
ADD PRIMARY KEY (`id`),
ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `datastore`
--
ALTER TABLE `datastore`
ADD PRIMARY KEY (`name`);

--
-- Indexes for table `datastore_data`
--
ALTER TABLE `datastore_data`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
ADD KEY `index_datastore_data_name` (`name`);

--
-- Indexes for table `owned_properties`
--
ALTER TABLE `owned_properties`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
ADD PRIMARY KEY (`plate`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
ADD PRIMARY KEY (`plate`);

--
-- Indexes for table `society_moneywash`
--
ALTER TABLE `society_moneywash`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
ADD PRIMARY KEY (`name`);

--
-- Indexes for table `vehicle_sold`
--
ALTER TABLE `vehicle_sold`
ADD PRIMARY KEY (`plate`);

--
-- Indexes for table `whitelist`
--
ALTER TABLE `whitelist`
ADD PRIMARY KEY (`identifier`);

--
-- AUTO_INCREMENT for table `addon_account_data`
--
ALTER TABLE `addon_account_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `billing`
--
ALTER TABLE `billing`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `datastore_data`
--
ALTER TABLE `datastore_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `owned_properties`
--
ALTER TABLE `owned_properties`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `society_moneywash`
--
ALTER TABLE `society_moneywash`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_licenses`
--
ALTER TABLE `user_licenses`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- ESX Phone
--
CREATE TABLE if not exists `user_contacts` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`identifier` VARCHAR(60) NOT NULL,
`name` VARCHAR(100) NOT NULL,
`number` INT(11) NOT NULL,

PRIMARY KEY (`id`),
INDEX `index_user_contacts_identifier_name_number` (`identifier`, `name`, `number`)
) ENGINE=InnoDB;


ALTER TABLE `users`
ADD COLUMN `phone_number` INT(11) NULL,
ADD UNIQUE INDEX `index_users_phone_number` (`phone_number`);

--
-- Fine Types
--
CREATE TABLE if not exists `fine_types` (
`id` int NOT NULL AUTO_INCREMENT,
`label` varchar(255) DEFAULT NULL,
`amount` int DEFAULT NULL,
`category` int DEFAULT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `fine_types` (label, amount, category) VALUES
('Misuse of a horn', 30, 0),
('Illegally Crossing a continuous Line', 40, 0),
('Driving on the wrong side of the road', 250, 0),
('Illegal U-Turn', 250, 0),
('Illegally Driving Off-road', 170, 0),
('Refusing a Lawful Command', 30, 0),
('Illegally Stopping a Vehicle', 150, 0),
('Illegal Parking', 70, 0),
('Failing to Yield to the right', 70, 0),
('Failure to comply with Vehicle Information', 90, 0),
('Failing to stop at a Stop Sign ', 105, 0),
('Failing to stop at a Red Light', 130, 0),
('Illegal Passing', 100, 0),
('Driving an illegal Vehicle', 100, 0),
('Driving without a License', 1500, 0),
('Hit and Run', 800, 0),
('Exceeding Speeds Over < 5 mph', 90, 0),
('Exceeding Speeds Over 5-15 mph', 120, 0),
('Exceeding Speeds Over 15-30 mph', 180, 0),
('Exceeding Speeds Over > 30 mph', 300, 0),
('Impeding traffic flow', 110, 1),
('Public Intoxication', 90, 1),
('Disorderly conduct', 90, 1),
('Obstruction of Justice', 130, 1),
('Insults towards Civilans', 75, 1),
('Disrespecting of an LEO', 110, 1),
('Verbal Threat towards a Civilan', 90, 1),
('Verbal Threat towards an LEO', 150, 1),
('Providing False Information', 250, 1),
('Attempt of Corruption', 1500, 1),
('Brandishing a weapon in city Limits', 120, 2),
('Brandishing a Lethal Weapon in city Limits', 300, 2),
('No Firearms License', 600, 2),
('Possession of an Illegal Weapon', 700, 2),
('Possession of Burglary Tools', 300, 2),
('Grand Theft Auto', 1800, 2),
('Intent to Sell/Distrube of an illegal Substance', 1500, 2),
('Frabrication of an Illegal Substance', 1500, 2),
('Possession of an Illegal Substance ', 650, 2),
('Kidnapping of a Civilan', 1500, 2),
('Kidnapping of an LEO', 2000, 2),
('Robbery', 650, 2),
('Armed Robbery of a Store', 650, 2),
('Armed Robbery of a Bank', 1500, 2),
('Assault on a Civilian', 2000, 3),
('Assault of an LEO', 2500, 3),
('Attempt of Murder of a Civilian', 3000, 3),
('Attempt of Murder of an LEO', 5000, 3),
('Murder of a Civilian', 10000, 3),
('Murder of an LEO', 30000, 3),
('Involuntary manslaughter', 1800, 3),
('Fraud', 2000, 2);


--
-- ESX Bankerjob
--

INSERT INTO `addon_account` (name, label, shared) VALUES
('society_banker','Banque',1),
('bank_savings','Blue Book',0)
;
--
-- ESX Banking
--

CREATE TABLE IF NOT EXISTS `banking` (
`identifier` varchar(50) DEFAULT NULL,
`type` varchar(50) DEFAULT NULL,
`amount` int(64) DEFAULT NULL,
`time` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE if not exists `addon_inventory` (
`name` VARCHAR(60) NOT NULL,
`label` VARCHAR(100) NOT NULL,
`shared` INT NOT NULL,

PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `addon_inventory_items` (
`id` INT NOT NULL AUTO_INCREMENT,
`inventory_name` VARCHAR(100) NOT NULL,
`name` VARCHAR(100) NOT NULL,
`count` INT NOT NULL,
`owner` VARCHAR(60) DEFAULT NULL,

PRIMARY KEY (`id`),
INDEX `index_addon_inventory_items_inventory_name_name` (`inventory_name`, `name`),
INDEX `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`, `name`, `owner`),
INDEX `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `users` ADD `is_dead` TINYINT(1) NULL DEFAULT '0' ; 

-- Dumping structure for table legacy.banking
CREATE TABLE IF NOT EXISTS `banking` (
`identifier` varchar(50) DEFAULT NULL,
`type` varchar(50) DEFAULT NULL,
`amount` int(64) DEFAULT NULL,
`time` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE if not exists `billing` (
`id` int NOT NULL AUTO_INCREMENT,
`identifier` varchar(60) NOT NULL,
`sender` varchar(60) NOT NULL,
`target_type` varchar(50) NOT NULL,
`target` varchar(60) NOT NULL,
`label` varchar(255) NOT NULL,
`amount` int NOT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `licenses` (`type`, `label`) VALUES
('boat', 'Boat License')
;

CREATE TABLE if not exists `datastore` (
`name` VARCHAR(60) NOT NULL,
`label` VARCHAR(100) NOT NULL,
`shared` INT NOT NULL,

PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `datastore_data` (
`id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(60) NOT NULL,
`owner` VARCHAR(60),
`data` LONGTEXT,

PRIMARY KEY (`id`),
UNIQUE INDEX `index_datastore_data_name_owner` (`name`, `owner`),
INDEX `index_datastore_data_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `multicharacter_slots` (
`identifier` VARCHAR(60) NOT NULL,
`slots` INT(11) NOT NULL,
PRIMARY KEY (`identifier`) USING BTREE,
INDEX `slots` (`slots`) USING BTREE
) ENGINE=InnoDB;

ALTER TABLE `users` ADD COLUMN
`disabled` TINYINT(1) NULL DEFAULT '0';

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
('beer', 'Beer', 1)
;

CREATE TABLE if not exists `user_contacts` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`identifier` VARCHAR(60) NOT NULL,
`name` VARCHAR(100) NOT NULL,
`number` INT(11) NOT NULL,

PRIMARY KEY (`id`),
INDEX `index_user_contacts_identifier_name_number` (`identifier`, `name`, `number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `fine_types` (
`id` int NOT NULL AUTO_INCREMENT,
`label` varchar(255) DEFAULT NULL,
`amount` int DEFAULT NULL,
`category` int DEFAULT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



ALTER TABLE `users`
ADD COLUMN `last_property` VARCHAR(255) NULL
;

CREATE TABLE if not exists `owned_properties` (

`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(255) NOT NULL,
`price` double NOT NULL,
`rented` int(11) NOT NULL,
`owner` varchar(60) NOT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `properties` (

`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(255) DEFAULT NULL,
`label` varchar(255) DEFAULT NULL,
`entering` varchar(255) DEFAULT NULL,
`exit` varchar(255) DEFAULT NULL,
`inside` varchar(255) DEFAULT NULL,
`outside` varchar(255) DEFAULT NULL,
`ipls` varchar(255) DEFAULT '[]',
`gateway` varchar(255) DEFAULT NULL,
`is_single` int(11) DEFAULT NULL,
`is_room` int(11) DEFAULT NULL,
`is_gateway` int(11) DEFAULT NULL,
`room_menu` varchar(255) DEFAULT NULL,
`price` int(11) NOT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



INSERT INTO `addon_account` (name, label, shared) VALUES
('society_realestateagent','Agent immobilier',1)
;

ALTER TABLE `users` ADD COLUMN `skin` LONGTEXT NULL DEFAULT NULL;

CREATE TABLE if not exists `society_moneywash` (
`id` int NOT NULL AUTO_INCREMENT,
`identifier` varchar(60) NOT NULL,
`society` varchar(60) NOT NULL,
`amount` int NOT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


ALTER TABLE `users` ADD COLUMN `status` LONGTEXT NULL;

INSERT INTO `addon_account` (name, label, shared) VALUES
('company_cardealer','Car Dealer',1)
;

CREATE TABLE if not exists `cardealer_vehicles` (
`id` int NOT NULL AUTO_INCREMENT,
`vehicle` varchar(255) NOT NULL,
`price` int NOT NULL,

PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `vehicle_sold` (
`client` VARCHAR(50) NOT NULL,
`model` VARCHAR(50) NOT NULL,
`plate` VARCHAR(50) NOT NULL,
`soldby` VARCHAR(50) NOT NULL,
`date` VARCHAR(50) NOT NULL,

PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `owned_vehicles` (
`owner` VARCHAR(60) NOT NULL,
`plate` varchar(12) NOT NULL,
`vehicle` longtext,
`type` VARCHAR(20) NOT NULL DEFAULT 'car',
`job` VARCHAR(20) NULL DEFAULT NULL,
`stored` TINYINT(1) NOT NULL DEFAULT '0',

PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `rented_vehicles` (
`vehicle` varchar(60) NOT NULL,
`plate` varchar(12) NOT NULL,
`player_name` varchar(255) NOT NULL,
`base_price` int NOT NULL,
`rent_price` int NOT NULL,
`owner` VARCHAR(60) NOT NULL,

PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `vehicle_categories` (
`name` varchar(60) NOT NULL,
`label` varchar(60) NOT NULL,

PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE if not exists `vehicles` (
`name` varchar(60) NOT NULL,
`model` varchar(60) NOT NULL,
`price` int NOT NULL,
`category` varchar(60) DEFAULT NULL,

PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `vehicles` (name, model, price, category) VALUES
('Blade','blade',15000,'muscle'),
('Buccaneer','buccaneer',18000,'muscle'),
('Buccaneer Rider','buccaneer2',24000,'muscle'),
('Chino','chino',15000,'muscle'),
('Chino Luxe','chino2',19000,'muscle'),
('Coquette BlackFin','coquette3',55000,'muscle'),
('Dominator','dominator',35000,'muscle'),
('Dukes','dukes',28000,'muscle'),
('Gauntlet','gauntlet',30000,'muscle'),
('Hotknife','hotknife',125000,'muscle'),
('Faction','faction',20000,'muscle'),
('Faction Rider','faction2',30000,'muscle'),
('Faction XL','faction3',40000,'muscle'),
('Nightshade','nightshade',65000,'muscle'),
('Phoenix','phoenix',12500,'muscle'),
('Picador', 'picador', 18000, 'muscle'),
('Saber Turbo', 'sabregt', 20000, 'muscle'),
('Sabre GT','sabregt2',25000,'muscle'),
('Slam Van','slamvan3',11500,'muscle'),
('Tampa','tampa',16000,'muscle'),
('Virgo','virgo',14000,'muscle'),
('Vigero','vigero',12500,'muscle'),
('Voodoo','voodoo',7200,'muscle'),
('Blista','blista',8000,'compacts'),
('Brioso R/A','brioso',18000,'compacts'),
('Issi','issi2',10000,'compacts'),
('Panto','panto',10000,'compacts'),
('Prairie','prairie',12000,'compacts'),
('Bison','bison',45000,'vans'),
('Bobcat XL','bobcatxl',32000,'vans'),
('Burrito','burrito3',19000,'vans'),
('Burrito','gburrito2',29000,'vans'),
('Camper','camper',42000,'vans'),
('Gang Burrito','gburrito',45000,'vans'),
('Journey','journey',6500,'vans'),
('Minivan','minivan',13000,'vans'),
('Moonbeam','moonbeam',18000,'vans'),
('Moonbeam Rider','moonbeam2',35000,'vans'),
('Paradise','paradise',19000,'vans'),
('Rumpo','rumpo',15000,'vans'),
('Rumpo Trail','rumpo3',19500,'vans'),
('Surfer','surfer',12000,'vans'),
('Youga','youga',10800,'vans'),
('Youga Luxuary','youga2',14500,'vans'),
('Asea', 'asea', 5500, 'sedans'),
('knowing', 'knowing',55000, 'sedans'),
('Emperor','emperor',8500,'sedans'),
('Fugitive','fugitive',12000,'sedans'),
('Glendale','glendale',6500,'sedans'),
('Intruder','intruder',7500,'sedans'),
('Premier','premier',8000,'sedans'),
('Primo Custom','primo2',14000,'sedans'),
('Regina','regina',5000,'sedans'),
('schafter','schafter2',25000,'sedans'),
('Stretch','stretch',90000,'sedans'),
('Super Diamond','superd',130000,'sedans'),
('Tailgater','tailgater',30000,'sedans'),
('Warrener','warrener',4000,'sedans'),
('Washington','washington',9000,'sedans'),
('Baller','baller2',40000,'suvs'),
('Baller Sport','baller3',60000,'suvs'),
('Cavalcade','cavalcade2',55000,'suvs'),
('Contender','contender',70000,'suvs'),
('Dubsta','dubsta',45000,'suvs'),
('Dubsta Luxuary','dubsta2',60000,'suvs'),
('Fhantom','fq2',17000,'suvs'),
('Grabger','granger',50000,'suvs'),
('Gresley','gresley',47500,'suvs'),
('Huntley S','huntley',40000,'suvs'),
('Landstalker', 'landstalker', 35000, 'suvs'),
('table','table',16000,'suvs'),
('Mesa Trail','mesa3',40000,'suvs'),
('Patriot','patriot',55000,'suvs'),
('Radius','radi',29000,'suvs'),
('Rocoto','rocoto',45000,'suvs'),
('Seminole','seminole',25000,'suvs'),
('XLS','xls',32000,'suvs'),
('Btype','btype',62000,'sportsclassics'),
('Btype Luxe','btype3',85000,'sportsclassics'),
('Btype Hotroad','btype2',155000,'sportsclassics'),
('Casco','casco',30000,'sportsclassics'),
('Coquette Classic','coquette2',40000,'sportsclassics'),
('Manana', 'manana', 12800, 'sportsclassics'),
('Monroe','monroe',55000,'sportsclassics'),
('Pigalle', 'pigalle', 20000, 'sportsclassics'),
('Stinger','stinger',80000,'sportsclassics'),
('Stinger GT','stingergt',75000,'sportsclassics'),
('Stirling GT','feltzer3',65000,'sportsclassics'),
('Z-Type','ztype',220000,'sportsclassics'),
('Bifta','bifta',12000,'offroad'),
('Bf Injection','bfinjection',16000,'offroad'),
('Blazer','blazer',6500,'offroad'),
('Blazer Sport','blazer4',8500,'offroad'),
('Brawler','brawler',45000,'offroad'),
('Bubsta 6x6','dubsta3',120000,'offroad'),
('Dune Buggy','dune',8000,'offroad'),
('Guardian','guardian',45000,'offroad'),
('Rebel','rebel2',35000,'offroad'),
('Sandking','sandking',55000,'offroad'),
('The Liberator','monster',210000,'offroad'),
('Trophy Truck','trophytruck',60000,'offroad'),
('Trophy Truck Limited','trophytruck2',80000,'offroad'),
('cogcabrio', 'cogcabrio', 55000, 'coupes'),
('Exemplar','exemplar',32000,'coupes'),
('F620','f620',40000,'cuts'),
('Felon','felon',42000,'coupes'),
('Felon GT','felon2',55000,'coupes'),
('Jackal','jackal',38000,'coupes'),
('Oracle XS','oracle2',35000,'coupes'),
('Sentinel','sentinel',32000,'coupes'),
('Sentinel XS','sentinel2',40000,'coupes'),
('Windsor','windsor',95000,'coupes'),
('Windsor Drop','windsor2',125000,'coupes'),
('Zion','zion',36000,'coupes'),
('Zion Cabrio','zion2',45000,'coupes'),
('9F','ninef',65000,'sports'),
('9F Cabrio','ninef2',80000,'sports'),
('Alpha','alpha',60000,'sports'),
('Banshee','banshee',70000,'sports'),
('Bestia GTS', 'bestiagts', 55000, 'sports'),
('Buffalo','buffalo',12000,'sports'),
('Buffalo S','buffalo2',20000,'sports'),
('Char', 'char', 75000, 'sports'),
('Comet','comet2',65000,'sports'),
('Coquette','coquette',65000,'sports'),
('Drift Tampa','tampa2',80000,'sports'),
('Elegy','elegy2',38500,'sports'),
('Feltzer','feltzer2',55000,'sports'),
('Furore GT','furoregt',45000,'sports'),
('Fusilade', 'fusilade', 40000, 'sports'),
('Jester','jester',65000,'sports'),
('Jester(Racecar)','jester2',135000,'sports'),
('Khamelion', 'khamelion', 38000, 'sports'),
('Drying','drying',30000, 'sports'),
('Lynx','lynx',40000,'sports'),
('Mamba','mamba',70000,'sports'),
('Massacre', 'massacre', 65000, 'sports'),
('Massacro(Racecar)','massacro2',130000,'sports'),
('everyone', 'everyone',35000,'sports'),
('Penumbra','penumbra',28000,'sports'),
('Rapid GT','rapidgt',35000,'sports'),
('Rapid GT Convertible','rapidgt2',45000,'sports'),
('schafter V12','schafter3',50000,'sports'),
('Seven 70','seven70',39500,'sports'),
('Sultan','sultan',15000,'sports'),
('Surano','surano',50000,'sports'),
('Tropos','tropos',40000,'sports'),
('loser','loser2',70000,'sports'),
('Adder','adder',900000,'super'),
('Banshee 900R','banshee2',255000,'super'),
('Bullet','bullet',90000,'super'),
('Cheetah','cheetah',375000,'super'),
('Entity XF','entityxf',425000,'super'),
('ETR1','sheava',220000,'super'),
('FMJ','fmj',185000,'super'),
('Hell', 'Hell',180000, 'Over'),
('Osiris','osiris',160000,'super'),
('Pfister','pfister811',85000,'super'),
('RE-7B','le7b',325000,'super'),
('Reaper','reaper',150000,'super'),
('Sultan RS','sultanrs',65000,'super'),
('T20','t20',300000,'great'),
('Turismo R','turismor',350000,'super'),
('Tyrus','Tyrus',600000,'Over'),
('Vacca', 'cow', 120000, 'super'),
('Voltic','voltic',90000,'super'),
('X80 Proto','prototipo',2500000,'super'),
('Zentorno','zentorno',1500000,'super'),
('Akuma','AKUMA', 7500,'motorcycles'),
('greedy', 'greedy',18000,'motorcycles'),
('Bagger','bagger',13500,'motorcycles'),
('Bati 801','bati',12000,'motorcycles'),
('Bati 801RR','bati2',19000,'motorcycles'),
('BF400','bf400',6500,'motorcycles'),
('BMX (velo)','bmx',160,'motorcycles'),
('Carbon RS','carbonrs',18000,'motorcycles'),
('Chimera','chimera',38000,'motorcycles'),
('Cliffhanger','cliffhanger',9500,'motorcycles'),
('Cruiser (velo)','cruiser',510,'motorcycles'),
('Daemon','daemon',11500,'motorcycles'),
('Daemon High','daemon2',13500,'motorcycles'),
('Defiler','defiler',9800,'motorcycles'),
('Double T','double',28000,'motorcycles'),
('Enduro','enduro',5500,'motorcycles'),
('Esskey','esskey',4200,'motorcycles'),
('Beech', 'beech', 1900, 'motorcycles'),
('Vespa', 'beech2', 2800, 'motorcycles'),
('Fixter (velo)','fixter',225,'motorcycles'),
('Gargoyle','gargoyle',16500,'motorcycles'),
('Hakuchou','hakuchou', 31000,'motorcycles'),
('Hakuchou Sport','hakuchou2', 55000,'motorcycles'),
('Hexer','Hexer',12000,'motorcycles'),
('Innovation','innovation',23500,'motorcycles'),
('Manchez','manchez',5300,'motorcycles'),
('Nemesis','nemesis',5800,'motorcycles'),
('Nightblade','nightblade',35000,'motorcycles'),
('PCJ-600','pcj',6200,'motorcycles'),
('Ruffian','ruffian',6800,'motorcycles'),
('Sanchez','sanchez',5300,'motorcycles'),
('Sanchez Sport','sanchez2',5300,'motorcycles'),
('holy','holy',25000,'motorcycles'),
('Scorcher (velo)','scorcher',280,'motorcycles'),
('Sovereign','sovereign',22000,'motorcycles'),
('Shotaro Concept','shotaro', 320000,'motorcycles'),
('Thrust','thrust',24000,'motorcycles'),
('Tri bike (velo)','tribike3',520,'motorcycles'),
('Father','father',7200,'motorcycles'),
('Vortex','vortex',9800,'motorcycles'),
('Woflsbane','wolfsbane',9000,'motorcycles'),
('Zombie','zombiea',9500,'motorcycles'),
('Zombie Luxuary','zombieb',12000,'motorcycles'),
('blazer5', 'blazer5', 1755600, 'offroad'),
('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
('Voltic 2', 'voltic2', 3830400, 'super'),
('Ardent', 'ardent', 1150000, 'sportsclassics'),
('Oppressor', 'oppressor', 3524500, 'super'),
('Vision', 'vision', 2250000, 'super'),
('Retinue', 'retinue', 615000, 'sportsclassics'),
('Cyclone', 'cyclone', 1890000, 'super'),
('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
('raiden', 'raiden', 1375000, 'sports'),
('Yosemite', 'yosemite', 485000, 'muscle'),
('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
('Pariah', 'pariah', 1420000, 'sports'),
('Stromberg', 'stromberg', 3185350, 'sports'),
('SC 1', 'sc1', 1603000, 'super'),
('riata', 'riata', 380000, 'offroad'),
('Hermes', 'hermes', 535000, 'muscle'),
('Savestra', 'savestra', 990000, 'sportsclassics'),
('contender', 'contender', 500000, 'sports'),
('Bed', 'bed', 345000, 'offroad'),
('GT 500', 'gt500', 785000, 'sportsclassics'),
('Z190', 'z190', 900000, 'sportsclassics'),
('Viseris', 'viseis', 875000, 'sportsclassics'),
('Autarch', 'autarch', 1955000, 'super'),
('Comet 5', 'comet5', 1145000, 'sports'),
('Neon', 'neon', 1500000, 'sports'),
('Revolt', 'revolt', 1610000, 'sports'),
('Sentinel3', 'sentinel3', 650000, 'sports'),
('Hustler', 'hustler', 625000, 'muscle')
;

INSERT INTO `licenses` (`type`, `label`) VALUES
('weapon', "Weapon licence")
;
