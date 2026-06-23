create table declaracion(
id int not null auto_increment primary key,
Id_producto int,
Fecha date,
Precio decimal(4,2)
);

insert INTO declaracion(Id_producto, Fecha, Precio)
values
(1001, '2025-01-01', 19.99),
(1001, '2025-04-15', 59.99),
(1001, '2025-06-08', 79.99),
(2002, '2025-04-17', 39.99),
(2002, '2025-05-19', 59.99);

SELECT Id_producto, Fecha, Precio
FROM (
    SELECT 
        Id_producto,
        Fecha,
        Precio,
        ROW_NUMBER() OVER (PARTITION BY Id_producto ORDER BY Fecha DESC) AS rn
    FROM declaracion
) AS t
WHERE rn = 1;
drop table ventas;
create table ventas(
id int not null auto_increment primary key,
Id_orden int,
Id_cliente int,
Fecha date,
Total int,
Estado varchar(15)
);

insert into ventas(Id_orden, Id_cliente, Fecha, Total, Estado)
values
(1, 1001, '2025-01-01', 100, 'JAL'),
(2, 1001, '2025-01-01', 150, 'JAL'),
(3, 1001, '2025-01-01', 75, 'JAL'),
(4, 1001, '2025-02-01', 100, 'JAL'),
(5, 1001, '2025-03-01', 100, 'JAL'),
(6, 2002, '2025-02-01', 75, 'JAL'),
(7, 2002, '2025-02-01', 150, 'JAL'),
(8, 3003, '2025-01-01', 100, 'CDMX'),
(9, 3003, '2025-02-01', 100, 'CDMX'),
(10, 3003, '2025-03-01', 100, 'CDMX'),
(11, 4004, '2025-04-01', 100, 'CDMX'),
(12, 4004, '2025-05-01', 50, 'CDMX'),
(13, 4004, '2025-05-01', 100, 'CDMX');


SELECT distinct Estado
from (
	select Id_cliente, Estado
    from(
		select Id_cliente,
				Estado,
				date_format(fecha, '%y-%m') as mes,
                avg (Total) as promedio_mensual
                from ventas
                group by Id_cliente, Estado, mes
	) t
    group by Id_cliente, Estado
    having min(promedio_mensual) >100
) final;

create table errores(
id int not null auto_increment primary key,
proceso varchar(15),
mensaje varchar(50),
ocurrencia int
);

insert into errores(proceso, mensaje, ocurrencia)
values
('Web', 'Error: No se puede dividir por 0', 3),
('RestAPI', 'Error: Fallo la conversión', 5),
('App', 'Error: Fallo la conversión', 7),
('RestAPI', 'Error: Error sin identificar', 9),
('Web', 'Error: Error sin identificar', 1),
('App', 'Error: Error sin identificar', 10),
('Web', 'Estado Completado', 8),
('RestAPI', 'Estado Completado', 6);

select proceso, mensaje, ocurrencia
from errores l
where ocurrencia = (
	select max(ocurrencia)
    from errores
    where mensaje = l.mensaje
);