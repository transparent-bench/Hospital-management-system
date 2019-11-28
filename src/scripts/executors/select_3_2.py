import operator
from pathlib import Path

from src.scripts.executors.base import BaseExecutor


class Select32Executor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "select_3_2.sql"

    index = "3-2"

    def fetch(self, *options, **kwargs):
        results: list = super().fetch(*options, **kwargs)
        all_ids = {p_id for _, _, p_id in results}
        id_to_is_good = dict(zip(all_ids, [True] * len(all_ids)))

        for id in all_ids:
            for date_from, date_until, _ in results:
                if results.count((date_from, date_until, id)) < 2:
                    id_to_is_good[id] = False

        good_ids = filter(operator.itemgetter(1), id_to_is_good.items())
        return list(map(operator.itemgetter(0), good_ids))


if __name__ == "__main__":
    print(Select32Executor().fetch())
