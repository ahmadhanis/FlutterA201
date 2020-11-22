-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 22, 2020 at 10:29 PM
-- Server version: 10.3.25-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slumber6_foodninjav2`
--

-- --------------------------------------------------------

--
-- Table structure for table `FOODS`
--

CREATE TABLE `FOODS` (
  `FOODID` int(5) NOT NULL,
  `FOODNAME` varchar(50) NOT NULL,
  `FOODPRICE` varchar(5) NOT NULL,
  `QUANTITY` varchar(5) NOT NULL,
  `RESTID` varchar(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `FOODS`
--

INSERT INTO `FOODS` (`FOODID`, `FOODNAME`, `FOODPRICE`, `QUANTITY`, `RESTID`) VALUES
(1, 'Mee Goreng Mamak', '5.00', '3', '1'),
(2, 'Laksa Perak', '4.50', '6', '3'),
(3, 'Roti Canai', '2.00', '73', '2'),
(4, 'Laksam', '2.50', '1', '1'),
(5, 'Pizza Cheese', '7.50', '28', '4'),
(6, 'Bolognese Sausage', '5.50', '28', '4'),
(7, 'Paperdele', '7.80', '48', '4'),
(8, 'Polenta', '10.50', '32', '4'),
(9, 'Kungpao Chicken', '6.50', '28', '5'),
(10, 'Pad Thai Noodle', '5.50', '38', '5'),
(11, 'Chickpea', '4.50', '17', '5'),
(12, 'Paneer Masalla', '5.50', '26', '2'),
(13, 'Kheema Samosa', '4.50', '40', '2'),
(14, 'Chicken Sagwala', '4.50', '39', '2'),
(15, 'Nasi Goreng Biasa', '4.50', '24', '1'),
(16, 'Nasi Rendang', '5.50', '28', '1'),
(17, 'Nasi Lemak Sotong', '5.50', '49', '1'),
(18, 'Laksa Lemak', '4.50', '38', '3'),
(19, 'Laksa Johor', '3.50', '19', '3'),
(20, 'Laksa Penang', '5.50', '29', '3');

-- --------------------------------------------------------

--
-- Table structure for table `RESTAURANT`
--

CREATE TABLE `RESTAURANT` (
  `ID` int(10) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `PHONE` varchar(15) NOT NULL,
  `LOCATION` varchar(50) NOT NULL,
  `IMAGE` varchar(30) NOT NULL,
  `DATEREG` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE current_timestamp(6)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESTAURANT`
--

INSERT INTO `RESTAURANT` (`ID`, `NAME`, `PHONE`, `LOCATION`, `IMAGE`, `DATEREG`) VALUES
(1, 'Abang Jo Tomyam', '048284953', 'Changlun', '48284953', '2020-11-18 11:52:48.846278'),
(2, 'Mak Mah', '049284953', 'Changlun', '49284953', '2020-11-18 11:52:54.058456'),
(3, 'Ah Kiong Coffee House', '048244953', 'Changlun', '48244953', '2020-11-18 11:54:55.444580'),
(4, 'Subaidah', '049265534', 'Changlun', '49265534', '2020-11-18 11:53:03.900366'),
(5, 'Kumar Curry House', '047664544', 'Changlun', '477664544', '2020-11-18 11:53:11.179619'),
(6, 'KFC', '044665544', 'Changlun', '44665544', '2020-11-18 11:53:15.510166'),
(7, 'Pizza House', '047635544', 'Changlun', '47635544', '2020-11-18 11:53:20.166304');

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `NAME` varchar(100) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PHONE` varchar(15) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `DATEREG` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `OTP` varchar(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`NAME`, `EMAIL`, `PHONE`, `PASSWORD`, `DATEREG`, `OTP`) VALUES
('lili', 'lili@gmail.com', '123', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2020-11-17 16:44:53.043873', '5106'),
('mimi', 'mimi@gmail.com', '123', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2020-11-17 16:46:45.285842', '1259'),
('ana', 'ana@gmail.com', '123', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2020-11-17 16:37:53.033188', '4669'),
('Kayiti Esam', 'degipo8342@rvemold.com', '01945543345', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '2020-11-10 12:23:15.379391', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `FOODS`
--
ALTER TABLE `FOODS`
  ADD PRIMARY KEY (`FOODID`);

--
-- Indexes for table `RESTAURANT`
--
ALTER TABLE `RESTAURANT`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`EMAIL`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `FOODS`
--
ALTER TABLE `FOODS`
  MODIFY `FOODID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `RESTAURANT`
--
ALTER TABLE `RESTAURANT`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
