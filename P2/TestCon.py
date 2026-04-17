from MyDataBase import MyDatabase
from Constants import Constants

if __name__ == "__main__":
    const = Constants()
    conn = MyDatabase(
        const.decrypt(Constants.e_host),
        int(const.decrypt(Constants.e_port)),
        const.decrypt(Constants.e_database),
        const.decrypt(Constants.e_user),
        const.decrypt(Constants.e_password)
    )

    conn.query("CREATE TABLE IF NOT EXISTS mytest (id INTEGER PRIMARY KEY)")
    conn.query("INSERT INTO mytest (id) VALUES (1), (2)")
    result = conn.query("SELECT * FROM mytest")
    print(result)
    conn.close()

