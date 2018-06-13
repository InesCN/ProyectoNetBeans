-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-06-2018 a las 15:23:32
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `chachachachi`
--
CREATE DATABASE IF NOT EXISTS `chachachachi` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `chachachachi`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ausencia`
--

CREATE TABLE `ausencia` (
  `P_ausencia` int(11) NOT NULL,
  `tipo` enum('Descanso','Urgencia','Médico') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ausencia`
--

INSERT INTO `ausencia` (`P_ausencia`, `tipo`) VALUES
(1, 'Médico'),
(2, 'Urgencia'),
(3, 'Descanso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ausencia_empleado`
--

CREATE TABLE `ausencia_empleado` (
  `P_ausenciaEmpleado` int(11) NOT NULL,
  `A_empleado` int(11) DEFAULT NULL,
  `A_ausencia` int(11) DEFAULT NULL,
  `justificada` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ausencia_empleado`
--

INSERT INTO `ausencia_empleado` (`P_ausenciaEmpleado`, `A_empleado`, `A_ausencia`, `justificada`) VALUES
(1, 1, 2, 1),
(3, 2, 3, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beacon`
--

CREATE TABLE `beacon` (
  `P_beacon` int(11) NOT NULL,
  `A_sala` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `P_empleado` int(11) NOT NULL,
  `nombre` char(20) DEFAULT NULL,
  `usuario` char(10) DEFAULT NULL,
  `contrasena` char(10) DEFAULT NULL,
  `correo` char(30) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `precioHora` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`P_empleado`, `nombre`, `usuario`, `contrasena`, `correo`, `fechaNacimiento`, `precioHora`) VALUES
(1, 'Ignacio', 'ignacio1', 'SoyIgnacio', 'ignacio@gmail.com', '1998-02-18', 10),
(2, 'Ana', 'Anita', 'AnaSoyYo', 'anaCasado@gmail.com', '1997-09-02', 10),
(3, 'Andrés', 'AndresGF', 'AnDrEs', 'andresgf@gmail.com', '1993-02-15', 9),
(4, 'Josefina', 'JoseRoDi', 'laJoOficiá', 'thejoseoficial@gmail.com', '1998-04-22', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado_horario`
--

CREATE TABLE `empleado_horario` (
  `P_empleadoHorario` int(11) NOT NULL,
  `A_empleado` int(11) DEFAULT NULL,
  `A_horario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado_horario`
--

INSERT INTO `empleado_horario` (`P_empleadoHorario`, `A_empleado`, `A_horario`) VALUES
(1, 1, 2),
(2, 2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado_sala_tarea`
--

CREATE TABLE `empleado_sala_tarea` (
  `P_empleadoSalaTarea` int(11) NOT NULL,
  `A_empleado` int(11) DEFAULT NULL,
  `A_sala` int(11) DEFAULT NULL,
  `A_tarea` int(11) DEFAULT NULL,
  `A_realizada` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `duracion` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado_sala_tarea`
--

INSERT INTO `empleado_sala_tarea` (`P_empleadoSalaTarea`, `A_empleado`, `A_sala`, `A_tarea`, `A_realizada`, `fecha`, `duracion`) VALUES
(1, 2, 6, 5, NULL, '2018-05-15', '00:20:00'),
(2, 1, 1, 3, NULL, '2018-05-28', '00:12:00'),
(3, 2, 3, 1, NULL, '2018-06-05', '00:10:00'),
(4, 3, 1, 3, NULL, '2018-06-11', '00:10:00'),
(5, 4, 2, 5, NULL, '2018-06-11', '00:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `P_horario` int(11) NOT NULL,
  `A_turno` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`P_horario`, `A_turno`, `fecha`) VALUES
(1, 2, '0000-00-00'),
(2, 3, '0000-00-00'),
(3, 1, '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

CREATE TABLE `sala` (
  `P_sala` int(11) NOT NULL,
  `nombre` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sala`
--

INSERT INTO `sala` (`P_sala`, `nombre`) VALUES
(1, 'Cocina'),
(2, 'Sala'),
(3, 'Baño'),
(4, 'Habitación 1'),
(5, 'Habitación 2'),
(6, 'Alacena'),
(7, 'Cuarto de estudio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea`
--

CREATE TABLE `tarea` (
  `P_tarea` int(11) NOT NULL,
  `texto` char(100) DEFAULT NULL,
  `duracion` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tarea`
--

INSERT INTO `tarea` (`P_tarea`, `texto`, `duracion`) VALUES
(1, 'Limpiar cristales', '00:20:00'),
(2, 'Barrer el suelo', '00:15:00'),
(3, 'Fregar el suelo', '00:15:00'),
(4, 'Lavar los platos', '00:10:00'),
(5, 'Quitar el polvo', '00:20:00'),
(6, 'Hacer la colada', '00:20:00'),
(7, 'Limpiar el baño', '00:45:00'),
(8, 'Tender la ropa', '00:05:00'),
(9, 'Planchar la ropa', '00:30:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea_realizada`
--

CREATE TABLE `tarea_realizada` (
  `P_tarea_realizada` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `pagada` tinyint(4) DEFAULT NULL,
  `duracion_min` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tarea_realizada`
--

INSERT INTO `tarea_realizada` (`P_tarea_realizada`, `fecha`, `pagada`, `duracion_min`) VALUES
(1, '2018-05-22', 0, 10),
(2, '2018-05-22', 1, 16),
(3, '2018-06-10', 0, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `P_turno` int(11) NOT NULL,
  `descripcion` enum('Mañana','Tarde','Noche') DEFAULT NULL,
  `hEntrada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `hSalida` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`P_turno`, `descripcion`, `hEntrada`, `hSalida`) VALUES
(1, 'Mañana', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Tarde', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Noche', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ausencia`
--
ALTER TABLE `ausencia`
  ADD PRIMARY KEY (`P_ausencia`);

--
-- Indices de la tabla `ausencia_empleado`
--
ALTER TABLE `ausencia_empleado`
  ADD PRIMARY KEY (`P_ausenciaEmpleado`),
  ADD KEY `A_empleado` (`A_empleado`),
  ADD KEY `A_ausencia` (`A_ausencia`);

--
-- Indices de la tabla `beacon`
--
ALTER TABLE `beacon`
  ADD PRIMARY KEY (`P_beacon`),
  ADD KEY `A_sala` (`A_sala`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`P_empleado`);

--
-- Indices de la tabla `empleado_horario`
--
ALTER TABLE `empleado_horario`
  ADD PRIMARY KEY (`P_empleadoHorario`),
  ADD KEY `A_empleado` (`A_empleado`),
  ADD KEY `A_horario` (`A_horario`);

--
-- Indices de la tabla `empleado_sala_tarea`
--
ALTER TABLE `empleado_sala_tarea`
  ADD PRIMARY KEY (`P_empleadoSalaTarea`),
  ADD KEY `A_empleado` (`A_empleado`),
  ADD KEY `A_sala` (`A_sala`),
  ADD KEY `A_tarea` (`A_tarea`),
  ADD KEY `A_realizada` (`A_realizada`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`P_horario`),
  ADD KEY `A_turno` (`A_turno`);

--
-- Indices de la tabla `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`P_sala`);

--
-- Indices de la tabla `tarea`
--
ALTER TABLE `tarea`
  ADD PRIMARY KEY (`P_tarea`);

--
-- Indices de la tabla `tarea_realizada`
--
ALTER TABLE `tarea_realizada`
  ADD PRIMARY KEY (`P_tarea_realizada`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`P_turno`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ausencia`
--
ALTER TABLE `ausencia`
  MODIFY `P_ausencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ausencia_empleado`
--
ALTER TABLE `ausencia_empleado`
  MODIFY `P_ausenciaEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `beacon`
--
ALTER TABLE `beacon`
  MODIFY `P_beacon` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `P_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `empleado_horario`
--
ALTER TABLE `empleado_horario`
  MODIFY `P_empleadoHorario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empleado_sala_tarea`
--
ALTER TABLE `empleado_sala_tarea`
  MODIFY `P_empleadoSalaTarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `P_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sala`
--
ALTER TABLE `sala`
  MODIFY `P_sala` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tarea`
--
ALTER TABLE `tarea`
  MODIFY `P_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tarea_realizada`
--
ALTER TABLE `tarea_realizada`
  MODIFY `P_tarea_realizada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `P_turno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ausencia_empleado`
--
ALTER TABLE `ausencia_empleado`
  ADD CONSTRAINT `ausencia_empleado_ibfk_1` FOREIGN KEY (`A_empleado`) REFERENCES `empleado` (`P_empleado`),
  ADD CONSTRAINT `ausencia_empleado_ibfk_2` FOREIGN KEY (`A_ausencia`) REFERENCES `ausencia` (`P_ausencia`);

--
-- Filtros para la tabla `beacon`
--
ALTER TABLE `beacon`
  ADD CONSTRAINT `beacon_ibfk_1` FOREIGN KEY (`A_sala`) REFERENCES `sala` (`P_sala`);

--
-- Filtros para la tabla `empleado_horario`
--
ALTER TABLE `empleado_horario`
  ADD CONSTRAINT `empleado_horario_ibfk_1` FOREIGN KEY (`A_empleado`) REFERENCES `empleado` (`P_empleado`),
  ADD CONSTRAINT `empleado_horario_ibfk_2` FOREIGN KEY (`A_horario`) REFERENCES `horario` (`P_horario`);

--
-- Filtros para la tabla `empleado_sala_tarea`
--
ALTER TABLE `empleado_sala_tarea`
  ADD CONSTRAINT `empleado_sala_tarea_ibfk_1` FOREIGN KEY (`A_empleado`) REFERENCES `empleado` (`P_empleado`),
  ADD CONSTRAINT `empleado_sala_tarea_ibfk_2` FOREIGN KEY (`A_sala`) REFERENCES `sala` (`P_sala`),
  ADD CONSTRAINT `empleado_sala_tarea_ibfk_3` FOREIGN KEY (`A_tarea`) REFERENCES `tarea` (`P_tarea`),
  ADD CONSTRAINT `tarea_realizada` FOREIGN KEY (`A_realizada`) REFERENCES `tarea_realizada` (`P_tarea_realizada`);

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `horario_ibfk_1` FOREIGN KEY (`A_turno`) REFERENCES `turno` (`P_turno`);
--
-- Base de datos: `desguaces`
--
CREATE DATABASE IF NOT EXISTS `desguaces` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `desguaces`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `P_Carrito` int(8) NOT NULL,
  `A_Usuario` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`P_Carrito`, `A_Usuario`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_re`
--

CREATE TABLE `car_re` (
  `P_Carre` int(8) NOT NULL,
  `A_Carrito` int(8) DEFAULT NULL,
  `A_Recambio` int(8) DEFAULT NULL,
  `Cantidad` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `car_re`
--

INSERT INTO `car_re` (`P_Carre`, `A_Carrito`, `A_Recambio`, `Cantidad`) VALUES
(1, 1, 1, 5),
(2, 1, 2, 1),
(3, 2, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentabancaria`
--

CREATE TABLE `cuentabancaria` (
  `P_CB` int(8) NOT NULL,
  `A_Usuario` int(8) DEFAULT NULL,
  `IBAN` varchar(34) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cuentabancaria`
--

INSERT INTO `cuentabancaria` (`P_CB`, `A_Usuario`, `IBAN`) VALUES
(1, 1, 'ES12 1234 1324 1234 2015'),
(2, 2, 'ES15 1234 1324 1234 2016');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desguace`
--

CREATE TABLE `desguace` (
  `P_Desguace` int(8) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Contrasenia` varchar(50) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `CIF` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `desguace`
--

INSERT INTO `desguace` (`P_Desguace`, `Nombre`, `Direccion`, `Contrasenia`, `Telefono`, `CIF`) VALUES
(1, '', '', '', '', ''),
(2, 'Desguace Becerril', 'Calle Inventada 7', '1', '942558789', '123456789C');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `P_Factura` int(8) NOT NULL,
  `Fecha` varchar(10) DEFAULT NULL,
  `A_Carrito` int(8) DEFAULT NULL,
  `A_Desguace` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`P_Factura`, `Fecha`, `A_Carrito`, `A_Desguace`) VALUES
(1, '20/05/2018', 1, 2),
(2, '4/6/2018', 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `P_Marca` int(8) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Pais` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`P_Marca`, `Nombre`, `Pais`) VALUES
(1, 'Audi', 'Alemania'),
(2, 'Mercedes', 'Alemania'),
(3, 'BMW', 'Alemania'),
(4, 'Citroen', 'Francia'),
(5, 'Fiat', 'Italia'),
(6, 'Ford', 'Estados Unidos'),
(7, 'Nissan', 'Japon'),
(8, 'Opel', 'Alemania'),
(9, 'Peugeot', 'Francia'),
(10, 'Renault', 'Francia'),
(11, 'Seat', 'España'),
(12, 'Volkswagen', 'Alemania'),
(13, 'Honda', 'Japon');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo`
--

CREATE TABLE `modelo` (
  `P_Modelo` int(8) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `A_Marca` int(8) DEFAULT NULL,
  `AnoSalida` varchar(4) DEFAULT NULL,
  `AnoExtincion` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `modelo`
--

INSERT INTO `modelo` (`P_Modelo`, `Nombre`, `A_Marca`, `AnoSalida`, `AnoExtincion`) VALUES
(1, 'A1', 1, '2010', 'Actualmente'),
(2, 'A2', 1, '2000', '2005'),
(3, 'A3', 1, '1996', '2003'),
(4, 'A3', 1, '2003', '2012'),
(5, 'A3', 1, '2012', 'Actualmente'),
(6, 'A4', 1, '1994', '2000'),
(7, 'A4', 1, '2000', '2004'),
(8, 'A4', 1, '2000', '2004'),
(9, 'A4', 1, '2004', '2008'),
(10, 'A4', 1, '2008', '2015'),
(11, 'A4', 1, '2015', 'Actualmente'),
(12, 'A5', 1, '2007', 'Actualmente'),
(13, 'A6', 1, '1994', '1997'),
(14, 'A6', 1, '1997', '2005'),
(15, 'A6', 1, '2005', '2011'),
(16, 'A6', 1, '2011', 'Actualmente'),
(17, 'A7', 1, '2010', 'Actualmente'),
(18, '190E', 2, '1982', '1993'),
(19, 'Clase A', 2, '1997', '2004'),
(20, 'Clase A', 2, '2004', '2012'),
(21, 'Clase A', 2, '2012', 'Actualmente'),
(22, 'Clase B', 2, '2005', '2011'),
(23, 'Clase B', 2, '2011', 'Actualmente'),
(24, 'Clase C', 2, '1993', '2000'),
(25, 'Clase C', 2, '2000', '2007'),
(26, 'Clase C', 2, '2007', '2014'),
(27, 'Clase C', 2, '2014', 'Actualmente'),
(28, 'Clase E', 2, '1993', '1995'),
(29, 'Clase E', 2, '1995', '2003'),
(30, 'Clase E', 2, '2002', '2009'),
(31, 'Clase E', 2, '2009', 'Actualmete'),
(32, 'Clase G', 2, '1979', '1993'),
(33, 'Clase G', 2, '1993', 'Actualmente'),
(34, 'Clase M', 2, '1998', '2005'),
(35, 'Clase M', 2, '2005', '2011'),
(36, 'Clase M', 2, '2011', 'Actualmente'),
(37, 'Clase E', 2, '1996', '2003'),
(38, 'Clase E', 2, '2003', 'Actualmente'),
(39, 'Serie 1', 3, '2004', '2012'),
(40, 'Serie 1', 3, '2010', 'Actualmente'),
(41, 'Serie 2(2002)', 3, '1966', '1977'),
(42, 'Serie 2 Coupe', 3, '2012', 'Actualmente'),
(43, 'Serie 3(E21)', 3, '1975', '1984'),
(44, 'Serie 3(E30)', 3, '1982', '1992'),
(45, 'Serie 3(E36)', 3, '1990', '1998'),
(46, 'Serie 3(E46)', 3, '1998', '2005'),
(47, 'Serie 3(E90/E92)', 3, '2005', '2011'),
(48, 'Serie 3(F30/F80)', 3, '2011', 'Actualmente'),
(49, 'Serie 4', 3, '2012', 'Actualmente'),
(50, 'Serie 5(E12)', 3, '1972', '1981'),
(51, 'Serie 5(E28)', 3, '1980', '1987'),
(52, 'Serie 5(E34)', 3, '1987', '1995'),
(53, 'Serie 5(E39)', 3, '1995', '2003'),
(54, 'Serie 5(E60)', 3, '2003', '2010'),
(55, 'Serie 5(F10)', 3, '2009', 'Actualmente'),
(56, 'Serie 6(E24)', 3, '1976', '1990'),
(57, 'Serie 6(E63)', 3, '2004', '2010'),
(58, 'Serie 6(F13)', 3, '2010', 'Actualmente'),
(59, 'C1', 4, '2004', '2014'),
(60, 'C1 II', 4, '2014', 'Actualmente'),
(61, 'C2', 4, '2003', '2009'),
(62, 'C3', 4, '2002', 'Actualmente'),
(63, 'C3 II', 4, '2009', 'Actualmente'),
(64, 'C3 III', 4, '2017', 'Actualmente'),
(65, 'C4', 4, '2004', '2011'),
(66, 'C4 II', 4, '2009', 'Hoy'),
(67, 'C5', 4, '2001', '2004'),
(68, 'C5 II', 4, '2004', 'Actualmente'),
(69, 'C5 III', 4, '2008', 'Actualmente'),
(70, 'C6', 4, '2005', 'Actualmente'),
(71, 'C8', 4, '2002', 'Actualmente'),
(72, 'DS3', 4, '2009', '2015'),
(73, 'DS4', 4, '2011', '2015'),
(74, 'DS5', 4, '2011', '2015'),
(75, 'Punto', 5, '1993', '1999'),
(76, 'Punto', 5, '1999', '2012'),
(77, 'Punto', 5, '2012', 'Actualmente'),
(78, '500', 5, '2007', 'Actualmente'),
(79, 'Panda', 5, '1980', '2004'),
(80, 'Panda', 5, '2003', 'Actualmente'),
(81, 'Panda', 5, '2012', 'Actualmente'),
(82, 'Focus', 6, '1998', '2007'),
(83, 'Focus', 6, '2007', '2012'),
(84, 'Focus', 6, '2010', 'Actualmente'),
(85, 'Fiesta', 6, '1976', '1983'),
(86, 'Fiesta', 6, '1983', '1989'),
(87, 'Fiesta', 6, '1989', '1997'),
(88, 'Fiesta', 6, '1995', '2002'),
(89, 'Fiesta', 6, '2002', 'Actualmente'),
(90, 'Fiesta', 6, '2008', 'Actualmente'),
(91, 'Escort', 6, '1968', '1976'),
(92, 'Escort', 6, '1973', '1981'),
(93, 'Escort', 6, '1980', '1986'),
(94, 'Escort', 6, '1985', '1990'),
(95, 'Escort', 6, '1990', '1992'),
(96, 'Escort', 6, '1992', '1996'),
(97, 'Escort', 6, '1995', '2002'),
(98, 'Sierra', 6, '1987', '1993'),
(99, 'Mondeo', 6, '1993', '1996'),
(100, 'Mondeo', 6, '1996', '2000'),
(101, 'Mondeo', 6, '2000', '2007'),
(102, 'Mondeo', 6, '2007', 'Actualmente'),
(103, 'Datsun 240 ', 7, '1978', '1981'),
(104, '280Z', 7, '1978', '1984'),
(105, '350Z', 7, '2002', 'Actualmente'),
(106, '370Z', 7, '2009', 'Actualmente'),
(107, 'GT-R', 7, '2007', 'Actualmente'),
(108, 'Almera', 7, '1995', '2000'),
(109, 'Mondeo', 7, '2000', 'Actualmente'),
(110, 'Patrol', 7, '1979', '1989'),
(111, 'Patrol', 7, '1994', '1998'),
(112, 'Patrol', 7, '1998', 'Actualmente'),
(113, 'Primera', 7, '1990', '1996'),
(114, 'Primera', 7, '1996', '2002'),
(115, 'Primera', 7, '2002', 'Actualmente'),
(116, 'Skyline R32', 7, '1989', '1994'),
(117, 'Skyline R33', 7, '1993', '1998'),
(118, 'Skyline R34', 7, '1998', '2002'),
(119, 'Silvia S12', 7, '1984', '1988'),
(120, 'Silvia S13/240sx/200sx', 7, '1988', '1993'),
(121, 'Silvia S14', 7, '1993', '1999'),
(122, 'Silvia S15', 7, '1999', '1992'),
(123, 'Astra F', 8, '1991', '1998'),
(124, 'Astra G', 8, '1998', '2009'),
(125, 'Astra H', 8, '2004', 'Actualmente'),
(126, 'Corsa', 8, '1982', '1993'),
(127, 'Corsa', 8, '1993', '2002'),
(128, 'Corsa', 8, '2000', '2009'),
(129, 'Corsa', 8, '2006', 'Actualmente'),
(130, 'Corsa', 8, '2014', 'Actualmente'),
(131, '106', 9, '1991', '1996'),
(132, '106', 9, '1988', '2003'),
(133, '205', 9, '1983', '1987'),
(134, '206', 9, '1998', '2013'),
(135, '206+', 9, '2009', '2013'),
(136, '208', 9, '2012', 'Actualmente'),
(137, '305', 9, '1982', '1990'),
(138, '405', 9, '1987', '1993'),
(139, '405', 9, '1992', '1999'),
(140, '306', 9, '1993', '2001'),
(141, '307', 9, '2002', 'Actualmente'),
(142, '308', 9, '2007', 'Actualmente'),
(143, '308', 9, '2013', 'Actualmente'),
(144, 'Clio I', 10, '1990', '1998'),
(145, 'Clio II', 10, '1998', '2005'),
(146, 'Clio II', 10, '2005', '2012'),
(147, 'Clio IV', 10, '2012', 'Actualmente'),
(148, 'Megane I', 10, '1995', '2004'),
(149, 'Megane II', 10, '2002', '2011'),
(150, 'Megane III', 10, '2009', '2013'),
(151, 'Megane IV', 10, '2015', 'Actualmente'),
(152, 'Laguna', 10, '1993', '2002'),
(153, 'Laguna', 10, '2001', 'Actualmente'),
(154, 'Laguna', 10, '2007', 'Actualmente'),
(155, 'Modus', 10, '2004', 'Actualmente'),
(156, 'Megane Scenic', 10, '1996', '2001'),
(157, 'Scenic I', 10, '1999', '2003'),
(158, 'Scenic II', 10, '2003', 'Actualmente'),
(159, 'Scenic III', 10, '2009', 'Actualmente'),
(160, 'Cordoba', 11, '1993', '1999'),
(161, 'Cordoba', 11, '1999', '2002'),
(162, 'Cordoba', 11, '2002', '2009'),
(163, 'Ibiza', 11, '1984', '1993'),
(164, 'Ibiza', 11, '1993', '1999'),
(165, 'Ibiza', 11, '1999', '2002'),
(166, 'Ibiza', 11, '2002', '2009'),
(167, 'Ibiza', 11, '2008', 'Actualmente'),
(168, 'Leon', 11, '1999', '2006'),
(169, 'Leon', 11, '2005', '2012'),
(170, 'Leon', 11, '2012', 'Actualmente'),
(171, 'Marbella', 11, '1986', '1998'),
(172, 'Golf MKI', 12, '1974', '1984'),
(173, 'Golf MKII', 12, '1983', '1992'),
(174, 'Golf MKIII', 12, '1991', '1997'),
(175, 'Golf MKIV', 12, '1997', '2003'),
(176, 'Golf MKV', 12, '2003', '2008'),
(177, 'Golf MKVI', 12, '2008', '2012'),
(178, 'Golf MKVII', 12, '2012', 'Actualmente'),
(179, 'Corrado', 12, '1987', '1995'),
(180, 'Scirocco', 12, '1974', '1980'),
(181, 'Scirocco', 12, '1980', '1992'),
(182, 'Scirocco', 12, '2008', 'Actualmente'),
(183, 'Passat B3', 12, '1988', '1993'),
(184, 'Passat B4', 12, '1993', '1997'),
(185, 'Passat B5', 12, '1997', '2005'),
(186, 'Passat B6', 12, '2005', '2010'),
(187, 'Passat B7', 12, '2010', '2014'),
(188, 'Passat B8', 12, '2014', 'Actualmente'),
(189, 'Polo I', 12, '1975', '1981'),
(190, 'Polo II', 12, '1981', '1994'),
(191, 'Polo III', 12, '1994', '2002'),
(192, 'Polo IV', 12, '2002', '2010'),
(193, 'Polo V', 12, '2009', 'Actualmente'),
(194, 'Polo VI', 12, '2017', 'Actualmente'),
(195, 'Accord', 13, '1976', '1981'),
(196, 'Accord', 13, '1982', '1985'),
(197, 'Accord', 13, '1986', '1989'),
(198, 'Accord', 13, '1990', '1993'),
(199, 'Accord', 13, '1994', '1997'),
(200, 'Accord', 13, '1998', '2002'),
(201, 'Accord', 13, '2003', '2007'),
(202, 'Accord', 13, '2013', 'Actualmente'),
(203, 'Civic', 13, '1973', '1979'),
(204, 'Civic', 13, '1980', '1983'),
(205, 'Civic', 13, '1984', '1987'),
(206, 'Civic', 13, '1988', '1991'),
(207, 'Civic', 13, '1992', '1995'),
(208, 'Civic', 13, '1996', '2000'),
(209, 'Civic', 13, '2000', '2005'),
(210, 'Civic', 13, '2006', '2011'),
(211, 'Civic', 13, '2012', '2015'),
(212, 'Civic', 13, '2016', 'Actualmente'),
(213, 'S2000', 13, '1999', 'Actualmente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelomotor`
--

CREATE TABLE `modelomotor` (
  `P_MM` int(8) NOT NULL,
  `A_Modelo` int(8) DEFAULT NULL,
  `A_Motor` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `modelomotor`
--

INSERT INTO `modelomotor` (`P_MM`, `A_Modelo`, `A_Motor`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motor`
--

CREATE TABLE `motor` (
  `P_Motor` int(8) NOT NULL,
  `Codigo` varchar(20) DEFAULT NULL,
  `Combustible` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `motor`
--

INSERT INTO `motor` (`P_Motor`, `Codigo`, `Combustible`) VALUES
(1, '2JC', 'Gasolina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pieza`
--

CREATE TABLE `pieza` (
  `P_Pieza` int(8) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `A_Tipo` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pieza`
--

INSERT INTO `pieza` (`P_Pieza`, `Nombre`, `A_Tipo`) VALUES
(1, 'Pinza de Freno', 1),
(2, 'Frenos de Disco', 1),
(3, 'Frenos de Tambor(Kit)', 1),
(4, 'Tubos/Latiguillos', 1),
(5, 'Anillo sensor ABS', 1),
(6, 'Liquido de Frenos', 1),
(7, 'Cable de accionamiento(Freno de estacionamiento)', 1),
(8, 'Regulador de fuerza de Frenado', 1),
(9, 'Servofreno', 1),
(10, 'Sensor ABS', 1),
(11, 'Interruptor Luces de ferno', 1),
(12, 'Zapatas de Freno', 1),
(13, 'Filtro de aceite', 2),
(14, 'Filtro de aire', 2),
(15, 'Filtro de combustible', 2),
(16, 'Filtro de aire del habitaculo', 2),
(17, 'Filtro de aceite', 2),
(18, 'Tapon de cambio de aceite', 2),
(19, 'Tapón roscado de vaciado de aceite', 2),
(20, 'Amortiguadores Delanteros', 3),
(21, 'Amortiguadores Traseros', 3),
(22, 'Muelle de chasis', 3),
(23, 'Cojinete columna suspension', 3),
(24, 'Kit de proteccion guardapolvos', 3),
(25, 'Rodamiento soporte amortiguador', 3),
(26, 'Cojinete de Rueda', 3),
(27, 'Cubo de Rueda', 3),
(28, 'Anillo Reten, Ciegüeñal', 3),
(29, 'Perno de Rueda', 3),
(30, 'Llanta de acero', 3),
(31, 'Rotula barra de acoplamiento', 3),
(32, 'Barra de acoplamiento', 3),
(33, 'Articulacion axial(Barra de acoplamiento)', 3),
(34, 'Bomba Hidarulica(Direccion)', 3),
(35, 'Engranaje de direccion', 3),
(36, 'Fuelle de direccion', 3),
(37, 'Juego de fuelles de direccion', 3),
(38, 'Fuelle de direccion(con accesorios)', 3),
(39, 'Barra Oscilante', 3),
(40, 'Rotula de suspension', 3),
(41, 'Travesaños/barras-estabilizador', 3),
(42, 'Suspension, Brazo Oscilante', 3),
(43, 'Casquillo del cojinete', 3),
(44, 'Suspension, cuerpo del eje', 3),
(45, 'Kit de embrague', 4),
(46, 'Cojinete de desembrague', 4),
(47, 'Cable de accionamiento del embrague', 4),
(48, 'Casquillo guia, embrague', 4),
(49, 'Arbol de trasmision', 4),
(50, 'Fuelle del arbol de transmision', 4),
(51, 'Suspension, arbol de transmision', 4),
(52, 'Fuelle de cardan', 4),
(53, 'Juego de articulacion(arbol)', 4),
(54, 'Anillo reten, brida caja', 4),
(55, 'Juego reapacion palanca de cambios', 4),
(56, 'Suspension caja de cambios', 4),
(57, 'Sensor revolcuion de caja automatica', 4),
(58, 'Bujia de encendido', 5),
(59, 'Bobina de encendido(Pipa)', 5),
(60, 'Correa dentada(distribucion)', 5),
(61, 'Correa del alternador', 5),
(62, 'Kit distribucion', 5),
(63, 'Kit distribucion + Bomba', 5),
(64, 'Polea del cigüeñal', 5),
(65, 'Bomba de combustible', 5),
(66, 'Suministro de aire', 5),
(67, 'Regulador de la presion del combustible', 5),
(68, 'Inyector', 5),
(69, 'Escobillla del Limpiaparabrisas', 6),
(70, 'Bomba de agua de lavado', 6),
(71, 'Motor del limpiaparabrisas', 6),
(72, 'Faro Principal', 6),
(73, 'Faro antiniebla', 6),
(74, 'Piloto posterior', 6),
(75, 'Piloto intermitente', 6),
(76, 'Elemento regulacion de faros', 6),
(77, 'Faro freno', 6),
(78, 'Enganche remolque', 6),
(79, 'Retrovisor interior', 6),
(80, 'Cristla retrovisor exterior', 6),
(81, 'Cubierta retrovisor exterior', 6),
(82, 'Soporte del escape', 7),
(83, 'Silencioso posterior', 7),
(84, 'Silencioso del medio', 7),
(85, 'Cinta de foma de escape', 7),
(86, 'Catalizador', 7),
(87, 'Sonda Lmabda', 7),
(88, 'Colector de escape', 7),
(89, 'Alternador', 8),
(90, 'Motor de arranque(Puesta en marcha)', 8),
(91, 'Polea del alternador', 8),
(92, 'Reagulador del alternador', 8),
(93, 'Bocina', 8),
(94, 'Tornillo corrector de inclinacion', 8),
(95, 'Bateria de arranque', 8),
(96, 'Cables de arranque', 8),
(97, 'Interruptor de marcha atras', 8),
(98, 'Interruptor de luz principal', 8),
(99, 'Conmutador en la columna de direccion', 8),
(100, 'Bomba de agua', 9),
(101, 'Tapon de refirgerante', 9),
(102, 'Deposito de compensacion refrigerante', 9),
(103, 'Radiador de refrigeracion', 9),
(104, 'Tubería de radiador', 9),
(105, 'Ventilador de refrigeracion', 9),
(106, 'Motor electrico, ventilador del radiador', 9),
(107, 'Interruptor de temperatura', 9),
(108, 'Termostato', 9),
(109, 'Sensor temperatura refrigerante', 9),
(110, 'Junta termostato', 9),
(111, 'Radiador de calefaccion', 10),
(112, 'Ventialdor habitaculo', 10),
(113, 'Compresor Aire acondicionado', 10),
(114, 'Condensador aire acondicionado', 10),
(115, 'Valvula de expasion aire acondicionado', 10),
(116, 'Filtro deshidratante de aire acondicionado', 10),
(117, 'Evaporador aire acondicionado', 10),
(118, 'Presostato aire acondicionado', 10),
(119, 'Valvula mezcladora', 10),
(120, 'Conducto refrigerante', 10),
(121, 'Elemento control aire acondicionado', 10),
(122, 'Tapa deposito de combustible', 11),
(123, 'Carcasa de llave', 11),
(124, 'Pila lithium', 11),
(125, 'Juegpo de cilindros de cierre', 11),
(126, 'Cerradura de puerta', 11),
(127, 'Cerradura de la puerta de maletero', 11),
(128, 'Cilindro de cierre, cerradura de encendido', 11),
(129, 'Elevalunas delantero', 11),
(130, 'Manecilla de apertura', 11),
(131, 'Muelle nuematico del maletero', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recambio`
--

CREATE TABLE `recambio` (
  `P_Recambio` int(8) NOT NULL,
  `A_Motor` int(8) DEFAULT NULL,
  `A_Pieza` int(8) DEFAULT NULL,
  `A_Desguace` int(8) DEFAULT NULL,
  `CantidadDisponible` int(2) DEFAULT NULL,
  `Precio` double(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `recambio`
--

INSERT INTO `recambio` (`P_Recambio`, `A_Motor`, `A_Pieza`, `A_Desguace`, `CantidadDisponible`, `Precio`) VALUES
(1, 1, 1, 2, 19, 50.00),
(2, 1, 14, 2, 25, 15.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `P_Tipo` int(8) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`P_Tipo`, `Nombre`) VALUES
(1, 'Frenado'),
(2, 'Filtracion'),
(3, 'Suspension-Direccion'),
(4, 'Embrague-Caja-Trasmision'),
(5, 'Compartimento Motor'),
(6, 'Equipamentos Exteriores'),
(7, 'Escape'),
(8, 'Electricidad'),
(9, 'Refrigeracion Motor'),
(10, 'Calefaccion-Climatizacion-Aire Acondicionado'),
(11, 'Cerraduras-Cierres');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `P_Usuario` int(8) NOT NULL,
  `A_Desguace` int(8) DEFAULT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Usuario` varchar(50) DEFAULT NULL,
  `Contrasena` varchar(50) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Telefono` varchar(9) DEFAULT NULL,
  `CorreoElectronico` varchar(50) DEFAULT NULL,
  `DNI` varchar(9) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`P_Usuario`, `A_Desguace`, `Nombre`, `Usuario`, `Contrasena`, `Direccion`, `Telefono`, `CorreoElectronico`, `DNI`, `Apellidos`) VALUES
(1, NULL, 'Adrian', 'adr1997', '1234', 'San camilo 8', '666123456', 'adrian@gmail.com', '74859613A', 'Iriondo Gonzalez'),
(2, 2, 'Rigoberto', 'r', '1', 'SanTiburcio 16', '942568794', 'rigoberto@gmail.com', '45698712K', 'Di Sousa');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`P_Carrito`),
  ADD KEY `A_Usuario` (`A_Usuario`);

--
-- Indices de la tabla `car_re`
--
ALTER TABLE `car_re`
  ADD PRIMARY KEY (`P_Carre`),
  ADD KEY `A_Recambio` (`A_Recambio`),
  ADD KEY `A_Carrito` (`A_Carrito`);

--
-- Indices de la tabla `cuentabancaria`
--
ALTER TABLE `cuentabancaria`
  ADD PRIMARY KEY (`P_CB`),
  ADD KEY `A_Usuario` (`A_Usuario`);

--
-- Indices de la tabla `desguace`
--
ALTER TABLE `desguace`
  ADD PRIMARY KEY (`P_Desguace`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`P_Factura`),
  ADD KEY `A_Carrito` (`A_Carrito`),
  ADD KEY `A_Desguace` (`A_Desguace`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`P_Marca`);

--
-- Indices de la tabla `modelo`
--
ALTER TABLE `modelo`
  ADD PRIMARY KEY (`P_Modelo`),
  ADD KEY `A_Marca` (`A_Marca`);

--
-- Indices de la tabla `modelomotor`
--
ALTER TABLE `modelomotor`
  ADD PRIMARY KEY (`P_MM`),
  ADD KEY `A_Modelo` (`A_Modelo`),
  ADD KEY `A_Motor` (`A_Motor`);

--
-- Indices de la tabla `motor`
--
ALTER TABLE `motor`
  ADD PRIMARY KEY (`P_Motor`);

--
-- Indices de la tabla `pieza`
--
ALTER TABLE `pieza`
  ADD PRIMARY KEY (`P_Pieza`),
  ADD KEY `A_Tipo` (`A_Tipo`);

--
-- Indices de la tabla `recambio`
--
ALTER TABLE `recambio`
  ADD PRIMARY KEY (`P_Recambio`),
  ADD KEY `A_Motor` (`A_Motor`),
  ADD KEY `A_Pieza` (`A_Pieza`),
  ADD KEY `A_Desguace` (`A_Desguace`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`P_Tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`P_Usuario`),
  ADD UNIQUE KEY `Usuario` (`Usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `P_Carrito` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `car_re`
--
ALTER TABLE `car_re`
  MODIFY `P_Carre` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cuentabancaria`
--
ALTER TABLE `cuentabancaria`
  MODIFY `P_CB` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `desguace`
--
ALTER TABLE `desguace`
  MODIFY `P_Desguace` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `P_Factura` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `P_Marca` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `modelo`
--
ALTER TABLE `modelo`
  MODIFY `P_Modelo` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=214;

--
-- AUTO_INCREMENT de la tabla `modelomotor`
--
ALTER TABLE `modelomotor`
  MODIFY `P_MM` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `motor`
--
ALTER TABLE `motor`
  MODIFY `P_Motor` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pieza`
--
ALTER TABLE `pieza`
  MODIFY `P_Pieza` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT de la tabla `recambio`
--
ALTER TABLE `recambio`
  MODIFY `P_Recambio` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `P_Tipo` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `P_Usuario` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`A_Usuario`) REFERENCES `usuario` (`P_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `car_re`
--
ALTER TABLE `car_re`
  ADD CONSTRAINT `car_re_ibfk_1` FOREIGN KEY (`A_Recambio`) REFERENCES `recambio` (`P_Recambio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `car_re_ibfk_2` FOREIGN KEY (`A_Carrito`) REFERENCES `carrito` (`P_Carrito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuentabancaria`
--
ALTER TABLE `cuentabancaria`
  ADD CONSTRAINT `cuentabancaria_ibfk_1` FOREIGN KEY (`A_Usuario`) REFERENCES `usuario` (`P_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`A_Carrito`) REFERENCES `carrito` (`P_Carrito`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`A_Desguace`) REFERENCES `desguace` (`P_Desguace`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `modelo_ibfk_1` FOREIGN KEY (`A_Marca`) REFERENCES `marca` (`P_Marca`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `modelomotor`
--
ALTER TABLE `modelomotor`
  ADD CONSTRAINT `modelomotor_ibfk_1` FOREIGN KEY (`A_Modelo`) REFERENCES `modelo` (`P_Modelo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modelomotor_ibfk_2` FOREIGN KEY (`A_Motor`) REFERENCES `motor` (`P_Motor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pieza`
--
ALTER TABLE `pieza`
  ADD CONSTRAINT `pieza_ibfk_1` FOREIGN KEY (`A_Tipo`) REFERENCES `tipo` (`P_Tipo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `recambio`
--
ALTER TABLE `recambio`
  ADD CONSTRAINT `recambio_ibfk_1` FOREIGN KEY (`A_Motor`) REFERENCES `motor` (`P_Motor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recambio_ibfk_2` FOREIGN KEY (`A_Pieza`) REFERENCES `pieza` (`P_Pieza`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recambio_ibfk_3` FOREIGN KEY (`A_Desguace`) REFERENCES `desguace` (`P_Desguace`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `jtree_category`
--
CREATE DATABASE IF NOT EXISTS `jtree_category` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `jtree_category`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

CREATE TABLE `category` (
  `catid` int(10) UNSIGNED NOT NULL,
  `catname` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `category`
--

INSERT INTO `category` (`catid`, `catname`) VALUES
(1, 'Monitor'),
(2, 'Mouse'),
(3, 'Keyboard');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategory`
--

CREATE TABLE `subcategory` (
  `scatid` int(10) UNSIGNED NOT NULL,
  `catid` int(10) UNSIGNED NOT NULL,
  `scatname` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `subcategory`
--

INSERT INTO `subcategory` (`scatid`, `catid`, `scatname`) VALUES
(1, 1, 'Samsung'),
(2, 2, 'A4Tech'),
(3, 1, 'Philips'),
(4, 2, 'Sonic'),
(5, 3, 'Perfect');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`catid`);

--
-- Indices de la tabla `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`scatid`),
  ADD KEY `FK_subcategory_1` (`catid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `category`
--
ALTER TABLE `category`
  MODIFY `catid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `subcategory`
--
ALTER TABLE `subcategory`
  MODIFY `scatid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `subcategory`
--
ALTER TABLE `subcategory`
  ADD CONSTRAINT `FK_subcategory_1` FOREIGN KEY (`catid`) REFERENCES `category` (`catid`);
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"relation_lines\":\"true\",\"snap_to_grid\":\"off\",\"angular_direct\":\"direct\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Volcado de datos para la tabla `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'table', 'chachachachi', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"allrows\":\"1\",\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@TABLE@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estructura de la tabla @TABLE@\",\"latex_structure_continued_caption\":\"Estructura de la tabla @TABLE@ (continÃºa)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Contenido de la tabla @TABLE@\",\"latex_data_continued_caption\":\"Contenido de la tabla @TABLE@ (continÃºa)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"xml_structure_or_data\":\"data\",\"xml_export_events\":\"something\",\"xml_export_functions\":\"something\",\"xml_export_procedures\":\"something\",\"xml_export_tables\":\"something\",\"xml_export_triggers\":\"something\",\"xml_export_views\":\"something\",\"xml_export_contents\":\"something\",\"yaml_structure_or_data\":\"data\",\"\":null,\"lock_tables\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}'),
(2, 'root', 'database', 'chachachachi', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"structure_or_data_forced\":\"0\",\"table_select[]\":[\"ausencia\",\"ausencia_empleado\",\"beacon\",\"empleado\",\"empleado_horario\",\"empleado_sala_tarea\",\"horario\",\"sala\",\"tarea\",\"tarea_realizada\",\"turno\"],\"table_structure[]\":[\"ausencia\",\"ausencia_empleado\",\"beacon\",\"empleado\",\"empleado_horario\",\"empleado_sala_tarea\",\"horario\",\"sala\",\"tarea\",\"tarea_realizada\",\"turno\"],\"table_data[]\":[\"ausencia\",\"ausencia_empleado\",\"beacon\",\"empleado\",\"empleado_horario\",\"empleado_sala_tarea\",\"horario\",\"sala\",\"tarea\",\"tarea_realizada\",\"turno\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@DATABASE@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estructura de la tabla @TABLE@\",\"latex_structure_continued_caption\":\"Estructura de la tabla @TABLE@ (continÃºa)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Contenido de la tabla @TABLE@\",\"latex_data_continued_caption\":\"Contenido de la tabla @TABLE@ (continÃºa)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"structure_and_data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"structure_and_data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_procedure_function\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"xml_structure_or_data\":\"data\",\"xml_export_events\":\"something\",\"xml_export_functions\":\"something\",\"xml_export_procedures\":\"something\",\"xml_export_tables\":\"something\",\"xml_export_triggers\":\"something\",\"xml_export_views\":\"something\",\"xml_export_contents\":\"something\",\"yaml_structure_or_data\":\"data\",\"\":null,\"lock_tables\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_create_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}'),
(3, 'root', 'database', 'ChachaChachi', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"structure_or_data_forced\":\"0\",\"table_select[]\":[\"ausencia\",\"ausencia_empleado\",\"beacon\",\"empleado\",\"empleado_horario\",\"empleado_sala_tarea\",\"horario\",\"sala\",\"tarea\",\"tarea_realizada\",\"turno\"],\"table_structure[]\":[\"ausencia\",\"ausencia_empleado\",\"beacon\",\"empleado\",\"empleado_horario\",\"empleado_sala_tarea\",\"horario\",\"sala\",\"tarea\",\"tarea_realizada\",\"turno\"],\"table_data[]\":[\"ausencia\",\"ausencia_empleado\",\"beacon\",\"empleado\",\"empleado_horario\",\"empleado_sala_tarea\",\"horario\",\"sala\",\"tarea\",\"tarea_realizada\",\"turno\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@DATABASE@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estructura de la tabla @TABLE@\",\"latex_structure_continued_caption\":\"Estructura de la tabla @TABLE@ (continÃºa)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Contenido de la tabla @TABLE@\",\"latex_data_continued_caption\":\"Contenido de la tabla @TABLE@ (continÃºa)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"structure_and_data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"structure_and_data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_procedure_function\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"xml_structure_or_data\":\"data\",\"xml_export_events\":\"something\",\"xml_export_functions\":\"something\",\"xml_export_procedures\":\"something\",\"xml_export_tables\":\"something\",\"xml_export_triggers\":\"something\",\"xml_export_views\":\"something\",\"xml_export_contents\":\"something\",\"yaml_structure_or_data\":\"data\",\"\":null,\"lock_tables\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_create_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}'),
(4, 'root', 'server', 'chachaChachi', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"chachachachi\",\"desguaces\",\"jtree_category\",\"phpmyadmin\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estructura de la tabla @TABLE@\",\"latex_structure_continued_caption\":\"Estructura de la tabla @TABLE@ (continÃºa)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Contenido de la tabla @TABLE@\",\"latex_data_continued_caption\":\"Contenido de la tabla @TABLE@ (continÃºa)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__pdf_pages`
--

INSERT INTO `pma__pdf_pages` (`db_name`, `page_nr`, `page_descr`) VALUES
('chachachachi', 2, 'ChachaChachi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

--
-- Volcado de datos para la tabla `pma__table_coords`
--

INSERT INTO `pma__table_coords` (`db_name`, `table_name`, `pdf_page_number`, `x`, `y`) VALUES
('chachachachi', 'ausencia', 2, 912, 150),
('chachachachi', 'ausencia_empleado', 2, 986, 146),
('chachachachi', 'beacon', 2, 48, 194),
('chachachachi', 'empleado', 2, 556, 57),
('chachachachi', 'empleado_horario', 2, 967, 182),
('chachachachi', 'empleado_sala_tarea', 2, 538, 234),
('chachachachi', 'horario', 2, 901, 174),
('chachachachi', 'sala', 2, 270, 251),
('chachachachi', 'tarea', 2, 335, 390),
('chachachachi', 'tarea_realizada', 2, 535, 435),
('chachachachi', 'turno', 2, 926, 152);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'chachachachi', 'ausencia_empleado', '{\"sorted_col\":\"`ausencia_empleado`.`P_ausenciaEmpleado` ASC\"}', '2018-05-16 13:20:48'),
('root', 'chachachachi', 'empleado_sala_tarea', '[]', '2018-05-21 12:34:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2018-06-11 13:23:15', '{\"lang\":\"es\",\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
