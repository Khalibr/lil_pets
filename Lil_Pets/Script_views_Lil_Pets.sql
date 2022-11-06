/* PROYECTO FINAL - VETERINARIA */

-- Esquema de bases de datos - Veterinaria & PetShop 'Lil Pet's
-- Alumno: Julian Alejandro Medina
-- Comisión: #3496
-- Profesor: Cesar Aracena
-- Tutor: Sergio Occhipinti

-- VISTAS Y SU USO

use lil_pets;

-- VISTAS BASICAS

-- -- --
-- VISTA DE LOS PRODUCTOS PARA GATO ADULTO
-- -- --   
CREATE OR REPLACE VIEW productos_gatos_view AS
	(
		SELECT
			PROD_descripcion AS Items,
            PROD_costoUnitario AS Costo_unitario
		FROM
			PRODUCTO
		WHERE
			PROD_descripcion like upper('%gato%')
        ORDER BY
			PROD_costoUnitario DESC
    );

-- -- --
-- VISTA DE LOS PRODUCTOS PARA GATITOS
-- -- --   
CREATE OR REPLACE VIEW productos_gatitos_view AS
	(
		SELECT
			PROD_descripcion AS Items,
            PROD_costoUnitario AS Costo_unitario
		FROM
			PRODUCTO
		WHERE
			PROD_descripcion like upper('%gatito%')
        ORDER BY
			PROD_costoUnitario DESC
    );
    
    
-- -- --
-- VISTA DE LOS PRODUCTOS PARA PERROS
-- -- --    
CREATE OR REPLACE VIEW productos_perros_view AS
	(
		SELECT
			PROD_descripcion AS Items,
            PROD_costoUnitario AS Costo_unitario
		FROM
			PRODUCTO
		WHERE
			PROD_descripcion like upper('%perro%')
        ORDER BY
			PROD_costoUnitario DESC
    );
    

-- VISTAS COMPUESTAS

-- -- --
-- VISTA DE LAS MASCOTAS ASOCIADAS CON SU DUEÑO
-- -- --
CREATE OR REPLACE VIEW cliente_mascotas_view AS
(
	SELECT
		CONCAT_WS(' ',c.CLI_nombre,c.CLI_apellido) AS Nombre_completo_cliente,
        m.MAS_nombre AS Nombre_mascota,
        m.MAS_especie AS Especie       
	FROM
		CLIENTE AS c
	JOIN
		MASCOTA AS m ON(CLI_ID = MAS_IDCliente)
);

-- -- --
-- VISTA DE CLIENTES QUE HICIERON AL MENOS UNA COMPRA
-- -- --
CREATE OR REPLACE VIEW cliente_que_compro_view AS
(
	SELECT
		c.CLI_ID AS ID,
		CONCAT_ws(' ',c.CLI_nombre,c.CLI_apellido) AS Nombre_completo,
        p.PED_fechahora AS Hora_compra
	FROM
		CLIENTE AS c
    JOIN
		PEDIDO AS p ON (c.CLI_ID = p.PED_IDCliente)
);


-- -- --
-- VISTA DE EMPLEADOS JUNTO CON SU PROFESION
-- -- --
CREATE OR REPLACE VIEW empleado_profesion_view AS
(
	SELECT
		CONCAT_WS(' ',e.EMP_nombre,e.EMP_apellido) AS Nombre_completo,
        c.CAT_descripcion AS profesion
	FROM
		EMPLEADO AS e
	JOIN
		CATEGORIA_EMPLEADO AS c ON(e.EMP_ID = c.CAT_IDEmpleado)
);