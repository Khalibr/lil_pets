
/* 
PROYECTO FINAL - VETERINARIA

• Esquema de bases de datos - Veterinaria & PetShop 'Lil Pet's
• Alumno: Julian Alejandro Medina
• Comisión: #3496
• Profesor: Cesar Aracena
• Tutor: Sergio Occhipinti

*/

-- USO DE LA BD
USE `Lil_Pets`;


-- Estructura para insertar registros en `CLIENTE`

INSERT INTO `CLIENTE`
	VALUES
		(1,'Godiva','Meritt','62.885.923','7 Canary Court','493-713-0830','gmeritt0@ask.com'),
		(2,'Shannan','Hartup','46.675.912','500 7th Terrace','428-364-6274','shartup1@bizjournals.com'),
		(3,'Sylas','Killoran','50.452.823','7591 Northview Terrace','865-810-2274','skilloran2@twitpic.com'),
		(4,'Lucita','McMearty','64.513.963','17046 Springview Hill','415-934-3278','lmcmearty3@sphinn.com'),
		(5,"Cathryn","Strewther","34.512.275","6 Valley Edge Parkway","634-251-4734","cstrewther4@reverbnation.com"),
		(6,'Bradan','Pilgrim','23.536.818','6737 Grover Terrace','170-966-2226','bpilgrim5@nyu.edu'),
		(7,'Rufe','Pocke','50.484.211','4420 Veith Alley','194-451-7397','rpocke6@nbcnews.com'),
		(8,'Gabriell','McRuvie','30.618.919','06 Gateway Place','224-963-4213','gmcruvie7@behance.net'),
		(9,'Conway','Ghio','83.378.384','797 Sycamore Point','950-472-3357','cghio8@rambler.ru'),
		(10,'Fannie','De La Cote','25.902.948','6482 Steensland Point','642-667-2430','fdelacote9@webs.com');


-- Estructura para insertar registros en `MASCOTA`

INSERT INTO `MASCOTA`
	VALUES
		(1,1,'Africa','2022-09-19','perro','coker','M',18.997,'NULL'),
		(2,2,'Blue','2022-07-10','gato','azul ruso','F',4.199,'NULL'),
		(3,3,'Weaver','2022-07-25','conejo','NULL','M',1.321,'NULL'),
		(4,3,'galapago','2022-09-14','conejo','NULL','F',1.548,'NULL'),
		(5,4,'Gazer sun','2021-11-28','gato','balinés','F',3.249,'NULL'),
		(6,5,'Gerbil','2022-10-25','perro','schnauzer','M',15.02,'NULL'),
		(7,6,'Swan','2021-11-18','hipopotamo','NULL','M',42.078,'NULL'),
		(8,7,'Desert','2022-07-07','perro','dogo del tíbet','M',38.066,'NULL'),
		(9,8,'Dik','2021-11-28','elefante','NULL','F',71.349,'NULL'),
		(10,9,'Cormorant','2022-05-29','perro','landseer','F',7.03,'NULL'),
		(11,10,'Plover','2022-01-11','perro','terranova','F',25.394,'NULL');


-- Estructura para insertar registros en `CATEGORIA_EMPLEADO`

INSERT INTO `CATEGORIA_EMPLEADO`
	VALUES
		(1,'Atencion Medica'),
		(2,'Estilista de mascotas');


-- Estructura para insertar registros en `EMPLEADO`

INSERT INTO `EMPLEADO`
	VALUES
		(1,1,'Edgar','Flores','Masculino','64.474.460','756-788-1519','1987-10-05',100000.00,'2021-05-31'),
		(2,2,'Maria','Taler','Femenino','67.607.435','341-341-0660','2000-12-27',50000.00,'2021-03-24'),
		(3,1,'Emanuel','Isba','Masculino','75.706.887','537-880-8516','1994-03-15',100000.00,'2020-05-10'),
        (4,2,'Nanda','Waler','Femenino','68.657.445','321-371-0610','1999-12-17',50000.00,'2019-07-30');


-- Estructura para insertar registros en `SERVICIO`
     
INSERT INTO `SERVICIO`
	VALUES
		(1,'Veterinaria','Castración',10000,'Castraciones de machos y hembras, caninos y felinos'),
		(2,'Veterinaria','Ecografias',5000,'Servicio de ecografías'),
		(3,'Veterinaria','Cirugias',15000,'Cirugías de baja y alta complejidad'),
		(4,'Veterinaria','Consulta',2500,'Consultas medicas'),
		(5,'Peluqueria','Corte y Baño completo',9500,'Incluye baño, secado, corte a máquina y/o tijera, peinado, limpieza de oídos y corte de uñas'),
		(6,'Peluqueria','Baño completo',7500,'Incluye baño, secado, peinado, limpieza de oídos y corte de uñas'),
		(7,'Peluqueria','Cortes de Raza',7000,'Schnauzer, Caniche, Cocker, Pastor Alemán, Pastor Inglé, otras razas'),
		(8,'Peluqueria','Limpieza de oidos',3500,'Servicio canino'),
		(9,'Peluqueria','Corte de uñas',2500,'Servicio canino y felino');


-- Estructura para insertar registros en `SERVICIO_SOLICITADO`
     
INSERT INTO `SERVICIO_SOLICITADO`
	VALUES
		(1,7,1,2,'2022-10-31 11:00'),
		(2,4,3,3,'2022-11-02 19:00'),
		(3,1,11,1,'2022-11-03 16:15'),
		(4,2,4,3,'2022-11-01 15:30'),
		(5,9,10,4,'2022-11-01 15:30');


-- Estructura para insertar registros en `HISTORIAL`

INSERT INTO `HISTORIAL`
	VALUES
		(1,3,'bajo peso');


-- Estructura para insertar registros en `PEDIDO`

INSERT INTO `PEDIDO`
	VALUES
		(1,3,DEFAULT),
		(2,7,'2022-01-11 16:59:31'),
		(3,5,'2022-04-13 18:46:32'),
		(4,1,'2022-08-17 18:48:50');


-- Estructura para insertar registros en `CATEGORIA_PRODUCTO`
    
INSERT INTO `CATEGORIA_PRODUCTO`
	VALUES
		(1,'Alimentos'),
		(2,'Snacks'),
		(3,'Accesorios'),
		(4,'Estetica e Higiene'),
		(5,'Salud');


-- Estructura para insertar registros en `PROVEEDOR`

INSERT INTO `PROVEEDOR`
	VALUES
		(1,'Wuckert LLC','30.927.7183','639-822-6952','dconn0@gov.uk','31306 Bobwhite Way','fotki.com'),
		(2,'Ferry Group','53.130.7404','724-237-5613','mokie1@deviantart.com','7 4th Parkway','lycos.com');


-- Estructura para insertar registros en `SUBCATEGORIA_PRODUCTO`
INSERT INTO `SUBCATEGORIA_PRODUCTO`
	VALUES
	(1,'Perro','generalizar en cualquier producto para perros, excepto alimento'),
	(2,'Gato','generalizar en cualquier producto para gatos, excepto alimento'),
	(3,'Perro Adulto','Utilizado para diferenciar en alimentos'),
	(4,'Cachorro','Utilizado para diferenciar en alimentos'),
	(5,'Gato Adulto','Utilizado para diferenciar en alimentos'),
	(6,'Gatito','Utilizado para diferenciar en alimentos'),
	(7,'Ave','productos para aves'),
	(8,'Pez','productos para peces'),
	(9,'Reptil','productos para reptiles'),
	(10,'Roedor','productos para roedores');


-- Estructura para insertar registros en `PRODUCTO`

INSERT INTO `PRODUCTO`
	VALUES
		(1,'Balanced 15KG Perro Adulto',1,3,8906,1),
		(2,'Eukanuba 15KG Cachorro',1,4,10425,1),
		(3,'Excellent 7.5KG Gatito',1,6,9925,2),
		(4,'Club Performance 7.5KG Gato Adulto',1,5,7813,2),
		(5,'Dentastix Pedigree saber carne para Perro',2,1,123,1),
		(6,'Orejas de vaca masticable para Perro',2,1,1685,1),
		(7,'Tiritas Dr.Zoo de Salmon para Gato',2,1,250,2),
		(8,'Chocolate Blanco Innovar para Gato',2,1,145,2),
		(9,'Soga Puppis tres nudos para Perro',3,1,823.2,1),
		(10,'Pelota Puppis Tenis para Perro',3,1,323.4,1),
		(11,'Cañita Puppis Insecto para Gato',3,1,785.4,2),
		(12,'Rascador Puppis ola carton para Gato',3,1,2110,2),
		(13,'Piedras sanitarias Tidy Cats 3.6KG',4,2,875,1),
		(14,'Arena sanitaria StonCat 4KG',4,2,1140,1),
		(15,'Toallitas patas humedas 80u. Perro',4,1,1400,2),
		(16,'Cortauñas Puppis para Perro',4,1,1070,2),
		(17,'PowerUltra 5-10KG (1 pipeta) Perro',5,1,650,1),
		(18,'PowerUltra 11-20KG (1 pipeta) Perro',5,1,750,1),
		(19,'Pipeta PowerMet antipulgas para Gato, hasta 4KG',5,2,590,2),
		(20,'Pipeta PowerSport On para Gato, 4-8KG',5,2,560,2);

 

-- Estructura para insertar registros en `DETALLE_VENTA`

INSERT INTO `DETALLE_VENTA`
	VALUES
		(1,1,1,3,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo)),
		(2,1,6,2,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo)),
		(3,1,16,1,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo)),
		(4,1,17,5,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo)),
		(5,2,2,3,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo)),
		(6,3,9,2,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo)),
		(7,4,14,3,f_calcular_subtotal(DET_IDProducto,DET_cantidad),35,f_calcular_recargo(DET_subtotal,DET_recargo));




/*
-- SANDBOX:
-- PRUEBA DE ELIMINACION DEL CLIENTE CON ID = 1
DELETE FROM CLIENTE WHERE (CLI_ID = 1);

-- al borrar el cliente, se elimina con exito la relacion con la mascota asociada al -ID CLIENTE 1-
SELECT * FROM MASCOTA;
*/