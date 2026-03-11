/* 
Implementacion de una base de datos en un sistema de informacion
2026/03/04 4-I
Juan Antonio Ortega Sandoval
Nombre de la practica
*/

/*
Efren Alexander Robles Gomez
4°I
04/03/26
*/
use cbtis;
DROP TABLE staff;
DROP TABLE empleados;
CREATE TABLE empleados (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25),
    edad INT,
    salario DECIMAL(10,2)
);

INSERT INTO empleados (nombre, edad, salario) VALUES
('Juan Perez', 25, 8500.00),
('Maria Lopez', 30, 9200.50),
('Carlos Ramirez', 28, 7800.75),
('Ana Torres', 35, 10500.00),
('Luis Hernandez', 22, 6900.25);

ALTER TABLE empleados
ADD departamento VARCHAR(30);

ALTER TABLE empleados
MODIFY salario INT;

ALTER TABLE empleados
DROP COLUMN departamento;

DROP TABLE IF EXISTS departamentos;

TRUNCATE TABLE empleados;

RENAME TABLE empleados TO staff;

ALTER TABLE staff
MODIFY salario INT DEFAULT 0;

CREATE SCHEMA rh_db;

RENAME TABLE staff TO rh_db.staff;


-- Crear una tabla llamaba "empleados" con las columnas  id, nombre
-- edad, and salario.

-- Insertar 5 registros en la tabla "emplados".

-- Agregar una nueva columna "departamento" a la tabla "empleados".

-- Cambiar el tipo de dato de la columna "salario" a Integer.

-- Eliminar la columna "departamento de la tabla "empleados".

-- Eliminar la tabla "departamentos" permanentemente.

-- Eliminar todos los registros de la tabla "empleados" pero mantener
-- la tabla.

-- Renombrar la tabla "empleados" a "staff".

-- Definir 0 como valor predeterminado en la comlumna "salario".

-- Crear un nuevo esquema llamado "rh_db".

-- Mover la tabla "empleados" al esquema "rh_db".