# 유용한 데이터 제공
- 우리나라 역학 연구에서 자주 쓰이는 데이터 모음과 랭글링을 수행한 R 코드를 제공합니다.

- 데이터는 .csv(인코딩: UTF-8), .rds(R 데이터 파일)로 제공됩니다.
  - .rds: 단일 R 객체를 저장하는 파일로 `readr::read_rds()`로 읽을 수 있습니다.

## 제공 데이터 목록

- 대기오염원과 기상요인
  - 대기오염원: SO2(ppm), CO(ppm), O3(ppm), NO2(ppm), PM10, PM2.5(2015년부터 측청됨)
  - 기상요인: 평균풍속, 평균상대습도, 평균강수량, 평균기온, 일교차
  - [시군구별] 2005-2020년 일 평균 대기오염원 농도 데이터
    - 경로: `./After_wrangling/airpollution_byregion.*`
  - [대도시별: 서울, 인천, 광주, 대구, 대전, 부산] 2005-2020년 일 평균 대기오염원 농도, 기상요인 데이터
    - 경로: `./After_wrangling/airpollution_meteor_byMetropolitanCity.*`
  - [전국 평균] 2005-2020년 일 평균 대기오염원 농도 데이터
    - 경로: `./After_wrangling/airpollution_mean.*`
  - [전국 평균] 2005-2020년 일 평균 대기오염원 농도, 기상요인 데이터
    - 경로: `./After_wrangling/airpollution_meteor_mean.*`

- 우리나라 휴일 정보
  - 2004-2022년 우리나라 휴일 정보 자료
    - 경로: `./After_wrangling/korean_holiday_2004-2022_adjust.*`
    - 중복행 제거 완료
    - 같은 날짜에 2개의 휴일이 존재하는 경우, 같은 날짜를 갖는 행이 2개 존재합니다.
    - 이는 다른 데이터와 `Date`로 `join`시 문제를 일으킵니다. 
    - 이러한 현상이 발생하는 이유는 음력을 따르는 휴일 때문이에요.
    - 중복행이 존재하는 경우를 하나 예로 들어보면, 2017년 10월 3일은 개천절이자 추석 연휴 첫 날입니다.
    - 음력을 따르는 명절 추석때문이죠.
    - 그래서, 해당 날짜(2017년 10월 3일)는 2개의 행이 존재하게 되어 `Date`가 더이상 unique한 열이 아니게 됩니다.
  
- 우리나라 중위 인구
  - [성별, 연령대별] 2002-2035년 연도별 우리나라 중위인구
    - 경로: `./After_wrangling/median population.*`
  
## Source
- 원자료를 내려받으면 제공된 R 코드로 재현(reproducible)이 가능합니다.

  - **대기오염원**: 🔗[에어코리아](https://www.airkorea.or.kr/web)
  - **기상요인**: 🔗[기상청 기상자료개방포털](https://data.kma.go.kr)
  - **우리나라 휴일 정보**: 🔗[한국천문연구원 특일정보 OPEN API](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15012690) (최신 자료가 필요하다면 OPEN API 활용 요청)
  - **우리나라 중위인구**: 🔗[국가통계포털](https://kosis.kr/index/index.do)
