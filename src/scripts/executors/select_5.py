import operator
from pathlib import Path

from src.scripts.executors.base import BaseExecutor

YEARS = (
    ("10", "9"),
    ("9", "8"),
    ("8", "7"),
    ("7", "6"),
    ("6", "5"),
    ("5", "4"),
    ("4", "3"),
    ("3", "2"),
    ("2", "1"),
    ("1", "0"),
)


class Select5Executor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "select_5.sql"

    index = '5'

    def fetch(self, *options, **kwargs) -> list:
        id_sums = {}
        result: list = []
        for time_from, time_until in YEARS:
            year_results = super().fetch(time_from, time_until, *options, **kwargs)
            for d_id, _, _, appointments in year_results:
                if time_from == "10":
                    id_sums[str(d_id)] = appointments
                else:
                    if d_id in map(int, id_sums.keys()):
                        id_sums[str(d_id)] += appointments

        for k, v in id_sums.items():
            if v >= 100:
                result.append((k, v))
        return result


if __name__ == "__main__":
    print(Select5Executor().fetch())
