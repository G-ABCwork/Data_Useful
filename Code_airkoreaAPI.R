# 0-1. R 환경변수에 일반 인증키 저장해놓기 ----------------------------------------------------
# usethis::edit_r_environ() # DATAGOKR_TOKEN_airpollution 으로 저장 완료
# 개인별로 일반 인증키 요청 필요!
Sys.getenv('DATAGOKR_TOKEN_airpollution') # check

# 0-2. Loading some packages ----------------------------------------------
library(tidyverse)
library(lubridate)
library(httr)
library(rvest)
library(jsonlite)

# 1. Get a json file from the open api -------------------------------------------
## (1) 요청 URL 저장
# air_url <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureSidoLIst"
air_url <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getMsrstnAcctoRDyrg"

## (2) 일반 인증키 저장
air_key <- Sys.getenv("DATAGOKR_TOKEN_airpollution")

## (3) HTTP 요청 실행. 활용가이드의 예시대로 실행.
## 인증키에 "%"가 있으면 더블인코딩 문제가 발생하므로 I() 함수를 씌워준다.
# air_res <- GET(url = air_url,
#                query = list(sidoName = "서울",
#                             searchCondition = "DAILY",
#                             serviceKey = air_key %>% I(),
#                             returnType = "json", # json 형태로 불러오기
#                             numOfRows = 600,
#                             pageNo = 1))
air_res <- GET(url = air_url,
               query = list(inqBginDt = "20201001",
                            inqEndDt = "20210401",
                            msrstnName = "강남구",
                            serviceKey = air_key %>% I(),
                            returnType = "json", # json 형태로 불러오기
                            numOfRows = 100,
                            pageNo = 1))

air_res

### 상태코드(Status)가 200이 아니면 HTTP Response(응답)가 정상이 아니라는 것을 의미
air_json <- air_res %>% 
    content(as = "text", encoding = "UTF-8") %>% # text 변환
    fromJSON()
air_json
str(air_json) # 원소(response)가 1개인 리스트 자료형

## (4) 응답 데이터에서 json 데이터 추출
# air_seoul <- tibble(air_json$response$body$items) %>% 
#     select(dataTime, cityName, ends_with("Value"), -khaiValue) %>% 
#     mutate(dataTime = ymd_hm(dataTime))
# air_seoul

air_gangnam <- tibble(air_json$response$body$items) %>%
    mutate(msurDt = ymd(msurDt))
air_gangnam
