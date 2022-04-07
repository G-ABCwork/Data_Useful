# 0-1. R 환경변수에 일반 인증키 저장해놓기 ----------------------------------------------------
# usethis::edit_r_environ() # DATAGOKR_TOKEN_airpollution 으로 저장 완료
# 개인별로 일반 인증키 요청 필요!
Sys.getenv('DATAGOKR_TOKEN_holiday') # check

# 0-2. get ready for Loading some packages ----------------------------------------------
library(tidyverse)
library(lubridate)
library(httr)
library(rvest)
library(jsonlite)

get_holiday <- function(.year){
    # Get a json file from the open api
    ## (1) 요청 URL 저장
    holiday_url <- "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"
    ## (2) 일반 인증키 저장
    holidayr_key <- Sys.getenv("DATAGOKR_TOKEN_airpollution")
    
    # (3) HTTP 요청 실행. 활용가이드의 예시대로 실행.
    ## 인증키에 "%"가 있으면 더블인코딩 문제가 발생하므로 I() 함수를 씌워준다.
    holiday_res <- GET(url = holiday_url,
                       query = list(solYear = .year,
                                    serviceKey = holidayr_key %>% I(),
                                    returnType = "json", # json 형태로 불러오기
                                    numOfRows = 100,
                                    pageNo = 1))
    ## (4) 상태코드(Status)가 200이 아니면 HTTP Response(응답)가 정상이 아니라는 것을 의미
    holiday_json <- holiday_res %>% 
        content(as = "text", encoding = "UTF-8") %>% # text 변환
        fromJSON()
    
    ## (5) 응답 데이터에서 json 데이터 추출
    tibble(holiday_json$response$body$items$item) %>%
        mutate(locdate = ymd(locdate))
}

get_holiday("2021")

bind_rows(
    get_holiday("2004"), get_holiday("2005"),
    get_holiday("2006"), get_holiday("2007"), 
    get_holiday("2008"), get_holiday("2009"),
    get_holiday("2010"), get_holiday("2011"), 
    get_holiday("2012"), get_holiday("2013"),
    get_holiday("2014"), get_holiday("2015"), 
    get_holiday("2016"), get_holiday("2017"),
    get_holiday("2018"), get_holiday("2019"), 
    get_holiday("2020"), get_holiday("2021"),
    get_holiday("2022")
) %>% 
    rename(
        date = locdate
    ) %>% 
    write_csv("./Before wrangling/holidays in South Korea/korean_holiday_2004-2022.csv")

# 중복 날짜 check
holiday <- read_csv("./Before wrangling/holidays in South Korea/korean_holiday_2004-2022.csv")
tail(holiday)
holiday %>% 
    are_duplicated() %>% 
    which
holiday[c(38, 39, 40, 87, 88, 89, 211, 212, 213), ] # seq = 1만 남기기.
holiday2 <- holiday %>% 
    filter(seq == 1)
holiday2 %>% 
    write_csv("./after wrangling/korean_holiday_2004-2022_adjust.csv")
holiday2 %>% 
    write_rds("./after wrangling/korean_holiday_2004-2022_adjust.rds")
