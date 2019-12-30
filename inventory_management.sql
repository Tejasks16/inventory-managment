-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 30, 2019 at 04:46 AM
-- Server version: 5.7.19
-- PHP Version: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_management`
--

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `convertToRupiah`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `convertToRupiah` (`number` INT) RETURNS VARCHAR(255) CHARSET latin1 BEGIN  
DECLARE hasil VARCHAR(255);  
SET hasil = REPLACE(REPLACE(REPLACE(FORMAT(number, 0), '.', '|'), ',', '.'), '|', ',');  
RETURN (hasil);  
END$$

DROP FUNCTION IF EXISTS `fRupiah`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fRupiah` (`number` BIGINT) RETURNS VARCHAR(255) CHARSET latin1 BEGIN  
DECLARE hasil VARCHAR(255);  
SET hasil = REPLACE(REPLACE(REPLACE(FORMAT(number, 0), '.', '|'), ',', '.'), '|', ',');  
RETURN (hasil);  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
CREATE TABLE IF NOT EXISTS `brand` (
  `brandID` int(12) NOT NULL AUTO_INCREMENT,
  `categoryID` int(12) NOT NULL,
  `brandName` varchar(100) DEFAULT NULL,
  `brandStatus` enum('active','inactive') DEFAULT NULL,
  PRIMARY KEY (`brandID`)
) ENGINE=InnoDB AUTO_INCREMENT=7017 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`brandID`, `categoryID`, `brandName`, `brandStatus`) VALUES
(7013, 10011, 'Polytron', 'active'),
(7014, 10011, 'LG', 'active'),
(7015, 10013, 'Yamaha', 'active'),
(7016, 10012, 'Tablets', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `categoryID` int(12) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(100) DEFAULT NULL,
  `categoryStatus` enum('active','inactive') DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=10014 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryID`, `categoryName`, `categoryStatus`) VALUES
(10011, 'Electronics', 'active'),
(10012, 'Medicines', 'active'),
(10013, 'Materials', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_order`
--

DROP TABLE IF EXISTS `inventory_order`;
CREATE TABLE IF NOT EXISTS `inventory_order` (
  `inventoryOrderID` int(12) NOT NULL AUTO_INCREMENT,
  `userID` int(12) DEFAULT NULL,
  `inventoryOrderTotal` int(12) DEFAULT NULL,
  `inventoryOrderDate` varchar(25) DEFAULT NULL,
  `inventoryOrderName` varchar(100) DEFAULT NULL,
  `inventoryOrderAddress` varchar(100) DEFAULT NULL,
  `paymentStatus` enum('cash','credit') DEFAULT NULL,
  `inventoryOrderStatus` enum('active','inactive') DEFAULT NULL,
  `inventoryOrderCreatedDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`inventoryOrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory_order`
--

INSERT INTO `inventory_order` (`inventoryOrderID`, `userID`, `inventoryOrderTotal`, `inventoryOrderDate`, `inventoryOrderName`, `inventoryOrderAddress`, `paymentStatus`, `inventoryOrderStatus`, `inventoryOrderCreatedDate`) VALUES
(2, 6001, 330000, '02-12-2019', 'Indomaret Asrama', 'Jalan Asrama Medan Helvetia', 'cash', 'active', 1575550462),
(3, 6004, 2200000, '03-12-2019', 'PT Nusa Net', 'Jalan Multatuli Medan Baru', 'cash', 'active', 1575550549),
(4, 6004, 220000000, '27-12-2019', 'Test123', 'Bangalore', 'cash', 'active', 1577455575),
(5, 6001, 1650000, '21-12-2019', 'Test', 'Bangalore', 'cash', 'active', 1577510905);

-- --------------------------------------------------------

--
-- Table structure for table `inventory_order_product`
--

DROP TABLE IF EXISTS `inventory_order_product`;
CREATE TABLE IF NOT EXISTS `inventory_order_product` (
  `inventoryOrderProductID` int(11) NOT NULL AUTO_INCREMENT,
  `inventoryOrderID` int(11) DEFAULT NULL,
  `productID` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` int(12) DEFAULT NULL,
  `tax` int(10) DEFAULT NULL,
  PRIMARY KEY (`inventoryOrderProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory_order_product`
--

INSERT INTO `inventory_order_product` (`inventoryOrderProductID`, `inventoryOrderID`, `productID`, `quantity`, `price`, `tax`) VALUES
(2, 2, 1908, 2, 150000, 15000),
(3, 3, 1907, 1, 2000000, 200000),
(4, 4, 1907, 100, 2000000, 200000),
(5, 5, 1908, 10, 150000, 15000);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `productID` int(12) NOT NULL AUTO_INCREMENT,
  `categoryID` int(12) NOT NULL,
  `brandID` int(12) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productDescription` varchar(200) NOT NULL,
  `productQuantity` int(11) NOT NULL,
  `productUnit` varchar(150) NOT NULL,
  `productBasePrice` int(12) NOT NULL,
  `productTax` int(12) NOT NULL,
  `productMinimumOrder` int(12) NOT NULL DEFAULT '0',
  `productEnterBy` int(11) NOT NULL,
  `productStatus` enum('pending','approved') NOT NULL,
  `productDate` date NOT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=1915 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `categoryID`, `brandID`, `productName`, `productDescription`, `productQuantity`, `productUnit`, `productBasePrice`, `productTax`, `productMinimumOrder`, `productEnterBy`, `productStatus`, `productDate`) VALUES
(1907, 10011, 7013, 'LCD Matrix Polytron', 'Lightening and save energy LCD for advertising', -89, 'Unit', 2000000, 200000, 0, 6001, 'pending', '2019-12-05'),
(1908, 10012, 7016, 'Collage Cartoon White Papers 10 inch', 'Cartoon papers for advertising or brocures', 3, 'Unit', 150000, 15000, 0, 6001, 'approved', '2019-12-05'),
(1912, 10011, 7014, 'Sony', 'test ', 10, 'Unit', 10, 10, 0, 6001, 'pending', '2019-12-28'),
(1913, 10012, 7016, 'Test final', 'This is final test test', 10, 'Unit', 100, 1000, 0, 6005, 'approved', '2019-12-30'),
(1914, 10011, 7014, 'ikiji', 'ABIBHVDC UBBAISCIibdcb ', 10, 'Unit', 10, 10, 0, 6001, 'pending', '2019-12-30');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(70) DEFAULT NULL,
  `userPassword` varchar(100) DEFAULT NULL,
  `userName` varchar(50) DEFAULT NULL,
  `userType` enum('master','user') DEFAULT NULL,
  `userStatus` enum('active','inactive') DEFAULT NULL,
  `userRole` varchar(24) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=6006 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `userEmail`, `userPassword`, `userName`, `userType`, `userStatus`, `userRole`) VALUES
(6001, 'tejasks@live.in', '$2y$10$IyCd5S/Jhpa/25k3DcED.uDJF5zQyOKjVIstSSDXMp90lD9f4ogTW', 'tejasks', 'master', 'active', 'manager'),
(6005, 'admin@mail.com', '$2y$10$5xTpMhEsEJ5GtbJHz10iIOdl7SGme3ypdbFu1pO9GeQyaxuLiOTcy', 'admin', 'master', 'active', 'assistant');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
