CREATE DATABASE  IF NOT EXISTS `restaurante3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `restaurante3`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurante3
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias_platillos`
--

DROP TABLE IF EXISTS `categorias_platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias_platillos` (
  `id_categoria` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) NOT NULL,
  `orden_mostrar` tinyint DEFAULT '0',
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre_categoria` (`nombre_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias_platillos`
--

LOCK TABLES `categorias_platillos` WRITE;
/*!40000 ALTER TABLE `categorias_platillos` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorias_platillos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_orden`
--

DROP TABLE IF EXISTS `detalle_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_orden` (
  `id_detalle_orden` int unsigned NOT NULL AUTO_INCREMENT,
  `id_orden` int unsigned NOT NULL,
  `id_platillo` smallint unsigned NOT NULL,
  `cantidad` tinyint unsigned NOT NULL,
  `precio_unitario_venta` decimal(7,2) NOT NULL,
  `subtotal_item` decimal(9,2) NOT NULL,
  `notas_personalizadas` text,
  PRIMARY KEY (`id_detalle_orden`),
  KEY `id_orden` (`id_orden`),
  KEY `id_platillo` (`id_platillo`),
  CONSTRAINT `detalle_orden_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id_orden`),
  CONSTRAINT `detalle_orden_ibfk_2` FOREIGN KEY (`id_platillo`) REFERENCES `platillos` (`id_platillo`),
  CONSTRAINT `detalle_orden_chk_1` CHECK ((`cantidad` > 0)),
  CONSTRAINT `detalle_orden_chk_2` CHECK ((`precio_unitario_venta` >= 0)),
  CONSTRAINT `detalle_orden_chk_3` CHECK ((`subtotal_item` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_orden`
--

LOCK TABLES `detalle_orden` WRITE;
/*!40000 ALTER TABLE `detalle_orden` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direcciones_clientes`
--

DROP TABLE IF EXISTS `direcciones_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direcciones_clientes` (
  `id_direccion` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` mediumint unsigned NOT NULL,
  `calle` varchar(255) NOT NULL,
  `numero_exterior` varchar(10) NOT NULL,
  `numero_interior` varchar(10) DEFAULT NULL,
  `colonia` varchar(100) NOT NULL,
  `codigo_postal` char(5) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `referencias` text,
  `es_predeterminada` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_direccion`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `direcciones_clientes_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direcciones_clientes`
--

LOCK TABLES `direcciones_clientes` WRITE;
/*!40000 ALTER TABLE `direcciones_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `direcciones_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes`
--

DROP TABLE IF EXISTS `ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes` (
  `id_orden` int unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` mediumint unsigned NOT NULL,
  `fecha_hora_orden` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipo_entrega` enum('domicilio','recoger_local') NOT NULL,
  `id_direccion` mediumint unsigned DEFAULT NULL,
  `estado_orden` enum('pendiente','en_preparacion','lista_recoger','en_camino','entregada','cancelada','pagada') NOT NULL,
  `total_orden` decimal(8,2) NOT NULL,
  `id_usuario` smallint unsigned DEFAULT NULL,
  `fecha_hora_pago` datetime DEFAULT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `instrucciones_especiales` text,
  PRIMARY KEY (`id_orden`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_direccion` (`id_direccion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ordenes_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `ordenes_ibfk_2` FOREIGN KEY (`id_direccion`) REFERENCES `direcciones_clientes` (`id_direccion`),
  CONSTRAINT `ordenes_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios_internos` (`id_usuario`),
  CONSTRAINT `ordenes_chk_1` CHECK ((`total_orden` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes`
--

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platillos`
--

DROP TABLE IF EXISTS `platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platillos` (
  `id_platillo` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` decimal(7,2) NOT NULL,
  `id_categoria` tinyint unsigned NOT NULL,
  `url_imagen` varchar(255) DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_platillo`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `platillos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_platillos` (`id_categoria`),
  CONSTRAINT `platillos_chk_1` CHECK ((`precio` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platillos`
--

LOCK TABLES `platillos` WRITE;
/*!40000 ALTER TABLE `platillos` DISABLE KEYS */;
/*!40000 ALTER TABLE `platillos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_internos`
--

DROP TABLE IF EXISTS `usuarios_internos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_internos` (
  `id_usuario` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `rol` enum('cajero','cocinero','repartidor','admin') NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_internos`
--

LOCK TABLES `usuarios_internos` WRITE;
/*!40000 ALTER TABLE `usuarios_internos` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_internos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01 23:27:08
