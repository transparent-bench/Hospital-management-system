from src.scripts.executors import BaseExecutor

from pathlib import Path


class CreateSchemaExecutor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "create_schema.sql"
    index = 'create_schema'
