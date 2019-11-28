from pathlib import Path

from src.scripts.executors.base import BaseExecutor


class Select4Executor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "select_4.sql"

    index = "4"
