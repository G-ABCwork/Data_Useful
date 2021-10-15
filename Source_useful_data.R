library(tidyverse)
daily_air <- read_rds("./After wrangling/airpollution_meteor_mean.rds") %>% 
    rename(Date = date,
           SO2 = SO2_Avg,
           CO = CO_Avg,
           O3 = O3_Avg,
           NO2 = NO2_Avg,
           PM10 = PM10_Avg,
           PM25 = PM25_Avg,
           Humid = Humidity_Avg,
           Prec = Precipitation,
           Temp = Temperature_Avg,
           Temp_range = Temperature_range) %>% 
    rename(
        Temperature = Temp,
        `Temperature gap` = Temp_range,
        Precipitation = Prec,
        `Relative humidity` = Humid
    ) %>%
    mutate( # ppm to ppb. ppb = 1000*ppm
        SO2 = 1000*SO2, # 아황산가스
        CO = 1000*CO, # 일산화탄소
        O3 = 1000*O3, # 오존
        NO2 = 1000*NO2 # 이산화질소
    )
holidays <- read_csv("./After wrangling/korean_holiday_2004-2022_adjust.csv") %>% 
    rename(holiday = dateName,
           Date = date) %>% 
    select(Date, holiday)
