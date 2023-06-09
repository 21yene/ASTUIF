-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2023 at 08:22 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `astuif`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `adminId` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categoryId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categoryId`, `name`, `createdAt`, `updatedAt`) VALUES
(1, 'ALL', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(2, 'STAFF', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(3, 'STUDENT', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(4, 'SOCAE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(5, 'SOMCME', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(6, 'SOEEC', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(7, 'SOANS', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(8, 'DOFP', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(9, 'ARCHITECTURE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(10, 'WRE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(11, 'ME', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(12, 'CE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(13, 'MSE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(14, 'CSE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(15, 'ECE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(16, 'EPCE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(17, 'FDP', '2023-06-08 06:03:31', '2023-06-08 06:03:31');

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `chatId` int(11) NOT NULL,
  `creatorType` enum('staff','student') NOT NULL,
  `categoryId` int(11) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `restrictedMode` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `creatorId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `chats`
--

INSERT INTO `chats` (`chatId`, `creatorType`, `categoryId`, `topic`, `restrictedMode`, `createdAt`, `updatedAt`, `creatorId`) VALUES
(1, 'student', 8, 'hello everyone', 0, '2023-06-08 07:40:32', '2023-06-08 07:40:32', 4),
(2, 'student', 8, 'hello student', 1, '2023-06-08 07:43:30', '2023-06-08 07:43:30', 4),
(3, 'staff', 8, 'hello teacher', 1, '2023-06-08 07:43:50', '2023-06-08 07:43:50', 10);

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `convid` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `from` varchar(255) NOT NULL,
  `userId` int(11) NOT NULL,
  `senderType` enum('Student','Staff') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `chatId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`convid`, `message`, `from`, `userId`, `senderType`, `createdAt`, `updatedAt`, `chatId`) VALUES
(1, 'hello', 'Nebiyu Mohammed Bedaso', 10, 'Staff', '2023-06-08 07:44:23', '2023-06-08 07:44:23', 1),
(2, 'good morninig', 'Nebiyu Mohammed Bedaso', 10, 'Staff', '2023-06-08 07:44:56', '2023-06-08 07:44:56', 1),
(3, 'hello', 'Milkias Solomon Gebrasilassie', 6, 'Student', '2023-06-08 07:47:51', '2023-06-08 07:47:51', 1),
(4, 'hello', 'Tamiru Belachew Hailemariyam', 4, 'Student', '2023-06-08 07:48:44', '2023-06-08 07:48:44', 1),
(5, 'hello', 'Nebiyu Mohammed Bedaso', 10, 'Staff', '2023-06-08 08:04:10', '2023-06-08 08:04:10', 1),
(6, 'hello', 'Milkias Solomon Gebrasilassie', 6, 'Student', '2023-06-08 08:04:52', '2023-06-08 08:04:52', 1),
(7, 'geej', 'Nebiyu Mohammed Bedaso', 10, 'Staff', '2023-06-08 08:05:38', '2023-06-08 08:05:38', 1);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `depId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ShortedName` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `schoolId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`depId`, `name`, `ShortedName`, `createdAt`, `updatedAt`, `schoolId`) VALUES
(1, 'Architecture', 'ARCHITECTURE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 1),
(2, 'Water Resource Engineering', 'WRE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 1),
(3, 'Mechanical Engineering', 'ME', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 2),
(4, 'Chemical Engineering', 'CE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 2),
(5, 'Materials Science Engineering', 'MSE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 2),
(6, 'Computer Science and Engineering', 'CSE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 3),
(7, 'Electronics and Communication Engineering', 'ECE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 3),
(8, 'Electrical Power and Control Engineering', 'EPCE', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 3),
(9, 'Freshman Division Program', 'FDP', '2023-06-08 06:03:31', '2023-06-08 06:03:31', 5);

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `likeId` int(11) NOT NULL,
  `liked_by_type` varchar(255) NOT NULL,
  `liked_by_id` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `postId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `postId` int(11) NOT NULL,
  `summarizable` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `categoryId` int(11) NOT NULL,
  `staffName` varchar(255) NOT NULL,
  `eventLocation` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `staffId` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`postId`, `summarizable`, `content`, `image`, `categoryId`, `staffName`, `eventLocation`, `createdAt`, `updatedAt`, `staffId`, `title`) VALUES
(1, '0', 'Exciting news! We are launching a new product next week. Stay tuned for more updates.', NULL, 1, 'Biruk Yonas Neway', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 1, NULL),
(2, '0', 'Join us this weekend for a charity event at the local community center. Let\'s make a difference together!', NULL, 1, 'Ephrem Honelign Alene', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 2, NULL),
(3, '0', 'We are excited to announce our partnership with a leading tech company. This collaboration will bring new opportunities for growth and innovation.', NULL, 1, 'Abel Jegnaw Mehari', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 3, NULL),
(4, '0', 'Attention students! Don\'t forget to submit your applications for the upcoming internship program. This is a great opportunity to gain valuable work experience.', NULL, 4, 'Robel Belachew Hailemariyam', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 4, NULL),
(5, '0', 'Let\'s celebrate World Environment Day by planting trees in our community. Join us this Saturday at the local park.', NULL, 4, 'Milkias Solomon Gebrasilassie', 'Local Park', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 5, NULL),
(6, '0', 'Exciting update! Our company has been nominated for the Best Employer of the Year award. We are proud of our team\'s dedication and hard work.', NULL, 4, 'Selam Alebachew Debeb', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 6, NULL),
(7, '0', 'Calling all talented artists! We are organizing an art competition with amazing prizes. Show us your creativity and passion.', NULL, 5, 'Yonas Muliye Fite', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 7, NULL),
(8, '0', 'Are you interested in learning new languages? Join our language exchange program where you can meet language enthusiasts and improve your skills.', NULL, 6, 'Henok Belayneh Eridaw', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 8, NULL),
(9, '0', 'Save the date! Our annual conference will take place on November 15th. Get ready for inspiring talks and valuable networking opportunities.', NULL, 9, 'Daniel Fantahun Gebremeskel', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 9, NULL),
(10, '0', 'Attention graduates! We are organizing a career fair next month. Don\'t miss this chance to connect with top companies and explore job opportunities.', NULL, 10, 'Nebiyu Mohammed Bedaso', 'Astu Stadium', '2023-06-08 06:03:34', '2023-06-08 06:03:34', 10, NULL),
(11, '0', 'and ethiopia', 'Images\\Post_Image\\1686332036147.png', 4, 'Biruk Yonas Neway', 'Addis abbbaba', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 1, NULL),
(13, '0', 'and ethiopiass', 'Images\\Post_Image\\1686333949309.png', 4, 'Biruk Yonas Neway', 'Addis abbbaba', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 1, NULL),
(14, '0', 'and ethiopiassas ss', 'Images\\Post_Image\\1686334598989.png', 4, 'Biruk Yonas Neway', 'Addis abbbaba  aa', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 1, 'astu bbb if');

-- --------------------------------------------------------

--
-- Table structure for table `rsvps`
--

CREATE TABLE `rsvps` (
  `id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `postId` int(11) NOT NULL,
  `userType` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `forUser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `rsvps`
--

INSERT INTO `rsvps` (`id`, `status`, `postId`, `userType`, `createdAt`, `updatedAt`, `forUser`) VALUES
(1, 0, 11, 'Student', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 1),
(2, 0, 11, 'Student', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 2),
(3, 0, 11, 'Student', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 3),
(4, 0, 11, 'Student', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 4),
(5, 0, 11, 'Student', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 22),
(6, 0, 11, 'Student', '2023-06-09 17:33:56', '2023-06-09 17:33:56', 23),
(7, 0, 12, 'Student', '2023-06-09 18:04:05', '2023-06-09 18:04:05', 1),
(8, 0, 12, 'Student', '2023-06-09 18:04:05', '2023-06-09 18:04:05', 2),
(9, 0, 12, 'Student', '2023-06-09 18:04:05', '2023-06-09 18:04:05', 3),
(10, 0, 12, 'Student', '2023-06-09 18:04:05', '2023-06-09 18:04:05', 4),
(11, 0, 12, 'Student', '2023-06-09 18:04:05', '2023-06-09 18:04:05', 22),
(12, 0, 12, 'Student', '2023-06-09 18:04:05', '2023-06-09 18:04:05', 23),
(13, 0, 13, 'Student', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 1),
(14, 0, 13, 'Student', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 2),
(15, 0, 13, 'Student', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 3),
(16, 0, 13, 'Student', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 4),
(17, 0, 13, 'Student', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 22),
(18, 0, 13, 'Student', '2023-06-09 18:05:49', '2023-06-09 18:05:49', 23),
(19, 0, 14, 'Student', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 1),
(20, 0, 14, 'Student', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 2),
(21, 0, 14, 'Student', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 3),
(22, 0, 14, 'Student', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 4),
(23, 0, 14, 'Student', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 22),
(24, 0, 14, 'Student', '2023-06-09 18:16:39', '2023-06-09 18:16:39', 23);

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `schoolId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ShortedName` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`schoolId`, `name`, `ShortedName`, `createdAt`, `updatedAt`) VALUES
(1, 'School of civil and architecture engineering', 'SOCAE', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(2, 'School of Mechanical Chemical and Materials Engineering', 'SOMCME', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(3, 'School of Electrical Engineering and Computing', 'SOEEC', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(4, 'School of Applied Natural Science', 'SOANS', '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(5, 'Division of Freshman Program', 'DOFP', '2023-06-08 06:03:31', '2023-06-08 06:03:31');

-- --------------------------------------------------------

--
-- Table structure for table `staffs`
--

CREATE TABLE `staffs` (
  `staffId` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `isVerified` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `staffs`
--

INSERT INTO `staffs` (`staffId`, `fullname`, `email`, `password`, `picture`, `isVerified`, `createdAt`, `updatedAt`) VALUES
(1, 'Biruk Yonas Neway', 'biruk@gmail.com', '$2b$10$gk4D1C4yjzoEmXMjUYtpGeq1kBeaCm4kfGUhQit/rNRhSdiNillVa', NULL, 0, '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(2, 'Ephrem Honelign Alene', 'ephrem@gmail.com', '$2b$10$7sVCV5FyI.5Ec1Zv2Qs.be9VzjQH5W6jbvx4eVnblNCGhs6/0Ycom', NULL, 0, '2023-06-08 06:03:31', '2023-06-08 06:03:31'),
(3, 'Abel Jegnaw Mehari', 'abel@gmail.com', '$2b$10$qqK16tYr1uPJf91roOca9uDptx.LRZDhiqI3rV5e0uqO1rDY5i4F6', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(4, 'Robel Belachew Hailemariyam', 'robel@gmail.com', '$2b$10$4SY3ah6cvF9YHNCrwAc.R.cF8d4SOciP.1SCGikGQMOYVgIL9lg8.', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(5, 'Milkias Solomon Gebrasilassie', 'milkias@gmail.com', '$2b$10$8hSqYJOTl.bkWDinyKSRROM6Z4dE5Eln./v4u7n/yt/3ChWiDrk0G', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(6, 'Selam Alebachew Debeb', 'selam@gmail.com', '$2b$10$hbXrUrhj6C2g2r3AfiH6oupiUN8ifK3NSVvPgP0.ZpRPGzg4mCi7K', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(7, 'Yonas Muliye Fite', 'yonas@gmail.com', '$2b$10$GjuwPQLB.iNzDM7l0yTmNeVFWv0PKFTItlziFL6LU2T4ELwLh0Jzu', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(8, 'Henok Belayneh Eridaw', 'henok@gmail.com', '$2b$10$up/i4O/GdcZtrlexRjAxNOER.BiGC/PxOSoi2gpdTQoolUuk4qZaC', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(9, 'Daniel Fantahun Gebremeskel', 'daniel@gmail.com', '$2b$10$3VFSmszY1qiuLeu2UkvhOOjYVKrkf5MtE8EO3.d4na01DyYCqd.dm', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(10, 'Nebiyu Mohammed Bedaso', 'nebiyu@gmail.com', '$2b$10$ehh0Wc7IHMprtnmWLMyN1OtErwQEpfqwgLReFZ/qHdZICH.ulKXCO', NULL, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32'),
(11, 'Milkias solomon', 'abr@abc.com', '$2b$10$Mtq5tjbr9cEUU/P7GF8w9OSzgqz27NPhGc45YgwCzp8fD.YMcgmjK', 'Images\\Staff_Image\\1686331192426.jpg', 0, '2023-06-09 17:19:52', '2023-06-09 17:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `studentId` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `year` int(11) NOT NULL,
  `isVerified` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `depId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentId`, `fullname`, `email`, `password`, `picture`, `year`, `isVerified`, `createdAt`, `updatedAt`, `depId`) VALUES
(1, 'Aysanew Yonas Neway', 'aysanew@gmail.com', '$2b$10$/0zHeV42w/0O7ljNyuneKOv4xP8G6tCrnmmfukRXR1dAHGm4v40iK', NULL, 5, 0, '2023-06-08 06:03:32', '2023-06-08 06:03:32', 1),
(2, 'Bereket Honelign Alene', 'bereket@gmail.com', '$2b$10$Z65JemF7WoBj5EU5IC.CXe.iiMwkku5Rj3PjP5evagmMP5xPwoqEq', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 1),
(3, 'Bekalu Jegnaw Mehari', 'bekalu@gmail.com', '$2b$10$GIAnAnRVeDjVD.kaBL0Wdu6TDGMKTnwFzZcDXzwgGDjXDk4crRXe2', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 2),
(4, 'Tamiru Belachew Hailemariyam', 'tamiru@gmail.com', '$2b$10$GhuxAK5AfXYQTgb2CdvGBe7ETIs8T8lMXCb8Dwa9BAGlgn5/M37Xy', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 2),
(5, 'Tinsae Hunegnaw Ambaneh', 'tinsae@gmail.com', '$2b$10$iLKg3tpw.iuLMKpTn.QYxesg3vWsrC5giBoUQlVwv6E4AEyUHg9wG', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 3),
(6, 'Milkias Solomon Gebrasilassie', 'milkias@gmail.com', '$2b$10$caA6hyeVZN.j3BEgVVw2Fefc9lsMHA6k/yUgaEdkBtlwGdhPYPCh.', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 3),
(7, 'Habtamu Alebachew Debeb', 'habtamu@gmail.com', '$2b$10$cz8A82/SNWZ4NX6ZYPfdYujKFZUY7465d1Bo0dXJZgT0gAfqwKQJG', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 4),
(8, 'Samuel Muliye Fite', 'samuel@gmail.com', '$2b$10$morw/1UXIlYb.yO7HsuJqOLIva.WW2lfxryeg1DjMcUbVPai5dfNy', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 4),
(9, 'Yehualashet Belayneh Eridaw', 'yehualashet@gmail.com', '$2b$10$Qx0CrCbdYWh/lCU6TFqufOHMNkP0Vgqf.0ujTzmqRur/GdJrV96mi', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 5),
(10, 'Brook Fantahun Gebremeskel', 'brook@gmail.com', '$2b$10$MmfoMnIywZBvaFxwC4XAA.s7om9YzqkXN.agFFricKWTDTlwXcz/i', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 5),
(11, 'Fuad Mohammed Bedaso', 'fuad@gmail.com', '$2b$10$mBnAaDr.d7m.SDFbdsoafeSHIZEtDZQ4/1AzS0BFXwk6CXmisOv6u', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 6),
(12, 'Absra Girma Tenna', 'absra@gmail.com', '$2b$10$XwvGOJ99smiJFIgPwqvTT.cIHwzcQ2bQVksEQ/DICXAenEVWNuI9e', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 6),
(13, 'Mentesenot Kibebew Kebede', 'mentesenot@gmail.com', '$2b$10$VXvr.oWqnz3arIIBR5oV6.XvgkukzEp4Sw3lNbCC5GerAeexxK256', NULL, 5, 0, '2023-06-08 06:03:33', '2023-06-08 06:03:33', 7),
(14, 'Ayantu Lemma Gizaw', 'ayantu@gmail.com', '$2b$10$vPTowXmPxW6/dgHuT1cwWOJdgGXQTvktUDfEkGGEAlsOyspwoz6hK', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 7),
(15, 'Mekdem Alemu Gebre', 'mekdem@gmail.com', '$2b$10$RSktv78RyrYAnBiaeMZDbe6idVyxJWeS92RtNAXgnBWFQNRFYtEw2', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 8),
(16, 'Abdi Adem Abdela', 'abdi@gmail.com', '$2b$10$GTprC9YPRERCfSONVL/i9Om2rdYseFFWcittYs.rOSwArcamkB4X2', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 8),
(17, 'Naila Abdelah Hassen', 'naila@gmail.com', '$2b$10$zyyL0zOMaLfJKuMRP3RRqOtBB5Uy2TxGFngbqGpjrzQCisr1EvaBi', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 9),
(18, 'Etsubsira Dirsha Demam', 'etsubsira@gmail.com', '$2b$10$OXbUcX1QeFxIHJ6.UV4hReyyQUVfH59ddDFp00hFJr2/1ypEB2JSu', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 9),
(19, 'Yared Abera Mengistu', 'yared@gmail.com', '$2b$10$Pgr0hSgYYGjMQPyO2UbJeOeO3S3a5GJ6nq2o2WjzzdpoSZWEEOwN6', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 6),
(20, 'Yafet Berhanu Garno', 'yafet@gmail.com', '$2b$10$vb1EPlZlrKxtTz4gDodXt.MdFp4Mdu/wHaLrd2zb/bJQNxLZa0hcO', NULL, 5, 0, '2023-06-08 06:03:34', '2023-06-08 06:03:34', 6),
(22, 'Kifle Abebaw', 'aaab', '$2b$10$76e/X15541pJwCjLKwmnP.QT44wkGeEJYDv2BUCs0U.3IFHy2IumS', 'Images\\Stud_Image\\1686325494930.jpg', 5, 0, '2023-06-09 15:44:55', '2023-06-09 15:44:55', 2),
(23, 'yohanis', 'abragdag', '$2b$10$Mvvh2FLRStcCi6im7xSIVO4BiNriLJDdwea3uW3RyGA5ZcCUoexQq', 'Images\\Stud_Image\\1686329294370.jpg', 5, 0, '2023-06-09 16:48:14', '2023-06-09 16:48:14', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`adminId`),
  ADD UNIQUE KEY `adminId` (`adminId`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryId`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`chatId`),
  ADD KEY `categoryId` (`categoryId`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`convid`),
  ADD KEY `chatId` (`chatId`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`depId`),
  ADD KEY `schoolId` (`schoolId`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`likeId`),
  ADD KEY `postId` (`postId`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`postId`),
  ADD KEY `categoryId` (`categoryId`),
  ADD KEY `staffId` (`staffId`);

--
-- Indexes for table `rsvps`
--
ALTER TABLE `rsvps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`schoolId`);

--
-- Indexes for table `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staffId`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentId`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD KEY `depId` (`depId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `chatId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `convid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `depId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `likeId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `postId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `rsvps`
--
ALTER TABLE `rsvps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `schoolId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staffId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `studentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_ibfk_1` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_2` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_3` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_3` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_3` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_3` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_4` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_5` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_6` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
