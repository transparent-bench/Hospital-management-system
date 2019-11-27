from src.scripts.executors.base import BaseExecutor


class Select1Executor(BaseExecutor):
    file_name = "../select_1.sql"

    def fetch(self, *options):
        if not options:
            raise RuntimeError("Provide patient's phone number")
        return super().fetch(*options)


if __name__ == "__main__":
    print(Select1Executor().fetch("+69998845204"))
