from flask import Blueprint, render_template
from app.models.usuario import Usuario

bp = Blueprint('usuarios', __name__, url_prefix='/usuarios')


@bp.route('')
@bp.route('/')
def index():
    try:
        usuarios = Usuario.query.all()
    except Exception:
        usuarios = []

    return render_template('usuarios/index.html', usuarios=usuarios)
