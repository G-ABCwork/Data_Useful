library(readxl)
library(tidyverse)

# 1. loading data ---------------------------------------------------------
## 출처 KOSIS 국가 통계: https://kosis.kr/statisticsList/statisticsListIndex.do?menuId=M_01_01&vwcd=MT_ZTITLE&parmTabId=M_01_01&outLink=Y&parentId=A.1;A_6.2;#content-group
read_xlsx("./Before wrangling/median population/원본_성_및_연령별_추계인구_1세별__5세별____전국_20210823161423.xlsx") %>% 
    select(-가정별) %>% 
    mutate(
        성별 = c("Total_all", rep("all", 22), "Male_all", rep("Male", 22), "Female_all", rep("Female", 22))
    ) %>% 
    write_csv("./After wrangling/median population.csv")

read_xlsx("./Before wrangling/median population/원본_성_및_연령별_추계인구_1세별__5세별____전국_20210823161423.xlsx") %>% 
    select(-가정별) %>% 
    mutate(
        성별 = c("Total_all", rep("all", 22), "Male_all", rep("Male", 22), "Female_all", rep("Female", 22))
    ) %>% 
    write_rds("./After wrangling/median population.rds")
