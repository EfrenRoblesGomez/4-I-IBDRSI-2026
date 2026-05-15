import pymysql
import copy

class MyDatabase:

    def __init__(self, host, port, database, user, password):
        timeout = 10
        self.connection = pymysql.connect(
            charset="utf8mb4",
            connect_timeout=timeout,
            cursorclass=pymysql.cursors.DictCursor,
            database=database,
            host=host,
            password=password,
            read_timeout=timeout,
            port=port,
            user=user,
            write_timeout=timeout,
        )

    def query(self, query, params=None):
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(query, params)
                if cursor.description is not None:
                    results_original = cursor.fetchall()
                else:
                    results_original = []
                self.connection.commit()
                return copy.deepcopy(results_original)
        except Exception:
            self.connection.rollback()
            raise

    def close(self):
        self.connection.close()
