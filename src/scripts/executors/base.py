import pathlib
from abc import ABC, abstractmethod

from src import config
from src.utils.database import Database


class BaseExecutor(ABC):
    @property
    @abstractmethod
    def file_name(self) -> pathlib.Path:
        raise NotImplementedError

    @property
    @abstractmethod
    def index(self) -> str:
        raise NotImplementedError

    def fetch(self, *options, **kwargs):
        with Database() as db:
            db._check_if_opened()

            with open(self.file_name, "r") as file:
                sql_query = file.read()
                if options:
                    sql_query = sql_query.format(*options)
            db.cursor.execute(sql_query)
            if kwargs.get("fetch_results", True):
                results = db.cursor.fetchall()
                return results
            return []

    _subclasses = dict()

    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        cls._subclasses[cls.index] = cls

    @classmethod
    def get_subclass(cls, index: str):
        import src.scripts.executors

        return cls._subclasses.get(index)
