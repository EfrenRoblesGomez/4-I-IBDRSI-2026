from app import db


class Usuario(db.Model):
    __tablename__ = 'usuarios'
    
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100))
    usuario = db.Column(
        db.String(50), 
        unique=True
        )
    contraseña = db.Column(db.String(255))
    
    rol = db.Column(db.String(20))