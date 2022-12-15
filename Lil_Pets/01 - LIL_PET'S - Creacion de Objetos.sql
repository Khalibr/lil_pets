
/* 
PROYECTO FINAL - VETERINARIA

• Esquema de bases de datos - Veterinaria & PetShop 'Lil Pet's
• Alumno: Julian Alejandro Medina
• Comisión: #3496
• Profesor: Cesar Aracena
• Tutor: Sergio Occhipinti

*/


-- DROP DE LA BD SI EXISTE
DROP SCHEMA IF EXISTS `Lil_Pets`;

-- CREACION DE LA BD
CREATE SCHEMA IF NOT EXISTS `Lil_Pets`;

-- USO DE LA BD
USE `Lil_Pets`;


-- *************************************************************
-- * Inicio de la creacion de ENTIDADES para la bd `LIL_PET'S` *
-- *************************************************************

-- Estructura para la tabla `CLIENTE`
CREATE TABLE IF NOT EXISTS `CLIENTE`(
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	DNI VARCHAR(50) NOT NULL,
	domicilio VARCHAR(50) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	PRIMARY KEY(ID)
);


-- Estructura para la tabla `MASCOTA`
CREATE TABLE IF NOT EXISTS `MASCOTA`(
	ID INT NOT NULL AUTO_INCREMENT,
	IDCliente INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	edad DATE NOT NULL,
	especie VARCHAR(50) NOT NULL,
	raza VARCHAR(50) NOT NULL,
	sexo VARCHAR(20) NOT NULL,
	peso DECIMAL(6,3) NOT NULL,
	descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_cliente_mascota FOREIGN KEY(IDCliente) REFERENCES CLIENTE(ID) ON DELETE CASCADE
);


-- Estructura para la tabla `CATEGORIA_EMPLEADO`
CREATE TABLE IF NOT EXISTS `CATEGORIA_EMPLEADO`(
	IDEmpleado INT NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(IDEmpleado)
);


-- Estructura para la tabla `EMPLEADO`
CREATE TABLE IF NOT EXISTS `EMPLEADO`(
	ID INT NOT NULL AUTO_INCREMENT,
	IDCategoria INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	sexo VARCHAR(20) NOT NULL,
	DNI VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	fechaNac DATE NOT NULL,
	salario DECIMAL(8,2) NOT NULL,
	fechaIngreso DATE NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_categoria_empleado FOREIGN KEY(IDCategoria)
	REFERENCES CATEGORIA_EMPLEADO(IDEmpleado) ON DELETE CASCADE
);


-- Estructura para la tabla `SERVICIO`
CREATE TABLE IF NOT EXISTS `SERVICIO`(
	ID INT NOT NULL AUTO_INCREMENT,
	area VARCHAR(50) NOT NULL,
	servicio VARCHAR(50) NOT NULL,
	costo DECIMAL(8,2) NOT NULL,
	descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(ID)
);


-- Estructura para la tabla `SERVICIO_SOLICITADO`
CREATE TABLE IF NOT EXISTS `SERVICIO_SOLICITADO`(
	ID INT NOT NULL AUTO_INCREMENT,
	IDServicio INT NOT NULL,
	IDMascota INT NOT NULL,
	IDEmpleado INT NOT NULL,
	fechahora DATETIME NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_servicio_s_solicitado FOREIGN KEY(IDServicio) REFERENCES SERVICIO(ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_mascota_s_solicitado FOREIGN KEY(IDMascota) REFERENCES MASCOTA(ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_empleado_s_solicitado FOREIGN KEY(IDEmpleado) REFERENCES EMPLEADO(ID) ON DELETE CASCADE
);


-- Estructura para la tabla `HISTORIAL`
CREATE TABLE IF NOT EXISTS `HISTORIAL`(
	ID INT NOT NULL AUTO_INCREMENT,
	IDMascota INT NOT NULL,
	diagnostico VARCHAR(140) NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_mascota_historial FOREIGN KEY(IDMascota) REFERENCES MASCOTA(ID) ON DELETE CASCADE
);


-- Estructura para la tabla `PEDIDO`
CREATE TABLE IF NOT EXISTS `PEDIDO`(
	ID INT NOT NULL AUTO_INCREMENT,
	IDCliente INT NOT NULL,
	fechahora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_cliente_pedido FOREIGN KEY(IDCliente) REFERENCES CLIENTE(ID) ON DELETE CASCADE
);


-- Estructura para la tabla `CATEGORIA_PRODUCTO`
CREATE TABLE IF NOT EXISTS `CATEGORIA_PRODUCTO`(
	IDProducto INT NOT NULL AUTO_INCREMENT,
	descripcion VARCHAR(50) NOT NULL,
	PRIMARY KEY(IDProducto)
);


-- Estructura para la tabla `PROVEEDOR`
CREATE TABLE IF NOT EXISTS `PROVEEDOR`(
	ID INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	DNI VARCHAR(50) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	web VARCHAR(50) NOT NULL,
	PRIMARY KEY(ID)
);


-- Estructura para la tabla `SUBCATEGORIA_PRODUCTO`
CREATE TABLE IF NOT EXISTS `SUBCATEGORIA_PRODUCTO`(
	ID INT NOT NULL AUTO_INCREMENT,
	especieEdad VARCHAR(50) NOT NULL,
	descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(ID)
);


-- Estructura para la tabla `PRODUCTO`
CREATE TABLE IF NOT EXISTS `PRODUCTO`(
	ID INT NOT NULL AUTO_INCREMENT,    
	descripcion VARCHAR(140) NOT NULL,
	IDCategoria INT NOT NULL,
	IDSubcategoria INT NOT NULL,
	precioUnitario DECIMAL(11,2) NOT NULL,
	IDProveedor INT NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_categoria_producto FOREIGN KEY(IDCategoria) REFERENCES CATEGORIA_PRODUCTO(IDProducto) ON DELETE CASCADE,
	CONSTRAINT fk_id_proveedor_producto FOREIGN KEY(IDProveedor) REFERENCES PROVEEDOR(ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_subcategoria_producto FOREIGN KEY(IDSubcategoria) REFERENCES SUBCATEGORIA_PRODUCTO(ID) ON DELETE CASCADE
);


-- Estructura para la tabla `DETALLE_VENTA`
CREATE TABLE IF NOT EXISTS `DETALLE_VENTA`(
	ID INT NOT NULL AUTO_INCREMENT,
	IDPedido INT NOT NULL,
	IDProducto INT NOT NULL,
	cantidad INT NOT NULL,
	subtotal DECIMAL(11,2) NOT NULL,
	recargo INT NOT NULL,
	total DECIMAL(11,2) NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT fk_id_pedido_d_venta FOREIGN KEY(IDPedido) REFERENCES PEDIDO(ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_producto_d_venta FOREIGN KEY(IDProducto) REFERENCES PRODUCTO(ID) ON DELETE CASCADE
);




-- ***********************************************************************
-- * Inicio de la creacion de tablas de AUDITORIA para la bd `LIL_PET'S` *
-- ***********************************************************************

-- CREACION DE LA TABLA "LOG_DETALLE_VENTA" DEL TRIGGER
CREATE TABLE IF NOT EXISTS  `log_detalle_venta`
(
	log_evento VARCHAR(50),
	log_IDVenta INT,
	log_IDPedido INT,
	log_subtotal DECIMAL(11,2),
	log_recargo INT,
	log_total DECIMAL(11,2),
	log_usuario VARCHAR(50),
	log_fechahora TIMESTAMP,
    PRIMARY KEY (log_IDVenta)
);


-- CREACION DE LA TABLA "LOG_SERVICIO_SOLICITADO" DEL TRIGGER
CREATE TABLE IF NOT EXISTS `log_servicio_solicitados`
(
	log_evento VARCHAR(50),
	log_ID INT,
	log_IDServicio INT,
	log_IDMascota INT,
	log_IDEmpleado INT,
	log_fechahora_cita DATETIME,
	log_usuario VARCHAR(50),
	log_fechahora TIMESTAMP,
	PRIMARY KEY(log_ID)
);


-- CREACION DE LA TABLA "LOG_PRECIO_ANTIGUO" PARA EL TRIGGER
CREATE TABLE IF NOT EXISTS `log_precio_antiguo`
(
	log_evento VARCHAR(50),
	log_IDProducto INT,
	log_IDCategoria INT,
	log_precioAntiguo DECIMAL(11,2),
	log_usuario VARCHAR(50),
	log_fechahora TIMESTAMP,
	PRIMARY KEY(log_IDProducto)
);



-- *************************************************************
-- * Inicio de la creacion de FUNCIONES para la bd `LIL_PET'S` *
-- *************************************************************

DELIMITER $$

DROP FUNCTION IF EXISTS `f_concat_nombre_completo`$$

-- FUNCION: concatena nombre y apellido
CREATE FUNCTION `f_concat_nombre_completo` (nombre VARCHAR (50), apellido VARCHAR (50)) RETURNS VARCHAR (50)
DETERMINISTIC
BEGIN
	DECLARE retorno VARCHAR(50);
	SET retorno = CONCAT_WS(' ',nombre,apellido);
	RETURN retorno;
END$$

-- *******************************************
DROP FUNCTION IF EXISTS `f_calcular_recargo`$$

-- FUNCION: calcula el iva 
CREATE FUNCTION `f_calcular_recargo` (subtotal DECIMAL(11,2),recargo INT) RETURNS DECIMAL(11,2)
NO SQL
BEGIN
	DECLARE retorno DECIMAL(11,2);
	SET retorno = subtotal * ((recargo/100) + 1);
	RETURN retorno;
END$$

-- *****************************************
DROP FUNCTION IF EXISTS `f_concat_precios`$$

-- FUNCION: concatena el simbolo `$` a los precios
CREATE FUNCTION `f_concat_precio` (precio DECIMAL(11,2)) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE retorno VARCHAR(50);
	SET retorno = CONCAT('$ ',precio);
	RETURN retorno;
END$$


-- ********************************************
DROP FUNCTION IF EXISTS `f_calcular_subtotal`$$

-- FUNCION: calcula el subtotal pasando por referencia los campos de producto y cantidad
CREATE FUNCTION `f_calcular_subtotal`(producto INT,cantidad INT) RETURNS DECIMAL(11,2)
DETERMINISTIC
BEGIN
	DECLARE total DECIMAL(11,2);
	SET total = (
		SELECT precioUnitario * cantidad
		FROM PRODUCTO
		WHERE ID = producto
	);
	RETURN total;
END$$

DELIMITER ;



-- *************************************************************
-- * Inicio de la creacion de VISTAS para la bd `LIL_PET'S` *
-- *************************************************************

-- VISTA DE LOS PRODUCTOS MAS VENDIDOS
CREATE OR REPLACE VIEW `vendido_view` AS
(
	SELECT
		d.IDProducto AS item,
		p.descripcion AS producto,
		SUM(d.cantidad) AS cantidad,
        f_calcular_subtotal(p.ID,SUM(d.cantidad)) AS "total sin recargo",
        f_calcular_recargo(f_calcular_subtotal(p.ID,SUM(d.cantidad)),d.recargo) AS "total con recargo"
	FROM
		DETALLE_VENTA AS d
	JOIN
		PRODUCTO AS p ON (p.ID = d.IDProducto)
	GROUP BY
		IDPRODUCTO
	ORDER BY
		cantidad DESC
	LIMIT 5
);


-- VISTA DE LOS PRODUCTOS PARA GATO ADULTO
CREATE OR REPLACE VIEW `productos_gatos_view` AS
(
	SELECT
		p.descripcion AS item,
		catpro.descripcion AS 'categoria producto',
		a.especieEdad AS 'subcategoria producto',
		f_concat_precio(p.precioUnitario) AS costo
	FROM
		PRODUCTO AS p
	JOIN
		CATEGORIA_PRODUCTO AS catpro ON (catpro.IDProducto = p.IDCategoria)
	JOIN
		SUBCATEGORIA_PRODUCTO AS a ON (a.ID = p.IDSubcategoria)
	WHERE
		a.especieEdad LIKE upper('%gat%')
	ORDER BY
		catpro.descripcion ASC,
		a.especieEdad DESC
);


-- VISTA DE LOS PRODUCTOS PARA PERROS
CREATE OR REPLACE VIEW `productos_perros_view` AS
(
	SELECT
		p.descripcion AS item,
		catpro.descripcion AS 'categoria producto',
		a.especieEdad AS 'subcategoria producto',
		f_concat_precio(p.precioUnitario) AS costo
	FROM
		PRODUCTO AS p
	JOIN
		SUBCATEGORIA_PRODUCTO AS a ON (a.ID = p.IDSubcategoria)
	JOIN
		CATEGORIA_PRODUCTO AS catpro ON (catpro.IDProducto = p.IDCategoria)
	WHERE
		a.especieEdad LIKE upper('%perr%')
        OR a.especieEdad LIKE upper('%cach%')
	ORDER BY
		catpro.descripcion ASC,
		a.especieEdad DESC
);


-- VISTA DE LAS MASCOTAS ASOCIADAS CON SU DUEÑO
CREATE OR REPLACE VIEW `cliente_mascotas_view` AS
(
	SELECT
		f_concat_nombre_completo(c.nombre,c.apellido) AS "nombre completo cliente",
		m.nombre AS mascota,
		m.especie AS especie
	FROM
		CLIENTE AS c
	JOIN
		MASCOTA as m ON (c.ID = m.IDCliente)
);


-- VISTA DEL TOP 10 DE LOS CLIENTES QUE MAS COMPRARON
CREATE OR REPLACE VIEW `top10_clientes_view` AS
(
	SELECT
		c.ID AS ID,
		f_concat_nombre_completo(c.nombre,c.apellido) AS "nombre completo cliente",
		COUNT(p.IDCliente) AS compras_realizadas
	FROM
		CLIENTE AS c
	JOIN
		PEDIDO AS p ON (c.ID = p.IDCliente)
	GROUP BY
		p.IDCliente
	ORDER BY
		compras_realizadas DESC
	LIMIT 10
);


-- VISTA CON MULTIPLE JOIN'S DE LA TABLA `PRODUCTO`
CREATE OR REPLACE VIEW `productos_view` AS
(
	SELECT
		p.ID as item,
		p.descripcion AS descripcion,
		c.descripcion AS categoria,
		a.especieEdad AS para,
		f_concat_precio(p.precioUnitario) AS costo,
		pr.nombre AS proveedor        
	FROM
		PRODUCTO AS p
	JOIN
		CATEGORIA_PRODUCTO AS c ON (p.IDCategoria = c.IDProducto)
	JOIN
		PROVEEDOR AS pr ON (p.IDProveedor = pr.ID)
	JOIN
		SUBCATEGORIA_PRODUCTO AS a ON (p.IDSubcategoria = a.ID)
	WHERE
		p.ID
	ORDER BY
		p.ID ASC
);


-- VISTA CON MULTIPLES JOIN'S DE LOS SERVICIOS SOLICITADOS
CREATE OR REPLACE VIEW `servicios_solicitados_view` AS
(
	SELECT
		soli.ID AS "id solicitud",
		serv.servicio AS servis,
        serv.ID AS "id servicio",
		serv.costo AS precio,
		m.nombre AS mascota,
		m.raza AS raza,
		f_concat_nombre_completo(c.nombre,c.apellido) AS cliente,
		f_concat_nombre_completo(e.nombre,e.apellido) AS empleado,
		cat.descripcion AS categoria_empleado,
		soli.fechahora AS fecha_hora,
		serv.descripcion AS descripcion
	FROM
		SERVICIO_SOLICITADO AS soli
	JOIN
		MASCOTA AS m ON (m.ID = soli.IDMascota)
	JOIN
		SERVICIO AS serv ON (serv.ID = soli.IDServicio)
	JOIN
		EMPLEADO AS e ON (e.ID = soli.IDEmpleado)
	JOIN
		CLIENTE AS c ON (c.ID = m.IDCliente)
	JOIN
		CATEGORIA_EMPLEADO AS cat ON (e.IDCategoria = cat.IDEmpleado)
);


-- VISTA DE LOS 5 SERVICIOS MAS SOLICITADOS
CREATE OR REPLACE VIEW `servicios_mas_solicitados_view` AS
(
	SELECT
		serv.ID AS ID,
		serv.servicio AS Servis,
		COUNT(soli.IDServicio) AS cantidad
	FROM
		SERVICIO AS serv
	JOIN
		SERVICIO_SOLICITADO AS soli ON (soli.IDServicio = serv.ID)
	GROUP BY
		soli.IDServicio
	ORDER BY
		cantidad DESC
	LIMIT 5
);


-- VISTA DE LA GANANCIA MENSUAL DE PRODUCTOS VENDIDOS DURANTE EL AÑO 2022
CREATE OR REPLACE VIEW `ganancias_x_mes_view` AS
(
	SELECT
		MONTHNAME(p.fechahora) AS mes,
		SUM(d.total - d.subtotal) AS ganancia
	FROM
		PEDIDO AS p
	JOIN
		DETALLE_VENTA AS d ON (d.IDPedido = p.ID)
	WHERE
		YEAR(p.fechahora) = '2022'
	GROUP BY
		mes
	ORDER BY
		mes ASC
);


-- VISTA DE GANANCIAS MENSUALES DE LOS SERVICIOS REALIZADOS DEL AÑO 2022
CREATE OR REPLACE VIEW `ganancia_servicios_view` AS
(
	SELECT
		MONTHNAME(soli.fechahora) AS mes,
		SUM(serv.costo) AS ganancia,
		COUNT(soli.IDServicio) AS 'cantidad solicitados'
	FROM
		SERVICIO AS serv
	JOIN
		SERVICIO_SOLICITADO AS soli ON (soli.IDServicio = serv.ID)
	WHERE
		YEAR(soli.fechahora) = '2022'
	GROUP BY
		mes
	ORDER BY
		mes DESC
);



-- *********************************************************************
-- * Inicio de la creacion de STORED PROCEDURES para la bd `LIL_PET'S` *
-- *********************************************************************

DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_ordenar_productos`$$

-- SP que ordena los productos segun el parametro que se le indique y en que orden (ASC/DESC)
CREATE PROCEDURE `sp_ordenar_productos` (IN campo VARCHAR(20), IN orden VARCHAR(4))
BEGIN
	-- concatenacion del ordenamiento
	IF LENGTH(campo) > 0 THEN 
		SET @orden_productos = CONCAT_WS(' ','ORDER BY',campo,orden);
	ELSE
		SET @orden_productos = '';
	END IF;
    
    -- clausula del select
    SET @clausula = CONCAT_WS(' ','SELECT * FROM PRODUCTO', @orden_productos);
    
    -- ejecución de la query
    PREPARE ejecutar FROM @clausula;
    EXECUTE ejecutar;
    DEALLOCATE PREPARE ejecutar;
    
END$$


-- **********************************************
DROP PROCEDURE IF EXISTS `sp_insert_new_client`$$

-- SP para insertar datos de un nuevo cliente
CREATE PROCEDURE `sp_insert_new_client` (IN sp_ID INT, IN sp_nombre VARCHAR(50), IN sp_apellido VARCHAR(50), IN sp_DNI VARCHAR(50), IN sp_domicilio VARCHAR(50),  IN sp_telefono VARCHAR(20),  IN sp_email VARCHAR(50))
BEGIN
	INSERT INTO `CLIENTE` (ID, nombre, apellido, DNI, domicilio, telefono, email)
		VALUES
			(sp_ID, sp_nombre, sp_apellido, sp_DNI, sp_domicilio, sp_telefono, sp_email);
END$$


-- ********************************************
DROP PROCEDURE IF EXISTS `sp_delete_client`$$

-- SP para eliminar un cliente de los registros
CREATE PROCEDURE `sp_delete_client` (IN sp_ID INT)
BEGIN
	DELETE
	FROM
		CLIENTE
	WHERE
		ID = sp_ID;
END$$



-- *************************************************************************
-- * Inicio de la creacion de TRIGGERS para la bd `LIL_PET'S` *
-- *************************************************************************

DROP TRIGGER IF EXISTS `tr_detalle_venta`$$

-- CREACION DEL TRIGGER
CREATE TRIGGER `tr_detalle_venta`
AFTER INSERT ON `DETALLE_VENTA`
FOR EACH ROW
BEGIN
	INSERT INTO `log_detalle_venta`
		VALUES
		('Nueva venta',NEW.ID, NEW.IDPedido, NEW.Subtotal, NEW.recargo, NEW.total, SESSION_USER(), CURRENT_TIMESTAMP());
END$$


-- ************************************************
DROP TRIGGER IF EXISTS  `tr_servicio_solicitados`$$

-- CREACION DEL TRIGGER
CREATE TRIGGER `tr_servicio_solicitados`
AFTER INSERT ON `SERVICIO_SOLICITADO`
FOR EACH ROW
BEGIN
	INSERT INTO `log_servicio_solicitados`
		VALUES
		('Servicio solicitado',NEW.ID, NEW.IDServicio, NEW.IDMascota, NEW.IDEmpleado, NEW.fechahora, SESSION_USER(), CURRENT_TIMESTAMP());
END$$


-- ********************************************
DROP TRIGGER IF EXISTS `tr_precio_antiguo`$$

-- CRECION DEL TRIGGER
CREATE TRIGGER `tr_precio_antiguo`
BEFORE UPDATE ON `PRODUCTO`
FOR EACH ROW
BEGIN
	INSERT INTO `log_precio_antiguo`
		VALUES
		('Producto modificado',OLD.ID, OLD.IDCategoria, OLD.precioUnitario, SESSION_USER(), CURRENT_TIMESTAMP());
END$$

DELIMITER ;



-- SANDBOX:
-- LLAMADA AL SP `sp_insert_new_client` PARA INGRESAR UN NUEVO CLIENTE

-- call lil_pets.sp_insert_new_client(NULL, 'josesito', 'carmelo', '32.123.212', 'spridfield', '422-123-1123', 'none@gmail.com');
-- SELECT * FROM CLIENTE;

-- LLAMADA AL SP `sp_delete_client` PARA LA ELIMINACION DE UN CLIENTE EXISTENTE

-- call lil_pets.sp_delete_client(11);
-- SELECT * FROM CLIENTE;
