CREATE DATABASE  IF NOT EXISTS `minhchungvanban` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `minhchungvanban`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: minhchungvanban
-- ------------------------------------------------------
-- Server version	5.7.12-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `botieuchuan`
--

DROP TABLE IF EXISTS `botieuchuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `botieuchuan` (
  `MaBTC` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TenBTC` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `MoTa` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`MaBTC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `botieuchuan`
--

LOCK TABLES `botieuchuan` WRITE;
/*!40000 ALTER TABLE `botieuchuan` DISABLE KEYS */;
INSERT INTO `botieuchuan` VALUES ('BTC01','AUN-QA CRITERIA',''),('BTC02','TEST BTC',''),('BTC03','ABET','USA CRITERIA'),('BTC04','DXD','dd'),('BTC05','TCVN123','Tiêu chuẩn Việt Nam');
/*!40000 ALTER TABLE `botieuchuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoatdong`
--

DROP TABLE IF EXISTS `hoatdong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hoatdong` (
  `MaHD` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TenHD` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MoTa` longtext COLLATE utf8_unicode_ci,
  `AnhMH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaHD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoatdong`
--

LOCK TABLES `hoatdong` WRITE;
/*!40000 ALTER TABLE `hoatdong` DISABLE KEYS */;
INSERT INTO `hoatdong` VALUES ('HD000','Học thuật',NULL,NULL),('HD001','Văn hóa',NULL,NULL),('HD002','Thể thao',NULL,NULL),('HD003','Hợp tác',NULL,NULL),('HD005','E-Sport','Dota 2, LOL, 3Q','HoatDong\\HD005\\Capture001.png'),('HD006','Du lịch','Du lịch các khu di tích.','HoatDong\\HD006\\mut.jpg');
/*!40000 ALTER TABLE `hoatdong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `minhchung`
--

DROP TABLE IF EXISTS `minhchung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `minhchung` (
  `MaTieuChi` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MaMC` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TenMC` longtext COLLATE utf8_unicode_ci NOT NULL,
  `MoTa` longtext COLLATE utf8_unicode_ci,
  `SoHieu` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NgayBanHanh` date NOT NULL,
  `MaNBH` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MaHD` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NgayThem` date DEFAULT NULL,
  PRIMARY KEY (`MaMC`),
  KEY `MaTieuChi` (`MaTieuChi`),
  KEY `MaNBH` (`MaNBH`),
  KEY `MaHD` (`MaHD`),
  KEY `minhchung_donggop_taikhoan_idx` (`Email`),
  CONSTRAINT `minhchung_banhanh_noibanhanh` FOREIGN KEY (`MaNBH`) REFERENCES `noibanhanh` (`MaNBH`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `minhchung_phanloai` FOREIGN KEY (`MaHD`) REFERENCES `hoatdong` (`MaHD`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `minhchung_taikhoan` FOREIGN KEY (`Email`) REFERENCES `taikhoan` (`Email`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `minhchung_tieuchi` FOREIGN KEY (`MaTieuChi`) REFERENCES `tieuchi` (`MaTieuChi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `minhchung`
--

LOCK TABLES `minhchung` WRITE;
/*!40000 ALTER TABLE `minhchung` DISABLE KEYS */;
INSERT INTO `minhchung` VALUES ('TCH001','MC002','Minh chứng 1','','Số 25-BTC','2017-12-07','NBH01','HD001','luunamten@gmail.com','2016-12-17'),('TCH002','MC003','Minh chứng 2','','Số 26-BTC','2017-12-07','NBH02','HD001',NULL,'2016-11-17'),('TCH003','MC004','Minh chứng 4','','Số 28-BTC','2017-02-15','NBH02','HD001',NULL,'2016-05-17'),('TCH003','MC005','Minh chứng số 1','ggg','Số 98-BTC','2017-02-15','NBH01','HD001','luunamten@gmail.com','2017-06-17'),('TCH006','MC007','C/C++ Programming Master','Master C/C++','C17','2017-12-14','NBH02','HD000','luunamten@gmail.com','2017-06-17'),('TCH001','MC008','Java Programming Master','Master Java SE, Java EE, Java ME','J20145','2017-12-15','NBH02','HD000','nguyenthihoa@gmail.com','2017-02-17'),('TCH010','MC009','Computer Graphics','OpenGL, OpenCL, Vulkan, DirectX','CG101','2017-12-14','NBH02','HD000','luunamten@gmail.com','2017-12-17'),('TCH002','MC010','TTX20','Open Source','TTX1022','2017-12-14','NBH04','HD000','nguyenthihoa@gmail.com','2017-12-17'),('TCH008','MC011','DGGB','High Performance','DXD012','2017-12-03','NBH04','HD000','luunamten@gmail.com','2017-12-17'),('TCH001','MC012','Range','Rang in 20','R12','2017-12-14','NBH05','HD002','luunamten@gmail.com','2017-12-17'),('TCH009','MC013','ĐRR','Giáo dục hiện đại','GD0211','2017-12-05','NBH02','HD001','luunamten@gmail.com','2017-12-18'),('TCH010','MC014','ewfewf','ewfwefwe','fewfewfwe','2017-12-13','NBH04','HD003','luunamten@gmail.com','2017-12-18'),('TCH012','MC015','Minh chứng 3','','m366','2017-12-15','NBH04','HD003','luunamten@gmail.com','2017-12-18'),('TCH011','MC016','Minh Chứng ABS','ABS','ABS2555','2017-12-23','NBH02','HD002','luunamten@gmail.com','2017-12-18'),('TCH010','MC017','Minh chung 42hb','tcvn1133','tcvn-cs','2017-12-26','NBH02','HD002','luunamten@gmail.com','2017-12-18'),('TCH013','MC018','Computer Programming ST','CPST','CP1','2017-12-13','NBH02','HD003','luunamten@gmail.com','2017-12-18'),('TCH013','MC019','Computer Programming ST 2','CPST','CP2','2017-12-13','NBH02','HD003','luunamten@gmail.com','2017-12-18'),('TCH013','MC020','Computer Programming ST 3','CPST','CP3','2017-12-08','NBH02','HD001','luunamten@gmail.com','2017-12-18'),('TCH014','MC021','Computer Programming ST 4','CPST','CP4','2017-12-08','NBH02','HD001','luunamten@gmail.com','2017-12-18'),('TCH013','MC022','Computer Programming ST 5','CPST','CP5','2017-12-08','NBH04','HD001','luunamten@gmail.com','2017-12-18'),('TCH013','MC023','Computer Programming ST 6','CPST','CP6','2017-12-08','NBH04','HD001','luunamten@gmail.com','2017-12-18'),('TCH014','MC024','Computer Programming ST 7A','CPST','CP7A','2017-12-08','NBH02','HD001','luunamten@gmail.com','2017-12-18'),('TCH002','MC025','Computer Programming ST 8','CPST','CP8','2017-12-08','NBH02','HD001','luunamten@gmail.com','2017-12-18'),('TCH004','MC026','COS 1','C1S','C2','2017-07-18','NBH02','HD001','luunamten@gmail.com','2017-12-18'),('TCH011','MC027','COS 2','C1S','C2','2016-10-11','NBH02','HD003','luunamten@gmail.com','2017-12-18'),('TCH012','MC028','COS 4','C1S','C4','2016-10-11','NBH02','HD003','luunamten@gmail.com','2017-12-18'),('TCH008','MC029','COS 5','C1S','C5','2016-10-11','NBH01','HD003','luunamten@gmail.com','2017-12-18'),('TCH008','MC030','COS 6','C1S','C6','2016-10-11','NBH01','HD001','luunamten@gmail.com','2017-12-18'),('TCH009','MC031','COS 7','C1S','C6','2016-10-11','NBH01','HD001','luunamten@gmail.com','2017-12-18'),('TCH011','MC032','COS 7.5','C1S','C6','2016-10-11','NBH01','HD001','luunamten@gmail.com','2017-12-18');
/*!40000 ALTER TABLE `minhchung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noibanhanh`
--

DROP TABLE IF EXISTS `noibanhanh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noibanhanh` (
  `MaNBH` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TenNBH` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`MaNBH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noibanhanh`
--

LOCK TABLES `noibanhanh` WRITE;
/*!40000 ALTER TABLE `noibanhanh` DISABLE KEYS */;
INSERT INTO `noibanhanh` VALUES ('NBH01','Phòng Công Tác Sinh Viên'),('NBH02','Phòng Đào Tạo'),('NBH04','Công Tác Xã Hội'),('NBH05','Đoàn Thanh Niên');
/*!40000 ALTER TABLE `noibanhanh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taikhoan` (
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MatKhau` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `HoTen` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `Nu` bit(1) NOT NULL,
  `NgaySinh` date NOT NULL,
  `DiaChi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NoiCongTac` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ChucVu` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SoDT` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `AnhDaiDien` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UserLevel` int(11) NOT NULL,
  PRIMARY KEY (`Email`),
  KEY `UserLevel` (`UserLevel`),
  CONSTRAINT `taikhoan_phanloai_userlevel` FOREIGN KEY (`UserLevel`) REFERENCES `userlevel` (`UserLevel`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taikhoan`
--

LOCK TABLES `taikhoan` WRITE;
/*!40000 ALTER TABLE `taikhoan` DISABLE KEYS */;
INSERT INTO `taikhoan` VALUES ('ho@gmail.com','123','Nguyễn Thị Hồng','','2017-12-18','NewYork','Harvard','Prime Minister','0123456789','Avatar\\ho@gmail.com\\lotus-flower.jpg',2),('hon@gmail.com','1','Hồng Vân','','2017-12-18','Japan','Harvard','Thủ quỷ','0909051552','Avatar\\hon@gmail.com\\se.jpg',1),('luunamten@gmail.com','1','Lư Thị Ngọc Quỳnh','','1997-11-27','Japan','ĐH SPKT','Dân thường','0909090909','Avatar\\luunamten@gmail.com\\land.png',3),('nguyenthihoa@gmail.com','123','Nguyễn Thị Hoa','','1991-01-12','6/1, đường Số 5, phường Linh Chiểu, quận Thủ Đức','ĐH SPKT','Trưởng phòng Đào tạo','0981422097','Avatar\\nguyenthihoa@gmail.com\\Sen.jpg',2),('trandainghia@gmail.com','1','Trần Đại Nghĩa','\0','1982-05-04','25 Lê Văn Chí, Thủ Đức','ĐH SPKT','Trưởng phòng Đào tạo','098653254','Avatar\\trandainghia@gmail.com\\anh-dep-la-vang-roi-33-2-59192.jpg',2);
/*!40000 ALTER TABLE `taikhoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taptin`
--

DROP TABLE IF EXISTS `taptin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taptin` (
  `mataptin` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `maminhchung` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FilePath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FileType` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`mataptin`),
  KEY `taptin_ibfk_1` (`maminhchung`),
  CONSTRAINT `taptin_ibfk_1` FOREIGN KEY (`maminhchung`) REFERENCES `minhchung` (`MaMC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taptin`
--

LOCK TABLES `taptin` WRITE;
/*!40000 ALTER TABLE `taptin` DISABLE KEYS */;
INSERT INTO `taptin` VALUES ('TT001','MC007','MinhChung\\MC007\\[Alex_Allain]_Jumping_into_C__.pdf','PDF'),('TT002','MC008','MinhChung\\MC008\\cst112-Text_book(10th_ed).pdf','PDF'),('TT003','MC009','MinhChung\\MC009\\Vulkan_Programming_Guide.pdf','PDF'),('TT004','MC010','MinhChung\\MC010\\OpenGL 4 Shading Language Cookbook, Second Edition.pdf','PDF'),('TT006','MC012','MinhChung\\MC012\\relational-algebra-exercises-answers.pdf','PDF'),('TT008','MC005','MinhChung\\MC005\\OpenGL 4 Shading Language Cookbook, Second Edition.pdf','PDF'),('TT009','MC013','MinhChung\\MC013\\Blender 3D Basics, 2nd Edition.pdf','PDF'),('TT010','MC014','MinhChung\\MC014\\ARB_texture_compression.pdf','PDF'),('TT011','MC011','MinhChung\\MC011\\collision.pdf','PDF'),('TT012','MC015','MinhChung\\MC015\\ARB_texture_compression.pdf','PDF'),('TT013','MC016','MinhChung\\MC016\\Blender 3D Basics, 2nd Edition.pdf','PDF'),('TT014','MC017','MinhChung\\MC017\\ch12_interrupts.pdf','PDF'),('TT015','MC018','MinhChung\\MC018\\quyet_dinh_29_10_8444.pdf','PDF'),('TT016','MC019','MinhChung\\MC019\\quyet_dinh_29_10_8444.pdf','PDF'),('TT017','MC020','MinhChung\\MC020\\quyet_dinh_29_10_8444.pdf','PDF'),('TT018','MC021','MinhChung\\MC021\\quyet_dinh_29_10_8444.pdf','PDF'),('TT019','MC022','MinhChung\\MC022\\quyet_dinh_29_10_8444.pdf','PDF'),('TT020','MC023','MinhChung\\MC023\\quyet_dinh_29_10_8444.pdf','PDF'),('TT021','MC024','MinhChung\\MC024\\quyet_dinh_29_10_8444.pdf','PDF'),('TT022','MC025','MinhChung\\MC025\\quyet_dinh_29_10_8444.pdf','PDF'),('TT023','MC026','MinhChung\\MC026\\quyet_dinh_29_10_8444.pdf','PDF'),('TT024','MC027','MinhChung\\MC027\\quyet_dinh_29_10_8444.pdf','PDF'),('TT025','MC028','MinhChung\\MC028\\quyet_dinh_29_10_8444.pdf','PDF'),('TT026','MC029','MinhChung\\MC029\\quyet_dinh_29_10_8444.pdf','PDF'),('TT027','MC030','MinhChung\\MC030\\quyet_dinh_29_10_8444.pdf','PDF'),('TT028','MC031','MinhChung\\MC031\\quyet_dinh_29_10_8444.pdf','PDF'),('TT029','MC032','MinhChung\\MC032\\quyet_dinh_29_10_8444.pdf','PDF');
/*!40000 ALTER TABLE `taptin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thongbao`
--

DROP TABLE IF EXISTS `thongbao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thongbao` (
  `MaTB` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TieuDeTB` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NoiDungTB` longtext COLLATE utf8_unicode_ci,
  `ThGianDangTai` date DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaTB`),
  KEY `Email` (`Email`),
  CONSTRAINT `thongbao_taikhoan` FOREIGN KEY (`Email`) REFERENCES `taikhoan` (`Email`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thongbao`
--

LOCK TABLES `thongbao` WRITE;
/*!40000 ALTER TABLE `thongbao` DISABLE KEYS */;
INSERT INTO `thongbao` VALUES ('TB001','Chào mừng Ngày NGVN (20/11)','Nhân dịp Chào mừng ngày Nhà giáo Việt Nam, Vào lúc 7h tối ngày 20/11, trường ĐH SPKT sẽ tổ chức chương trình văn nghệ \"Tri ân Thầy cô\". Kính mong toàn thể cán bộ và sinh viên trong trường đến tham dự chương trình văn nghệ','2017-11-20',NULL),('TB002','Thông báo Tuyển sinh','Trường ĐH Sư phạm Kỹ thuật vừa công bố chỉ tiêu tuyển sinh năm 2018','2017-11-30',NULL),('TB003','Kỷ niệm 55 năm ngày thành lập Trường ĐH SPKT','Nhân dịp ngày kỷ niệm thành lập Trường ĐH SPKT, trường sẽ tổ chức lễ kỷ niệm vào 9h sáng ngày 10/10. Kính mong toàn thể cán bộ và sinh viên của trường có thể đến tham gia lễ kỷ niệm.<div><br></div>','2017-10-01',NULL),('TB004','Thi Olympic các môn Khoa học Tự nhiên','Thi Olympic Khoa học Tự nhiên vào ngày 15 - 01 - 2017.','2017-12-16','nguyenthihoa@gmail.com'),('TB005','Thi Olympic các môn Khoa học Tự nhiên lần 2','Thi vào ngày 25-01-2017','2017-12-18',NULL),('TB007','Thông báo khẩn 3','Thiên thạch rơi trúng trường SPKT','2017-12-18','luunamten@gmail.com');
/*!40000 ALTER TABLE `thongbao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tieuchi`
--

DROP TABLE IF EXISTS `tieuchi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tieuchi` (
  `MaTieuChuan` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MaTieuChi` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TenTieuChi` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`MaTieuChi`),
  KEY `MaTieuChuan` (`MaTieuChuan`),
  CONSTRAINT `tieuchi_thuoc_tieuchuan` FOREIGN KEY (`MaTieuChuan`) REFERENCES `tieuchuan` (`MaTieuChuan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tieuchi`
--

LOCK TABLES `tieuchi` WRITE;
/*!40000 ALTER TABLE `tieuchi` DISABLE KEYS */;
INSERT INTO `tieuchi` VALUES ('TC001','TCH001','Tiêu chí 1.1'),('TC001','TCH002','Tiêu chí 1.2'),('TC002','TCH003','Tiêu chí 1.1'),('TC002','TCH004','Tiêu chí 1.2'),('TC003','TCH005','Tiêu chí 1.1'),('TC003','TCH006','Tiêu chí 1.2'),('TC004','TCH007','Tiêu chí 1.1'),('TC004','TCH008','Tiêu chí 1.2'),('TC005','TCH009','Tiêu chí ABT01'),('TC005','TCH010','Tiêu chí ABT02'),('TC008','TCH011','Tiêu chí 1'),('TC010','TCH012','Tiêu chí 2'),('TC011','TCH013','TC-AB.1'),('TC012','TCH014','TC-ABS.1');
/*!40000 ALTER TABLE `tieuchi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tieuchuan`
--

DROP TABLE IF EXISTS `tieuchuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tieuchuan` (
  `MaBTC` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MaTieuChuan` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `TenTieuChuan` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`MaTieuChuan`),
  KEY `MaBTC` (`MaBTC`),
  CONSTRAINT `tieuchuan_thuoc_botieuchuan` FOREIGN KEY (`MaBTC`) REFERENCES `botieuchuan` (`MaBTC`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tieuchuan`
--

LOCK TABLES `tieuchuan` WRITE;
/*!40000 ALTER TABLE `tieuchuan` DISABLE KEYS */;
INSERT INTO `tieuchuan` VALUES ('BTC03','TC001','DXD'),('BTC01','TC002','Programme Specification'),('BTC02','TC003','Tiêu chuẩn 1'),('BTC02','TC004','Tiêu chuẩn 2'),('BTC03','TC005','Computer Science'),('BTC02','TC006','TCLLS'),('BTC04','TC007','DMDM'),('BTC05','TC008','TC1'),('BTC01','TC009','TC2'),('BTC05','TC010','TC2'),('BTC03','TC011','AB123'),('BTC03','TC012','AB5F'),('BTC01','TC013','TCVN Computer Science');
/*!40000 ALTER TABLE `tieuchuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlevel`
--

DROP TABLE IF EXISTS `userlevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userlevel` (
  `UserLevel` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`UserLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlevel`
--

LOCK TABLES `userlevel` WRITE;
/*!40000 ALTER TABLE `userlevel` DISABLE KEYS */;
INSERT INTO `userlevel` VALUES (1,'Người xem'),(2,'Người đóng góp'),(3,'Admin');
/*!40000 ALTER TABLE `userlevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'minhchungvanban'
--

--
-- Dumping routines for database 'minhchungvanban'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_secondPart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_secondPart`(
id varchar(255),
prefixLen int
) RETURNS int(11)
BEGIN
	declare secondpart int;
    set secondpart = convert(substring(id, prefixLen+1, length(id) -  prefixLen), unsigned);
	return secondpart;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_NextID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `func_NextID`(lastID varchar(10), prefix varchar(10), size int) RETURNS varchar(10) CHARSET utf8
begin
		declare num_nextID int;
		declare nextID varchar(10);
		if (lastID = '') then set lastID = concat(prefix, REPEAT(0, size - LENGTH(prefix))); end if;
		set lastID = LTRIM(RTRIM(lastID));
		set num_nextID = REPLACE(lastID, prefix, '') + 1;
		set size = size - LENGTH(prefix);
		set nextID = concat(prefix, RIGHT(concat(REPEAT(0, size), CONVERT(num_nextID, CHAR)), size));
		return nextID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insBoTieuChuan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insBoTieuChuan`(tenbtc varchar(255), mota longtext, out lastID varchar(10))
BEGIN
    set lastID = (select MaBTC from botieuchuan order by MaBTC desc limit 1);
    set lastID = func_NextID(lastID, 'BTC', 5);
	insert into botieuchuan values (lastID, tenbtc, mota);
    select lastID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addBoTieuChuan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addBoTieuChuan`(
in _tenbtc varchar(255),
in _mota longtext
)
BEGIN
	declare maxID varchar(10);
    declare _mabtc varchar(10);
    set maxID = (select mabtc from botieuchuan order by fn_secondPart(mabtc, 3) desc limit 1);
    if(trim(maxID) = '' or maxID is NULL) then
		set _mabtc = 'BTC000';
	else
		set _mabtc = func_NextID(maxID,'BTC', length(maxID));
    end if;
	insert into botieuchuan values(_mabtc, _tenbtc, _mota);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addHoatDong` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addHoatDong`(
in _tenhd varchar(100),
in _mota longtext,
in _anhmh varchar(255),
out $mahd varchar(10)
)
BEGIN
	declare maxID varchar(10);
    declare _mahd varchar(10);
    set maxID = (select mahd from hoatdong order by fn_secondPart(mahd, 2) desc limit 1);
    if(trim(maxID) = '' or maxID is NULL) then
		set _mahd = 'HD000';
	else
		set _mahd = func_NextID(maxID,'HD', length(maxID));
    end if;
    set $mahd = _mahd;
	insert into hoatdong values(_mahd, _tenhd, _mota, _anhmh);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addMinhChung` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addMinhChung`(
in MaTieuChi varchar(10),
in TenMinhChung longtext,
in MoTa longtext,
in SoHieu varchar(50),
in NgayBanHanh date,
in MaNBH varchar(10),
in MaHD varchar(10),
in Email varchar(100),
out $MaMC varchar(10)
)
BEGIN
	declare maxID varchar(10);
    declare _MaMC varchar(10);
    set maxID = (select MaMC from minhchung order by fn_secondPart(MaMC, 2) desc limit 1);
    set _MaMC = func_NextID(maxID, 'MC', length(maxID));
    set $MaMC = _MaMC;
	insert into minhchung values(MaTieuChi, _MaMC, TenMinhChung, MoTa, SoHieu, NgayBanHanh,
    MaNBH, MaHD, Email, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addTapTin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addTapTin`(
in maminhchung varchar(10),
in filepath varchar(255),
in filetype varchar(10)
)
BEGIN
	declare maxID varchar(10);
    declare _MaTapTin varchar(10);
    set maxID = (select MaTapTin from taptin order by fn_secondPart(MaTapTin, 2) desc limit 1);
    if(trim(maxID) = '' or maxID is NULL) then
		set _MaTapTin = 'TT000';
	else
		set _MaTapTin = func_NextID(maxID,'TT', length(maxID));
    end if;
	insert into taptin values(_MaTapTin, maminhchung, filepath, filetype);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addThongBao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addThongBao`(
in _tieudetb varchar(255),
in _noidungtb longtext,
in _email varchar(100)
)
BEGIN
	declare maxID varchar(10);
    declare _matb varchar(10);
    set maxID = (select matb from thongbao order by fn_secondPart(matb, 2) desc limit 1);
    if(trim(maxID) = '' or maxID is NULL) then
		set _matb = 'TB000';
	else
		set _matb = func_NextID(maxID,'TB', length(maxID));
    end if;
	insert into thongbao values(_matb, _tieudetb, _noidungtb, now(), _email);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addTieuChi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addTieuChi`(
in _matieuchuan varchar(10),
in _tentieuchi longtext
)
BEGIN
	declare maxID varchar(10);
    declare _match varchar(10);
    set maxID = (select matieuchi from tieuchi order by fn_secondPart(matieuchi, 3) desc limit 1);
    if(trim(maxID) = '' or maxID is NULL) then
		set _match = 'TCH000';
	else
		set _match = func_NextID(maxID,'TCH', length(maxID));
    end if;
	insert into tieuchi values(_matieuchuan, _match, _tentieuchi);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addTieuChuan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addTieuChuan`(
in _mabtc varchar(10),
in _tentieuchuan longtext
)
BEGIN
	declare maxID varchar(10);
    declare _matc varchar(10);
    set maxID = (select matieuchuan from tieuchuan order by fn_secondPart(matieuchuan, 2) desc limit 1);
    if(trim(maxID) = '' or maxID is NULL) then
		set _matc = 'TC000';
	else
		set _matc = func_NextID(maxID,'TC', length(maxID));
    end if;
	insert into tieuchuan values(_mabtc, _matc, _tentieuchuan);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_caplaiMatKhau` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_caplaiMatKhau`(_email varchar(100) , pass varchar(10), out trangthai bool)
begin
	set trangthai = false;
    if exists (select * from taikhoan where Email= _email collate utf8_unicode_ci)
	THEN
		update taikhoan set MatKhau = pass where Email = _email collate utf8_unicode_ci;
		set trangthai = true;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_createNBH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createNBH`(
in TenNBH varchar(100)
)
BEGIN
	declare maxID varchar(10);
    declare _MaNBH varchar(10);
    set maxID = (select MaNBH from noibanhanh order by fn_secondPart(MaNBH, 3) desc limit 1);
    set _MaNBH = func_NextID(maxID,'NBH', length(maxID));
	insert into noibanhanh values(_MaNBH, TenNBH);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_searchBTC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_searchBTC`(
in keyword varchar(255)  
)
BEGIN
	declare _keyword  varchar(255) ;
    set _keyword  = concat('%',keyword collate utf8_unicode_ci,'%') collate utf8_unicode_ci;
	select * from botieuchuan where mabtc like _keyword collate utf8_unicode_ci or tenbtc like _keyword collate utf8_unicode_ci
    or mota like _keyword collate utf8_unicode_ci;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_searchMinhChung` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_searchMinhChung`(
in keyword varchar(255),
in _email varchar(100),
in _userlevel int
)
BEGIN
	declare _keyword  varchar(255) ;
    set _keyword  = concat('%',keyword collate utf8_unicode_ci,'%') collate utf8_unicode_ci;
	select * from minhchung where (mamc like _keyword collate utf8_unicode_ci or tenmc like _keyword collate utf8_unicode_ci
    or matieuchi like _keyword collate utf8_unicode_ci or mahd like _keyword collate utf8_unicode_ci
    or manbh like _keyword collate utf8_unicode_ci or email like _keyword collate utf8_unicode_ci) and (email = _email collate utf8_unicode_ci or _userlevel = 3);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_searchTieuChi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_searchTieuChi`(
in keyword varchar(255)
)
BEGIN
	declare _keyword  varchar(255) ;
    set _keyword  = concat('%',keyword collate utf8_unicode_ci,'%') collate utf8_unicode_ci;
	select * from tieuchi where matieuchi like _keyword collate utf8_unicode_ci
    or tentieuchi like _keyword collate utf8_unicode_ci or matieuchuan like _keyword collate utf8_unicode_ci
    order by matieuchuan asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_soMinhChungThang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_soMinhChungThang`(
in _year varchar(10),
in _month varchar(10)
)
BEGIN
    select count(mamc) as num from minhchung where year(ngaythem) = _year and month(ngaythem) = _month;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_soMinhChungTrenTC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_soMinhChungTrenTC`(
in _mabtc varchar(10)
)
BEGIN
	select T2.matieuchuan as mtc, T2.tentieuchuan as ttc, count(minhchung.matieuchi) as nummc from minhchung right join
    (select T1.*, matieuchi from tieuchi right join (
		select matieuchuan, tentieuchuan from tieuchuan where mabtc = _mabtc collate utf8_unicode_ci
		) as T1 on T1.matieuchuan = tieuchi.matieuchuan
    ) as T2 on T2.matieuchi = minhchung.matieuchi group by T2.matieuchuan, T2.tentieuchuan;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test`()
BEGIN
	declare i int;
    set i = 0;
    while(i < 12) do
		select * from minhchung;
        set i = i + 1;
    end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_xoaHoatDong` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_xoaHoatDong`(
in _mahd varchar(10),
out _anhmh varchar(255)
)
BEGIN
	set _anhmh = (select anhmh from hoatdong where mahd = _mahd collate utf8_unicode_ci);
    delete from hoatdong where mahd = _mahd collate utf8_unicode_ci;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_xoaMinhChung` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_xoaMinhChung`(
in _mamc varchar(10),
in _email varchar(100),
in _userlevel int,
out _filepath varchar(255)
)
BEGIN
	set _filepath = (select filepath from taptin where maminhchung = _mamc collate utf8_unicode_ci);
    delete from minhchung where (email = _email collate utf8_unicode_ci or _userlevel = 3) and mamc = _mamc collate utf8_unicode_ci;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_xoaTaiKhoan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_xoaTaiKhoan`(
in _email varchar(100),
out _avatar varchar(255)
)
BEGIN
	set _avatar = (select anhdaidien from taikhoan where email = _email collate utf8_unicode_ci);
    delete from taikhoan where email = _email collate utf8_unicode_ci;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_xoaTapTin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_xoaTapTin`(
in _mamc varchar(10),
out _filepath varchar(255)
)
BEGIN
	set _filepath = (select filepath from taptin where maminhchung = _mamc collate utf8_unicode_ci);
	delete from taptin where maminhchung = _mamc collate utf8_unicode_ci;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-19  0:02:28
