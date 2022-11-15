
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


/* 
-
• INICIO DE LA CREACION DE ENTIDADES PARA LA BD `LIL_PET'S`
-
*/

-- Estructura para la tabla `CLIENTE`

CREATE TABLE IF NOT EXISTS `CLIENTE`(
	CLI_ID INT NOT NULL AUTO_INCREMENT,
	CLI_nombre VARCHAR(50) NOT NULL,
	CLI_apellido VARCHAR(50) NOT NULL,
	CLI_DNI VARCHAR(50) NOT NULL,
	CLI_domicilio VARCHAR(50) NOT NULL,
	CLI_telefono VARCHAR(20) NOT NULL,
	CLI_email VARCHAR(50) NOT NULL,
	PRIMARY KEY(CLI_ID)
);


-- Estructura para la tabla `MASCOTA`

CREATE TABLE IF NOT EXISTS `MASCOTA`(
	MAS_ID INT NOT NULL AUTO_INCREMENT,
	MAS_IDCliente INT NOT NULL,
	MAS_nombre VARCHAR(50) NOT NULL,
	MAS_edad DATE NOT NULL,
	MAS_especie VARCHAR(50) NOT NULL,
	MAS_raza VARCHAR(50) NOT NULL,
	MAS_sexo VARCHAR(20) NOT NULL,
	MAS_peso DECIMAL(6,3) NOT NULL,
	MAS_descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(MAS_ID),
	CONSTRAINT fk_id_cliente_mascota FOREIGN KEY(MAS_IDCliente) REFERENCES CLIENTE(CLI_ID) ON DELETE CASCADE
);


-- Estructura para la tabla `CATEGORIA_EMPLEADO`

CREATE TABLE IF NOT EXISTS `CATEGORIA_EMPLEADO`(
	CAT_IDEmpleado INT NOT NULL AUTO_INCREMENT,
	CAT_descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(CAT_IDEmpleado)
);


-- Estructura para la tabla `EMPLEADO`

CREATE TABLE IF NOT EXISTS `EMPLEADO`(
	EMP_ID INT NOT NULL AUTO_INCREMENT,
	EMP_IDCategoria INT NOT NULL,
	EMP_nombre VARCHAR(50) NOT NULL,
	EMP_apellido VARCHAR(50) NOT NULL,
	EMP_sexo VARCHAR(20) NOT NULL,
	EMP_DNI VARCHAR(50) NOT NULL,
	EMP_telefono VARCHAR(50) NOT NULL,
	EMP_fechaNac DATE NOT NULL,
	EMP_salario DECIMAL(8,2) NOT NULL,
	EMP_fechaIngreso DATE NOT NULL,
	PRIMARY KEY(EMP_ID),
	CONSTRAINT fk_id_categoria_empleado FOREIGN KEY(EMP_IDCategoria)
	REFERENCES CATEGORIA_EMPLEADO(CAT_IDEmpleado) ON DELETE CASCADE
);


-- Estructura para la tabla `SERVICIO`

CREATE TABLE IF NOT EXISTS `SERVICIO`(
	SER_ID INT NOT NULL AUTO_INCREMENT,
	SER_area VARCHAR(50) NOT NULL,
	SER_servicio VARCHAR(50) NOT NULL,
	SER_costo DECIMAL(8,2) NOT NULL,
	SER_descripcion VARCHAR(140) NOT NULL,
	PRIMARY KEY(SER_ID)
);


-- Estructura para la tabla `SERVICIO_SOLICITADO`

CREATE TABLE IF NOT EXISTS `SERVICIO_SOLICITADO`(
	SOL_ID INT NOT NULL AUTO_INCREMENT,
	SOL_IDServicio INT NOT NULL,
	SOL_IDMascota INT NOT NULL,
	SOL_IDEmpleado INT NOT NULL,
	SOL_fechahora DATETIME NOT NULL,
	PRIMARY KEY(SOL_ID),
	CONSTRAINT fk_id_servicio_s_solicitado FOREIGN KEY(SOL_IDServicio) REFERENCES SERVICIO(SER_ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_mascota_s_solicitado FOREIGN KEY(SOL_IDMascota) REFERENCES MASCOTA(MAS_ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_empleado_s_solicitado FOREIGN KEY(SOL_IDEmpleado) REFERENCES EMPLEADO(EMP_ID) ON DELETE CASCADE
);


-- Estructura para la tabla `HISTORIAL`

CREATE TABLE IF NOT EXISTS `HISTORIAL`(
	HIS_ID INT NOT NULL AUTO_INCREMENT,
	HIS_IDMascota INT NOT NULL,
	HIS_diagnostico VARCHAR(140) NOT NULL,
	PRIMARY KEY(HIS_ID),
	CONSTRAINT fk_id_mascota_historial FOREIGN KEY(HIS_IDMascota) REFERENCES MASCOTA(MAS_ID) ON DELETE CASCADE
);


-- Estructura para la tabla `PEDIDO`

CREATE TABLE IF NOT EXISTS `PEDIDO`(
	PED_ID INT NOT NULL AUTO_INCREMENT,
	PED_IDCliente INT NOT NULL,
	PED_fechahora TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(PED_ID),
	CONSTRAINT fk_id_cliente_pedido FOREIGN KEY(PED_IDCliente) REFERENCES CLIENTE(CLI_ID) ON DELETE CASCADE
);


-- Estructura para la tabla `CATEGORIA_PRODUCTO`

CREATE TABLE IF NOT EXISTS `CATEGORIA_PRODUCTO`(
	CAT_IDProducto INT NOT NULL AUTO_INCREMENT,
	CAT_descripcion VARCHAR(50) NOT NULL,
	PRIMARY KEY(CAT_IDProducto)
);


-- Estructura para la tabla `PROVEEDOR`

CREATE TABLE IF NOT EXISTS `PROVEEDOR`(
	PROV_ID INT NOT NULL AUTO_INCREMENT,
	PROV_nombre VARCHAR(50) NOT NULL,
	PROV_DNI VARCHAR(50) NOT NULL,
	PROV_telefono VARCHAR(20) NOT NULL,
	PROV_email VARCHAR(50) NOT NULL,
	PROV_direccion VARCHAR(50) NOT NULL,
	PROV_web VARCHAR(50) NOT NULL,
	PRIMARY KEY(PROV_ID)
);


-- Estructura para la tabla `PRODUCTO`

CREATE TABLE IF NOT EXISTS `PRODUCTO`(
	PROD_ID INT NOT NULL AUTO_INCREMENT,    
	PROD_descripcion VARCHAR(140) NOT NULL,
	PROD_IDCategoria INT NOT NULL,
	PROD_precioUnitario DECIMAL(11,2) NOT NULL,
	PROD_IDProveedor INT NOT NULL,
	PRIMARY KEY(PROD_ID),
	CONSTRAINT fk_id_categoria_producto FOREIGN KEY(PROD_IDCategoria) REFERENCES CATEGORIA_PRODUCTO(CAT_IDProducto) ON DELETE CASCADE,
	CONSTRAINT fk_id_proveedor_producto FOREIGN KEY(PROD_IDProveedor) REFERENCES PROVEEDOR(PROV_ID) ON DELETE CASCADE
);


-- Estructura para la tabla `DETALLE_VENTA`

CREATE TABLE IF NOT EXISTS `DETALLE_VENTA`(
	DET_ID INT NOT NULL AUTO_INCREMENT,
	DET_IDPedido INT NOT NULL,
	DET_IDProducto INT NOT NULL,
	DET_cantidad INT NOT NULL,
	DET_subtotal DECIMAL(11,2) NOT NULL,
	DET_recargo INT NOT NULL,
	DET_total DECIMAL(11,2) NOT NULL,
	PRIMARY KEY(DET_ID),
	CONSTRAINT fk_id_pedido_d_venta FOREIGN KEY(DET_IDPedido) REFERENCES PEDIDO(PED_ID) ON DELETE CASCADE,
	CONSTRAINT fk_id_producto_d_venta FOREIGN KEY(DET_IDProducto) REFERENCES PRODUCTO(PROD_ID) ON DELETE CASCADE
);



/* 
-
• INICIO DE LA CREACION DE FUNCIONES PARA LA BD `LIL_PET'S`
-
*/



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

DROP FUNCTION IF EXISTS `f_calcular_recargo`$$

-- FUNCION: calcula el iva 
CREATE FUNCTION `f_calcular_recargo` (subtotal DECIMAL(11,2),recargo INT) RETURNS DECIMAL(11,2)
NO SQL
BEGIN
	DECLARE retorno DECIMAL(11,2);
	SET retorno = subtotal * ((recargo/100) + 1);
	RETURN retorno;
END$$


DROP FUNCTION IF EXISTS `f_concat_precios`$$

-- FUNCION: concatena el simbolo `$` a los precios
CREATE FUNCTION `f_concat_precio` (precio DECIMAL(11,2)) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE retorno VARCHAR(50);
	SET retorno = CONCAT('$ ',precio);
	RETURN retorno;
END$$



DROP FUNCTION IF EXISTS `f_calcular_subtotal`$$

-- FUNCION: calcula el subtotal pasando por referencia los campos de producto y cantidad
CREATE FUNCTION `f_calcular_subtotal`(producto INT,cantidad INT) RETURNS DECIMAL(11,2)
DETERMINISTIC
BEGIN
	DECLARE total DECIMAL(11,2);
	SET total = (
		SELECT PROD_precioUnitario * cantidad
		FROM PRODUCTO
		WHERE PROD_ID = producto
	);
	RETURN total;
END$$

DELIMITER ;



/* 
-
• INICIO DE LA CREACION DE FUNCIONES PARA LA BD `LIL_PET'S`
-
*/


-- VISTA DE LOS PRODUCTOS MAS VENDIDOS
CREATE OR REPLACE VIEW `mas_vendido` AS
(
	SELECT
		d.DET_IDProducto AS item,
        p.PROD_descripcion AS producto,
        d.DET_cantidad AS cantidad
	FROM
		DETALLE_VENTA AS d
	JOIN
		PRODUCTO AS p ON (p.PROD_ID = d.DET_IDProducto)
	ORDER BY
		d.DET_cantidad DESC
	LIMIT 5
);


-- VISTA DE LOS PRODUCTOS PARA GATO ADULTO

CREATE OR REPLACE VIEW `productos_gatos_view` AS
(
	SELECT
		p.PROD_descripcion AS items,
		f_concat_precio(p.PROD_precioUnitario) AS costo_compra
	FROM
		PRODUCTO AS p
	WHERE
		p.PROD_descripcion like upper('%gato%')
	ORDER BY
		p.PROD_precioUnitario DESC
);


-- VISTA DE LOS PRODUCTOS PARA GATITOS

CREATE OR REPLACE VIEW `productos_gatitos_view` AS
(
	SELECT
		p.PROD_descripcion AS items,
		f_concat_precio(p.PROD_precioUnitario) AS costo_unitario
	FROM
		PRODUCTO AS p
	WHERE
		p.PROD_descripcion like upper('%gatito%')
	ORDER BY
		p.PROD_precioUnitario DESC
);


-- VISTA DE LOS PRODUCTOS PARA PERROS
 
CREATE OR REPLACE VIEW `productos_perros_view` AS
(
	SELECT
		p.PROD_descripcion AS items,
		f_concat_precio(p.PROD_precioUnitario) AS costo
	FROM
		PRODUCTO AS p
	WHERE
		p.PROD_descripcion like upper('%perro%')
	ORDER BY
		p.PROD_precioUnitario DESC
);


-- VISTA DE LAS MASCOTAS ASOCIADAS CON SU DUEÑO

CREATE OR REPLACE VIEW `cliente_mascotas_view` AS
(
	SELECT
		f_concat_nombre_completo(c.CLI_nombre,c.CLI_apellido) AS nombre_completo_cliente,
		m.MAS_nombre AS nombre_mascota,
		m.MAS_especie AS especie       
	FROM
		CLIENTE AS c
	JOIN
		MASCOTA AS m ON(c.CLI_ID = m.MAS_IDCliente)
);


-- VISTA DEL TOP 10 DE LOS CLIENTES QUE MAS COMPRARON

CREATE OR REPLACE VIEW `top10_clientes_view` AS
(
	SELECT
		c.CLI_ID AS ID,
		f_concat_nombre_completo(c.CLI_nombre,c.CLI_apellido) AS nombre_completo,
        COUNT(p.PED_IDCliente) AS compras_realizadas
	FROM
		CLIENTE AS c
	JOIN
		PEDIDO AS p ON (c.CLI_ID = p.PED_IDCliente)
	GROUP BY
		p.PED_IDCliente
	ORDER BY
		compras_realizadas DESC
	LIMIT 10
);



-- VISTA DE EMPLEADOS JUNTO CON SU PROFESION

CREATE OR REPLACE VIEW `empleado_profesion_view` AS
(
	SELECT
		f_concat_nombre_completo(e.EMP_nombre,e.EMP_apellido) AS nombre_completo,
		c.CAT_descripcion AS profesion
	FROM
		EMPLEADO AS e
	JOIN
		CATEGORIA_EMPLEADO AS c ON(e.EMP_ID = c.CAT_IDEmpleado)
);


-- VISTA CON MULTIPLE JOIN'S DE LA TABLA `PRODUCTO`, DONDE SE REEMPLAZAN LAS FK POR SU NOMBRE/DESCRIPCION DE TABLAS RELACIONADAS

CREATE OR REPLACE VIEW `productos_view` AS
(
	SELECT
		p.PROD_ID as item,
		p.PROD_descripcion AS descripcion,
		c.CAT_descripcion AS categoria,
		f_concat_precio(p.PROD_precioUnitario) AS costo,
		pr.PROV_nombre AS proveedor        
	FROM
		PRODUCTO AS p
	JOIN
		CATEGORIA_PRODUCTO AS c ON (p.PROD_IDCategoria = c.CAT_IDProducto)
	JOIN
		PROVEEDOR AS pr ON (p.PROD_IDProveedor = pr.PROV_ID)
	WHERE
		p.PROD_ID
	ORDER BY
		p.PROD_ID ASC
);


-- VISTA CON MULTIPLES JOIN'S, DETALLA LOS SERVICIOS SOLICITADOS
-- ADICIONANDO INFORMACION ESCALADA DE TABLAS RELACIONADAS UNA CON OTRAS

CREATE OR REPLACE VIEW `servicios_solicitados_view` AS
(
	SELECT
		SOL_ID AS id,
		SER_servicio AS servis,
		f_concat_precio(SER_costo) AS precio,
		MAS_nombre AS mascota,
		MAS_raza AS raza,
		f_concat_nombre_completo(CLI_nombre,CLI_apellido) AS cliente,
		EMP_nombre AS empleado,
		CAT_descripcion AS categoria_empleado,
		SOL_fechahora AS fecha_hora,
		SER_descripcion AS descripcion
	FROM
		SERVICIO_SOLICITADO
	JOIN
		MASCOTA ON (MAS_ID = SOL_IDMascota)
	JOIN
		SERVICIO ON (SER_ID = SOL_IDServicio)
	JOIN
		EMPLEADO ON (EMP_ID = SOL_IDEmpleado)
	JOIN
		CLIENTE ON (CLI_ID = MAS_IDCliente)
	JOIN
		CATEGORIA_EMPLEADO ON (EMP_IDCategoria = CAT_IDEmpleado)
);


-- VISTA DE LOS 5 SERVICIOS MAS SOLICITADOS

CREATE OR REPLACE VIEW `servicios_mas_solicitados_view` AS
(
	SELECT
		serv.SER_ID AS ID,
		serv.SER_servicio AS Servis,
		COUNT(soli.SOL_IDServicio) AS cantidad
	FROM
		SERVICIO AS serv
	JOIN
		SERVICIO_SOLICITADO AS soli ON (soli.SOL_IDServicio = serv.SER_ID)
	GROUP BY
		soli.SOL_IDServicio
	ORDER BY
		cantidad DESC
	LIMIT 5
);

-- VISTA DE LA GANANCIA MENSUAL DE VENTAS DEL AÑO 2022

CREATE OR REPLACE VIEW `ganancias_x_mes` AS
(
	SELECT
		d.DET_IDPedido AS IDPEDIDO,
		MONTHNAME(p.PED_fechahora) AS mes,
		SUM(d.DET_total - d.DET_subtotal) AS ganancia
	FROM
		PEDIDO AS p
	JOIN
		DETALLE_VENTA AS d ON (d.DET_IDPedido = p.PED_ID)
	WHERE
		YEAR(p.PED_fechahora) = '2022'
	GROUP BY
		mes
	ORDER BY
		mes ASC
);


-- VISTA DE GANANCIAS MENSUALES DE LOS SERVICIOS REALIZADOS DEL AÑO 2022

CREATE OR REPLACE VIEW `ganancia_servicios` AS
(
	SELECT
		MONTHNAME(soli.SOL_fechahora) as mes,
		SUM(serv.SER_costo) AS ganancia,
        COUNT(soli.SOL_IDServicio) AS 'cantidad solicitados'
	FROM
		SERVICIO AS serv
	JOIN
		SERVICIO_SOLICITADO AS soli ON (soli.SOL_IDServicio = serv.SER_ID)
	WHERE
		YEAR(soli.SOL_fechahora) = '2022'
	GROUP BY
		mes
	ORDER BY
		mes DESC
);



/* 
-
• INICIO DE LA CREACION DE STORED PROCEDURES PARA LA BD `LIL_PET'S`
-
*/



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


DROP PROCEDURE IF EXISTS `sp_insert_new_client`$$

-- SP para insertar datos de un nuevo cliente

CREATE PROCEDURE `sp_insert_new_client` (IN sp_CLI_ID INT, IN sp_CLI_nombre VARCHAR(50), IN sp_CLI_apellido VARCHAR(50), IN sp_CLI_DNI VARCHAR(50), IN sp_CLI_domicilio VARCHAR(50),  IN sp_CLI_telefono VARCHAR(20),  IN sp_CLI_email VARCHAR(50))
BEGIN
	INSERT INTO `CLIENTE` (CLI_ID, CLI_nombre, CLI_apellido, CLI_DNI, CLI_domicilio, CLI_telefono, CLI_email)
		VALUES
			(sp_CLI_ID, sp_CLI_nombre, sp_CLI_apellido, sp_CLI_DNI, sp_CLI_domicilio, sp_CLI_telefono, sp_CLI_email);
END$$


DROP PROCEDURE IF EXISTS `sp_delete_client`$$

-- SP para eliminar un cliente de los registros

CREATE PROCEDURE `sp_delete_client` (IN sp_CLI_ID INT)
BEGIN
	DELETE
	FROM
		CLIENTE
	WHERE
		CLI_ID = sp_CLI_ID;
END$$

DELIMITER ;

/*
-- SANDBOX:
-- LLAMADA AL SP `sp_insert_new_client` PARA INGRESAR UN NUEVO CLIENTE

call lil_pets.sp_insert_new_client(NULL, 'josesito', 'carmelo', '32.123.212', 'spridfield', '422-123-1123', 'none@gmail.com');
SELECT * FROM CLIENTE;

-- LLAMADA AL SP `sp_delete_client` PARA LA ELIMINACION DE UN CLIENTE EXISTENTE

call lil_pets.sp_delete_client(11);
SELECT * FROM CLIENTE;
*/




/* 
-
• INICIO DE LA CREACION DE TRIGGERS Y TABLAS DE AUDITORIA PARA LA BD `LIL_PET'S`
-
*/


/*
	APARTIR DE ESTA TABLA DE AUDITORIA SE PUEDE LLEVAR UN REGISTRO
    DE TODOS LOS PEDIDOS REALIZADOS, TENIENDO EN CUENTA EL USUARIO Y LA FECHA/HORA
    DE INSERCION.
*/
DROP TABLE IF EXISTS `log_detalle_venta`;

-- CREACION DE LA TABLA "LOG_DETALLE_VENTA" DEL TRIGGER
CREATE TABLE `log_detalle_venta`
(
	log_IDVenta INT PRIMARY KEY,
    log_IDPedido INT,
    log_subtotal DECIMAL(11,2),
    log_recargo INT,
    log_total DECIMAL(11,2),
    log_usuario VARCHAR(50),
    log_evento TIMESTAMP
);


DROP TRIGGER IF EXISTS `tr_detalle_venta`;

-- CREACION DEL TRIGGER
CREATE TRIGGER `tr_detalle_venta`
AFTER INSERT ON `DETALLE_VENTA`
FOR EACH ROW
INSERT INTO `log_detalle_venta`
	VALUES
		(NEW.DET_ID, NEW.DET_IDPedido, NEW.DET_Subtotal, NEW.DET_recargo, NEW.DET_total, SESSION_USER(), CURRENT_TIMESTAMP());



/*
	APARTIR DE ESTA TABLA SE AUDITAN TODOS AQUELLOS SERVICIOS QUE SE SOLICITARON
    DE MANERA QUE, SE LLEVA UN REGISTRO DETALLADO DE LOS MISMOS TENIENDO EN CUENTA
    CUANDO Y QUE USUARIO REALIZÓ DICHA INSERCION.
*/
DROP TABLE IF EXISTS `log_servicio_solicitados`;

-- CREACION DE LA TABLA "LOG_SERVICIO_SOLICITADO" DEL TRIGGER
CREATE TABLE `log_servicio_solicitados`
(
	log_ID INT,
    log_IDServicio INT,
    log_IDMascota INT,
    log_IDEmpleado INT,
    log_fechahora DATETIME,
    log_usuario VARCHAR(50),
    log_evento TIMESTAMP,
    PRIMARY KEY(log_ID)
);


DROP TRIGGER IF EXISTS  `tr_servicio_solicitados`;

-- CREACION DEL TRIGGER
CREATE TRIGGER `tr_servicio_solicitados`
AFTER INSERT ON `SERVICIO_SOLICITADO`
FOR EACH ROW
INSERT INTO `log_servicio_solicitados`
	VALUES
		(NEW.SOL_ID, NEW.SOL_IDServicio, NEW.SOL_IDMascota, NEW.SOL_IDEmpleado, NEW.SOL_fechahora, SESSION_USER(), CURRENT_TIMESTAMP());
      
      

/*
	APARTIR DE ESTA TABLE SE AUDITAN TODOS AQUELLOS SERVICIOS QUE SE SOLICITARON
    DE MANERA QUE, SE LLEVA UN REGISTRO DETALLADO DE LOS MISMOS TENIENDO EN CUENTA
    CUANDO Y QUE USUARIO REALIZÓ DICHA INSERCION.
*/
DROP TABLE IF EXISTS `log_precio_antiguo`;

-- CREACION DE LA TABLA "LOG_PRECIO_ANTIGUO" PARA EL TRIGGER
CREATE TABLE `log_precio_antiguo`
(
	log_IDProducto INT,
    log_IDCategoria INT,
    log_precioAntiguo DECIMAL(11,2),
    log_usuario VARCHAR(50),
    log_evento TIMESTAMP,
    PRIMARY KEY(log_IDProducto)
);


DROP TRIGGER IF EXISTS `tr_precio_antiguo`;

-- CRECION DEL TRIGGER
CREATE TRIGGER `tr_precio_antiguo`
BEFORE UPDATE ON `PRODUCTO`
FOR EACH ROW
INSERT INTO `log_precio_antiguo`
	VALUES
		(OLD.PROD_ID, OLD.PROD_IDCategoria, OLD.PROD_precioUnitario, SESSION_USER(), CURRENT_TIMESTAMP());
        
/*
update producto
set PROD_precioUnitario = 5
where PROD_ID = 1;

select * from producto;*/