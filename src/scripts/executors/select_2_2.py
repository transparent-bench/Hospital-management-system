from src.scripts.executors.base import BaseExecutor

TIMESLOTS = (
    ("9:00", "10:00"),
    ("10:00", "11:00"),
    ("12:00", "13:00"),
    ("14:00", "15:00"),
    ("16:00", "17:00"),
)


class Select22Executor(BaseExecutor):
    file_name = "../select_2_2.sql"

    def fetch(self):
        results = []
        for time_from, time_until in TIMESLOTS:
            results.append(super().fetch(time_from, time_until))
        return results


if __name__ == "__main__":
    print(Select22Executor().fetch())
