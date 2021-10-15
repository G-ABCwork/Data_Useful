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
  + Population median
* Details
  + **airpollution_byregion**
    + 2005-2020 The average daily concentration of **ambient air pollution data**
    + **divided by si(city)-gun(county)-gu(district) (Administrative divisions of South Korea)**
  + **airpollution_mean**
    + The average daily concentration of **ambient air pollution data (National level)**
    + That is, not divided by si-gun-gu(district)
  + **airpollution_meteor_mean**
    + 2005-2020 The average daily concentration of **ambient air pollution and meteorological factors data (National level)**
  + **airpollution_metor_byMetropolitanCity**
    + 2005-2020 The average daily concentration of ambient air pollution and meteorological factors data
    + divided by metropolitan cities (Seoul, Busan, Daegu, Dajeon, Gwangju, Incheon, Ulsan)
  + **korean_holiday_2004-2002_adjust**
    + 2004-2022 Public holidays
    + dropped duplicated rows
    + There were cases where there were two rows with the same date due to overlapping two holidays(Essentially because of the lunar calendar)
    + **e.g.** 2017-10-03 the National Foundation Day of Korea, Chuseok (It's based on lunar calender)
   + **median population**
     + 2002-2035 Median population
     + Divided by age and sex, including total population
 * **Data source**
   + Airkorea: https://www.airkorea.or.kr/web (Ambient air pollution)
   + Korea Meteorological Administration: https://data.kma.go.kr (Meteorological factors)
   + OPEN API from KASI: https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15012690 (Korea holidays)
   + KOSIS: https://kosis.kr/ (Population median)
