-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2023 at 11:22 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_beasiswa`
--

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `nim` varchar(10) NOT NULL,
  `nama_mahasiswa` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telp` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`nim`, `nama_mahasiswa`, `alamat`, `telp`) VALUES
('20121002', 'Rani handayani', 'sleman', '5678'),
('20121003', 'Zulkifli ridho', 'wonosari', '90123'),
('20121004', 'Ana nur laila', 'kasihan', '4567'),
('20121006', 'Naufaludin', 'magelang', '5678'),
('20121007', 'Nirmala', 'klaten', '2349');

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `iddaftar` int(11) NOT NULL,
  `tgldaftar` date DEFAULT NULL,
  `tahun` varchar(4) DEFAULT NULL,
  `nim` varchar(10) DEFAULT NULL,
  `pendapatan_ortu` int(11) DEFAULT NULL,
  `ipk` decimal(3,2) DEFAULT NULL,
  `jml_saudara` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`iddaftar`, `tgldaftar`, `tahun`, `nim`, `pendapatan_ortu`, `ipk`, `jml_saudara`) VALUES
(19, '2023-07-13', '2023', '20121003', 3000000, 3.50, 2),
(21, '2023-07-13', '2023', '20121002', 2000000, 3.15, 3),
(23, '2023-07-13', '2023', '20121004', 2000000, 3.00, 5),
(24, '2023-07-14', '2023', '20121006', 2500000, 3.05, 4),
(25, '2023-07-14', '2023', '20121007', 1, 0.00, 0),
(26, '2023-07-14', '', '', 1000000, 0.10, 5);

-- --------------------------------------------------------

--
-- Table structure for table `perangkingan`
--

CREATE TABLE `perangkingan` (
  `idperangkingan` int(11) NOT NULL,
  `iddaftar` int(11) DEFAULT NULL,
  `n_pendapatan` decimal(4,3) DEFAULT NULL,
  `n_ipk` decimal(4,3) DEFAULT NULL,
  `n_saudara` decimal(4,3) DEFAULT NULL,
  `preferensi` decimal(4,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `perangkingan`
--

INSERT INTO `perangkingan` (`idperangkingan`, `iddaftar`, `n_pendapatan`, `n_ipk`, `n_saudara`, `preferensi`) VALUES
(257, 17, 0.556, 1.000, 1.000, 0.778),
(258, 18, 1.000, 0.953, 1.000, 0.986),
(357, 19, 9.999, 1.000, 0.400, 9.999),
(358, 21, 9.999, 0.900, 0.600, 9.999),
(359, 23, 9.999, 0.857, 1.000, 9.999),
(360, 24, 9.999, 0.871, 0.800, 9.999),
(361, 25, 1.000, 0.000, 0.000, 0.500);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vperangkingan`
-- (See below for the actual view)
--
CREATE TABLE `vperangkingan` (
`idperangkingan` int(11)
,`iddaftar` int(11)
,`tgldaftar` date
,`tahun` varchar(4)
,`nim` varchar(10)
,`nama_mahasiswa` varchar(100)
,`n_pendapatan` decimal(4,3)
,`n_ipk` decimal(4,3)
,`n_saudara` decimal(4,3)
,`preferensi` decimal(4,3)
);

-- --------------------------------------------------------

--
-- Structure for view `vperangkingan`
--
DROP TABLE IF EXISTS `vperangkingan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vperangkingan`  AS SELECT `perangkingan`.`idperangkingan` AS `idperangkingan`, `perangkingan`.`iddaftar` AS `iddaftar`, `pendaftaran`.`tgldaftar` AS `tgldaftar`, `pendaftaran`.`tahun` AS `tahun`, `pendaftaran`.`nim` AS `nim`, `mahasiswa`.`nama_mahasiswa` AS `nama_mahasiswa`, `perangkingan`.`n_pendapatan` AS `n_pendapatan`, `perangkingan`.`n_ipk` AS `n_ipk`, `perangkingan`.`n_saudara` AS `n_saudara`, `perangkingan`.`preferensi` AS `preferensi` FROM ((`perangkingan` join `pendaftaran` on(`perangkingan`.`iddaftar` = `pendaftaran`.`iddaftar`)) join `mahasiswa` on(`pendaftaran`.`nim` = `mahasiswa`.`nim`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`nim`) USING BTREE;

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`iddaftar`) USING BTREE;

--
-- Indexes for table `perangkingan`
--
ALTER TABLE `perangkingan`
  ADD PRIMARY KEY (`idperangkingan`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  MODIFY `iddaftar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `perangkingan`
--
ALTER TABLE `perangkingan`
  MODIFY `idperangkingan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=362;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
