from src.scripts.executors import BaseExecutor


def fetch_by_index(index, *options, **kwargs):
    return BaseExecutor.get_subclass(index)().fetch(*options, **kwargs)


if __name__ == '__main__':
    print(fetch_by_index('1', '+39950937634'))
