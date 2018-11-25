-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 25-11-2018 a las 06:08:57
-- Versión del servidor: 5.7.19
-- Versión de PHP: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ecommerce_db`
--
CREATE DATABASE IF NOT EXISTS `ecommerce_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ecommerce_db`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_consultarProducto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarProducto` (`p_moneda` CHAR(3), `p_webid` INT)  begin
    if p_moneda<>'MXN' then
        select p.*,pm.precio as precio2, pm.precio_nuevo as precioNuevo2 from tbl_producto p 
        inner join tb_producto_moneda pm on pm.webid=p.webid
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true and pm.moneda=p_moneda
        and p.webid=p_webid;
    else
        select p.* from tbl_producto p 
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true
        and p.webid=p_webid;
    end if;
end$$

DROP PROCEDURE IF EXISTS `sp_contarProductosPorMarca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_contarProductosPorMarca` (`p_codMar` INT)  begin
   select count(*) from tbl_producto where codigo_marca=p_codMar;
end$$

DROP PROCEDURE IF EXISTS `sp_contar_categorias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_contar_categorias` (IN `cod_cat` INT)  begin
    select count(*) as "cantidad" from tbl_categoria 
    where categoria_superior=cod_cat and
    codigo<>cod_cat;
end$$

DROP PROCEDURE IF EXISTS `sp_listarProductosActivos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarProductosActivos` (`p_moneda` CHAR(3))  begin
    if p_moneda<>'MXN' then
        select p.*,pm.precio as precio2, pm.precio_nuevo as precioNuevo2 from tbl_producto p 
        inner join tb_producto_moneda pm on pm.webid=p.webid
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true and pm.moneda=p_moneda;
    else
        select p.* from tbl_producto p 
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true;
    end if;
end$$

DROP PROCEDURE IF EXISTS `sp_listarProductosPorCategoria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarProductosPorCategoria` (`p_moneda` CHAR(3), `p_codCat` INT)  begin
    if p_moneda<>'MXN' then
        select p.*,pm.precio as precio2, pm.precio_nuevo as precioNuevo2 from tbl_producto p 
        inner join tb_producto_moneda pm on pm.webid=p.webid
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true and pm.moneda=p_moneda
        and p.codigo_categoria=p_codCat;
    else
        select p.* from tbl_producto p 
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true
        and p.codigo_categoria=p_codCat;
    end if;
end$$

DROP PROCEDURE IF EXISTS `sp_listarProductosPorMarca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarProductosPorMarca` (`p_moneda` CHAR(3), `p_codMar` INT)  begin
    if p_moneda<>'MXN' then
        select p.*,pm.precio as precio2, pm.precio_nuevo as precioNuevo2 from tbl_producto p 
        inner join tb_producto_moneda pm on pm.webid=p.webid
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true and pm.moneda=p_moneda
        and p.codigo_marca=p_codMar;
    else
        select p.* from tbl_producto p 
        inner join tbl_marca marca on marca.codigo=p.codigo_marca
        inner join tbl_Categoria c on c.codigo=p.codigo_categoria
        where p.estado=true and c.estado=true and marca.estado=true
        and p.codigo_marca=p_codMar;
    end if;
end$$

DROP PROCEDURE IF EXISTS `sp_listar_categorias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_categorias` ()  begin
    select codigo,nombre from tbl_categoria where estado=true
    order by nombre;
end$$

DROP PROCEDURE IF EXISTS `sp_listar_categoria_superior`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_categoria_superior` ()  begin
    select codigo,nombre from tbl_categoria where codigo=categoria_superior and estado=true;
end$$

DROP PROCEDURE IF EXISTS `sp_listar_marcas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_marcas` ()  begin
    select codigo,nombre from tbl_marca where estado=true;
end$$

DROP PROCEDURE IF EXISTS `sp_listar_sub_categoria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_sub_categoria` (`p_csuperior` INT)  begin
    select codigo,nombre from tbl_categoria 
    where codigo<>categoria_superior and estado=true
    and categoria_superior=p_csuperior;
end$$

DROP PROCEDURE IF EXISTS `sp_registrar_producto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_producto` (`p_nombre` VARCHAR(30), `p_precio` DECIMAL(10,2), `p_precio_nuevo` DECIMAL(10,2), `p_stock` INT, `p_nuevo` BOOLEAN, `p_recomendado` BOOLEAN, `p_descripcion` VARCHAR(250), `p_estado` BOOLEAN, `p_codigo_marca` INT, `p_codigo_categoria` INT, `p_imagen` VARCHAR(200), `p_moneda_cop` CHAR(3), `p_precio_cop` DECIMAL(10,2), `p_precio_nuevo_cop` DECIMAL(10,2), `p_moneda_usd` CHAR(3), `p_precio_usd` DECIMAL(10,2), `p_precio_nuevo_usd` DECIMAL(10,2), `p_moneda_pen` CHAR(3), `p_precio_pen` DECIMAL(10,2), `p_precio_nuevo_pen` DECIMAL(10,2))  begin
    declare v_webid int;
    insert into tbl_producto values(
    null, 
    p_nombre,
    p_precio,
    p_precio_nuevo,
    p_stock,
    p_nuevo,
    p_recomendado,
    p_descripcion,
    p_estado,
    p_codigo_marca,
    p_codigo_categoria,
    p_imagen);

    set v_webid=(select last_insert_id());

    insert into tb_producto_moneda values(p_moneda_cop,p_precio_cop,p_precio_nuevo_cop,v_webid);   
    insert into tb_producto_moneda values(p_moneda_usd,p_precio_usd,p_precio_nuevo_usd,v_webid);
    insert into tb_producto_moneda values(p_moneda_pen,p_precio_pen,p_precio_nuevo_pen,v_webid);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_categoria`
--

DROP TABLE IF EXISTS `tbl_categoria`;
CREATE TABLE IF NOT EXISTS `tbl_categoria` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `categoria_superior` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `categoria_superior` (`categoria_superior`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_categoria`
--

INSERT INTO `tbl_categoria` (`codigo`, `nombre`, `estado`, `categoria_superior`) VALUES
(1, 'ROPA DEPORTIVA', 1, 1),
(2, 'NIKE', 1, 1),
(3, 'ADIDAS', 1, 1),
(4, 'PUMA', 1, 1),
(5, 'HOMBRES', 1, 5),
(6, 'SACO', 1, 5),
(7, 'PANTALON', 1, 5),
(8, 'NIÑOS', 1, 8),
(9, 'MUJERES', 1, 9),
(10, 'CAMISA', 1, 5),
(11, 'CASACA', 1, 1),
(12, 'FALDA', 1, 1),
(13, 'POLERAS', 1, 5),
(14, 'BUZOS', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_marca`
--

DROP TABLE IF EXISTS `tbl_marca`;
CREATE TABLE IF NOT EXISTS `tbl_marca` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_marca`
--

INSERT INTO `tbl_marca` (`codigo`, `nombre`, `estado`) VALUES
(1, 'NIKE', 1),
(2, 'PUMA', 1),
(3, 'ADIDAS', 1),
(4, 'LACOSTE', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_producto`
--

DROP TABLE IF EXISTS `tbl_producto`;
CREATE TABLE IF NOT EXISTS `tbl_producto` (
  `webid` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precio_nuevo` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT '1',
  `nuevo` tinyint(1) DEFAULT '1',
  `recomendado` tinyint(1) DEFAULT '0',
  `descripcion` varchar(250) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `codigo_marca` int(11) DEFAULT NULL,
  `codigo_categoria` int(11) DEFAULT NULL,
  `imagen` varchar(200) DEFAULT 'demo.jpg',
  PRIMARY KEY (`webid`),
  KEY `codigo_marca` (`codigo_marca`),
  KEY `codigo_categoria` (`codigo_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_producto`
--

INSERT INTO `tbl_producto` (`webid`, `nombre`, `precio`, `precio_nuevo`, `stock`, `nuevo`, `recomendado`, `descripcion`, `estado`, `codigo_marca`, `codigo_categoria`, `imagen`) VALUES
(11, 'camisa manga corta de flores', '10.00', '0.00', 0, 1, 1, 'camisa manga corta floreada de algodon', 0, 4, 5, '2411201808023023410700165251202509.jpg'),
(12, 'polo rosado para dama', '21.00', '0.00', 0, 1, 1, 'bla blabla', 1, 3, 1, '24112018081017-9094836647191668943CZ8006_000_plp_model.jpg'),
(13, 'cami buzo nike', '70.00', '0.00', 50, 1, 1, 'cami buzo nike', 1, 1, 13, '241120180246064156289490096382981pro4.jpg'),
(14, 'polera puma l230', '50.00', '0.00', 15, 0, 1, 'polera puma l230 de algodon', 1, 2, 11, '241120180248405878890832625071004pu4.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_revision`
--

DROP TABLE IF EXISTS `tbl_revision`;
CREATE TABLE IF NOT EXISTS `tbl_revision` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `correo` varchar(60) DEFAULT NULL,
  `comentario` varchar(200) DEFAULT NULL,
  `estrellas` int(11) DEFAULT '3',
  `fecha` datetime DEFAULT NULL,
  `webid` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `webid` (`webid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_producto_moneda`
--

DROP TABLE IF EXISTS `tb_producto_moneda`;
CREATE TABLE IF NOT EXISTS `tb_producto_moneda` (
  `moneda` char(3) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precio_nuevo` decimal(10,2) DEFAULT NULL,
  `webid` int(11) NOT NULL,
  PRIMARY KEY (`moneda`,`webid`),
  KEY `webid` (`webid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_producto_moneda`
--

INSERT INTO `tb_producto_moneda` (`moneda`, `precio`, `precio_nuevo`, `webid`) VALUES
('COP', '20.00', '0.00', 11),
('COP', '30.00', '0.00', 12),
('COP', '20.00', '0.00', 13),
('COP', '40.00', '0.00', 14),
('PEN', '10.00', '0.00', 11),
('PEN', '10.00', '0.00', 12),
('PEN', '10.00', '0.00', 13),
('PEN', '20.00', '0.00', 14),
('USD', '70.00', '0.00', 11),
('USD', '50.00', '0.00', 12),
('USD', '30.00', '0.00', 13),
('USD', '86.00', '0.00', 14);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  ADD CONSTRAINT `tbl_categoria_ibfk_1` FOREIGN KEY (`categoria_superior`) REFERENCES `tbl_categoria` (`codigo`);

--
-- Filtros para la tabla `tbl_producto`
--
ALTER TABLE `tbl_producto`
  ADD CONSTRAINT `tbl_producto_ibfk_1` FOREIGN KEY (`codigo_marca`) REFERENCES `tbl_marca` (`codigo`),
  ADD CONSTRAINT `tbl_producto_ibfk_2` FOREIGN KEY (`codigo_categoria`) REFERENCES `tbl_categoria` (`codigo`);

--
-- Filtros para la tabla `tbl_revision`
--
ALTER TABLE `tbl_revision`
  ADD CONSTRAINT `tbl_revision_ibfk_1` FOREIGN KEY (`webid`) REFERENCES `tbl_producto` (`webid`);

--
-- Filtros para la tabla `tb_producto_moneda`
--
ALTER TABLE `tb_producto_moneda`
  ADD CONSTRAINT `tb_producto_moneda_ibfk_1` FOREIGN KEY (`webid`) REFERENCES `tbl_producto` (`webid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
