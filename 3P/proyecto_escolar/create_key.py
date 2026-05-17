import os
import secrets

SECRET_KEY_FILE = os.path.join(os.path.dirname(__file__), '.secret_key')

def secret_key():
    """Return a persistent secret key stored in a file.

    If the file does not exist, generate a new key and save it.
    """
    if os.path.exists(SECRET_KEY_FILE):
        with open(SECRET_KEY_FILE, 'r', encoding='utf-8') as f:
            key = f.read().strip()
            if key:
                return key

    key = secrets.token_hex(32)
    with open(SECRET_KEY_FILE, 'w', encoding='utf-8') as f:
        f.write(key)
    return key