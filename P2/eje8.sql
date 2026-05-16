use cbtis;

drop table VENTAS;

create table VENTAS(
id int not null auto_increment primary key,
año YEAR,
cantidad INT
);

insert into VENTAS(año, cantidad)
values
(2025, 352645),
(2024, 165565),
(2024, 254654),
(2023, 159521),
(2023, 251696),
(2023, 111894);

SELECT
    SUM(CASE WHEN año = 2025 THEN cantidad ELSE 0 END) AS `2025`,
    SUM(CASE WHEN año = 2024 THEN cantidad ELSE 0 END) AS `2024`,
    SUM(CASE WHEN año = 2023 THEN cantidad ELSE 0 END) AS `2023`
FROM VENTAS;

drop table muestra;
CREATE TABLE muestra (
id int not null auto_increment primary key,
valor INTEGER
);

INSERT INTO muestra(valor)
VALUES 
(1),
(1),
(2),
(3),
(3),
(4);

select distinct valor
from muestra;

create TABLE designer(
id int not null auto_increment primary KEY,
fila int,
aplicacion varchar(20) NULL,
estado varchar(25)
);

insert into designer(fila, aplicacion, estado)
values
(1, 'Web', 'Aprobado'),
(2, null,'Fallo'),
(3, NULL, 'Fallo'),
(4, NULL, 'Fallo'),
(5, 'App', 'Aprobado'),
(6, NULL, 'Fallo'),
(7, NULL, 'Fallo'),
(8, null, 'Aprobado'),
(9, null, 'Aprobado'),
(10, 'RESTAPI', 'Fallo'),
(11, null, 'Fallo'),
(12, null, 'Fallo');

WITH cte AS (
    SELECT *,
        COUNT(aplicacion) OVER (ORDER BY  fila) AS grupo
    FROM designer
)
SELECT 
    fila,
    MAX(aplicacion) OVER (PARTITION BY grupo) AS aplicacion,
    estado
FROM cte
ORDER BY fila;