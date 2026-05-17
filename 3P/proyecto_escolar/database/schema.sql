-- =====================================================
-- SISTEMA DE CONTROL ESCOLAR
-- =====================================================

CREATE DATABASE IF NOT EXISTS control_escolar
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE control_escolar;

-- =====================================================
-- TABLA: usuarios
-- =====================================================

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,

    email VARCHAR(150) NOT NULL UNIQUE,

    password VARCHAR(255) NOT NULL,

    rol ENUM(
        'admin',
        'docente',
        'control_escolar'
    ) NOT NULL DEFAULT 'control_escolar',

    activo BOOLEAN DEFAULT TRUE,

    ultimo_login DATETIME NULL,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLA: turnos
-- =====================================================

CREATE TABLE turnos (
    id INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL UNIQUE,

    descripcion VARCHAR(255),

    hora_inicio TIME,

    hora_fin TIME,

    activo BOOLEAN DEFAULT TRUE,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLA: grupos
-- =====================================================

CREATE TABLE grupos (
    id INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL,

    semestre INT NOT NULL,

    aula VARCHAR(50),

    turno_id INT NOT NULL,

    activo BOOLEAN DEFAULT TRUE,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_grupo_turno
        FOREIGN KEY (turno_id)
        REFERENCES turnos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- TABLA: materias
-- =====================================================

CREATE TABLE materias (
    id INT AUTO_INCREMENT PRIMARY KEY,

    clave VARCHAR(20) NOT NULL UNIQUE,

    nombre VARCHAR(150) NOT NULL,

    descripcion TEXT,

    creditos INT DEFAULT 0,

    horas_semana INT DEFAULT 0,

    activo BOOLEAN DEFAULT TRUE,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLA: docentes
-- =====================================================

CREATE TABLE docentes (
    id INT AUTO_INCREMENT PRIMARY KEY,

    numero_empleado VARCHAR(30) NOT NULL UNIQUE,

    nombre VARCHAR(100) NOT NULL,

    apellido VARCHAR(100) NOT NULL,

    email VARCHAR(150) UNIQUE,

    telefono VARCHAR(20),

    especialidad VARCHAR(150),

    activo BOOLEAN DEFAULT TRUE,

    fecha_contratacion DATE,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLA: planeaciones
-- =====================================================

CREATE TABLE planeaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,

    grupo_id INT NOT NULL,

    materia_id INT NOT NULL,

    docente_id INT NOT NULL,

    dia_semana ENUM(
        'Lunes',
        'Martes',
        'Miercoles',
        'Jueves',
        'Viernes',
        'Sabado'
    ) NOT NULL,

    hora_inicio TIME NOT NULL,

    hora_fin TIME NOT NULL,

    aula VARCHAR(50),

    periodo_escolar VARCHAR(50),

    observaciones TEXT,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_planeacion_grupo
        FOREIGN KEY (grupo_id)
        REFERENCES grupos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_planeacion_materia
        FOREIGN KEY (materia_id)
        REFERENCES materias(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_planeacion_docente
        FOREIGN KEY (docente_id)
        REFERENCES docentes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- TABLA: logs_login
-- TRACKING DE INICIO DE SESIÓN
-- =====================================================

CREATE TABLE logs_login (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    usuario_id INT NOT NULL,

    email VARCHAR(150),

    ip_address VARCHAR(45),

    user_agent TEXT,

    sistema_operativo VARCHAR(100),

    navegador VARCHAR(100),

    login_exitoso BOOLEAN DEFAULT TRUE,

    mensaje VARCHAR(255),

    fecha_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_logs_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =====================================================
-- TABLA: audit_logs
-- AUDITORÍA GENERAL DEL SISTEMA
-- =====================================================

CREATE TABLE audit_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    usuario_id INT NULL,

    tabla_afectada VARCHAR(100) NOT NULL,

    registro_id INT NOT NULL,

    accion ENUM(
        'INSERT',
        'UPDATE',
        'DELETE'
    ) NOT NULL,

    datos_anteriores JSON NULL,

    datos_nuevos JSON NULL,

    ip_address VARCHAR(45),

    user_agent TEXT,

    fecha_evento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_audit_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =====================================================
-- ÍNDICES
-- =====================================================

CREATE INDEX idx_grupos_turno
ON grupos(turno_id);

CREATE INDEX idx_planeaciones_grupo
ON planeaciones(grupo_id);

CREATE INDEX idx_planeaciones_docente
ON planeaciones(docente_id);

CREATE INDEX idx_planeaciones_materia
ON planeaciones(materia_id);

CREATE INDEX idx_logs_login_usuario
ON logs_login(usuario_id);

CREATE INDEX idx_logs_login_fecha
ON logs_login(fecha_login);

CREATE INDEX idx_audit_tabla
ON audit_logs(tabla_afectada);

CREATE INDEX idx_audit_usuario
ON audit_logs(usuario_id);

CREATE INDEX idx_audit_fecha
ON audit_logs(fecha_evento);

-- =====================================================
-- DATOS INICIALES
-- =====================================================

INSERT INTO turnos (
    nombre,
    descripcion,
    hora_inicio,
    hora_fin
)
VALUES
(
    'Matutino',
    'Turno de mañana',
    '07:00:00',
    '13:00:00'
),
(
    'Vespertino',
    'Turno de tarde',
    '14:00:00',
    '20:00:00'
);

-- =====================================================
-- USUARIO ADMIN INICIAL
-- PASSWORD DEBE ENCRIPTARSE EN FLASK
-- =====================================================

INSERT INTO usuarios (
    nombre,
    apellido,
    email,
    password,
    rol
)
VALUES (
    'Administrador',
    'Sistema',
    'admin@school.local',
    'HASH_PASSWORD',
    'admin'
);

-- =====================================================
-- TRIGGER: AUDITORÍA INSERT GRUPOS
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_grupos_insert
AFTER INSERT ON grupos
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs (
        tabla_afectada,
        registro_id,
        accion,
        datos_nuevos
    )
    VALUES (
        'grupos',
        NEW.id,
        'INSERT',
        JSON_OBJECT(
            'nombre', NEW.nombre,
            'semestre', NEW.semestre,
            'aula', NEW.aula
        )
    );
END$$

DELIMITER ;

-- =====================================================
-- TRIGGER: AUDITORÍA UPDATE GRUPOS
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_grupos_update
AFTER UPDATE ON grupos
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs (
        tabla_afectada,
        registro_id,
        accion,
        datos_anteriores,
        datos_nuevos
    )
    VALUES (
        'grupos',
        NEW.id,
        'UPDATE',

        JSON_OBJECT(
            'nombre', OLD.nombre,
            'semestre', OLD.semestre,
            'aula', OLD.aula
        ),

        JSON_OBJECT(
            'nombre', NEW.nombre,
            'semestre', NEW.semestre,
            'aula', NEW.aula
        )
    );
END$$

DELIMITER ;

-- =====================================================
-- TRIGGER: AUDITORÍA DELETE GRUPOS
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_grupos_delete
AFTER DELETE ON grupos
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs (
        tabla_afectada,
        registro_id,
        accion,
        datos_anteriores
    )
    VALUES (
        'grupos',
        OLD.id,
        'DELETE',

        JSON_OBJECT(
            'nombre', OLD.nombre,
            'semestre', OLD.semestre,
            'aula', OLD.aula
        )
    );
END$$

DELIMITER ;