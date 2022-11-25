
/* 
PROYECTO FINAL - VETERINARIA

• Esquema de bases de datos - Veterinaria & PetShop 'Lil Pet's
• Alumno: Julian Alejandro Medina
• Comisión: #3496
• Profesor: Cesar Aracena
• Tutor: Sergio Occhipinti

*/

-- USO DE LA BD OCULTA
USE `mysql`;


/*
	INICIO DE LA SENTENCIA PARA GESTIONAR LOS USUARIOS
	EN LA BD LIL_PETS
*/ 

-- INICIO DE LA SENTENCIA PARA GESTIONAR EL USUARIO DE SOLO LECTURA
CREATE USER 'sergio_lectura'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Coder123';

-- SENTENCIA PARA OTORGAR EL PERMISO AL USUARIO DE LECTURA
GRANT SELECT ON lil_pets.* TO 'sergio_lectura'@'localhost';

-- VER EL PERMISO OTORGADO
SHOW GRANTS FOR 'sergio_lectura'@'localhost';


-- INICIO DE LA SENTENCIA PARA GESTIONAR EL USUARIO DE "LECTURA, INSERCIÓN Y MODIFICACION"
CREATE USER 'sergio_op'@'localhost'IDENTIFIED WITH mysql_native_password BY 'Coder1234';

-- SENTENCIA PARA OTORGAR LOS PERMISOS AL USUARIO SERGIO_OP
GRANT SELECT, INSERT, UPDATE ON lil_pets.* TO 'sergio_op'@'localhost';

-- VER LOS PERMISOS OTORGADOS
SHOW GRANTS FOR 'sergio_op'@'localhost';
