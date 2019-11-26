from abc import ABC, abstractmethod

from src.utils.database import Database


class BaseExecutor(ABC):

    @property
    @abstractmethod
    def file_name(self) -> str:
        raise NotImplementedError

    def fetch(self):
        with Database() as db:
            db.open(dbname="hospital_management_system", user="postgres", password="", host="localhost")
            with open(self.file_name, 'r') as file:
                sql_query = file.read()
            db.cursor.execute(sql_query)
            results = db.cursor.fetchall()
            return results