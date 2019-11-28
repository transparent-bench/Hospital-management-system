from pathlib import Path

from src.scripts.executors.base import BaseExecutor


class Select31Executor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "select_3_1.sql"

    index = '3-1'
