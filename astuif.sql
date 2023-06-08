-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2023 at 11:00 AM
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
(1, 'SOECE', '2023-04-03 09:41:22', '2023-04-03 09:41:22'),
(3, 'PCE', '2023-04-03 09:42:16', '2023-04-03 09:42:16'),
(4, 'ECE', '2023-04-03 09:42:34', '2023-04-03 09:42:34'),
(5, 'CSE', '2023-04-03 09:42:56', '2023-04-03 09:42:56'),
(6, 'STUDENT', '2023-04-03 09:43:06', '2023-04-03 09:43:06'),
(7, 'STAFF', '2023-04-03 09:43:12', '2023-04-03 09:43:12'),
(8, 'ALL', '2023-04-03 09:43:17', '2023-04-03 09:43:17');

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
(1, 'student', 8, 'I love you my ethiopia', 0, '2023-04-03 12:55:54', '2023-04-03 12:55:54', 4),
(10, 'staff', 8, 'Student Council', 0, '2023-05-21 12:18:34', '2023-05-21 12:18:34', 1),
(11, 'staff', 8, 'Debate Club', 1, '2023-05-21 12:19:29', '2023-05-21 12:19:29', 1),
(12, 'staff', 8, 'Section Meeting', 0, '2023-06-07 08:10:01', '2023-06-07 08:10:01', 5),
(18, 'staff', 8, 'Meeting', 0, '2023-06-07 08:21:16', '2023-06-07 08:21:16', 5);

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `convid` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `userId` int(11) NOT NULL,
  `senderType` enum('Student','Staff') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `chatId` int(11) DEFAULT NULL,
  `from` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`convid`, `message`, `userId`, `senderType`, `createdAt`, `updatedAt`, `chatId`, `from`) VALUES
(7, 'Controll how this works', 1, 'Staff', '2023-05-21 12:14:57', '2023-05-21 12:14:57', 1, 'Abraham Mekuria'),
(15, 'This message is for chat id 1', 1, 'Staff', '2023-05-29 12:54:19', '2023-05-29 12:54:19', 1, 'Abraham Mekuria'),
(17, 'Mine always is a try', 9, 'Student', '2023-05-29 12:59:18', '2023-05-29 12:59:18', 10, 'Yabets Abebaw'),
(19, 'The student council is now open', 3, 'Student', '2023-05-29 12:59:52', '2023-05-29 12:59:52', 10, 'Fentahun Amare'),
(20, 'Fortress is built', 5, 'Student', '2023-05-29 13:00:23', '2023-05-29 13:00:23', 10, 'Kifle Abebaw'),
(21, 'wellcome to the Debate Club', 8, 'Student', '2023-05-29 13:01:21', '2023-05-29 13:01:21', 11, 'Yabets Urgo'),
(22, 'the man on the ledge', 9, 'Student', '2023-06-01 13:36:29', '2023-06-01 13:36:29', 1, 'Yabets Abebaw'),
(25, 'wow', 6, 'Student', '2023-06-01 13:40:40', '2023-06-01 13:40:40', 1, 'Kifle Abebaw'),
(27, 'well, it works in chat 10 ig', 6, 'Student', '2023-06-01 14:00:57', '2023-06-01 14:00:57', 10, 'Kifle Abebaw'),
(28, 'well, it works in 11 as well', 6, 'Student', '2023-06-01 14:01:18', '2023-06-01 14:01:18', 11, 'Kifle Abebaw'),
(29, 'bye bye', 6, 'Student', '2023-06-01 14:16:25', '2023-06-01 14:16:25', 1, 'Kifle Abebaw'),
(32, 'perfectly balanced ', 6, 'Student', '2023-06-01 14:19:26', '2023-06-01 14:19:26', 10, 'Kifle Abebaw'),
(37, 'wellcome to the Debate Club', 8, 'Student', '2023-06-01 17:34:50', '2023-06-01 17:34:50', 11, 'Yabets Urgo'),
(38, 'the man is gone', 6, 'Student', '2023-06-01 18:04:24', '2023-06-01 18:04:24', 11, 'Kifle Abebaw'),
(39, 'Helo ', 9, 'Student', '2023-06-02 06:59:38', '2023-06-02 06:59:38', 1, 'Yabets Abebaw'),
(40, 'The is working', 9, 'Student', '2023-06-02 10:08:08', '2023-06-02 10:08:08', 1, 'Yabets Abebaw'),
(41, 'hello everyone', 6, 'Student', '2023-06-02 11:19:12', '2023-06-02 11:19:12', 1, 'Kifle Abebaw'),
(42, 'mm', 10, 'Student', '2023-06-02 11:57:02', '2023-06-02 11:57:02', 1, 'maru'),
(43, 'fdafda', 4, 'Staff', '2023-06-06 22:46:16', '2023-06-06 22:46:16', 11, 'Yabets');

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
(1, 'Power and Control Engineering', 'PCE', '2023-04-03 09:42:16', '2023-04-03 09:42:16', 1),
(2, 'Electronics and Communication Engineering', 'ECE', '2023-04-03 09:42:34', '2023-04-03 09:42:34', 1),
(3, 'Computer Science and Engineering', 'CSE', '2023-04-03 09:42:56', '2023-04-03 09:42:56', 1);

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

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`likeId`, `liked_by_type`, `liked_by_id`, `createdAt`, `updatedAt`, `postId`) VALUES
(19, 'student', '2', '2023-04-03 11:53:44', '2023-04-03 11:53:44', NULL),
(21, 'student', '1', '2023-04-03 11:54:10', '2023-04-03 11:54:10', NULL),
(25, 'student', '1', '2023-04-03 12:22:12', '2023-04-03 12:22:12', NULL),
(26, 'student', '2', '2023-04-03 12:22:55', '2023-04-03 12:22:55', NULL),
(27, 'student', '3', '2023-04-03 12:23:00', '2023-04-03 12:23:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `postId` int(11) NOT NULL,
  `content` text DEFAULT NULL,
  `categoryId` int(11) NOT NULL,
  `staffName` varchar(255) NOT NULL,
  `eventLocation` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `staffId` int(11) DEFAULT NULL,
  `summarizable` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`postId`, `content`, `categoryId`, `staffName`, `eventLocation`, `createdAt`, `updatedAt`, `staffId`, `summarizable`, `image`) VALUES
(4, 'jalala', 1, 'Abraham Mekuria', 'Addis abbbaba', '2023-04-04 17:15:24', '2023-04-04 17:15:24', 1, '0', NULL),
(5, 'one love ethiopia', 1, 'Abraham Mekuria', 'Addis abbbaba', '2023-04-04 17:15:39', '2023-04-04 17:15:39', 1, '0', NULL),
(7, 'and ethiopia', 1, 'Abraham Mekuria', 'Addis abbbaba', '2023-04-04 18:41:00', '2023-04-04 18:41:00', 1, '0', NULL),
(14, 'and ethiopia', 4, 'Abraham Mekuria', 'Addis abbbaba', '2023-06-02 15:28:59', '2023-06-02 15:28:59', 1, '0', NULL),
(15, 'My First Post', 1, 'Yabets', 'Space', '2023-06-06 21:35:43', '2023-06-06 21:35:43', 4, '0', NULL),
(16, 'dasdas', 1, 'Abraham Mekuria', NULL, '2023-06-06 22:16:38', '2023-06-06 22:16:38', 1, '0', NULL),
(17, 'afafa', 1, 'Yabets', NULL, '2023-06-06 22:18:51', '2023-06-06 22:18:51', 4, '0', NULL),
(18, 'qweqwe', 1, 'Abel Yk', NULL, '2023-06-06 22:51:22', '2023-06-06 22:51:22', 3, '0', NULL),
(19, 'qweqwe', 1, 'Abel Yk', NULL, '2023-06-06 22:51:40', '2023-06-06 22:51:40', 3, '0', NULL),
(20, 'qweqwe', 1, 'Abraham Mekuria', NULL, '2023-06-06 22:51:40', '2023-06-06 22:51:40', 1, '0', NULL),
(21, 'dsDDsd', 1, 'Yabets', NULL, '2023-06-07 08:31:40', '2023-06-07 08:31:40', 4, '0', NULL);

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
(1, 0, 1, 'Student', '2023-04-03 09:55:54', '2023-04-03 09:55:54', 2),
(2, 0, 1, 'Student', '2023-04-03 09:55:54', '2023-04-03 09:55:54', 3),
(3, 0, 1, 'Student', '2023-04-03 09:55:54', '2023-04-03 09:55:54', 4),
(11, 0, 4, 'Student', '2023-04-04 17:15:24', '2023-04-04 17:15:24', 2),
(12, 0, 4, 'Student', '2023-04-04 17:15:24', '2023-04-04 17:15:24', 3),
(13, 0, 4, 'Student', '2023-04-04 17:15:24', '2023-04-04 17:15:24', 4),
(14, 0, 4, 'Student', '2023-04-04 17:15:24', '2023-04-04 17:15:24', 5),
(15, 0, 5, 'Student', '2023-04-04 17:15:39', '2023-04-04 17:15:39', 2),
(16, 0, 5, 'Student', '2023-04-04 17:15:39', '2023-04-04 17:15:39', 3),
(17, 0, 5, 'Student', '2023-04-04 17:15:39', '2023-04-04 17:15:39', 4),
(18, 0, 5, 'Student', '2023-04-04 17:15:39', '2023-04-04 17:15:39', 5),
(19, 0, 6, 'Student', '2023-04-04 17:15:49', '2023-04-04 17:15:49', 2),
(20, 0, 6, 'Student', '2023-04-04 17:15:49', '2023-04-04 17:15:49', 3),
(21, 0, 6, 'Student', '2023-04-04 17:15:49', '2023-04-04 17:15:49', 4),
(22, 0, 6, 'Student', '2023-04-04 17:15:49', '2023-04-04 17:15:49', 5),
(23, 0, 7, 'Student', '2023-04-04 18:41:00', '2023-04-04 18:41:00', 2),
(24, 0, 7, 'Student', '2023-04-04 18:41:00', '2023-04-04 18:41:00', 3),
(25, 0, 7, 'Student', '2023-04-04 18:41:00', '2023-04-04 18:41:00', 4),
(26, 0, 7, 'Student', '2023-04-04 18:41:00', '2023-04-04 18:41:00', 5),
(27, 0, 8, 'Student', '2023-04-10 15:39:19', '2023-04-10 15:39:19', 2),
(28, 0, 8, 'Student', '2023-04-10 15:39:19', '2023-04-10 15:39:19', 3),
(29, 0, 8, 'Student', '2023-04-10 15:39:19', '2023-04-10 15:39:19', 4),
(30, 0, 8, 'Student', '2023-04-10 15:39:19', '2023-04-10 15:39:19', 5),
(31, 0, 9, 'Student', '2023-04-10 15:43:27', '2023-04-10 15:43:27', 2),
(32, 0, 9, 'Student', '2023-04-10 15:43:27', '2023-04-10 15:43:27', 3),
(33, 0, 9, 'Student', '2023-04-10 15:43:27', '2023-04-10 15:43:27', 4),
(34, 0, 9, 'Student', '2023-04-10 15:43:27', '2023-04-10 15:43:27', 5),
(35, 0, 10, 'Student', '2023-04-10 15:45:35', '2023-04-10 15:45:35', 2),
(36, 0, 10, 'Student', '2023-04-10 15:45:35', '2023-04-10 15:45:35', 3),
(37, 0, 10, 'Student', '2023-04-10 15:45:35', '2023-04-10 15:45:35', 4),
(38, 0, 10, 'Student', '2023-04-10 15:45:35', '2023-04-10 15:45:35', 5),
(43, 0, 12, 'Student', '2023-04-10 15:55:16', '2023-04-10 15:55:16', 2),
(44, 0, 12, 'Student', '2023-04-10 15:55:16', '2023-04-10 15:55:16', 3),
(45, 0, 12, 'Student', '2023-04-10 15:55:16', '2023-04-10 15:55:16', 4),
(46, 0, 12, 'Student', '2023-04-10 15:55:16', '2023-04-10 15:55:16', 5),
(47, 0, 13, 'Student', '2023-04-10 15:56:31', '2023-04-10 15:56:31', 2),
(48, 0, 13, 'Student', '2023-04-10 15:56:31', '2023-04-10 15:56:31', 3),
(49, 0, 13, 'Student', '2023-04-10 15:56:31', '2023-04-10 15:56:31', 4),
(50, 0, 13, 'Student', '2023-04-10 15:56:31', '2023-04-10 15:56:31', 5),
(51, 0, 14, 'Student', '2023-06-02 15:28:59', '2023-06-02 15:28:59', 5),
(52, 0, 14, 'Student', '2023-06-02 15:28:59', '2023-06-02 15:28:59', 6),
(53, 0, 14, 'Student', '2023-06-02 15:28:59', '2023-06-02 15:28:59', 7),
(54, 0, 14, 'Student', '2023-06-02 15:28:59', '2023-06-02 15:28:59', 11),
(55, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 2),
(56, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 3),
(57, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 5),
(58, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 6),
(59, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 7),
(60, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 8),
(61, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 9),
(62, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 10),
(63, 0, 15, 'Student', '2023-06-06 21:35:44', '2023-06-06 21:35:44', 11);

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
(1, 'school of electrical and communication engineering', 'SOECE', '2023-04-03 09:41:22', '2023-04-03 09:41:22'),
(2, 'school of power and control engineering', 'SOPCE', '2023-04-03 09:41:47', '2023-04-03 09:41:47');

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
(1, 'Abraham Mekuria', 'abr@abc.com', '$2b$10$OUs4pb8al8s1FyCbZeFQO.YODpPBP8dNXU6CJn886hz6dAtOSl.4.', NULL, 0, '2023-04-03 09:55:43', '2023-04-03 09:55:43'),
(3, 'Abel Yk', 'Abel@abc.com', '$2b$10$vd7JX0Nv7weyZkPSErZon.x9WD/i9Eg3rdwRRmWDpftSSmJ4nggNK', NULL, 0, '2023-06-01 11:39:56', '2023-06-01 11:39:56'),
(4, 'Yabets', 'Yabets@abc.com', '$2b$10$NrWsq4YdheWa8CQd2Z9UMOags6E7Ld21ZKriOxuLbgcr2vhe.TArW', NULL, 0, '2023-06-03 09:59:52', '2023-06-03 09:59:52');

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
(2, 'Abraham Mekuria', 'AbrahamMekuria@gmail.com', '$2b$10$t0fNIapw33rN5MXuGNIBfe8bsPnwfwFeihgclhiJ3JPkGuGJofPMy', 'Abraham Mekuria', 5, 0, '2023-04-03 09:51:02', '2023-04-03 09:51:02', 3),
(3, 'Fentahun Amare', 'Fentahun Amare@gmail.com', '$2b$10$BLx2V14tRIMeDibGpeqduu78KvMbfTxHxe4E4fxBZGw42zsXX/cC2', 'Fentahun Amare', 5, 0, '2023-04-03 09:52:13', '2023-04-03 09:52:13', 1),
(5, 'Kifle Abebaw', 'Kifle Abebaw@gmail.com', '$2b$10$lYqbVT2wisTCDLdoUcCV3uP50ngyexjf2FPDZnv3y6f3aHYlAwrsi', 'Kifle Abebaw', 5, 0, '2023-04-03 10:03:51', '2023-04-03 10:03:51', 2),
(6, 'Kifle Abebaw', 'kifle@gmail.com', '$2b$10$b5sC4.xNgkDDT59mruu0muFnr9Cz.vaqufz3rECq8TbQSYgxBE.5S', 'Kifle Abebaw', 5, 0, '2023-04-10 16:43:51', '2023-04-10 16:43:51', 2),
(7, 'Kifle Abebaw', 'aaa', '$2b$10$YUiEJuxTQzuC0NqzH5zraOC/rVCRa6E6YLrtG.uVM7ZSXM9e9lvLa', 'Kifle Abebaw', 5, 0, '2023-04-10 17:09:01', '2023-04-10 17:09:01', 2),
(8, 'Yabets Urgo', 'Yabets@astu.edu.et', '$2b$10$Vj95W4ZXhmcTDLZ2d6HLuO0g11lT5zWfQjxoKR8RlJX0po4RnBKna', 'Yab', 4, 0, '2023-05-16 20:08:27', '2023-05-16 20:08:27', 3),
(9, 'Yabets Abebaw', 'Yabets@gmail.com', '$2b$10$7aphZS4dDAyzYfdQ5zGFJOOM1b35VYiIePKKJp6bHJtZoOqYmYf52', 'Abebaw', 5, 0, '2023-05-16 22:18:27', '2023-05-16 22:18:27', 1),
(10, 'maru', 'maru@gmail.com', '$2b$10$gpabqd8zxwBx9R7.AP6YY.3vuEa4uaOQL7o.SuzGu47dK3/77k/G2', 'a', 2, 0, '2023-06-02 11:54:53', '2023-06-02 11:54:53', 1),
(11, 'Kifle Abebaw', 'aaab', '$2b$10$M/NKh2bK2BDMAJEjnv.e1u5ccRxAmx8rpa.FSscoCgDgLQ4pd5OX.', 'Kifle Abebaw', 5, 0, '2023-06-02 13:23:52', '2023-06-02 13:23:52', 2);

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
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `email_6` (`email`),
  ADD UNIQUE KEY `email_7` (`email`),
  ADD UNIQUE KEY `email_8` (`email`),
  ADD UNIQUE KEY `email_9` (`email`);

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
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `email_6` (`email`),
  ADD UNIQUE KEY `email_7` (`email`),
  ADD UNIQUE KEY `email_8` (`email`),
  ADD UNIQUE KEY `email_9` (`email`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentId`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `email_6` (`email`),
  ADD UNIQUE KEY `email_7` (`email`),
  ADD UNIQUE KEY `email_8` (`email`),
  ADD UNIQUE KEY `email_9` (`email`),
  ADD UNIQUE KEY `email_10` (`email`),
  ADD UNIQUE KEY `email_11` (`email`),
  ADD UNIQUE KEY `email_12` (`email`),
  ADD UNIQUE KEY `email_13` (`email`),
  ADD KEY `depId` (`depId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `chatId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `convid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `depId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `likeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `postId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `rsvps`
--
ALTER TABLE `rsvps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `schoolId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staffId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `studentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_4` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_5` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_6` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_7` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_ibfk_1` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_2` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_3` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_4` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_5` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_6` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_ibfk_7` FOREIGN KEY (`chatId`) REFERENCES `chats` (`chatId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_10` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_11` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_12` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_13` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_14` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_15` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_16` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_17` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_3` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_4` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_5` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_6` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_7` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_8` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_ibfk_9` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`schoolId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_3` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_4` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_5` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_6` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_7` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `likes_ibfk_8` FOREIGN KEY (`postId`) REFERENCES `posts` (`postId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_10` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_11` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_12` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_13` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_14` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_15` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_16` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_17` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_18` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_19` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_3` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_4` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_5` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_6` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_7` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_8` FOREIGN KEY (`staffId`) REFERENCES `staffs` (`staffId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `posts_ibfk_9` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_10` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_11` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_12` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_13` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_14` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_4` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_5` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_6` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_7` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_8` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_9` FOREIGN KEY (`depId`) REFERENCES `departments` (`depId`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
