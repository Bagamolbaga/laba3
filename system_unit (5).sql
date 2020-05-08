-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Апр 24 2020 г., 17:27
-- Версия сервера: 5.7.29-0ubuntu0.16.04.1
-- Версия PHP: 7.0.33-0ubuntu0.16.04.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `system_unit`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`admin`@`localhost` PROCEDURE `function_SUM` ()  NO SQL
SELECT SUM((SELECT volume FROM `memory` WHERE id = 5) + (SELECT volume FROM `memory` WHERE id = 6))$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `query_period_time` ()  NO SQL
SELECT * FROM `memory` WHERE release_year BETWEEN 2016 AND 2018$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `search_MAX_id` ()  NO SQL
SELECT * FROM `processor` WHERE id = (SELECT MAX(id) FROM `processor`)$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `search_MIN_id` ()  NO SQL
SELECT * FROM `processor` WHERE id = (SELECT MIN(id) FROM `processor`)$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `search_NULL_fields` ()  NO SQL
SELECT * FROM `processor` WHERE manufacture is NULL OR processor_line is NULL OR model is NULL OR frequency is NULL OR frequency_boost is NULL OR cores is NULL OR core_model is NULL OR socket is NULL OR integrated_graphics is NULL OR memory_type is NULL$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `search_NULL_row` ()  NO SQL
SELECT * FROM `processor` WHERE manufacture is NULL AND processor_line is NULL AND model is NULL AND frequency is NULL AND frequency_boost is NULL AND cores is NULL AND core_model is NULL AND socket is NULL AND integrated_graphics is NULL AND memory_type is NULL$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `search_processor` ()  NO SQL
SELECT * FROM `processor` WHERE model = 'i5-4460'$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `select_graphics_card_Microstar(MSI)` ()  NO SQL
SELECT * FROM `graphics_card` WHERE manufacture = 'Microstar (MSI)'$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `select_memory_SSD` ()  NO SQL
SELECT * FROM `memory` WHERE type = 'SSD'$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `select_memory_volume` ()  NO SQL
SELECT * FROM `memory` WHERE volume = 512000$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `select_motherboard_DDR4` ()  NO SQL
SELECT * FROM `motherboard` WHERE memory_type = 'DDR4'$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `select_processor_DDR4` ()  NO SQL
SELECT * FROM `processor` WHERE memory_type = 'DDR4'$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `subquery_graphics_card_memory_type` ()  NO SQL
SELECT * FROM `graphics_card` WHERE memory_type IN (SELECT type FROM `memory_type` WHERE type = 'GDDR5')$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `subquery_memory_manufacture` ()  NO SQL
SELECT * FROM `memory` WHERE manufacture IN (SELECT manufacture FROM `manufacture` WHERE manufacture = 'Western Digital')$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `subquery_processor_socket` ()  NO SQL
SELECT * FROM `processor` WHERE socket IN (SELECT socket FROM `socket_type` WHERE socket = 'LGA1151-v2')$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `table_join_memory_controller` ()  NO SQL
SELECT * FROM `memory_controller` LEFT JOIN `memory` ON `memory_controller`.`manufacture` = `memory`.`controller`$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `table_join_motherboard_graphics_card` ()  NO SQL
SELECT * FROM `motherboard` INNER JOIN `graphics_card` ON `motherboard`.`manufacture` = `graphics_card`.`manufacture`$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `table_join_motherboard_processor` ()  NO SQL
SELECT * FROM `motherboard` INNER JOIN `processor` ON `motherboard`.`memory_type` = `processor`.`memory_type` AND `motherboard`.`socket` = `processor`.`socket`$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `table_join_motherboard_processor_manufacture` ()  NO SQL
SELECT * FROM `processor` INNER JOIN `motherboard` ON `motherboard`.`memory_type` = `processor`.`memory_type` AND `motherboard`.`socket` = `processor`.`socket` WHERE `motherboard`.`manufacture` = 'GIGABYTE'$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `table_join_processor_memory_type` ()  NO SQL
SELECT * FROM `processor` LEFT JOIN `motherboard` ON `processor`.`socket` = `motherboard`.`socket` AND `processor`.`memory_type` = `motherboard`.`memory_type`$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `graphics_card`
--

CREATE TABLE `graphics_card` (
  `id` int(11) NOT NULL,
  `manufacture` varchar(255) NOT NULL COMMENT 'Производитель',
  `model` varchar(255) NOT NULL COMMENT 'Модель',
  `memory` int(11) NOT NULL COMMENT 'Объем (Мб)',
  `memory_type` varchar(255) NOT NULL COMMENT 'Тип памяти',
  `frequency` int(11) NOT NULL COMMENT 'Частота (МГц)',
  `frequency_boost` int(11) DEFAULT NULL COMMENT 'Максимальная частота (МГц)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `graphics_card`
--

INSERT INTO `graphics_card` (`id`, `manufacture`, `model`, `memory`, `memory_type`, `frequency`, `frequency_boost`) VALUES
(1, 'Microstar (MSI)', 'GeForce GTX 1650 GAMING X [GTX 1650 GAMING X 4G]', 4096, 'GDDR5', 1485, 1860),
(2, 'PowerColor', 'AMD Radeon RX 580 Red Dragon OC [AXRX 580 4GBD5-3DHDV2/OC]', 4096, 'GDDR5', 1257, 1350),
(3, 'Palit', 'GeForce GTX 1650 SUPER StormX OC [NE6165S018G1-166F]', 4096, 'GDDR6', 1530, 1770),
(4, 'Palit', 'GeForce RTX 2060 Dual OC [NE62060S18J9-1160A]', 6144, 'GDDR6', 1365, 1725),
(5, 'Microstar (MSI)', 'GeForce RTX 2060 VENTUS XS 6G OC [RTX 2060 VENTUS XS 6G OC]', 6144, 'GDDR6', 1365, 1710),
(6, 'GIGABYTE', 'AMD Radeon RX 5700 XT AORUS [GV-R57XTAORUS-8GD]', 8192, 'GDDR6', 1770, 2010),
(7, 'Microstar (MSI)', 'GeForce RTX 2070 Super VENTUS OC [RTX 2070 SUPER VENTUS OC]', 8192, 'GDDR6', 1605, 1785),
(8, 'Microstar (MSI)', 'GeForce RTX 2080 Ti GAMING X TRIO [RTX 2080 Ti GAMING X TRIO]', 11264, 'GDDR6', 1350, 1755),
(9, 'GIGABYTE', 'GeForce GTX 1050 LP [GV-N1050OC-2GL]', 2048, 'GDDR6', 1366, 1506),
(10, 'Inno3D', 'GeForce GTX 1650 TWIN X2 OC [N16502-04D5X-1510VA25]', 4096, 'GDDR5', 1485, 1710),
(11, 'Microstar (MSI)', 'AMD Radeon RX 5500 XT GAMING X [RX 5500 XT GAMING X 8G]', 8192, 'GDDR6', 1685, 1845);

-- --------------------------------------------------------

--
-- Структура таблицы `manufacture`
--

CREATE TABLE `manufacture` (
  `id` int(11) NOT NULL,
  `manufacture` varchar(255) NOT NULL COMMENT 'Производитель'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `manufacture`
--

INSERT INTO `manufacture` (`id`, `manufacture`) VALUES
(5, 'AMD'),
(13, 'ASRock'),
(11, 'ASUS'),
(15, 'Esonic'),
(12, 'GIGABYTE'),
(20, 'Inno3D'),
(6, 'Intel'),
(18, 'KFA2'),
(14, 'Microstar (MSI)'),
(16, 'Palit'),
(17, 'PowerColor'),
(4, 'Samsung'),
(19, 'Sapphire'),
(2, 'Seagate'),
(7, 'Silicon Graphics'),
(10, 'Silicon Power'),
(8, 'Sun Microsystems'),
(3, 'TOSHIBA'),
(9, 'VIA'),
(1, 'Western Digital');

-- --------------------------------------------------------

--
-- Структура таблицы `memory`
--

CREATE TABLE `memory` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL COMMENT 'Тип памяти',
  `manufacture` varchar(255) NOT NULL COMMENT 'Производитель',
  `model` varchar(255) NOT NULL COMMENT 'Модель',
  `volume` int(11) NOT NULL COMMENT 'Объем (мб)',
  `transmission_speed` int(11) DEFAULT NULL COMMENT 'Скорость передачи (мб/с)',
  `release_year` year(4) DEFAULT NULL COMMENT 'Год выпуска',
  `controller` varchar(255) DEFAULT NULL COMMENT 'Контроллер'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `memory`
--

INSERT INTO `memory` (`id`, `type`, `manufacture`, `model`, `volume`, `transmission_speed`, `release_year`, `controller`) VALUES
(1, 'SSD', 'Western Digital', 'WDS500G2B0A', 512000, 530, 2018, 'Marvell'),
(2, 'HDD', 'Western Digital', 'WD10EZEX', 1048576, NULL, 2016, NULL),
(3, 'SSD', 'Western Digital', 'WDS240G2G0A', 245760, 465, 2018, 'Marvell'),
(4, 'HDD', 'Seagate', 'ST3500312CS', 512000, NULL, NULL, NULL),
(5, 'HDD', 'Western Digital', 'WD10PURZ', 1048576, NULL, 2017, NULL),
(6, 'HDD', 'TOSHIBA', 'HDWL110UZSVA', 1048576, NULL, 2019, NULL),
(7, 'SSD', 'Samsung', 'MZ-76E500BW', 512000, 520, 2018, 'Samsung'),
(8, 'HDD', 'Western Digital', 'WD5003AZEX', 512000, NULL, 2016, NULL),
(9, 'SSD', 'Silicon Power', 'SP120GBSS3S55S25', 122880, 440, 2014, 'Phison');

-- --------------------------------------------------------

--
-- Структура таблицы `memory_controller`
--

CREATE TABLE `memory_controller` (
  `id` int(11) NOT NULL,
  `manufacture` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `memory_controller`
--

INSERT INTO `memory_controller` (`id`, `manufacture`) VALUES
(4, 'Indilinx (OCZ)'),
(5, 'Intel'),
(2, 'JMicron'),
(1, 'Marvell'),
(7, 'Phison'),
(3, 'Samsung'),
(6, 'SandForce (LSI)');

-- --------------------------------------------------------

--
-- Структура таблицы `memory_type`
--

CREATE TABLE `memory_type` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL COMMENT 'Тип памяти'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `memory_type`
--

INSERT INTO `memory_type` (`id`, `type`) VALUES
(3, 'DDR'),
(4, 'DDR2'),
(5, 'DDR3'),
(6, 'DDR4'),
(7, 'GDDR'),
(8, 'GDDR2'),
(9, 'GDDR3'),
(10, 'GDDR4'),
(11, 'GDDR5'),
(12, 'GDDR6'),
(2, 'HDD'),
(1, 'SSD');

-- --------------------------------------------------------

--
-- Структура таблицы `motherboard`
--

CREATE TABLE `motherboard` (
  `id` int(11) NOT NULL,
  `manufacture` varchar(255) DEFAULT NULL COMMENT 'Производитель',
  `model` varchar(255) DEFAULT NULL COMMENT 'Модель',
  `socket` varchar(255) DEFAULT NULL COMMENT 'Разъем',
  `chipset` varchar(255) DEFAULT NULL COMMENT 'Чипсет',
  `memory_type` varchar(255) DEFAULT NULL COMMENT 'Тип памяти'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `motherboard`
--

INSERT INTO `motherboard` (`id`, `manufacture`, `model`, `socket`, `chipset`, `memory_type`) VALUES
(1, 'ASUS', 'PRIME B450M-K', 'AM4', 'AMD B450', 'DDR4'),
(2, 'GIGABYTE', 'B450M S2H', 'AM4', 'AMD B450', 'DDR4'),
(3, 'GIGABYTE', 'Z390 D', 'LGA1151-v2', 'Intel Z390', 'DDR4'),
(4, 'GIGABYTE', 'GA-970A-DS3P', 'AM3+', 'AMD 970', 'DDR3'),
(5, 'ASRock', 'A320M-HDV R4.0', 'AM4', 'AMD A320', 'DDR4'),
(6, 'Microstar (MSI)', 'B450 GAMING PLUS MAX', 'AM4', 'AMD B450', 'DDR4'),
(7, 'Microstar (MSI)', 'A68HM-E33 V2', 'FM2+', 'AMD A68H', 'DDR3'),
(8, 'Microstar (MSI)', 'H110M PRO-VH PLUS', 'LGA1151', 'Intel H110', 'DDR4'),
(9, 'ASRock', 'A320M-DVS R4.0', 'AM4', 'AMD A320', 'DDR4'),
(10, 'Esonic', 'G31CEL2', 'LGA775', 'Intel G31', 'DDR2'),
(11, 'Esonic', 'H61FEL-U', 'LGA1155', 'Intel H61', 'DDR3'),
(12, 'ASRock', 'H310CM-HDV/M.2', 'LGA1151-v2', 'Intel H310', 'DDR4'),
(13, 'ASUS', 'PRIME B365M-K', 'LGA1151-v2', 'Intel B365', 'DDR4'),
(14, 'ASUS', 'PRIME A320M-A', 'AM4', 'AMD A320', 'DDR4');

-- --------------------------------------------------------

--
-- Структура таблицы `processor`
--

CREATE TABLE `processor` (
  `id` int(11) NOT NULL,
  `manufacture` varchar(255) DEFAULT NULL COMMENT 'Производитель',
  `processor_line` varchar(255) DEFAULT NULL COMMENT 'Линейка процессора',
  `model` varchar(255) DEFAULT NULL COMMENT 'Модель',
  `frequency` int(11) DEFAULT NULL COMMENT 'Частота (МГц)',
  `frequency_boost` int(11) DEFAULT NULL COMMENT 'Максимальная частота (МГц)',
  `cores` int(2) DEFAULT NULL COMMENT 'Кол-во ядер',
  `core_model` varchar(255) DEFAULT NULL COMMENT 'Модель процессора',
  `socket` varchar(255) DEFAULT NULL COMMENT 'Разъем',
  `integrated_graphics` varchar(255) DEFAULT NULL COMMENT 'Встроенная граф. система',
  `memory_type` varchar(255) DEFAULT NULL COMMENT 'Тип памяти'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `processor`
--

INSERT INTO `processor` (`id`, `manufacture`, `processor_line`, `model`, `frequency`, `frequency_boost`, `cores`, `core_model`, `socket`, `integrated_graphics`, `memory_type`) VALUES
(1, 'Intel', 'Core i5 4-го поколения', 'i5-4460', 3200, 3400, 4, 'Haswell', 'LGA1150', 'Intel® HD Graphics 4600', 'DDR3'),
(2, 'Intel', 'Core i7 9-го поколения', 'i7-9700K', 3600, 4900, 8, 'Coffee Lake R', 'LGA1151', 'Intel® UHD 630', 'DDR4'),
(3, 'AMD', 'Ryzen 5', 'Ryzen™ 5 2600', 3400, 3900, 6, 'Pinnacle Ridge', 'AM4', NULL, 'DDR4'),
(4, 'AMD', 'Ryzen 5', 'Ryzen™ 5 3600', 3600, 4200, 6, 'Matisse', 'AM4', NULL, 'DDR4'),
(5, 'Intel', 'Core i9 9-го поколения', 'i9-9900K', 3600, 5000, 8, 'Coffee Lake R', 'LGA1151', 'Intel® UHD 630', 'DDR4'),
(6, 'Intel', 'Core i3 9-го поколения', 'i3-9100F', 3600, 4200, 4, 'Coffee Lake R', 'LGA1151', NULL, 'DDR4'),
(7, 'AMD', 'Athlon', 'X4 840', 3100, 3800, 4, 'Kaveri', 'FM2+', NULL, 'DDR3'),
(8, 'Intel', 'Celeron', 'G4930', 3200, NULL, 2, 'Coffee Lake S', 'LGA1151-v2', 'Intel UHD Graphics 610', 'DDR4'),
(9, 'Intel', 'Pentium Gold', 'G5600F', 3900, NULL, 2, 'Coffee Lake S', 'LGA1151-v2', NULL, 'DDR4'),
(10, 'Intel', 'Xeon', 'E3-1281 v3', 3700, 4100, 4, 'Haswell', 'LGA1150', NULL, 'DDR3'),
(11, 'Intel', 'Xeon', 'E3-1275 v6', 3800, 4200, 4, 'Kaby Lake-S', 'LGA1151', 'Intel HD Graphics P630', 'DDR4'),
(12, 'AMD', 'Ryzen 9', '3900X', 3800, 4600, 12, 'Matisse', 'AM4', NULL, 'DDR4');

-- --------------------------------------------------------

--
-- Структура таблицы `socket_type`
--

CREATE TABLE `socket_type` (
  `id` int(11) NOT NULL,
  `socket` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `socket_type`
--

INSERT INTO `socket_type` (`id`, `socket`) VALUES
(5, 'AM3+'),
(1, 'AM4'),
(6, 'FM2+'),
(2, 'LGA1150'),
(4, 'LGA1151'),
(3, 'LGA1151-v2'),
(8, 'LGA1155'),
(7, 'LGA775');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `graphics_card`
--
ALTER TABLE `graphics_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manufacture` (`manufacture`),
  ADD KEY `memory_type` (`memory_type`);

--
-- Индексы таблицы `manufacture`
--
ALTER TABLE `manufacture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manufacture` (`manufacture`);

--
-- Индексы таблицы `memory`
--
ALTER TABLE `memory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `manufacture` (`manufacture`),
  ADD KEY `controller` (`controller`),
  ADD KEY `model` (`model`);

--
-- Индексы таблицы `memory_controller`
--
ALTER TABLE `memory_controller`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manufacture` (`manufacture`);

--
-- Индексы таблицы `memory_type`
--
ALTER TABLE `memory_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Индексы таблицы `motherboard`
--
ALTER TABLE `motherboard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manufacture` (`manufacture`),
  ADD KEY `memory_type` (`memory_type`),
  ADD KEY `socket` (`socket`);

--
-- Индексы таблицы `processor`
--
ALTER TABLE `processor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manufacture` (`manufacture`),
  ADD KEY `memory_type` (`memory_type`),
  ADD KEY `socket` (`socket`);

--
-- Индексы таблицы `socket_type`
--
ALTER TABLE `socket_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `socket` (`socket`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `graphics_card`
--
ALTER TABLE `graphics_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблицы `manufacture`
--
ALTER TABLE `manufacture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT для таблицы `memory`
--
ALTER TABLE `memory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT для таблицы `memory_controller`
--
ALTER TABLE `memory_controller`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `memory_type`
--
ALTER TABLE `memory_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `motherboard`
--
ALTER TABLE `motherboard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблицы `processor`
--
ALTER TABLE `processor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `socket_type`
--
ALTER TABLE `socket_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `graphics_card`
--
ALTER TABLE `graphics_card`
  ADD CONSTRAINT `graphics_card_ibfk_1` FOREIGN KEY (`manufacture`) REFERENCES `manufacture` (`manufacture`),
  ADD CONSTRAINT `graphics_card_ibfk_2` FOREIGN KEY (`memory_type`) REFERENCES `memory_type` (`type`);

--
-- Ограничения внешнего ключа таблицы `memory`
--
ALTER TABLE `memory`
  ADD CONSTRAINT `memory_ibfk_1` FOREIGN KEY (`type`) REFERENCES `memory_type` (`type`),
  ADD CONSTRAINT `memory_ibfk_2` FOREIGN KEY (`manufacture`) REFERENCES `manufacture` (`manufacture`),
  ADD CONSTRAINT `memory_ibfk_3` FOREIGN KEY (`controller`) REFERENCES `memory_controller` (`manufacture`);

--
-- Ограничения внешнего ключа таблицы `motherboard`
--
ALTER TABLE `motherboard`
  ADD CONSTRAINT `motherboard_ibfk_1` FOREIGN KEY (`manufacture`) REFERENCES `manufacture` (`manufacture`),
  ADD CONSTRAINT `motherboard_ibfk_2` FOREIGN KEY (`memory_type`) REFERENCES `memory_type` (`type`),
  ADD CONSTRAINT `motherboard_ibfk_3` FOREIGN KEY (`socket`) REFERENCES `socket_type` (`socket`);

--
-- Ограничения внешнего ключа таблицы `processor`
--
ALTER TABLE `processor`
  ADD CONSTRAINT `processor_ibfk_1` FOREIGN KEY (`manufacture`) REFERENCES `manufacture` (`manufacture`),
  ADD CONSTRAINT `processor_ibfk_2` FOREIGN KEY (`memory_type`) REFERENCES `memory_type` (`type`),
  ADD CONSTRAINT `processor_ibfk_3` FOREIGN KEY (`socket`) REFERENCES `socket_type` (`socket`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
