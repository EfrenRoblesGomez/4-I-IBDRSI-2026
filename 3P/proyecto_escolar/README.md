# Sistema Web Escolar - Version Alfa

Este proyecto es la base de un sistema web escolar desarrollado con Flask y SQLAlchemy. Su objetivo final es apoyar tareas de control academico como la gestion de usuarios, grupos, materias, docentes, planeaciones y registros administrativos.

En el estado actual, el proyecto funciona como una version alfa enfocada en validar la estructura inicial de la aplicacion, la configuracion de Flask, la conexion con MySQL y una ruta de prueba que consulta la tabla `usuarios`.

## Estado actual

La aplicacion ya cuenta con:

- Fabrica de aplicacion en Flask mediante `create_app()`.
- Configuracion centralizada en `config.py`.
- Conexion a base de datos con Flask-SQLAlchemy y PyMySQL.
- Modelo inicial `Usuario`.
- Ruta `/test` para comprobar consultas a la tabla `usuarios`.
- Script SQL base en `database/schema.sql` para crear la estructura de la base de datos.
- Archivos reservados para futuros modelos y rutas de alumnos, grupos, materias y planeacion.

Algunos modulos aun estan en preparacion. Los archivos de rutas y modelos como `alumnos.py`, `grupos.py`, `materias.py` y `planeacion.py` existen como parte de la estructura del proyecto, pero todavia no contienen logica funcional.

## Tecnologias

- Python
- Flask
- Flask-SQLAlchemy
- PyMySQL
- MySQL o MariaDB

## Requisitos

- Python 3.11 o superior
- MySQL/MariaDB, o acceso a una base de datos MySQL compatible
- `pip` para instalar dependencias
- Entorno virtual recomendado

## Instalacion

### 1. Entrar al proyecto

```bash
cd proyecto_escolar
```

### 2. Crear un entorno virtual

```bash
python -m venv .venv
```

### 3. Activar el entorno virtual

En Windows:

```bash
.\.venv\Scripts\activate
```

En macOS/Linux:

```bash
source .venv/bin/activate
```

### 4. Instalar dependencias

```bash
pip install -r requeriments.txt
```

> Nota: el archivo de dependencias se llama `requeriments.txt` en este proyecto.

## Configuracion

La configuracion principal esta en `config.py`, dentro de la clase `Configuracion`.

La aplicacion usa estas variables:

- `SECRET_KEY`: clave secreta de Flask. Si no existe, se genera automaticamente con `create_key.py` y se guarda en `.secret_key`.
- `DATABASE_URL`: cadena de conexion a MySQL. Si no se define, se usa la URL configurada por defecto en `config.py`.

Ejemplo de conexion local:

```bash
set DATABASE_URL=mysql+pymysql://usuario:password@localhost:3306/control_escolar
```

En PowerShell:

```powershell
$env:DATABASE_URL="mysql+pymysql://usuario:password@localhost:3306/control_escolar"
```

## Base de datos

El archivo `database/schema.sql` contiene una propuesta de estructura para el sistema escolar, incluyendo tablas como:

- `usuarios`
- `turnos`
- `grupos`
- `materias`
- `docentes`
- `planeaciones`
- `logs_login`
- `audit_logs`

Para cargar el script en MySQL:

```bash
mysql -u root -p < database/schema.sql
```

Tambien debe considerarse que, al iniciar la aplicacion, Flask-SQLAlchemy ejecuta `db.create_all()` dentro de `app/__init__.py`. Esto crea las tablas definidas por los modelos disponibles en Python. Actualmente, el modelo implementado es `Usuario`.

## Ejecucion

Para iniciar el servidor de desarrollo:

```bash
python run.py
```

La aplicacion se ejecuta en:

```text
http://127.0.0.1:5000
```

## Ruta disponible

### `/test`

Ruta de prueba que consulta la tabla `usuarios` usando el modelo `Usuario`.

Muestra:

- Si la consulta se ejecuto correctamente.
- La cantidad de registros encontrados.
- El primer usuario registrado.
- Una lista de nombres disponibles.

Esta ruta sirve para comprobar que Flask, SQLAlchemy y la base de datos estan comunicandose correctamente.

## Estructura del proyecto

```text
proyecto_escolar/
+-- app/
|   +-- models/
|   |   +-- alumno.py
|   |   +-- grupo.py
|   |   +-- materia.py
|   |   +-- planeacion.py
|   |   +-- usuario.py
|   +-- routes/
|   |   +-- alumnos.py
|   |   +-- grupos.py
|   |   +-- materias.py
|   |   +-- planeacion.py
|   |   +-- test.py
|   +-- __init__.py
+-- database/
|   +-- schema.sql
+-- .secret_key
+-- config.py
+-- create_key.py
+-- requeriments.txt
+-- run.py
+-- README.md
```

## Archivos principales

- `run.py`: punto de entrada de la aplicacion.
- `app/__init__.py`: crea la aplicacion Flask, inicializa la base de datos y registra rutas.
- `config.py`: define la configuracion de Flask y SQLAlchemy.
- `create_key.py`: genera y reutiliza una clave secreta local.
- `app/models/usuario.py`: modelo inicial para la tabla `usuarios`.
- `app/routes/test.py`: ruta de prueba para validar consultas.
- `database/schema.sql`: script SQL con la estructura propuesta de la base de datos.

## Problemas comunes

### No se encuentra un modulo de Flask o SQLAlchemy

Instala las dependencias:

```bash
pip install -r requeriments.txt
```

### Error de conexion a la base de datos

Revisa que:

- La URL de conexion sea correcta.
- La base de datos este disponible.
- El usuario y la contrasena tengan permisos.
- Si usas una base remota, la configuracion SSL sea compatible.

### La ruta `/test` marca error con la tabla `usuarios`

Verifica que la tabla exista y que sus columnas coincidan con el modelo `Usuario` definido en `app/models/usuario.py`.

## Siguientes pasos sugeridos

- Alinear completamente el modelo `Usuario` con el script `schema.sql`.
- Implementar los modelos pendientes: alumnos, grupos, materias y planeaciones.
- Registrar nuevos blueprints para las rutas funcionales.
- Agregar plantillas HTML para las vistas del sistema.
- Implementar autenticacion y control de roles.
- Separar credenciales sensibles mediante variables de entorno.

## Autor

Efren Alexander Robles Gomez - 4o I  
Centro de Bachillerato Tecnologico Industrial y de Servicios No. 246  
Proyecto escolar: Sistema de Control Academico
