from src.scripts.executors.base import BaseExecutor
from src.scripts.test_data.select_1 import populate


class Select1GenerationExecutor(BaseExecutor):
    file_name = None
    index = "td_1"

    def fetch(self, *options, **kwargs):
        return populate(is_print=True)
