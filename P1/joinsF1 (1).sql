CREATE TABLE `defaultdb`.`a` (
  `id` INT NOT NULL,
  `pilotos` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);
  
  CREATE TABLE `defaultdb`.`b` (
  `id` INT NOT NULL,
  `pilotos` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);
  
  DROP TABLE `defaultdb`.`a`;
  DROP TABLE `defaultdb`.`b`;
  
  insert into `defaultdb`.`a` 
  ( `id`,`pilotos`) values
  (1,'S. Perez'),
  (2,'M. Botas'),
  (3,'M. Verstappen'),
  (4,'I. Hadjar'),
  (5,'C. Leclerk'),
  (6,'L. Hamilton'),
  (7,'L. Norris');
  
    insert into `defaultdb`.`b` 
  ( `id`,`pilotos`) values
  (1,'G. Russell'),
  (2,'K. Antonelli'),
  (3,'S. Perez'),
  (4,'F. Alonso'),
  (5,'M. Verstappen'),
  (6,'L. Lawson'),
  (7,'L. Hamilton');
  
  select *
  from a
  inner join b on a.pilotos = b.pilotos;
  
  select a.id, a.pilotos, b.pilotos
  from a 
  left join b on a.pilotos = b.pilotos;
  
  select a.id, a.pilotos, b.pilotos
  from a 
  right join b on a.pilotos = b.pilotos;
  
  select *
  from a
  left outer join b on a.pilotos = b.pilotos;
  
  select *
  from a
  right outer join b on a.pilotos = b.pilotos;
  
  select *
  from a
  left join b on a.pilotos = b.pilotos
  
  union
  
  select *
  from a
  right join b on a.pilotos = b.pilotos;
  
