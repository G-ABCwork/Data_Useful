# 0. loading libraries ----------------------------------------------------
library(tidyverse)
library(lubridate)
library(fpp3)
library(vroom)
library(skimr)
library(fs) # for catch the path of files
# 1. airpollution ------------------------------------------------------------
air <- read_rds("./after wrangling/airpollution_byregion.rds")
air %>% 
    select(지역) %>% 
    View()

## 서울, 부산, 대구, 인천, 광주, 대전, 울산
# air %>% 
#     filter(str_detect(지역, "^서울")) %>% 
#     select(지역) %>% 
#     unique %>% 
#     View
# air %>% 
#     filter(str_detect(지역, "^부산")) %>% 
#     select(지역) %>% 
#     unique %>% 
#     View
# air %>% 
#     filter(str_detect(지역, "^대구")) %>% 
#     select(지역) %>% 
#     unique %>% 
#     View
# air %>% 
#     filter(str_detect(지역, "^인천")) %>% 
#     select(지역) %>% 
#     unique %>% 
#     View
# air %>% 
#     filter(str_detect(지역, "^광주")) %>% 
#     select(지역) %>% 
#     unique %>% 
#     View
# air %>% 
#     filter(str_detect(지역, "^대전")) %>% 
#     select(지역) %>% 
#     unique %>% 
#     View
# air %>%
#     filter(str_detect(지역, "^울산")) %>%
#     select(지역) %>%
#     unique %>%
#     View
air %>% 
    filter(str_detect(지역, "^서울|^부산|^대구|^인천|^광주|^대전|^울산")) %>% 
    select(지역) %>%
    unique %>%
    View
air2 <- air %>% 
    filter(str_detect(지역, "^서울|^부산|^대구|^인천|^광주|^대전|^울산")) %>% 
    mutate(Region = str_extract(지역, "^서울|^부산|^대구|^인천|^광주|^대전|^울산")) %>% 
    group_by(Region, date) %>% 
    summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>% 
    ungroup() %>% 
    mutate(SO2_Avg = ifelse(is.nan(SO2_Avg), NA, SO2_Avg),
           CO_Avg = ifelse(is.nan(CO_Avg), NA, CO_Avg),
           O3_Avg = ifelse(is.nan(O3_Avg), NA, O3_Avg),
           NO2_Avg = ifelse(is.nan(NO2_Avg), NA, NO2_Avg),
           PM10_Avg = ifelse(is.nan(PM10_Avg), NA, PM10_Avg),
           PM25_Avg = ifelse(is.nan(PM25_Avg), NA, PM25_Avg)) %>% 
    rename(Date = date)

# 2. meteorological factors -----------------------------------------------
## (1) 강수량
f_precip <- list.files(path = "./Before wrangling/meteorological factors/", pattern = "^강수량", full.names = TRUE)
daily_precip <- vroom(f_precip, locale = locale('ko',encoding='euc-kr'), delim = ",", skip = 8) %>% 
    rename(Date = 일시, Precipitation = `강수량(mm)`, Region = 지점명) %>% 
    filter(year(Date) < 2021) %>%
    select(Region, Date, Precipitation)
daily_precip %>% 
    filter(is.na(Precipitation)) # 0으로 대치
daily_precip2 <- daily_precip %>% 
    mutate(Precipitation = ifelse(is.na(Precipitation), 0, Precipitation))

## (2) 습도
f_humid <- list.files(path = "./Before wrangling/meteorological factors/", pattern = "^습도", full.names = TRUE)
daily_humid <- vroom(f_humid, locale = locale('ko',encoding='euc-kr'), delim = ",", skip = 8) %>% 
    rename(Date = 일시, `Relative humidity` = `평균습도(%rh)`, Region = 지점명) %>% 
    filter(year(Date) < 2021) %>%
    select(Region, Date, `Relative humidity`)
daily_humid %>% 
    filter(is.na(`Relative humidity`))
daily_humid2 <- daily_humid %>% 
    tsibble(key = Region, index = Date) %>% 
    tidyr::fill(`Relative humidity`, .direction = "down") # 이전시점의 값으로 대치

## (3) 풍속(wind speed)
f_wind <- list.files(path = "./Before wrangling/meteorological factors/", pattern = "^풍속", full.names = TRUE)
daily_wind <- vroom(f_wind, locale = locale('ko',encoding='euc-kr'), delim = ",", skip = 8) %>% 
    rename(Date = 일시, `Wind speed` = `평균풍속(m/s)`, Region = 지점명) %>% 
    filter(year(Date) < 2021) %>%
    select(Region, Date, `Wind speed`)
daily_wind %>% 
    filter(is.na(`Wind speed`)) # 전후의 평균으로 대치
daily_wind2 <- daily_wind %>% 
    tsibble(key = Region, index = Date) %>% 
    tidyr::fill(`Wind speed`, .direction = "down")

## (4) 기온, 일교차
f_temp <- list.files(path = "./Before wrangling/meteorological factors/", pattern = "^기온", full.names = TRUE)
daily_temp <- vroom(f_temp, locale = locale('ko',encoding='euc-kr'), delim = ",", skip = 8) %>% 
    rename(Date = 일시, Temperature = `평균기온(℃)`, Region = 지점명) %>% 
    filter(year(Date) < 2021)
daily_temp %>% 
    filter(is.na(Temperature))  # 이전 시점의 값으로 대치 후, 일교차 계산
daily_temp2 <- daily_temp %>% 
    tsibble(key = Region, index = Date) %>% 
    tidyr::fill(`Temperature`, `최고기온(℃)`, `최저기온(℃)`, .direction = "down") %>% 
    mutate(`Temperature gap` = `최고기온(℃)` - `최저기온(℃)`) %>% 
    select(Region, Date, Temperature, `Temperature gap`)

byregion <- air2 %>% 
    left_join(daily_precip2, by = c("Region", "Date")) %>% 
    left_join(daily_humid2, by = c("Region", "Date")) %>% 
    left_join(daily_wind2, by = c("Region", "Date")) %>% 
    left_join(daily_temp2, by = c("Region", "Date"))
# write_rds(byregion, "./after wrangling/airpollution_metor_byMetropolitanCity.rds")
# write_csv(byregion, "./after wrangling/airpollution_metor_byMetropolitanCity.csv")
