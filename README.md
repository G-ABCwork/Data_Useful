# Providing useful data
* Providing useful data when doing data analysis related to epidemiology in South Korea
* all files are provided .csv type(encoded UTF-8) and .rds type
* .rds file: a file which stores a single R object(commonly used in R)
* Provided data
  + Ambient air pollution
    + SO2, CO, O3, NO2, PM10, PM2.5
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
    + That is, not divided by si(city)-gun(county)-gu(district)
  + **airpollution_meteor_mean**
    + 2005-2020 The average daily concentration of **ambient air pollution and meteorological factors data (National level)**
  + **airpollution_metor_byMetropolitanCity**
    + 2005-2020 The average daily concentration of ambient air pollution and meteorological factors data in South Korea
    + divided by metropolitan cities (Seoul, Busan, Daegu, Dajeon, Gwangju, Incheon, Ulsan)
 
 
 
 
 * **Data source**
   + https://www.airkorea.or.kr/web (Ambient air pollution)
   + https://data.kma.go.kr (Meteorological factors)
