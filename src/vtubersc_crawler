import time
import typing

import pandas as pd
import requests
from pydantic import BaseModel
from loguru import logger
from tqdm import tqdm

from sqlalchemy import (
    create_engine,
    engine,
)

def clean_data(
    df: pd.DataFrame,
) -> pd.DataFrame:
    df["rank"] = [
        df["index"][col]["rank"]
        for col in df.index
    ]
    
    key_to_check = "rankFluc"

    df["rankFluc"] = [
        str(df["index"][col]["rankFluc"])
        if key_to_check in df["index"][col]
        else
        'nope'
        for col in df.index
    ]
    
    df["name"] = [
        df["channel"][col]["name"]
        for col in df.index
    ]
    df = df.drop(["index"], axis=1)
    df = df.drop(["channel"], axis=1)
    df = df.fillna("0.0")
    
    return df

def col_name(
    df: pd.DataFrame,
    colname: typing.List[str],
) -> pd.DataFrame:
    vtuber_data = {
        "itemId": "itemId",
        "period": "",
        "pscore": "",
        "pplay": "",
        "plike": "",
        "pdislike": "",
        "channelPlayCount": "channelPlayCount",
        "channelPlayFluc": "",
        "subscriberCount": "subscriberCount",
        "subscriberFluc": "subscriberFluc",
        "maxLiveViewer": "maxLiveViewer",
        "donationAmount": "donationAmount",
        "donationCount": "donationCount",
        "index": "index",
        "channel": "channel",
        "videos": "",
    }
    df.columns = [
        vtuber_data[col]
        for col in colname
    ]
    df = df.drop([""], axis=1)
    return df

class vtuberdata(BaseModel):
    itemId: str
    channelPlayCount: float
    subscriberCount: float
    subscriberFluc: float
    maxLiveViewer: int
    donationAmount: float
    donationCount: int
    rank: int
    rankFluc: str
    name: str

def check_schema(
    df: pd.DataFrame,
) -> pd.DataFrame:
    """檢查資料型態, 確保每次要上傳資料庫前, 型態正確"""
    df_dict = df.to_dict("records")
    df_schema = [
        vtuberdata(**dd).__dict__ # **字典的意思
        for dd in df_dict
    ]
    df = pd.DataFrame(df_schema)
    return df

def header():
    return {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0"
        }

def crawler_twse(
    period: str,
) -> pd.DataFrame:
    # headers 中的 Request url
    url = (
            "https://api.playboard.co/v1/chart/channel"
            "?locale=en&countryCode=TW&period={period}&size=20&chartTypeId=10&periodTypeId=3&indexDimensionId=41&indexTypeId=3&indexTarget=v-tuber&indexCountryCode=JP"
        )
    url = url.format(
        period = period
    )
    # request method
    res = requests.get(
        url, headers=header()
    )
    time.sleep(5)

    try:
        df = pd.DataFrame(res.json()["list"])# dataframe注意大小寫
        colname = df.columns
    except BaseException:
        return pd.DataFrame()
    
    if len(df) == 0:
        return pd.DataFrame()
    
    df = col_name(
        df.copy(), colname
    )
    return df

def get_mysql_financialdata_conn() -> engine.base.Connection:
    """
    user: root
    password: test
    host: localhost
    port: 3306
    database: financialdata
    如果有實體 IP，以上設定可以自行更改
    """
    address = "mysql+pymysql://root:test@localhost:3306/vtuberdata"
    engine = create_engine(address)
    connect = engine.connect()
    return connect

def period_list(
    period: int
) -> typing.List[str]:
    date_list = [
        str(
            period - (week*604800)
        )
        for week in range(1,53)
    ]
    return date_list

def main():
    period = 1708300800
    
    for period in tqdm(period_list(period)):
        logger.info(period)
        df = crawler_twse(period=period)
        if len(df) > 0:
            # 資料清理
            df = clean_data(df.copy())
            # upload db
            try:
                df.to_sql(
                    name="VtuberSC",
                    con=get_mysql_financialdata_conn(),
                    if_exists="append",
                    index=False,
                    chunksize=1000,
                )
            except Exception as e:
                logger.info(e)


if __name__ == "__main__":
    main()
