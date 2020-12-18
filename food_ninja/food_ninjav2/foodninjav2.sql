-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 18, 2020 at 09:46 PM
-- Server version: 10.3.27-MariaDB-cll-lve
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
-- Table structure for table `CART`
--

CREATE TABLE `CART` (
  `EMAIL` varchar(50) NOT NULL,
  `FOODID` varchar(7) NOT NULL,
  `FOODQTY` varchar(5) NOT NULL,
  `REMARKS` varchar(100) NOT NULL,
  `RESTID` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CART`
--

INSERT INTO `CART` (`EMAIL`, `FOODID`, `FOODQTY`, `REMARKS`, `RESTID`) VALUES
('degipo8342@rvemold.com', '3', '4', '', '2'),
('degipo8342@rvemold.com', '13', '3', '', '2'),
('degipo8342@rvemold.com', '14', '2', '', '2'),
('degipo8342@rvemold.com', '12', '4', '', '2');

-- --------------------------------------------------------

--
-- Table structure for table `FOODS`
--

CREATE TABLE `FOODS` (
  `FOODID` int(5) NOT NULL,
  `FOODNAME` varchar(50) NOT NULL,
  `FOODPRICE` varchar(5) NOT NULL,
  `QUANTITY` varchar(5) NOT NULL,
  `IMAGENAME` varchar(50) NOT NULL,
  `RESTID` varchar(5) NOT NULL,
  `TYPE` varchar(10) NOT NULL,
  `STATUS` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `FOODS`
--

INSERT INTO `FOODS` (`FOODID`, `FOODNAME`, `FOODPRICE`, `QUANTITY`, `IMAGENAME`, `RESTID`, `TYPE`, `STATUS`) VALUES
(1, 'Mee Goreng Mamak', '6.00', '40', '1', '1', 'Food', 'Available'),
(2, 'Laksa Perak', '4.50', '16', '2', '3', 'Food', 'Available'),
(3, 'Roti Canai', '2.00', '73', '3', '2', 'Food', 'Available'),
(4, 'Laksam', '2.50', '15', '4', '1', 'Food', 'Available'),
(5, 'Pizza Cheese', '7.50', '28', '5', '4', 'Food', 'Available'),
(6, 'Bolognese Sausage', '5.50', '28', '6', '4', 'Food', 'Available'),
(7, 'Paperdele', '7.80', '48', '7', '4', 'Food', 'Available'),
(8, 'Polenta', '10.50', '32', '8', '4', 'Food', 'Available'),
(9, 'Kungpao Chicken', '6.50', '28', '9', '5', 'Food', 'Available'),
(10, 'Pad Thai Noodle', '5.50', '38', '10', '5', 'Food', 'Available'),
(11, 'Chickpea', '4.50', '17', '11', '5', 'Food', 'Available'),
(12, 'Paneer Masalla', '5.50', '26', '12', '2', 'Food', 'Available'),
(13, 'Kheema Samosa', '4.50', '40', '13', '2', 'Food', 'Available'),
(14, 'Chicken Sagwala', '4.50', '39', '14', '2', 'Food', 'Available'),
(15, 'Nasi Goreng Biasa', '4.50', '24', '15', '1', 'Food', 'Available'),
(16, 'Nasi Rendang', '5.50', '28', '16', '1', 'Food', 'Available'),
(17, 'Nasi Lemak Sotong', '5.50', '40', '17', '1', 'Food', 'Available'),
(18, 'Laksa Lemak', '4.50', '38', '18', '3', 'Food', 'Available'),
(19, 'Laksa Johor', '3.50', '19', '19', '3', 'Food', 'Available'),
(20, 'Laksa Penang', '5.50', '29', '20', '3', 'Food', 'Available'),
(21, 'Tomyam Susu', '8.00', '205', '1-1606281612819523', '1', 'Food', 'Available'),
(22, 'Curry Laksa', '5.20', '30', '10-1606880350157367', '10', 'Food', 'Available'),
(23, 'Kuetiau Kungfu', '5.60', '30', '10-1606881110305849', '10', 'Food', 'Available'),
(24, 'Mee Sup', '6.00', '45', '10-1606881241367582', '10', 'Food', 'Available'),
(25, 'Kopi O', '1.50', '50', '1-1607960229226433', '1', 'Beverage', 'Available'),
(26, 'Sirap Anggur', '2.50', '50', '1-1607960390685445', '1', 'Beverage', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `RESTAURANT`
--

CREATE TABLE `RESTAURANT` (
  `ID` int(10) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(40) NOT NULL,
  `PHONE` varchar(15) NOT NULL,
  `LOCATION` varchar(50) NOT NULL,
  `IMAGE` varchar(30) NOT NULL,
  `OTP` varchar(4) NOT NULL,
  `DELIVERY` varchar(5) NOT NULL,
  `DATEREG` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `RADIUS` varchar(2) NOT NULL,
  `LATITUDE` varchar(15) NOT NULL,
  `LONGITUDE` varchar(15) NOT NULL,
  `STATUS` varchar(10) NOT NULL,
  `RATING` varchar(3) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESTAURANT`
--

INSERT INTO `RESTAURANT` (`ID`, `NAME`, `EMAIL`, `PASSWORD`, `PHONE`, `LOCATION`, `IMAGE`, `OTP`, `DELIVERY`, `DATEREG`, `RADIUS`, `LATITUDE`, `LONGITUDE`, `STATUS`, `RATING`) VALUES
(1, 'Abang Jo Tomyam', 'abgjo321@avro.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '048284953', 'Changlun', '48284953', '1', '1.30', '2020-11-23 23:55:59.157121', '5', '6.435363', '100.427001', 'OPEN', '4'),
(2, 'Mak Mah', 'makmah321@avro.com', '8fe670fef2b8c74ef8987cdfccdb32e96ad4f9a2', '049284953', 'Changlun', '49284953', '1', '1.50', '2020-11-23 23:56:05.216568', '6', '6.433827', '100.430520', 'OPEN', '5'),
(3, 'Ah Kiong Coffee House', 'ahkiong321@avro.com', '8fe670fef2b8c74ef8987cdfccdb32e96ad4f9a2', '048244953', 'Changlun', '48244953', '1', '1.50', '2020-11-23 23:56:09.301222', '10', '6.423678', '100.425199', 'OPEN', '3.5'),
(4, 'Subaidah', 'subaidah321@avro.com', '8fe670fef2b8c74ef8987cdfccdb32e96ad4f9a2', '049265534', 'Changlun', '49265534', '1', '1.20', '2020-11-23 23:56:13.337346', '5', '6.437921', '100.447429', 'OPEN', '5'),
(5, 'Kumar Curry House', 'kumar321@avro.com', '8fe670fef2b8c74ef8987cdfccdb32e96ad4f9a2', '047664544', 'Changlun', '477664544', '1', '1.00', '2020-11-23 23:56:17.191741', '15', '6.423166', '100.424855', 'OPEN', '5'),
(9, 'Xoyonib', 'xoyonib991@tan9595.com', '8fe670fef2b8c74ef8987cdfccdb32e96ad4f9a2', '0196665544', 'Changlun', '0196665544-1606149285949309', '1', '2.50', '2020-11-24 00:34:47.985050', '9', '6.427175', '100.416272', 'OPEN', '5'),
(10, 'Laksa House', 'lebofe9957@bcpfm.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0194702499', 'Changlun', '0194702499-1606279085373742', '1', '2.00', '2020-11-25 12:38:11.131565', '10', '6.447218', '100.444081', 'OPEN', '5'),
(11, 'McDonald Changlun', 'mcd@gmail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '019444555', 'Bukit Kayu Hitam', '019444555-1608095466609267', '1', '1.2', '2020-12-16 13:11:09.272113', '5', '6.4318283', '100.4299967', 'CLOSE', '0');

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
('Kayiti Esam', 'degipo8342@rvemold.com', '01945543345', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '2020-11-10 12:23:15.379391', '0'),
('Student', 'student@gmail.com', '0123456789', '2c0413e4bdd9c697c7284c4d97d029f0e241598e', '2020-11-27 14:04:16.971516', '4651'),
('aidil', 'yarabe2024@febeks.com', '012504311', 'b0399d2029f64d445bd131ffaa399a42d2f8e7dc', '2020-12-17 07:59:30.916375', '0'),
('lkk', 'lkk@yahoo.com', '012345678', '8cb2237d0679ca88db6464eac60da96345513964', '2020-12-04 15:26:32.227938', '4233'),
('abc', 'abc@yahoo.com', '0123344556', 'a9993e364706816aba3e25717850c26c9cd0d89d', '2020-12-04 15:42:24.316853', '6801'),
('123', '123@gmail.com', '1234567', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2020-12-04 15:46:59.527248', '9319'),
('nowis', 'nowis60840@hebgsw.com', '012345678', '6a204d9bb1c192219585a8f6d2993fa454eb94b4', '2020-12-04 15:57:52.398066', '0'),
('nowis', 'nowis60840@hegsw.com', '0123456789', '6a204d9bb1c192219585a8f6d2993fa454eb94b4', '2020-12-04 16:04:18.931600', '6967'),
('poydecelte', 'poydecelte@nedoz.com', '0112345678', '1f4a04e5543d8760660bb080226040b987b88d47', '2020-12-04 16:18:38.549307', '0'),
('', '', '', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '2020-12-18 11:50:25.578790', '4134');

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
  MODIFY `FOODID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `RESTAURANT`
--
ALTER TABLE `RESTAURANT`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
