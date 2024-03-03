import pandas as pd
from fastapi import FastAPI
from sqlalchemy import create_engine, engine


def get_mysql_financialdata_conn() -> engine.base.Connection:
    address = "mysql+pymysql://root:test@127.0.0.1:3306/vtuberdata"
    engine = create_engine(address)
    connect = engine.connect()
    return connect


app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/vtuber_data")
def vtuber_data(
    name: str = "",
):
    sql = f"""
    select * from VtuberSC
    where name LIKE '%%{name}%%'
    """
    mysql_conn = get_mysql_financialdata_conn()
    data_df = pd.read_sql(sql, con=mysql_conn)
    data_dict = data_df.to_dict("records")
    return {"data": data_dict}
