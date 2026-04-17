from cryptography.fernet import Fernet
import base64
import os

class Constants:
    e_host = "Z0FBQUFBQnA0QUxVYjdCTFl2M2dLXzJxaVhlVWp5ZG1OekxmZkJObDlCYXFsRTNLMG0zSUZFamZESXlVaGtlOGt4VFFxcUhGOFo1TFJKNXFZNmJySXNqRHZKY3VDVzhLZ1lES005VTlMYjdpMGUweVlSb3pWaEI1WUJ0UkxKWGtiTmNsQXhhUU5xVnE="
    e_port = "Z0FBQUFBQnA0QUxVcFZEb1BhN2h6enJ2ZjN4TU51R2JONzRUUE1ueHRnYldFaFBBUVVNMnZoYUc4TVVQOHQwSUFiWGFxTElqWU5SR3JTR1Q2QUZ0UXRWNGZrcTRPdkt4Mnc9PQ=="
    e_database = "Z0FBQUFBQnA0QUxVUGw2VEFOY2dRMTFDSmMzeHdMT2x6a2xBTldzenNnbFpLeEszUjFTR2tqVU1Fa1JWbDlBWE0yYnVZcjlZS3dkTk1pbkY2V0tPNzdKZW82TjVNQ1laaWc9PQ=="
    e_user = "Z0FBQUFBQnA0QUxVSDNpeGtqQkg0QkoyN0lZOEh3TDBSSHU3VEVvNzA2WEpaMFFMZEd1Wk9lVHl4NW5fMXVfb2QwWGdoUWtRekk4UUF5dnFjOW41QzJLMzItU1lScHVTclE9PQ=="
    e_password = "Z0FBQUFBQnA0QUxVeU9YTDJKRUhBaHh5ZUVsaUpId04wRlVnc1BieFlBQktxWjFnTl91QWZkM3ZRdmR5YldKZ002YWR6Zmd5enJxaFFHRDZyTl82UmRJdWw5cWZjdHlsWWNsRXhCUzlHeFdUOFpVbjdyWjFmTHc9"

    host = "mysql-f382ebf-cbtis.b.aivencloud.com"
    port = "26910"
    database = "defaultdb"
    user = "avnadmin"
    password = "AVNS_WE9_KEHQsbc15PD5FHE"

    def generate_and_save_key(self, key_filename="secret.key"):
        """Generates a key and saves it to a file."""
        key = Fernet.generate_key()
        with open(key_filename, "wb") as key_file:
            key_file.write(key)
        print(f"New key generated and saved to {key_filename}")

    def load_key(self, key_filename="secret.key"):
        """Loads the key from the current directory's file. Generates it if it doesn't exist."""
        if not os.path.exists(key_filename):
            self.generate_and_save_key(key_filename)
        with open(key_filename, "rb") as key_file:
            return key_file.read()

    def encrypt(self, string):
        key = self.load_key()
        f = Fernet(key)
        encrypted_bytes = f.encrypt(string.encode())
        return base64.urlsafe_b64encode(encrypted_bytes).decode("utf-8")

    def decrypt(self, string):
        key = self.load_key()
        f = Fernet(key)
        decrypted_bytes = f.decrypt(base64.urlsafe_b64decode(string))
        return decrypted_bytes.decode()

if __name__ == "__main__":
    const = Constants()
    print(f"Encrypted host : {const.encrypt(Constants.host)}")
    print(f"Encrypted port : {const.encrypt(Constants.port)}")
    print(f"Encrypted database : {const.encrypt(Constants.database)}")
    print(f"Encrypted user : {const.encrypt(Constants.user)}")
    print(f"Encrypted password : {const.encrypt(Constants.password)}")
