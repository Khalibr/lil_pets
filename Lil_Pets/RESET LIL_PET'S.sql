-- -- -
-- RESET Veterinaria
-- -- --
USE lil_pets;

-- DESACTIVAR LOS FK
SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE CLIENTE;
TRUNCATE TABLE MASCOTA;
TRUNCATE TABLE EMPLEADO;
TRUNCATE TABLE CATEGORIA_EMPLEADO;
TRUNCATE TABLE SERVICIO;
TRUNCATE TABLE PEDIDO;
TRUNCATE TABLE HISTORIAL;
TRUNCATE TABLE CATEGORIA_PRODUCTO;
TRUNCATE TABLE DETALLE_VENTA;
TRUNCATE TABLE PRODUCTO;
TRUNCATE TABLE PROVEEDOR;
TRUNCATE TABLE SERVICIO_PENDIENTE;

SET FOREIGN_KEY_CHECKS=1;