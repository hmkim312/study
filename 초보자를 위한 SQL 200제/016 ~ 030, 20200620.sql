-- #016 대소문자 변환 함수 배우기
-- 사원테이블의 이름을 출력, 첫번쨰 컬럼은 이름을 대문자로, 두번째 컬럼 이름을 소문자로, 세번재 컬럼은 앞에만 대문자
-- 단일 행 함수 : 하나의 행을 입력받아 하나의 행을 반환하는 함수(문자, 숫자, 날짜 변환, 일반 함수)
-- 다중 행 함수 : 여러 개의 행을 입력받아 하나의 행을 반환하는 함수(그룹 함수)
SELECT UPPER(ename) ,LOWER(ename), INITCAP(ename)
    FROM emp;

-- 이름이 scott인 사원의 이름과 월급을 조회
SELECT ENAME, SAL
    FROM emp
    WHERE LOWER(ename) ='scott';

-- 이름이 소문자인지 대문자 인지 모를때
SELECT ename, sal
    FROM emp
    WHERE LOWER(ename) = 'scott' or UPPER(ename) ='SCOTT';
    
-- #017 문자에서 특정 철자 추출하기
-- SMITH에서 SMI만 잘라서 출력
-- SUBSTR('SMITH',1,3) : SMITH에서 1번쨰부터 3번째까지만 출력 
SELECT SUBSTR('SMITH',1,3)
    FROM DUAL;

-- MI가 출력
SELECT SUBSTR('SMITH',2,2)
    FROM DUAL;
    
-- TH가 출력 뒤의 2번째부터 2개가 출력
SELECT SUBSTR('SMITH',-2,2)
    FROM DUAL;
    
-- 2번째부터 모두 출력
SELECT SUBSTR('SMITH',2)
    FROM DUAL;
    
-- #018 문자열의 길이를 출력하기
-- 이름을 출력한뒤 그 옆에 이름의 철자 개수를 출력
SELECT ename, LENGTH(ename)
    FROM emp;
    
-- 한글도 마찬가지로 문자열의 길이가 출력됨
SELECT LENGTH('가나다라마바사')
    FROM DUAL;

-- 바이트의 길이를 출력
SELECT LENGTHB('가나다라마바사')
    FROM DUAL;
    
-- #019 문자에서 특정 철자의 위치 출력하기
-- SMITH에서 알파벳 철자 M이 위치한 자리 찾기
-- INSTR : 문자에서 특정 철자의 위치를 출력하는 함수
SELECT INSTR('SMITH', 'M')
    FROM DUAL;
    
-- 이메일에서 naver.com만 추출하기
-- @의 위치 찾기
SELECT INSTR('abcdefg@naver.com','@')
    FROM DUAL;

-- 찾은 위치부터 +1 까지 SUBSTR을 이용하여 모두 출력 하면 naver.com만 나옴    
SELECT SUBSTR('abcdefg@naver.com',INSTR('abcdefg@naver.com','@') + 1)
    FROM DUAL;
    
-- 오른쪽에 com을 없애고 출력
SELECT RTRIM(SUBSTR('abcdefg@naver.com',INSTR('abcdefg@naver.com','@') + 1),'.com')
    FROM DUAL;
    
-- #020 특정 철자를 다른 철자로 변경하기
-- 이름과 월급을 출력, 월급의 0을 *표로 출력
-- replace : 특정 철자를 다른 철자로 변경하는 문자 함수
SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;
    
-- 월급의 숫자 0~3까지를 *로 출력
-- REGEXP_REPLACE : 정규표현식 함수
SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as SALARY
    FROM emp;
    
-- 테이블 생성
CREATE TABLE TEST_ENAME
(ENAME   VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('김인호');
INSERT INTO TEST_ENAME VALUES('안상수');
INSERT INTO TEST_ENAME VALUES('최영희');
COMMIT;

-- 이름의 두번째 자리의 한글을 *로 출력
SELECT REPLACE(ENAME, SUBSTR(ENAME, 2,1), '*') as "전광판_이름"
    FROM test_ename;

-- #021 특정 철자를 N개 만큼 채우기
-- 이름과 월급을 출력, 월급 컬럼의 자릿수를 10자리로 하고 월급을 출력하고 남은 나머지 자리에 별표*로 출력
-- LPAD : 왼쪽으로 채워 넣음
-- RPAD : 오른쪽으로 채워 넣음
SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal,10,'*') as salary2
    FROM emp;

-- 다른것도 되나?
SELECT ename, LPAD(sal, 10, 'a') as salary1, RPAD(sal,10,'a') as salary2
    FROM emp;
    
-- 이름과 월급을 출력하고 월급 100을 네모 하나로 출력함(100당 ■ 1개) 
SELECT ename, sal, LPAD('■', round(sal/100) , '■') as bar_chart
    FROM emp;
    
-- #022 특정 철자 잘라내기
-- 첫번째 컬럼은 smith 철자를 출력, 두번째 컬럼은 s를, 세번째 컬럼은 h를, 네번쨰 컬럼은 smiths의 양끝 s를 잘라서 출력
-- LTRIM : 왼쪽 철자를 잘라서 출력
-- RTRIM : 오른쪽 철자를 잘라서 출력
-- TRIM : 양쪽의 철자를 잘라서 출력
SELECT 'smith', LTRIM('smith' ,'s'), RTRIM('smith', 'h'), TRIM('s' from 'smiths')
    FROM dual;
    
-- insert 문장으로 사원 테이블에 사원 데이터를 입력, jack 사원 데이터를 입력할때 jack 오른쪽에 공백을 하나 넣어서 입력
insert into emp(empno, ename, sal, job, deptno) values(8291, 'jack ', 3000, 'SALESMAN', 30);
commit

-- 이름이 jack인 사원의 이름과 월급을 조회
-- 안나옴, jack의 이름옆에 ' '공백이 있어서
SELECT ename, sal
    FROM emp
    WHERE ename = 'jack';
    
-- RTRIM으로 공백을 제거하고 찾음    
SELECT ename, sal
    FROM emp
    WHERE RTRIM(ename) = 'jack';

-- 입력한 데이터 삭제
DELETE FROM emp WHERE TRIM(ename) ='jack';
commit;

-- #023 반올림해서 출력하기
-- 876.567 숫자를 소주점 두번째 자리인 6에서 반올림해서 출력
-- ROUND(876.567 ,1) 는 소수점 이후 두번째 자리에서 반올림
-- ROUND(876.567 ,2) 는 소수점 이후 세번째 자리에서 반올림
-- ROUND(876.567 ,-1) 는 소수점 이전 일의 자리에서 반올림
-- ROUND(876.567 ,-2) 는 소수점 이전 십의 자리에서 반올림
-- ROUND(876.567 ,0) 는 소수점자리가 기준이라 똑같은 숫자가 출력됨
SELECT '876.567' as 숫자, ROUND(876.567 ,1)
    FROM dual;
    
-- #024 숫자를 버리고 출력하기
-- 876,567을 소수점 두번째 자리인 6부터 모두 버리고 출력
-- 버리는 자리는 ROUND와 똑같음
SELECT '876.567' as 숫자, TRUNC(876.567 ,1)
    FROM dual;
    
-- #025 나눈 나머지 값 출력하기
-- MOD : 앞에 숫자를 뒤에 숫자로 나눈 나머지 값 출력
-- FLOOR : 앞에 숫자를 뒤에 숫자로 나눈 몫 출력
-- 숫자 10을 3으로 나눈 나머지 값을 출력
SELECT MOD(10, 3)
    FROM DUAL;

-- 사원번호와 사원 번호가 홀수이면 1, 짝수면 0을 출력
SELECT empno, MOD(empno,2)
    FROM emp;
    
-- 사원번호가 짝수인 사원들의 사원 번호와 이름을 출력
SELECT empno, ename
    FROM emp
    WHERE MOD(empno,2) =0;
    
-- 10을 3으로 나눈 몫을 출력
SELECT FLOOR(10/3)
    FROM dual;
    
-- #026 날짜 간 개월수 출력하기
-- sysdate : 오늘 날짜를 확인하는 함수
-- months_between(최신날짜, 예전날짜) : 날짜 값을 입력받아 숫자 값을 출력
-- 이름을 출력하고 입사한 날짜부터 오늘까지 총 몇달 근무했는지 출력
SELECT ename, MONTHS_BETWEEN(sysdate, hiredate)
    FROM emp;

-- 2018년 10월 1일에서 2019년 6월 1일 사이의 총 일수를 출력
-- to_date : 날짜를 구하는 함수
SELECT TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')
    FROM dual;

-- 2018년 10월 1일부터 2019년 6월 1일 사이의 총 주수 구하기
SELECT ROUND((TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')) / 7)  as "총 주수"
    FROM dual;

-- #027 개월 수 더한 날짜 출력하기
-- 2019년 5월 1일부터 100달 뒤의 날짜는?
SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'),100)
    FROM dual;

-- 2019년 5월 1일부터 100일 후에 돌아오는 날짜
-- 100일이면 한달을 30일? 31일? 애매함
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + 100
    FROM dual;
    
-- 100일이면 한달을 30일? 31일? 애매함 그래서 month 옵션을 줌
-- interval 함수로 날짜 한술 연산을 구현
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '100' month
    FROM dual;
    
-- interval 함수를 사용, 2019년 5월 1일부터 1년 3개월 후의 날짜를 출력
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
    FROM dual;
    
-- 연도가 1자리 : YEAR, 연도가 3자리 : YEAR(3)
-- 2019년 5월 1일에서 3년 후의 날짜를 반환
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '3' year
    FROM dual;
    
-- TO_YMINTERVAL을 사용하여 2019년 5월 1일부터 3년 5개월 후의 날짜를 출력

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') as 날짜
    FROM dual;
    
-- #028 특정 날짜 뒤에 오는 요일 날짜 출력하기
-- 2019년 5월 22일부터 바로 돌아올 월요일의 날짜는?
SELECT '2019/05/22' as 날짜,  NEXT_DAY('2019/05/22', '월요일')
    FROM dual;
    
-- 오늘 날짜를 출력
SELECT SYSDATE as "오늘 날짜"
    FROM dual;

-- 오늘부터 앞으로 돌아올 화요일의 날짜를 출력
SELECT NEXT_DAY(SYSDATE, '화요일') as "다음 날짜"
    FROM dual;
    
-- 오늘부터 100달 뒤에 돌아오는 월요일의 날짜를 출력
SELECT NEXT_DAY(ADD_MONTHS(sysdate, 100), '월요일') as "다음 날짜"
    FROM  dual;
    
-- #029 특정 날짜가 있는 달의 마지막 날짜 출력하기
-- 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 출력
SELECT '2019/05/22' as "날짜", LAST_DAY('2019/05/22')  as "마지막 날짜"
    FROM dual;
    
-- 오늘부터 이번달 말일까지 총 며칠 남았는지 출력
SELECT LAST_DAY(sysdate) - SYSDATE as "남은 날짜"
    FROM dual;
    
-- KING인 사원의 이름, 입사일, 입사한 달의 마지낙 날짜를 출력
SELECT ename, hiredate, LAST_DAY(hiredate)
    FROM emp
    WHERE ename = 'KING';
    
-- #030 문자형으로 데이터 유형 변환하기
-- 이름이 SCOTT인 사원의 이름과 입사한 요일을 출력하고, SCOTT의 월급에 천단위를 구분할수 있는 ,를 붙임
-- TO_CHAR(sal, 999,999)는 월급을 출력할때 천단위를 표시하여 출력
-- TO_CHAR : 숫자형 데이터 유형을 문자형으로 변환하거나 날짜형 데이터 유형을 문자형으로 변환할떄 사용
SELECT ename, TO_CHAR(hiredate, 'DAY') as 요일, TO_CHAR(sal, '999,999') as 월급
    FROM emp
    WHERE ename ='SCOTT';
    
-- 날짜를 문자로 변환해서 출력하면 날짜에서 년, 월, 일, 요일 등을 추출해서 출력
SELECT hiredate, TO_CHAR(hiredate, 'RRRR') as 연도, TO_CHAR(hiredate, 'MM') as 달,
                 TO_CHAR(hiredate, 'DD') as 일, TO_CHAR(hiredate, 'DAY') as 요일
    FROM emp
    WHERE ename = 'KING';
    
-- 1981년도에 입사한 사원의 이름과 입사일을 출력
SELECT ename, hiredate
    FROM emp
    WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

-- 날짜컬럼에서 연도/월/일/시간/분/초를 추출하기 위해 EXTRACT 함수를 사용
SELECT ename as 이름, EXTRACT(year from hiredate) as 연도,
                     EXTRACT(MONTH from hiredate) as 달,
                     EXTRACT(day from hiredate) as 요일
    FROM emp;
    
-- 이름과 월급을 출력하는데, 월급을 출력할때 천단위를 표시해서 출력
SELECT ename as 이름, TO_CHAR(sal, '999,999') as 월급
 FROM emp;
 
-- 천 단위와 백만 단위를 표시하는 예제
SELECT ename as 이름, TO_CHAR(sal * 200, '999,999,999') as 월급
    FROM emp;
    
-- 알파벳 L을 사용하여 화폐단위를 붙여서 출력
SELECT ename as 이름, TO_CHAR(sal*200, 'L999,999,999') as 월급
    FROM emp;