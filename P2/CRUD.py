
from MyDataBase import MyDatabase
from Constants import Constants

class CRUD:
    def __init__(self):
        const = Constants()
        self.conn = MyDatabase(
            const.decrypt(Constants.e_host),
            int(const.decrypt(Constants.e_port)),
            const.decrypt(Constants.e_database),
            const.decrypt(Constants.e_user),
            const.decrypt(Constants.e_password)
        )

    def create_profile(self, name, alias, token, birthdate, email, lang_code, routine, alarm, inactivity_time, inactivity_type):
        sql = (
            "INSERT INTO defaultdb.profiles "
            "(name, alias, token, birthdate, email, lang_code, `routine`, alarm, inactivity_time, inactivity_type) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
        )
        params = (name, alias, token, birthdate, email, lang_code, routine, alarm, inactivity_time, inactivity_type)
        return self.conn.query(sql, params)

    def get_profile(self):
        sql = (
            "SELECT idx, name, alias, token, birthdate, email, lang_code, `routine`, alarm, inactivity_time, inactivity_type "
            "FROM defaultdb.profiles;"
        )
        return self.conn.query(sql)

    def set_profile(self, name, alias, token, birthdate, email, lang_code, routine, alarm, inactivity_time, inactivity_type):
        return self.create_profile(name, alias, token, birthdate, email, lang_code, routine, alarm, inactivity_time, inactivity_type)

    def update_profile(self, name, alias, token, birthdate, email, lang_code, routine, alarm, inactivity_time, inactivity_type, idx):
        sql = (
            "UPDATE defaultdb.profiles "
            "SET name=%s, alias=%s, token=%s, birthdate=%s, email=%s, lang_code=%s, `routine`=%s, alarm=%s, inactivity_time=%s, inactivity_type=%s "
            "WHERE idx=%s;"
        )
        params = (name, alias, token, birthdate, email, lang_code, routine, alarm, inactivity_time, inactivity_type, idx)
        return self.conn.query(sql, params)

    def delete_profile(self, idx):
        sql = "DELETE FROM defaultdb.profiles WHERE idx=%s;"
        return self.conn.query(sql, (idx,))
    