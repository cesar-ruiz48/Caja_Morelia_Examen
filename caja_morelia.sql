-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-07-2022 a las 17:39:13
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `caja_morelia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_cliente` (IN `_id` INT(11))  BEGIN

DELETE FROM tbl_cmv_cliente_cuenta WHERE id_cliente = _id;

DELETE FROM tbl_cmv_cliente WHERE id_cliente = _id;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `informacion_cuentas` (IN `_id_cliente` INT(11))  BEGIN

SELECT tbl_cmv_cliente_cuenta.id_cliente_cuenta AS id, tbl_cmv_cliente_cuenta.saldo_actual AS saldo, tbl_cmv_cliente_cuenta.fecha_ultimo_movimiento ASultimo, tbl_cmv_cliente_cuenta.fecha_contratacion AS fecha, car_cmv_tipo_cuenta.nombre_cuenta AS cuenta
FROM tbl_cmv_cliente_cuenta
LEFT JOIN car_cmv_tipo_cuenta ON car_cmv_tipo_cuenta.id_cuenta = tbl_cmv_cliente_cuenta.id_cuenta
WHERE tbl_cmv_cliente_cuenta.id_cliente = _id_cliente;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `info_cliente` (IN `_id_cliente` INT(11))  BEGIN

SELECT tbl_cmv_cliente.id_cliente AS id, tbl_cmv_cliente.nombre AS nombre, tbl_cmv_cliente.apellido_paterno AS ap, tbl_cmv_cliente.apellido_materno AS am, tbl_cmv_cliente.rfc AS rfc, tbl_cmv_cliente.curp AS curp FROM tbl_cmv_cliente WHERE tbl_cmv_cliente.id_cliente = _id_cliente;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_clientes` ()  BEGIN

SELECT tbl_cmv_cliente.id_cliente AS id_cliente, CONCAT(tbl_cmv_cliente.nombre, ' ', tbl_cmv_cliente.apellido_paterno, ' ', tbl_cmv_cliente.apellido_materno) AS nombre, tbl_cmv_cliente.rfc AS rfc, tbl_cmv_cliente.fecha_alta AS alta, car_cmv_tipo_cuenta.nombre_cuenta AS cuenta, tbl_cmv_cliente_cuenta.saldo_actual AS saldo, tbl_cmv_cliente_cuenta.fecha_ultimo_movimiento AS ultimomov
FROM tbl_cmv_cliente
LEFT JOIN tbl_cmv_cliente_cuenta ON tbl_cmv_cliente_cuenta.id_cliente = tbl_cmv_cliente.id_cliente
LEFT JOIN car_cmv_tipo_cuenta ON tbl_cmv_cliente_cuenta.id_cuenta = car_cmv_tipo_cuenta.id_cuenta GROUP BY tbl_cmv_cliente.id_cliente;


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_cmv_tipo_cuenta`
--

CREATE TABLE `car_cmv_tipo_cuenta` (
  `id_cuenta` int(11) NOT NULL,
  `nombre_cuenta` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `car_cmv_tipo_cuenta`
--

INSERT INTO `car_cmv_tipo_cuenta` (`id_cuenta`, `nombre_cuenta`) VALUES
(1, 'AHORRO'),
(2, 'CREDIPRONTO'),
(3, 'REVOLVENTE'),
(4, 'ABICUENTA'),
(5, 'INVERDINAMICA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cmv_cliente`
--

CREATE TABLE `tbl_cmv_cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `curp` varchar(18) NOT NULL,
  `fecha_alta` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_cmv_cliente`
--

INSERT INTO `tbl_cmv_cliente` (`id_cliente`, `nombre`, `apellido_paterno`, `apellido_materno`, `rfc`, `curp`, `fecha_alta`) VALUES
(1, 'ANTONIO ', 'MENDOZA ', 'RODRIGUEZ', 'XAXX010101000', 'XAXX010101000XXQ2', '2022-07-01 10:27:21'),
(3, 'JESUS', 'LOPEZ', 'LOPEZ', 'XAXX010101000', 'XAXX010101000BNY1', '2022-07-20 16:39:23'),
(4, 'ANGEL', 'CRUZ', 'MARTINEZ', 'XAXX010101000', 'XAXX010101000LOM1', '2022-07-16 17:43:16'),
(6, 'DULCE', 'MARTINEZ', 'LOPEZ', 'XAXX010101000', 'XAXX010101000158A', '2022-07-18 15:29:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cmv_cliente_cuenta`
--

CREATE TABLE `tbl_cmv_cliente_cuenta` (
  `id_cliente_cuenta` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  `saldo_actual` decimal(10,2) NOT NULL,
  `fecha_contratacion` datetime NOT NULL,
  `fecha_ultimo_movimiento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_cmv_cliente_cuenta`
--

INSERT INTO `tbl_cmv_cliente_cuenta` (`id_cliente_cuenta`, `id_cliente`, `id_cuenta`, `saldo_actual`, `fecha_contratacion`, `fecha_ultimo_movimiento`) VALUES
(6, 1, 1, '250.00', '2022-07-01 15:25:20', '2022-07-01 13:37:21'),
(8, 3, 1, '922.31', '2022-07-04 12:18:09', '2022-07-04 12:18:20'),
(9, 4, 1, '1025.32', '2022-07-05 10:16:17', '2022-07-06 11:21:21'),
(11, 6, 1, '3659.00', '2022-07-07 14:25:23', '2022-07-07 12:27:21'),
(12, 6, 3, '55000.00', '2022-07-09 11:26:23', '2022-07-09 12:32:23'),
(13, 6, 2, '15250.00', '2022-07-14 09:24:33', '2022-07-16 11:28:18');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `car_cmv_tipo_cuenta`
--
ALTER TABLE `car_cmv_tipo_cuenta`
  ADD PRIMARY KEY (`id_cuenta`);

--
-- Indices de la tabla `tbl_cmv_cliente`
--
ALTER TABLE `tbl_cmv_cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tbl_cmv_cliente_cuenta`
--
ALTER TABLE `tbl_cmv_cliente_cuenta`
  ADD PRIMARY KEY (`id_cliente_cuenta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_cuenta` (`id_cuenta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `car_cmv_tipo_cuenta`
--
ALTER TABLE `car_cmv_tipo_cuenta`
  MODIFY `id_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tbl_cmv_cliente`
--
ALTER TABLE `tbl_cmv_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tbl_cmv_cliente_cuenta`
--
ALTER TABLE `tbl_cmv_cliente_cuenta`
  MODIFY `id_cliente_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_cmv_cliente_cuenta`
--
ALTER TABLE `tbl_cmv_cliente_cuenta`
  ADD CONSTRAINT `tbl_cmv_cliente_cuenta_ibfk_1` FOREIGN KEY (`id_cuenta`) REFERENCES `car_cmv_tipo_cuenta` (`id_cuenta`),
  ADD CONSTRAINT `tbl_cmv_cliente_cuenta_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `tbl_cmv_cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
