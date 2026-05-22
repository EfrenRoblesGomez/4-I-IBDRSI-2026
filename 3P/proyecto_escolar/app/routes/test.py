from flask import Blueprint
from app.models.usuario import Usuario

bp = Blueprint('test', __name__)


@bp.route('/test')
def test_route():
    try:
        total_usuarios = Usuario.query.count()
        usuarios = Usuario.query.all()
        primer_usuario = Usuario.query.first()

        nombres = [usuario.nombre for usuario in usuarios if usuario.nombre]
        nombres_texto = ', '.join(nombres) if nombres else 'No hay nombres disponibles.'
        primer = primer_usuario.nombre if primer_usuario else 'No hay usuarios.'

        return (
            f"<h1>Ruta de prueba</h1>"
            f"<p>Mensaje: La consulta se ejecutó correctamente.</p>"
            f"<p>Cantidad de registros en usuarios: {total_usuarios}</p>"
            f"<p>Primer usuario: {primer}</p>"
            f"<p>Nombres encontrados: {nombres_texto}</p>"
        )
    except Exception as error:
        return (
            f"<h1>Error en la ruta de prueba</h1>"
            f"<p>No se pudo leer la tabla usuarios.</p>"
            f"<p>Detalle: {error}</p>"
        )
