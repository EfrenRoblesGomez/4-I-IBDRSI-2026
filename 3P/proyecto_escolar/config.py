import os
import create_key

class Configuracion:
    SECRET_KEY = os.environ.get('SECRET_KEY') or create_key.secret_key()
    SQLALCHEMY_DATABASE_URI = os.environ.get(
        'DATABASE_URL',
        'mysql+pymysql://avnadmin:AVNS_WE9_KEHQsbc15PD5FHE@mysql-f382ebf-cbtis.b.aivencloud.com:26910/defaultdb'
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ENGINE_OPTIONS = {
        'connect_args': {
            'ssl': {
                'ssl_mode': 'REQUIRED'
            }
        }
    }