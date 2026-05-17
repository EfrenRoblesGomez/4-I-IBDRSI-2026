create table flujos(
id int not null auto_increment primary key,
flujo varchar(25),
paso int,
estado varchar(15)
);

insert into flujos(flujo, paso, estado)
values

('Alpha', 1, 'Error'),
('Alpha', 2, 'Finalizado'),
('Alpha', 3, 'Corriendo'),
('Bravo', 1, 'Finalizado'),
('Bravo', 2, 'Finalizado'),
('Charlie', 1, 'Corriendo'),
('Charlie', 2, 'Corriendo'),
('Delta', 1, 'Error'),
('Delta', 2, 'Error'),
('Echo', 1, 'Corriendo'),
('Echo', 2, 'Finalizado');

select
	flujo,
    case
		when sum(estado = 'Error') > 0
			and sum(estado = 'Finalizado') > 0 then 'indeterminado'
            
		when sum(estado = 'Error') > 0 then 'error'
        
        when sum(estado = 'Corriendo') > 0 then 'corriendo'
        
        when sum(estado = 'Finalizado') > 0 then 'Finalizado'
        
        else 'Indeterminado'
	end as estado
from flujos
group by flujo;

create table valores(
id int not null auto_increment primary key,
secuencia int,
sintaxis varchar(25)
);

insert into valores(secuencia, sintaxis)
values
(1, 'SELECT'),
(2, 'Producto,'),
(3, 'Precio,'),
(4, 'Disponibilidad,'),
(5, 'FROM'),
(6, 'Productos'),
(7, 'WHERE'),
(8, 'Precio'),
(9, '>100');

select group_concat(sintaxis, ' ') as sintaxis
from valores;

create table juego(
id int not null auto_increment primary key,
jugadorA int,
jugadorB int,
marcador int
);

insert into juego(jugadorA, jugadorB, marcador)
values
(1001, 2002, 150),
(3003, 4004, 15),
(4004, 3003, 125);

SELECT 
    LEAST(jugadorA, jugadorB) AS jugadorA,
    GREATEST(jugadorA, jugadorB) AS jugadorB,
    SUM(marcador) AS marcador
FROM juego
GROUP BY 
    LEAST(jugadorA, jugadorB),
    GREATEST(jugadorA, jugadorB);