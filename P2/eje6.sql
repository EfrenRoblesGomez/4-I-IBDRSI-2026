create table clasificacion(
id int not null auto_increment primary key,
Id_jugador int,
marcador int
);

insert into clasificacion(Id_jugador, marcador)
values
(1001, 2343),
(2002, 9432),
(3003, 6548),
(4004, 1054),
(5005, 6832);

select 
	case
		when fila <= total/2 then 1
        else 2 
	end as categoria,
    Id_jugador,
    marcador
from (
	select
		Id_jugador,
        marcador,
        row_number() over (order by marcador desc) as fila,
        count(*) over () as total
	from clasificacion
) t;

create table paginacion(
id int not null auto_increment primary key,
Id_orden int,
Id_cliente int,
Fecha date,
Cantidad int,
Estado varchar(25)
);

insert into paginacion(Id_orden, Id_cliente, Fecha, Cantidad, Estado)
values
(1, 1001, '2025-01-01', 100, 'JAL'),
(2, 3003, '2025-01-01', 100, 'COL'),
(3, 1001, '2025-03-01', 100, 'JAL'),
(4, 2002, '2025-02-01', 150, 'JAL'),
(5, 1001, '2025-02-01', 100, 'JAL'),
(6, 4004, '2025-05-01', 50, 'COL'),
(7, 1001, '2025-01-01', 150, 'JAL'),
(8, 3003, '2025-03-01', 100, 'COL'),
(9, 4004, '2025-04-01', 100, 'COL'),
(10, 1001, '2025-01-01', 75, 'JAL'),
(11, 2002, '2025-02-01', 75, 'JAL'),
(12, 3003, '2025-02-01', 100, 'COL'),
(13, 4004, '2025-05-01', 100, 'COL');

select *
from paginacion
order by Id_orden
limit 5 offset 4;

create table proveedores(
id int not null auto_increment primary key,
Id_orden int,
Id_cliente int,
cantidad int,
proveedor varchar(25)
);

insert into proveedores(Id_orden, Id_cliente, cantidad, proveedor)
values
(1, 1001, 12, 'IBM'),
(2, 1001, 54, 'IBM'),
(3, 1001, 32, 'Amazon'),
(4, 2002, 7, 'Amazon'),
(5, 2002, 16, 'Amazon'),
(6, 2002, 5, 'IBM');

select Id_cliente, proveedor
from (
	select
		Id_cliente,
        proveedor,
        count(*) as total_pedidos,
        row_number() over (
			partition by Id_cliente
            order by count(*) desc
		) as ranking
	from proveedores
    group by Id_cliente, proveedor
) t
where ranking =1;