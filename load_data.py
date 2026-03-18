"""
Simple script to read a csv file and load it into Snowflake with write_pandas()

"""

import yaml
import pandas as pd
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas

DATA_FILE = "Vektis Open Databestand Zorgverzekeringswet 2023 - gemeente.csv"
DATABASE = "proefkeuken"
SCHEMA = "brons"
TABLE = "vektisdata"


def read_data(file: str) -> pd.DataFrame:
    df = pd.read_csv(file, sep=";")
    return df


def read_config():
    """Reads the config file (hardcoded ./config/config.yml)"""

    with open("./config/config.yml", "r") as conf:
        configuration = yaml.safe_load(conf)

    return configuration


def create_connection(config: dict):
    """Creates a Snowflake connection"""

    return snowflake.connector.connect(**config)


def save_dataframe(connection, dataframe, table, database, schema):
    """
    Save a dataframe directly into Snowflake

    More information: https://docs.snowflake.com/en/developer-guide/python-connector/python-connector-api#write_pandas
    """

    return write_pandas(
        conn=connection,
        df=dataframe,
        table_name=table,
        database=database,
        schema=schema,
        quote_identifiers=False,
        use_logical_type=True,
    )


def run_script():
    config = read_config()
    db_conn = create_connection(config)
    df = pd.read_csv(DATA_FILE, sep=";")
    result = save_dataframe(db_conn, df, TABLE, DATABASE, SCHEMA)
    print(result)


if __name__ == "__main__":
    run_script()
