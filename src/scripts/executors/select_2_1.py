from src.scripts.executors.base import BaseExecutor


class Select21Executor(BaseExecutor):
    file_name = "../select_2_1.sql"


if __name__ == "__main__":
    print(Select21Executor().fetch())
