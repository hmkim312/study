-- #126 엑셀 데이터를 DB에 로드하는 방법
-- csv 파일을 저장할 테이블을 생성
CREATE TABLE CANCER
(암종     VARCHAR2(50),
 질병코드  VARCHAR(20),
 환자수   NUMBER(10),
 성별    VARCHAR2(20),
 조유병률 NUMBER(10,2),
 생존률  NUMBER(10,2));
 
-- 테이블에서 데이터import -> 데이터 선택 -> 컬럼 매칭

-- #127 스티브 잡스 연설문에서 가장 많이 나오는 단어는 무엇인가?
-- 테이블 생성
CREATE TABLE SPEECH
 ( SPEECH_TEXT VARCHAR(1000) );
 
-- jobs.txt 테이블에 불러옴
-- 데이터 입력 후 건수를 확인
SELECT count(*) FROM speech;

-- REGEXP_SUBSTR 함수로 문장을 어절단위로 나눔
-- REGEXP_SUBSTR : 정규 표현식 함수
SELECT REGEXP_SUBSTR('I naver graduated from college', '[^ ]+', 1, 2) word
    FROM dual;
    
-- 어절 확인
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
    FROM speech, ( SELECT LEVEL a
                        FROM dual
                        CONNECT BY LEVEL <= 52);
                        
-- 어절로 나눈 단어들을 카운트하여 가장 많이 나오는 단어순으로 정렬
SELECT word, count(*)
    FROM ( SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
            FROM speech, ( SELECT LEVEL a
                                FROM dual
                                CONNECT BY LEVEL <= 52)         
        )
WHERE word is not null
GROUP BY word
ORDER BY count(*) DESC;

-- #128 스티브 잡스 연설문에는 긍정 단어가 많은가, 부정 단어가 많은가
-- 긍정단어와 부정단어를 저장하기 위한 테이블을 생성
CREATE TABLE POSITIVE ( P_TEXT VARCHAR2(2000) );
CREATE TABLE NEGATIVE ( N_TEXT VARCHAR2(2000) );

-- positive와 negative 단어를 테이블에 임포트

-- 127의 결과를 view로 저장
CREATE VIEW SPEECH_VIEW
as
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
    FROM speech, ( SELECT level a
                    FROM dual
                    CONNECT BY LEVEL <=52);
                    
-- 긍정단어의 건수 조회
SELECT count(word) as "긍정 단어"
    FROM speech_view
    WHERE lower(word) IN ( SELECT lower(p_text)
                            FROM positive );
                            
-- 부정단어의 건수 조회
SELECT count(word) as "부정 단어"
    FROM speech_view
    WHERE lower(word) IN ( SELECT lower(n_text)
                            FROM negative );
                            
-- #129 절도가 많이 발생하는 요일은 언제인가?
-- 범죄 발생 요일 데이터를 담기 위한 테이블 생성
DROP TABLE CRIME_DAY;

CREATE TABLE CRIME_DAY
( CRIME_TYPE  VARCHAR2(50),
  SUN_CNT    NUMBER(10),
  MON_CNT   NUMBER(10),
  TUE_CNT    NUMBER(10),
  WED_CNT   NUMBER(10),
  THU_CNT    NUMBER(10),
  FRI_CNT     NUMBER(10),
  SAT_CNT    NUMBER(10),
  UNKNOWN_CNT  NUMBER(10) );

-- unpivot문을 이용하여 요일 컬럼을 로우로 검색한 데이터를 crime_day_unpivot 테이블 생성
CREATE TABLE CRIME_DAY_UNPIVOT
 AS
 SELECT *
   FROM CRIME_DAY
   UNPIVOT ( CNT FOR  DAY_CNT  IN ( SUN_CNT, MON_CNT, TUE_CNT, WED_CNT,
   THU_CNT, FRI_CNT, SAT_CNT) );
   
-- crime_type이 절도 범죄로만 행을 제한하고 rank 함수를 이용해서 건수가 많은 순으로 순위를 부여
-- 1위만 출력
SELECT *
    FROM (
        SELECT DAY_CNT, CNT, RANK() over (ORDER BY cnt DESC) RNK
            FROM crime_day_unpivot
            WHERE TRIM(crime_type) = '절도'
        )
    WHERE RNK = 1;
    
-- #130 우리나라에서 대학 등록금이 가장 높은 학교는 어디?
-- TABLE 생성
CREATE TABLE UNIVERSITY_FEE
( DIVISION      VARCHAR2(20),
  TYPE          VARCHAR2(20),
  UNIVERSITY    VARCHAR2(60),
  LOC           VARCHAR2(40),
  ADMISSION_CNT NUMBER(20),
  ADMISIION_FEE NUMBER(20),
  TUITION_FEE   NUMBER(20));
  
-- UNIVERSITY_FEE 테이블에서 등록금이 가장 높은 학교 순으로 순위 부여
SELECT *
    FROM ( 
        SELECT UNIVERSITY, TUITION_FEE,
                RANK() over (ORDER BY tuition_fee DESC NULLS last) 순위
            FROM university_fee
        )
    WHERE 순위 = 1;
    
-- #131 서울시 물가 중 가장 비싼 품목과 가격은 무엇인가?
-- TABLE 생성
drop table price;

create  table price 
(  
P_SEQ	number(10),
M_SEQ	number(10),
M_NAME  varchar2(80),
A_SEQ	number(10),
A_NAME	varchar2(60),
A_UNIT	varchar2(40),
A_PRICE	number(10),
P_YEAR_MONTH	varchar2(30),
ADD_COL	     varchar2(180),
M_TYPE_CODE	varchar2(20),
M_TYPE_NAME	varchar2(20),
M_GU_CODE	varchar2(10),
M_GU_NAME	varchar2(30) );


  
-- 데이터 입력(131_data_insert.sql 파일) 
-- price의 테이블에서 최대 가격을 출력하고 메인쿼리에서 그 가격 해당하는 품목과 이름 가격을 출력
SELECT a_name as "상품", a_price as "가격", m_name as "매장명"
    FROM price
    WHERE a_price = (SELECT MAX(a_price)
                        FROM price);
                        
-- price의 테이블에서 최소 가격을 출력하고 메인쿼리에서 그 가격 해당하는 품목과 이름 가격을 출력
SELECT a_name as "상품", a_price as "가격", m_name as "매장명"
    FROM price
    WHERE a_price = (SELECT MIN(a_price)
                        FROM price);

--# 132 살인이 가장 많이 발생하는 장소는 어디인가?
-- 테이블 생성
CREATE TABLE CRIME_LOC
 ( CRIME_TYPE   VARCHAR2(100),
   CRIME_LOC    VARCHAR2(100),
   CRIME_CNT    NUMBER(10));
   
-- 132_data_insert.sql 파일로 데이터 삽입
-- 범죄유형이 살인인 장소와 그 순위를 출력
SELECT *
    FROM (
        SELECT c_loc, cnt, RANK() over (ORDER BY cnt DESC) rnk
            FROM crime_loc
            WHERE crime_type ='살인'
        )
WHERE rnk = 1;

-- #133 가정불화로 생기는 가장 큰 범죄 유형은?
-- TABLE 생성
create table crime_cause
(
범죄유형  varchar2(30),
생계형  number(10),
유흥 number(10),
도박 number(10),
허영심 number(10),
복수  number(10),
해고  number(10),
징벌 number(10),
가정불화  number(10),
호기심 number(10),
유혹  number(10),
사고   number(10),
불만   number(10),
부주의   number(10),
기타   number(10)  );

-- 133_data_insert.sql로 데이터 삽입
-- 범죄 동기가 출력되기 용이하도록 unpivot문을 이용하여 범죄 동기 컬럼을 로우로 검색한 데이터를
-- crime_cause2 테이블로 생성
CREATE TABLE CRIME_CAUSE2
as
SELECT *
    FROM crime_cause
    unpivot (cnt FOR term IN (생계형, 유흥, 도박, 허영심, 복수, 해고, 징벌, 가정불화,
                              호기심, 유혹, 사고, 불만, 부주의, 기타));
                              
-- 서브쿼리에서 가정불화로 인한 원인의 건수중에서 가장 큰 건수를 출력
-- 그 건수와 같으면서 원인이 가정 불화인 범죄 유형을 메인쿼리에서 조회
SELECT 범죄유형
    FROM crime_cause2
    WHERE cnt = ( SELECT MAX(cnt)
                    FROM crime_cause2
                    WHERE TERM = '가정불화')
    AND TERM = '가정불화';

-- #134 방화사건의 가장 큰 원인은 무엇인가?
-- 방화사건의 가장 큰 원인을 조회
SELECT TERM as 원인
    FROM crime_cause2
    WHERE cnt = ( SELECT MAX(CNT)
                    FROM crime_cause2
                    WHERE 범죄유형 = '방화')
    AND 범죄유형 = '방화';
    
-- #135 전국에서 교통사고가 제일 많이 발생하는 지역은?
-- 테이블 생성
CREATE TABLE ACC_LOC_DATA
(ACC_LOC_NO    NUMBER(10),
 ACC_YEAR       NUMBER(10),
 ACC_TYPE       VARCHAR2(20),
 ACC_LOC_CODE   NUMBER(10),
 CITY_NAME      VARCHAR2(50),
 ACC_LOC_NAME  VARCHAR2(200),
 ACC_CNT        NUMBER(10),
 AL_CNT          NUMBER(10),
 DEAD_CNT       NUMBER(10),
 M_INJURY_CNT   NUMBER(10),
 L_INJURY_CNT    NUMBER(10),
 H_INJURY_CNT   NUMBER(10),
 LAT              NUMBER(15,8),
 LOT              NUMBER(15,8),
 DATA_UPDATE_DATE   DATE );
 
-- csv. 데이터 입력
-- FROM절의 서브쿼리에서 교통사고 건수가 많은 순으로 순위를 부여하여 결과를 출력
-- 메인쿼리에서 서브쿼리의 결과 중 순위 5위까지만 제한을 걸어 출력
SELECT *
    FROM ( SELECT acc_loc_name as "사고 장소", acc_cnt as "사고 건수",
                DENSE_RANK() over (ORDER BY acc_cnt DESC NULLS LAST) as 순위
            FROM acc_loc_data
            WHERE acc_year = 2017
        )
    WHERE 순위 <= 5;
    
-- #136 치킨집 폐업이 가장 많았던 연도는 언제인가?
-- 테이블 생성
CREATE TABLE CLOSING
( 연도        NUMBER(10),
  미용실       NUMBER(10),
  양식집       NUMBER(10),
  일식집       NUMBER(10),
  치킨집       NUMBER(10),
  커피음료      NUMBER(10),
  한식음식점     NUMBER(10),
  호프간이주점    NUMBER(10));
  
-- 폐업건수csv를 입력
-- 치킨집 폐업건수가 높은 순으로 순위를 출력
SELECT 연도  "치킨집 폐업 연도", 치킨집 "건수"
    FROM (SELECT 연도, 치킨집,
                RANK() over (ORDER BY 치킨집 DESC) as 순위
        FROM closing)
    WHERE 순위 = 1;
    
-- #세계에서 근무 시간이 가장 긴 나라는 어디인가?
-- 테이블 생성
CREATE  TABLE  WORKING_TIME
( COUNTRY      VARCHAR2(30),
  Y_2014       NUMBER(10),
  Y_2015       NUMBER(10),
  Y_2016       NUMBER(10),
  Y_2017       NUMBER(10),
  Y_2018       NUMBER(10) );

-- 근로자당_연평균_실제_근로시간_OECD.xlsx 입력
-- unpivot문을 이용하여 연도컬럼을 오루로 생성한 쿼리의 결과를 view로 등록
CREATE VIEW C_WORK_TIME
AS
SELECT *
    FROM WORKING_TIME
    UNPIVOT (cnt FOR y_year IN (Y_2014, Y_2015, Y_2016, Y_2017, Y_2018));
    
-- RANK함수를 이용 연간 근로시간이 가장 높은 순으로 순위를 부여하여 나라명과 같이 출력
SELECT country, cnt, RANK() over (ORDER BY cnt DESC) 순위
    FROM C_WORK_TIME
    WHERE Y_YEAR = 'Y_2018';

-- #138 남자와 여자가 각각 많이 걸리는 암은?
-- 테이블 생성
CREATE  TABLE  CANCER2
( 암종       VARCHAR2(50),   
  질병코드   VARCHAR2(20),
  환자수     NUMBER(10),
  성별       VARCHAR2(20),
  조유병률   NUMBER(10,2),     
  생존률    NUMBER(10,2) );

-- 국립암센서_24개암종암발생률_2018년12월csv데이터를 임포트
-- 성별이 남자인 데이터에서 환자수가 가장 많은 암이 무엇인지 조회
-- UNION ALL집합 연산자를 사용하여 위 아래 쿼리 결과를 같이 출력되게 함
-- 서브 쿼리에서 받은 환자수에 대한 조건에 만족하는 암종과 성별과 환자수를 출력
-- 성별이 여자인 환자수의 최대값을 출력하여 메인쿼리문에 전달
SELECT DISTINCT(암종), 성별, 환자수
    FROM cancer2
    WHERE 환자수 = (SELECT MAX(환자수)
                    FROM cancer2
                    WHERE 성별 = '남자' and 암종 != '모든암')
UNION ALL
SELECT DISTINCT(암종), 성별, 환자수
    FROM cancer2
    WHERE 환자수 = (SELECT MAX(환자수)
                    FROM cancer2
                    WHERE 성별 = '여자');