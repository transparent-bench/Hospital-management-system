from src.scripts.executors import BaseExecutor


def fetch_by_index(index):
    return BaseExecutor.get_subclass(index)().fetch(index)


if __name__ == '__main__':
    print(fetch_by_index('1'))
