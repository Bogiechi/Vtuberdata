# 建立直播主的SuperChat相關資料爬蟲

## Instruction

### 建立資料庫
`docker volume create mysql`

`docker-compose -f mysql.yml up`

### 建立API
`poetry run uvicorn main:app --reload --port 8888`

## Purpose
### 目標是建立自動化Data Pipeline, 來分析疫情後虛擬直播主的SuperChat趨勢
