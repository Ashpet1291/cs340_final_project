-- phpMyAdmin SQL Dump
-- version 5.1.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 26, 2021 at 08:24 PM
-- Server version: 10.4.20-MariaDB-log
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_pettiboa`
--

-- --------------------------------------------------------

--
-- Table structure for table `Announcements`
--

CREATE TABLE `Announcements` (
  `announcements_id` int(10) AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `title` varchar(70) NOT NULL,
  `note` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `announcement_owner` int(10) NOT NULL
  PRIMARY KEY (`announcements_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Announcements`
--

INSERT INTO `Announcements` (`active`, `title`, `note`, `start_date`, `end_date`, `announcement_owner`) VALUES
(1, 'Chris\'s birthday party', 'Chris\'s birthday party is this weekend- just bring yourselves we will have food games and cake', '2021-05-21', '0000-00-00', 5),
(1, 'Summer camping trip', 'this year we reserved 5 spaces at Florence campground-if you want to come let me know', '2021-05-21', '0000-00-00', 6),
(0, 'County Fair', 'the fair is the weekend of the 18th if anyone is interested in going', '2021-05-21', '0000-00-00', 2),
(1, 'Going Grocery Shopping', 'I\'m going grocery shopping tonight if anyone needs anything last chance to add to the list', '2021-05-21', '0000-00-00', 5);

-- --------------------------------------------------------

--
-- Table structure for table `Family_Members`
--
DROP TABLE IF EXISTS `Family_Members`;

CREATE TABLE `Family_Members` (
  `family_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `nick_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(75) NOT NULL,
  `birthday` date NOT NULL,
  `primary_number` varchar(12) NOT NULL,
  PRIMARY KEY (`family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Family_Members`
--
LOCK TABLES `Family_Members` WRITE;

INSERT INTO `Family_Members` VALUES
(1, 'Oliver', 'Turbo', 'Tree', '1993-1-1', '123-123-1234')
(1, 'Johnathon', 'John', 'Wick', '1980-05-21', '303-210-4019'),
(1, 'Sarah', NULL, 'Wick', '1983-05-21', '503-210-4019'),
(1, 'Steven', 'Stevie', 'Wick', '2001-12-05', '303-210-4019'),
(1, 'Christopher', 'Chris', 'George', '1979-05-21', '303-210-4019'),
(0, 'Regina', 'gina', 'George', '1982-05-21', '303-210-4019'),
(1, 'Olivia', 'liv', 'George', '2003-05-21', '303-210-4019');

UNLOCK TABLES;
-- --------------------------------------------------------

--
-- Table structure for table `Family_Members_Announcements`
--

CREATE TABLE `Family_Members_Announcements` (
  `family_members` int(11) NOT NULL,
  `announcements` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Items`
--

CREATE TABLE `Items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` int(11) NOT NULL,
  `item_name` varchar(70) NOT NULL,
  `item_amount` int(10) NOT NULL,
  `suggested_store` varchar(50) NOT NULL,
  `note` text NOT NULL,
  `item_owner` int(11) NOT NULL,
    PRIMARY KEY ('item_id')
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Items`
--

INSERT INTO `Items` (`active`, `item_name`, `item_amount`, `suggested_store`, `note`, `item_owner`) VALUES
(1, 'pickles', 1, 'Safeway', 'need for sandwiches', 2)
(1, 'lightbulbs', 2, 'Winco', '75 watt-garage light is out', 1),
(1, 'outside table', 1, 'Winco', 'would take new or used if in good condition', 5),
(1, 'lemons', 6, 'Roth\'s', 'want to make lemonaide later- roths has freshest fruit', 6),
(1, 'coolers', 2, '', 'need for camping-big or small', 4);

-- --------------------------------------------------------

--
-- Table structure for table `Places`
--

CREATE TABLE `Places` (
  `place_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `name` varchar(70) NOT NULL,
  `website` text DEFAULT NULL,
  `indoor` tinyint(1) NOT NULL,
  `note` text NOT NULL
  PRIMARY KEY ('places_id')
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Places`
--

INSERT INTO `Places` (`place_id`, `active`, `name`, `address`, `website`, `indoor`, `note`) VALUES
(1, 'Pike Place Market', 1, 'http://pikeplacemarket.org/', 0, 'was very fun we liked the flowers from the fourth booth and loved the pie we got and the honey'),
(1, 'Disneyland', 2, 'https://disneyland.disney.go.com/', 0, 'really enjoyed the rides in tommorowland and the food at flo\'s cafe'),
(1, 'Venice Canals', 3, NULL, 0, 'expensive but definitely worth the price- we had a blast'),
(1, 'Arcade', 4, NULL, 1, 'this arcade was cheap and everyone had a blast- has bowling-minigolf and many games'),
(1, 'beach', 5, 'https://www.seasideor.com/', 0, 'love this beach-want to come back and rent a beach house for the weekend');


--
-- Constraints for table `Announcements`
--
ALTER TABLE `Announcements`
  ADD CONSTRAINT `Announcements_ibfk_1` FOREIGN KEY (`announcement_owner`) REFERENCES `Family_Members` (`family_id`);

--
-- Constraints for table `Family_Members_Announcements`
--
ALTER TABLE `Family_Members_Announcements`
  ADD CONSTRAINT `Family_Members_Announcements_ibfk_1` FOREIGN KEY (`announcements`) REFERENCES `Announcements` (`announcements_id`),
  ADD CONSTRAINT `Family_Members_Announcements_ibfk_2` FOREIGN KEY (`family_members`) REFERENCES `Family_Members` (`family_id`);

--
-- Constraints for table `Items`
--
ALTER TABLE `Items`
  ADD CONSTRAINT `Items_ibfk_2` FOREIGN KEY (`item_owner`) REFERENCES `Family_Members` (`family_id`);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
