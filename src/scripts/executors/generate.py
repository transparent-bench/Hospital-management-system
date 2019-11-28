from src.scripts.executors.base import BaseExecutor
from src.utils.generation import create_population


class GenerateExecutor(BaseExecutor):
    index = 'generate'
    file_name = None

    def fetch(self, *options, **kwargs) -> None:
        create_population(is_print=True)
