<<<<<<< HEAD
# Providing useful data
* Providing useful data when doing data analysis related to epidemiology in South Korea
* all files are provided .csv type(encoded UTF-8) and .rds type
* .rds file: a file which stores a single R object(commonly used in R, use readr::read_rds())
* Provided data
  + Ambient air pollution
    + SO2(ppm), CO(ppm), O3(ppm), NO2(ppm), PM10, PM2.5
    + PM2.5 has been measured since 2015
  + Meteorological factors
    + Average wind speed, Average relative humidity, Average precipitation, Average temperature, Temperature gap
  + Korean holidays
  + Median population
* Details
  + **airpollution_byregion**
    + 2005-2020 The average daily concentration of ambient air pollution data
    + divided by si-gun-gu (Administrative divisions of South Korea)
  + **airpollution_mean**
    + The average daily concentration of ambient air pollution data (National level)
    + That is, not divided by si-gun-gu
  + **airpollution_meteor_mean**
    + 2005-2020 The average daily concentration of ambient air pollution and meteorological factors data (National level)
  + **airpollution_metor_byMetropolitanCity**
    + 2005-2020 The average daily concentration of ambient air pollution and meteorological factors data
    + divided by metropolitan cities (Seoul, Busan, Daegu, Dajeon, Gwangju, Incheon, Ulsan)
  + **korean_holiday_2004-2002_adjust**
    + 2004-2022 Public holidays
    + dropped duplicated rows
    + There were cases where there were two rows with the same date due to overlapping two holidays(Essentially because of the lunar calendar)
    + e.g. 2017-10-03 the National Foundation Day of Korea, Chuseok (It's based on lunar calender)
   + **median population**
     + 2002-2035 Median population
     + Divided by age and sex, including total population
 * **Data source**
   + Airkorea: https://www.airkorea.or.kr/web (Ambient air pollution)
   + Korea Meteorological Administration: https://data.kma.go.kr (Meteorological factors)
   + OPEN API from KASI: https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15012690 (Korea holidays)
   + KOSIS: https://kosis.kr/ (Median population)
=======
# 유용한 데이터 제공
- 우리나라 역학 연구에 자주 쓰일 수 있는 데이터 모음과 전처리를 수행한 R 코드를 제공합니다.
- 모든 파일은 .csv(인코딩: UTF-8), .rds(R 데이터 파일)로 제공됩니다.
  - .rds: 단일 R 객체를 저장하는 파일로 `readr::read_rds()`로 읽을 수 있습니다. 

## 제공 데이터 모음
### 1 대기오염원
- SO2(ppm), CO(ppm), O3(ppm), NO2(ppm), PM10, PM2.5
  - PM2.5는 2015년부터 측정됩니다.
### 2 기상요인
- 평균풍속, 평균상대습도, 평균강수량, 평균기온, 일교차
### 3 우리나라 휴일 정보
### 4 우리나라 중위인구

## 제공 데이터 세부사항
- [시군구별] 2005-2020년 대기오염원 일 평균 농도 자료: `./After_wrangling/airpollution_byregion.*`
- [우리나라 전체 평균] 2005-2020년 대기오염원 일 평균 농도 자료: `./After_wrangling/airpollution_mean.*`
- [대도시별] 2005-2020년 일 평균 대기오염원, 기상요인 자료: `./After_wrangling/airpollution_meteor_byMetropolitanCity.*`
  - 대도시: 서울, 부산, 대구, 대전, 광주, 인천, 울산
- [우리나라 전체 평균] 2005-2020년 일 평균 대기오염원, 기상요인 자료: `./After_wrangling/airpollution_meteor_mean.*`
- 2004-2022년 우리나라 휴일 정보 자료: `./After_wrangling/korean_holiday_2004-2022_adjust.*`
  - 중복열 제거: 같은 날짜에 2개의 휴일이 겹치는 경우, 동일한 날짜를 갖는 행이 2개 만들어지는데, 
  - 이는 다른 데이터와 `Date`로 `join`시 문제를 일으킵니다. 
  - 이러한 현상이 발생하는 이유는 본질적으로 음력을 따르는 휴일 때문이에요.
  - 예를 들자면, 2017년 10월 3일 개천절은 음력을 따르는 명절 추석과 겹치는 날짜가 발생하여, 
  - 2017년 10월 3일에 해당하는 날짜가 2개가 존재하여 `Date`가 더이상 unique한 열이 아니게 됩니다.
- [성별, 연령대별] 2002-2035년 연도별 우리나라 중위인구: `./After_wrangling/median population.*`

## Source
- **대기오염원**: [에어코리아](https://www.airkorea.or.kr/web)
- **기상요인**: [기상청 기상자료개방포털](https://data.kma.go.kr)
- **우리나라 휴일 정보**: [한국천문연구원 특일정보 OPEN API](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15012690)
  - 최신 자료가 필요하다면 OPEN API 활용 요청을 하셔야합니다.
- **우리나라 중위인구**: [국가통계포털](https://kosis.kr/index/index.do)
>>>>>>> b5cc35dfa649427f5050070661a48ebbe4e1dd5d
