import psycopg2


class Database:
    def __init__(self):
        self.conn = None
        self.cursor = None


    def open(self, dbname, user, password, host):
        self.conn = psycopg2.connect(dbname=dbname,
                                     user=user,
                                     password=password,
                                     host=host)
        self.cursor = self.conn.cursor()

    def close(self):
        if self.conn:
            self.conn.commit()
            self.cursor.close()
            self.conn.close()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()

    def get(self, table, columns, limit=None):
        query = "SELECT {0} from {1};".format(columns, table)
        self.cursor.execute(query)
        rows = self.cursor.fetchall()
        return rows[len(rows) - limit if limit else 0:]

    def write(self, table, columns, data, pk='id', is_print=True):
        """
        :return: id of just inserted row
        """
        query = "INSERT INTO {0} ({1}) VALUES ({2}) RETURNING {3};".format(table, columns, data, pk)
        if is_print:
            print(query)
        self.cursor.execute(query)
        self.conn.commit()
        return self.cursor.fetchone()[0]

    def query(self, sql):
        self.cursor.execute(sql)
        rows = self.cursor.fetchall()
        return rows
