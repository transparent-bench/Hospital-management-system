from pathlib import Path

from src.scripts.executors.base import BaseExecutor


class Select1Executor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "select_1.sql"

    index = '1'

    def fetch(self, *options, **kwargs):
        if not options:
            raise RuntimeError("Provide patient's phone number")
        return super().fetch(*options, **kwargs)


if __name__ == "__main__":
    print(Select1Executor().fetch("+16674091351"))
