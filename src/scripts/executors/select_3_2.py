from src.scripts.executors.base import BaseExecutor
import operator


class Executor(BaseExecutor):
    file_name = '../select_3_2.sql'

    def fetch(self):
        results: list = super().fetch()
        all_ids = {p_id for _, _, p_id in results}
        id_to_is_good = dict(zip(all_ids, [True]*len(all_ids)))

        for id in all_ids:
            for date_from, date_until, _ in results:
                if results.count((date_from, date_until, id)) < 2:
                    id_to_is_good[id] = False

        good_ids = filter(operator.itemgetter(1), id_to_is_good.items())
        return list(map(operator.itemgetter(0), good_ids))


if __name__ == '__main__':
    print(Executor().fetch())