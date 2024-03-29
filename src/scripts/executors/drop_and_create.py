from src.scripts.executors import BaseExecutor
from src.utils.database import drop_and_create


class DropAndCreate(BaseExecutor):
    file_name = None
    index = "drop_and_create"

    def fetch(self, *options, **kwargs):
        is_done = drop_and_create()
        print(is_done)
        return is_done
