# Sistema de Control Escolar

Sistema web para la gestión de información académica de una institución educativa. Permite administrar estudiantes, grupos, materias, calificaciones y horarios.

## Características

- 👤 Gestión de usuarios (administradores, docentes, personal de control escolar)
- 📚 Administración de estudiantes y grupos
- 📖 Registro de materias y contenido académico
- 📋 Planeación didáctica y horarios
- 📊 Registro de calificaciones
- 🔐 Sistema de autenticación y autorización

## Requisitos

- Python 3.11+
- MySQL/MariaDB
- pip (gestor de paquetes de Python)

## Instalación

### 1. Clonar o descargar el proyecto

```bash
cd proyecto_escolar
```

### 2. Crear un entorno virtual

```bash
python -m venv .venv
```

### 3. Activar el entorno virtual

**En Windows:**
```bash
.\.venv\Scripts\activate
```

**En macOS/Linux:**
```bash
source .venv/bin/activate
```

### 4. Instalar dependencias

```bash
pip install -r requeriments.txt
```

### 5. Configurar la base de datos

Edita `config.py` con tus credenciales de MySQL:

```python
SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://usuario:contraseña@localhost:3306/control_escolar'
```

### 6. Inicializar la base de datos

Ejecuta el script SQL en tu cliente MySQL:

```bash
mysql -u root -p < database/schema.sql
```

## Uso

### Ejecutar la aplicación

```bash
python run.py
```

La aplicación estará disponible en `http://127.0.0.1:5000`

### Rutas disponibles

- `/test` - Ruta de prueba para verificar la conexión a la base de datos

## Estructura del proyecto

```
proyecto_escolar/
├── app/
│   ├── models/              # Modelos de la base de datos
│   │   ├── alumno.py
│   │   ├── grupo.py
│   │   ├── materia.py
│   │   ├── planeacion.py
│   │   └── usuario.py
│   ├── routes/              # Rutas y controladores
│   │   ├── alumnos.py
│   │   ├── grupos.py
│   │   ├── materias.py
│   │   ├── planeacion.py
│   │   └── test.py
│   ├── templates/           # Plantillas HTML
│   │   ├── alumnos/
│   │   ├── auth/
│   │   ├── calificaciones/
│   │   ├── docentes/
│   │   ├── grupos/
│   │   └── materias/
│   ├── static/              # Archivos estáticos
│   │   ├── css/
│   │   ├── img/
│   │   └── js/
│   ├── utils/               # Utilidades y funciones auxiliares
│   └── __init__.py
├── database/
│   └── schema.sql           # Script de creación de tablas
├── config.py                # Configuración de la aplicación
├── run.py                   # Punto de entrada de la aplicación
├── create_key.py            # Generador de claves secretas
├── requeriments.txt         # Dependencias del proyecto
└── README.md                # Este archivo
```

## Configuración

### Variables de entorno

Puedes configurar las siguientes variables de entorno:

- `SECRET_KEY` - Clave secreta de Flask (generada automáticamente si no se proporciona)
- `DATABASE_URL` - URL de conexión a la base de datos

### Archivo config.py

El archivo `config.py` contiene la configuración principal de la aplicación:

```python
class Configuracion:
    SECRET_KEY = os.environ.get('SECRET_KEY') or create_key.secret_key()
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL', 'mysql+pymysql://...')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ENGINE_OPTIONS = {
        'connect_args': {
            'ssl': {
                'ssl_mode': 'REQUIRED'
            }
        }
    }
```

## Desarrollo

### Activar modo debug

El servidor Flask se ejecuta en modo debug por defecto. Esto permite:

- Recarga automática al cambiar archivos
- Depurador interactivo en caso de errores
- Salida detallada en consola

### Instalar dependencias de desarrollo

```bash
pip install flask-sqlalchemy flask-login pymysql
```

## Problemas comunes

### Error: ModuleNotFoundError: No module named 'flask_sqlalchemy'

**Solución:** Instala las dependencias:
```bash
pip install -r requeriments.txt
```

### Error de conexión a la base de datos

**Solución:** Verifica que:
1. MySQL esté corriendo
2. Las credenciales en `config.py` sean correctas
3. La base de datos esté creada

### Puerto 5000 ya en uso

**Solución:** Ejecuta Flask en un puerto diferente:
```bash
python run.py --port 5001
```

O termina el proceso usando el puerto 5000:
```bash
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

## Contribuciones

Las contribuciones son bienvenidas. Para cambios importantes, abre un issue primero para discutir los cambios propuestos.

## Licencia

Proyecto de código abierto. Libre para usar y modificar.

## Autor

Efrén Alexander Robles Gomez - 4°I
Centro de Bachillerato Tecnologico Industrial y de Servicios N°246
Proyecto Escolar - Sistema de Control Académico
