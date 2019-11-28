import psycopg2

db_name = "hospital_management_system"


class Database:
    def __init__(self):
        self.conn = None
        self.cursor = None

    def open(self, dbname, user, password, host):
        self.conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host)
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
        return rows[len(rows) - limit if limit else 0 :]

    def write(self, table, columns, data, pk="id", is_print: bool = False):
        """
        :return: pk of just inserted row
        """
        query = "INSERT INTO {0} ({1}) VALUES ({2}) RETURNING {3};".format(table, columns, data, pk)
        self.cursor.execute(query)
        self.conn.commit()
        id_of_new_row = self.cursor.fetchone()[0]

        if is_print:
            print(f"{query[:-1]}={id_of_new_row}")
        return id_of_new_row

    def query(self, sql):
        self.cursor.execute(sql)
        rows = self.cursor.fetchall()
        return rows


def drop_and_init():
    drop_database()
    init_database()


def drop_database():
    with psycopg2.connect(database="postgres", user="postgres", password="", host="localhost") as conn:
        with conn.cursor() as cur:
            conn.autocommit = True
            cur.execute(f"DROP DATABASE IF EXISTS {db_name};")


def init_database():
    with psycopg2.connect(database="postgres", user="postgres", password="", host="localhost") as conn:
        with conn.cursor() as cur:
            cur.execute(f"CREATE DATABASE {db_name};")
            from scripts.executors import CreateSchemaExecutor
            CreateSchemaExecutor().fetch(fetch_results=False)
