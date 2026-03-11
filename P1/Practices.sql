/* 
Implementacion de una base de datos en un sistema de informacion
2026/03/04 4-I
Juan Antonio Ortega Sandoval
Nombre de la practica
*/

CREATE TABLE departamentos (
  id int NOT NULL,
  name varchar(25) NOT NULL,
  location date NOT NULL,
  PRIMARY KEY (id, name)
);


-- Crear una tabla llamaba "empleados" con las columnas  id, nombre, edad, and salario.

-- Insertar 5 registros en la tabla "emplados".

-- Agregar una nueva columna "departamento" a la tabla "empleados".

-- Cambiar el tipo de dato de la columna "salario" a Integer.

-- Eliminar la columna "departamento de la tabla "empleados".

-- Eliminar la tabla "departamentos" permanentemente.

-- Eliminar todos los registros de la tabla "empleados" pero mantener la tabla.

-- Renombrar la tabla "empleados" a "staff".

-- Definir 0 como valor predeterminado en la comlumna "salario".

-- Crear un nuevo esquema llamado "rh_db".

-- Mover la tabla "empleados" al esquema "rh_db".
