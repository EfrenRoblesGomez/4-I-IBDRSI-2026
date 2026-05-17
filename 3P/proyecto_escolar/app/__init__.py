from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object('config.Configuracion')
    
    db.init_app(app)
    
    with app.app_context():
        from app.routes.test import bp as test_bp
        app.register_blueprint(test_bp)
        db.create_all()
    
    return app