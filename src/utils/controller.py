from src.scripts.executors import CreateSchemaExecutor
import psycopg2

db_name = "hospital_management_system"


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
            CreateSchemaExecutor().fetch(fetch_results=False)
