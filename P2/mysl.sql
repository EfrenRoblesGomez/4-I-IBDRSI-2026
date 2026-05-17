CREATE TABLE `cbtis`.`cliente`(
id int NOT NULL auto_increment PRIMARY KEY,
Customer_ID int,
Type_Phone varchar(25),
Phone_Number varchar(20)
);

INSERT into cbtis.cliente
(Customer_ID, Type_Phone, Phone_Number)
VALUES
(1001, 'Celular', '333-897-5421'),
(1001, 'Trabajo', '333-897-6542'),
(1001, 'Casa', '333-698-9874'),
(2002, 'Celular', '333-963-6544'),
(2002, 'Trabajo', '333-812-9856'),
(3003, 'Celular', '333-987-6541');

SELECT * 
from cliente;

SELECT 
    Customer_ID,
    MAX(CASE WHEN Type_Phone = 'Celular' THEN Phone_Number END) AS Celular,
    MAX(CASE WHEN Type_Phone = 'Trabajo' THEN Phone_Number END) AS Trabajo,
    MAX(CASE WHEN Type_Phone = 'Casa' THEN Phone_Number END) AS Casa
FROM cliente
GROUP BY Customer_ID;

drop TABLE desarrollos;

create table desarrollos(
id int not null auto_increment primary key,
desarrollo varchar(25),
etapa int,
finalizado date NULL
);

insert INTO desarrollos(desarrollo, etapa, finalizado)
values 
('RestAPI', 1, '2024/02/01'),
('RestAPI', 2, '2024/05/30'),
('RestAPI', 3, '2024/06/29'),
('Web', 1, '2024/10/28'),
('Web', 2, '2024/11/20'),
('Web', 3, null),
('App', 1, '2024/01/30'),
('App', 2, null);

SELECT *
FROM desarrollos;

select DISTINCT *
FROM desarrollos
WHERE finalizado is NULL;

create TABLE requerimentos(
id int not null auto_increment primary key,
decripcion varchar(25)
);

insert into requerimentos(decripcion)
values
('geologo'),
('astronomo'),
('tecnico');

create TABLE candidatos(
id int not null auto_increment primary key,
ID_candidato int,
descripcion_candidato varchar(25)
);

insert into candidatos (ID_candidato, descripcion_candidato)
VALUES 
(1001, 'Geólogo'),
(1001, 'Astrónomo'),
(1001, 'Bioquímico'),
(1001, 'Técnico'),
(2002, 'Cirujano'),
(2002, 'Mecánico'),
(2002, 'Geólogo'),
(3003, 'Geólogo'),
(3003, 'Astrónomo'),
(4004, 'Ingeniero');

select *
from candidatos;

SELECT c.ID_candidato
FROM candidatos c
JOIN requerimentos r ON c.descripcion_candidato = r.decripcion
GROUP BY c.ID_candidato
HAVING COUNT(DISTINCT c.descripcion_candidato) = (SELECT COUNT(*) FROM requerimentos);