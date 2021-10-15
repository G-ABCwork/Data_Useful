library(tidyverse)
library(fpp3)
library(vroom) # for csv/txt files
library(readxl) # for xlsx files
library(fs) # for catch the path of files
library(stringr)
memory.limit(50000) # 메모리 늘리기

# 1. loading data -----------------------------------------------------------
## 2005-2014년: PM2.5 존재 X
clean <- function(f){
    map_df(f, read_excel) %>% 
        mutate_at(vars(SO2:PM10), as.numeric) %>% 
        mutate(
            SO2 = ifelse(SO2 < 0, NA, SO2),
            CO = ifelse(CO < 0, NA, CO),
            O3 = ifelse(O3 < 0, NA, O3),
            NO2 = ifelse(NO2 < 0, NA, NO2),
            PM10 = ifelse(PM10 < 0, NA, PM10)
        ) %>%
        filter(!is.na(SO2) | !is.na(CO) | !is.na(O3) | !is.na(NO2) | !is.na(PM10))
}
f_05 <- dir_ls(path = "./Before wrangling/airpollution/2005/")
f_06 <- dir_ls(path = "./Before wrangling/airpollution/2006/")
f_07 <- dir_ls(path = "./Before wrangling/airpollution/2007/")
f_08 <- dir_ls(path = "./Before wrangling/airpollution/2008/")
f_09 <- dir_ls(path = "./Before wrangling/airpollution/2009/")
f_10 <- dir_ls(path = "./Before wrangling/airpollution/2010/")
f_11 <- dir_ls(path = "./Before wrangling/airpollution/2011/")
f_12 <- dir_ls(path = "./Before wrangling/airpollution/2012/")
f_13 <- dir_ls(path = "./Before wrangling/airpollution/2013/")
f_14 <- dir_ls(path = "./Before wrangling/airpollution/2014/")
air_2005 <- clean(f_05)
air_2006 <- clean(f_06)
air_2007 <- clean(f_07)
air_2008 <- clean(f_08)
air_2009 <- clean(f_09)
air_2010 <- clean(f_10)
air_2011 <- clean(f_11)
air_2012 <- clean(f_12)
air_2013 <- clean(f_13)
clean_csv <- function(f){
    map_df(f, ~read.csv(.x, header = T, fileEncoding = "euc-kr")) %>% 
        mutate_at(vars(SO2:PM10), as.numeric) %>% 
        mutate(
            SO2 = ifelse(SO2 < 0, NA, SO2),
            CO = ifelse(CO < 0, NA, CO),
            O3 = ifelse(O3 < 0, NA, O3),
            NO2 = ifelse(NO2 < 0, NA, NO2),
            PM10 = ifelse(PM10 < 0, NA, PM10)
        ) %>%
        filter(!is.na(SO2) | !is.na(CO) | !is.na(O3) | !is.na(NO2) | !is.na(PM10)) %>% 
        as_tibble
}
air_2014 <- clean_csv(f_14)

# (1) 2015-2020년: PM2.5까지 존재
f_15 <- dir_ls(path = "../Before wrangling/airpollution/2015/")
f_16 <- dir_ls(path = "../Before wrangling/airpollution/2016/")
f_17 <- dir_ls(path = "../Before wrangling/airpollution/2017/")
f_18 <- dir_ls(path = "../Before wrangling/airpollution/2018/")
f_19 <- dir_ls(path = "../Before wrangling/airpollution/2019/")
f_20 <- dir_ls(path = "../Before wrangling/airpollution/2020/")
clean_csv2 <- function(f){
    vroom(f) %>% 
        mutate_at(vars(SO2:PM25), as.numeric) %>% 
        mutate(
            SO2 = ifelse(SO2 < 0, NA, SO2),
            CO = ifelse(CO < 0, NA, CO),
            O3 = ifelse(O3 < 0, NA, O3),
            NO2 = ifelse(NO2 < 0, NA, NO2),
            PM10 = ifelse(PM10 < 0, NA, PM10),
            PM25 = ifelse(PM25 < 0, NA, PM25)
        ) %>%
        filter(!is.na(SO2) | !is.na(CO) | !is.na(O3) | !is.na(NO2) | !is.na(PM10), !is.na(PM25))
}
air_2015 <- clean_csv2(f_15)
air_2016 <- clean_csv2(f_16)
air_2017 <- clean(f_17)
air_2018 <- clean(f_18)
air_2019 <- clean(f_19)
air_2020 <- map_df(f_20, ~read_excel(.x, col_types = "text")) %>% 
    # 일부파일은 측정소코드를 character로 읽어서 오류. 따라서, 모든 열 character로 읽도록 통일
    mutate_at(vars(SO2:PM25), as.numeric) %>% 
    mutate(
        SO2 = ifelse(SO2 < 0, NA, SO2),
        CO = ifelse(CO < 0, NA, CO),
        O3 = ifelse(O3 < 0, NA, O3),
        NO2 = ifelse(NO2 < 0, NA, NO2),
        PM10 = ifelse(PM10 < 0, NA, PM10),
        PM25 = ifelse(PM25 < 0, NA, PM25)
    ) %>%
    filter(!is.na(SO2) | !is.na(CO) | !is.na(O3) | !is.na(NO2) | !is.na(PM10), !is.na(PM25))

# 2. wrangling data -------------------------------------------------------
glimpse(air_2005) # 2005~2013까지 PM2.5 열 추가.
glimpse(air_2006)
glimpse(air_2007)
glimpse(air_2008)
glimpse(air_2009)
glimpse(air_2010)
glimpse(air_2011)
glimpse(air_2012)
glimpse(air_2013)
glimpse(air_2014)
glimpse(air_2015)
glimpse(air_2016)
glimpse(air_2017) # 열 "망" 제거
glimpse(air_2018) # 열 "망" 제거
glimpse(air_2019) # 열 "망" 제거
glimpse(air_2020) # 열 "망" 제거

# air_2018_duplicate <- air_2018 %>%
#     select(-망) %>%
#     mutate(측정일시 = ymd_h(측정일시)) %>%
#     select(-주소, -측정소코드) %>%
#     unite(지역_측정소명, c(지역, 측정소명)) %>%
#     group_by(지역_측정소명, 측정일시) %>%
#     summarise(n = n()) %>%
#     filter(n > 1)
# duplicate_region <- air_2018_duplicate %>%
#     select(지역_측정소명) %>%
#     unique %>%
#     pull
# air_2018_duplicate %>%
#     filter(지역_측정소명 == duplicate_region[[1]]) %>%
#     pull(측정일시) %>%
#     range
# air2_2018 <- air_2018 %>%
#     select(-망) %>%
#     mutate(측정일시 = ymd_h(측정일시)) %>%
#     select(-주소, -측정소코드) %>%
#     unite(지역_측정소명, c(지역, 측정소명))
# air2_2018 %>%
#     filter(
#         지역_측정소명 == duplicate_region[[1]],
#         측정일시 >= ymd_h("2018-10-01 01"),
#         측정일시 <= ymd_h("2019-01-01 00")) %>%
#     view() # 경남 거제시_저구리 중복행 측정값 모두 동일함. 삭제해도 하나는 삭제해도 됨.
# air2_2018 %>%
#     filter(
#         지역_측정소명 == duplicate_region[[1]],
#         측정일시 >= ymd_h("2018-10-01 01"),
#         측정일시 <= ymd_h("2019-01-01 00")) %>%
#     distinct(지역_측정소명, 측정일시, .keep_all = TRUE)
# air2_2018 %>% # 중복행 제거한 것
#     distinct(지역_측정소명, 측정일시, .keep_all = TRUE)
make_tsbl_daily <- function(tb){
    tb %>% 
        mutate(측정일시 = ymd_h(측정일시)) %>% 
        select(-주소, -측정소코드) %>% 
        unite(지역_측정소명, c(지역, 측정소명)) %>% 
        # (지역_측정소명, 측정일시) 조합에 중복있을 경우 제거.
        # air_2018의 경남 거제시_저구리 지역에서 확인해본 결과, 중복된 경우 측정값 동일했음
        distinct(지역_측정소명, 측정일시, .keep_all = TRUE) %>% 
        as_tsibble(key = 지역_측정소명, index = 측정일시) %>% 
        group_by_key() %>% 
        index_by(date = ~ as_date(.)) %>% # hourly data to daily data
        summarise(
            mean_SO2 = mean(SO2, na.rm = TRUE),
            mean_CO = mean(CO, na.rm = TRUE),
            mean_O3 = mean(O3, na.rm = TRUE),
            mean_NO2 = mean(NO2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE)
        ) %>% 
        as_tibble()
}
make_tsbl_daily2 <- function(tb){ # 2015년부터 PM2.5 존재
    tb %>% 
        mutate(측정일시 = ymd_h(측정일시)) %>% 
        select(-주소, -측정소코드) %>% 
        unite(지역_측정소명, c(지역, 측정소명)) %>% 
        # (지역_측정소명, 측정일시) 조합에 중복있을 경우 제거.
        # air_2018의 경남 거제시_저구리 지역에서 확인해본 결과, 중복된 경우 측정값 동일했음
        distinct(지역_측정소명, 측정일시, .keep_all = TRUE) %>% 
        as_tsibble(key = 지역_측정소명, index = 측정일시) %>% 
        group_by_key() %>% 
        index_by(date = ~ as_date(.)) %>% # hourly data to daily data
        summarise(
            mean_SO2 = mean(SO2, na.rm = TRUE),
            mean_CO = mean(CO, na.rm = TRUE),
            mean_O3 = mean(O3, na.rm = TRUE),
            mean_NO2 = mean(NO2, na.rm = TRUE),
            mean_PM10 = mean(PM10, na.rm = TRUE),
            mean_PM25 = mean(PM25, na.rm = TRUE)
        ) %>% 
        as_tibble()
}
daily_2005 <- make_tsbl_daily(air_2005)
daily_2006 <- make_tsbl_daily(air_2006)
daily_2007 <- make_tsbl_daily(air_2007)
daily_2008 <- make_tsbl_daily(air_2008)
daily_2009 <- make_tsbl_daily(air_2009)
daily_2010 <- make_tsbl_daily(air_2010)
daily_2011 <- make_tsbl_daily(air_2011)
daily_2012 <- make_tsbl_daily(air_2012)
daily_2013 <- make_tsbl_daily(air_2013)
daily_2014 <- make_tsbl_daily(air_2014)
daily_2015 <- make_tsbl_daily2(air_2015)
daily_2016 <- make_tsbl_daily2(air_2016)
daily_2017 <- make_tsbl_daily2(air_2017 %>% select(-망))
daily_2018 <- make_tsbl_daily2(air_2018 %>% select(-망))
daily_2019 <- make_tsbl_daily2(air_2019 %>% select(-망))
daily_2020 <- make_tsbl_daily2(air_2020 %>% select(-망))

# 3. load and wrangling rds files -----------------------------------------
daily_air <- bind_rows(daily_2005, daily_2006, daily_2007, daily_2008, daily_2009, daily_2010,
                       daily_2011, daily_2012, daily_2013, daily_2014, daily_2015, daily_2016,
                       daily_2017, daily_2018, daily_2019, daily_2020, .id = "groups") %>% 
    separate(지역_측정소명, c("지역", "측정소명"), sep = "_") %>% 
    mutate(mean_SO2 = ifelse(is.nan(mean_SO2), NA, mean_SO2),
           mean_CO = ifelse(is.nan(mean_CO), NA, mean_CO),
           mean_O3 = ifelse(is.nan(mean_O3), NA, mean_O3),
           mean_NO2 = ifelse(is.nan(mean_NO2), NA, mean_NO2),
           mean_PM10 = ifelse(is.nan(mean_PM10), NA, mean_PM10),
           mean_PM25 = ifelse(is.nan(mean_PM25), NA, mean_PM25))
glimpse(daily_air)
summary(daily_air)

### 12월 31일 24시가 1월 1일로 처리되서 발생하는 문제로 확인됨
daily_air %>% 
    filter(groups == 11)
daily_air %>% 
    filter(year(date) > 2014, 지역 == "강원 강릉시")
daily_air %>%
    filter(지역 == "강원 강릉시") %>%
    group_by(date) %>%
    summarise(n = n()) %>%
    filter(n > 1)
ymd_h("2015123124")

### 어떻게 해결할까?
### 2016/2017/2018/2019/2020의 12월 31일 24시. 1월 1일로 처리. 그럼 1월1일끼리 평균
daily_air2 <- daily_air %>%
    group_by(지역, date) %>% # 지역별
    summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%  # 같은 (지역, date)가 있으면 평균 내기.
    ungroup() %>% 
    mutate(SO2_Avg = ifelse(is.nan(mean_SO2), NA, mean_SO2),
           CO_Avg = ifelse(is.nan(mean_CO), NA, mean_CO),
           O3_Avg = ifelse(is.nan(mean_O3), NA, mean_O3),
           NO2_Avg = ifelse(is.nan(mean_NO2), NA, mean_NO2),
           PM10_Avg = ifelse(is.nan(mean_PM10), NA, mean_PM10),
           PM25_Avg = ifelse(is.nan(mean_PM25), NA, mean_PM25)) %>% 
    select(지역, date, SO2_Avg:PM25_Avg) %>% 
    filter(date < ymd("2021-01-01"))
### 한번 더 겹치는 것 없나 검토.
daily_air2 %>% 
    filter(year(date) > 2014, 지역 == "강원 강릉시")
daily_air2 %>%
    group_by(지역, date) %>%
    summarise(n = n()) %>%
    filter(n > 1)

## 지역별
# write_rds(daily_air2, "./after wrangling/airpollution_byregion.rds")
# write_csv(daily_air2, "./after wrangling/airpollution_byregion.csv")
# read_rds("./after wrangling/airpollution_byregion.rds")

## 전국 평균
daily <- daily_air2 %>% 
    group_by(date) %>% 
    summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%  
    mutate(SO2_Avg = ifelse(is.nan(SO2_Avg), NA, SO2_Avg),
           CO_Avg = ifelse(is.nan(CO_Avg), NA, CO_Avg),
           O3_Avg = ifelse(is.nan(O3_Avg), NA, O3_Avg),
           NO2_Avg = ifelse(is.nan(NO2_Avg), NA, NO2_Avg),
           PM10_Avg = ifelse(is.nan(PM10_Avg), NA, PM10_Avg),
           PM25_Avg = ifelse(is.nan(PM25_Avg), NA, PM25_Avg))
# write_rds(daily, "./after wrangling/airpollution_mean.rds")
# write_csv(daily, "./after wrangling/airpollution_mean.csv")
# read_rds("./after wrangling/airpollution_mean.rds")

## 전국평균 대기오염원 + 평균기온, 일교차, 강수량, 습도
daily_temp <- read.csv("./before wrangling/meteorological factors/National level/기온_20050101_20201231.csv",
                       skip = 7, header = T, fileEncoding = "euc-kr") %>% 
    tibble %>% 
    mutate(일교차 = 최고기온...-최저기온...,
              날짜 = ymd(날짜)) %>% 
    select(-지점, -최저기온..., -최고기온...) %>% 
    rename(date = 날짜, 평균기온 = 평균기온...)
summary(daily_temp)

daily_rain <- read.csv("./before wrangling/meteorological factors/National level/강수량_20050101_20201231.csv",
                       skip = 7, header = T, fileEncoding = "euc-kr") %>% 
    tibble %>% 
    mutate(날짜 = ymd(날짜)) %>% 
    select(-지점) %>% 
    rename(date = 날짜, 강수량 = 강수량.mm.)
summary(daily_rain)

daily_humid <- read.csv("./before wrangling/meteorological factors/National level/습도_20050101_20201231.csv",
                        skip = 14, header = T, fileEncoding = "euc-kr") %>% 
    tibble %>% 
    mutate(일시 = ymd(일시)) %>% 
    arrange(일시) %>% 
    rename(date = 일시, 평균습도 = 평균습도..rh.) %>% 
    select(date, 평균습도)
summary(daily_humid)

daily_wind <- read.csv("./before wrangling/meteorological factors/National level/풍속_20050101_20201231.csv",
                       skip = 14, header = T, fileEncoding = "euc-kr") %>% 
    drop_na() %>% 
    tibble %>% 
    mutate(일시 = ymd(일시)) %>% 
    arrange(일시) %>% 
    rename(date = 일시, 평균풍속 = 평균풍속.m.s.) %>% 
    select(date, 평균풍속)

daily_all <- daily %>% 
    left_join(daily_temp) %>% 
    left_join(daily_rain) %>% 
    left_join(daily_humid) %>% 
    rename(Temperature_Avg = 평균기온,
           Temperature_range = 일교차,
           Precipitation = 강수량,
           Humidity_Avg = 평균습도)
summary(daily_all)

write_rds(daily_all, "./after wrangling/airpollution_meteor_mean.rds")
write_csv(daily_all, "./after wrangling/airpollution_meteor_mean.csv")
