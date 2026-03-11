CREATE TABLE detalle_horarios (
  horario_id int NOT NULL,
  hora_salida date NOT NULL,
  hora_entrada date NOT NULL,
  codigo_incapacidad varchar(25) DEFAULT NULL,
  PRIMARY KEY (horario_id, hora_salida)
);
 
CREATE TABLE plantilla_detalle_horarios (
  plantilla_id int NOT NULL,
  dia int NOT NULL,
  codigo_incapacidad varchar(25) DEFAULT NULL,
  turno varchar(25) DEFAULT NULL,
  PRIMARY KEY (plantilla_id, dia)
);

CREATE TABLE horarios (
  horario_id int NOT NULL AUTO_INCREMENT,
  plantilla_id int DEFAULT NULL,
  PRIMARY KEY (horario_id)
);
 
INSERT INTO plantilla_detalle_horarios (plantilla_id, dia, codigo_incapacidad, turno)
  VALUES 
  (1, 1, NULL, '1/10'),
  (1, 2, NULL, '1/11,5'),
  (1, 3, NULL, '1/10'),
  (1, 4, NULL, '1/11,5'),
  (1, 5, NULL, '1/10'),
  (1, 6, 'vacaciones', NULL),
  (1, 7, 'vacaciones', NULL),
  (2, 2, NULL, '1/11,5'),
  (2, 3, NULL, '2/11,5'),
  (2, 4, NULL, '1|11.5'),
  (2, 5, NULL, '1/11,5'),
  (2, 6, 'vacaciones', NULL),
  (2, 7, 'vacaciones', NULL),
  (3, 1, NULL, '1#8'),
  (3, 2, NULL, '1.0'),
  (3, 3, 'viaje_negocios', NULL);
 
 
INSERT INTO horarios (horario_id, plantilla_id)
  VALUES (1, 5),
		 (2, 1),
		 (4, 2),
		 (3, 3),
		 (5, 4);