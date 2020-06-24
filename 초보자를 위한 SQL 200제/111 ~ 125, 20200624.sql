-- #111 SQL로 알고리즘 문제풀기(1)
-- 구구단 2단 출력
-- 계층형 질의문을 이용
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                            FROM dual
                            CONNECT BY LEVEL <=9)
    SELECT '2' || 'x' || NUM || ' = ' || 2 * NUM as "2단"
        FROM LOOP_TABLE;
        
-- 숫자 1번부터 9번까지 출력한 결과를 WITH절을 이용하여 LOOP_TABLE로 저장
SELECT LEVEL as NUM
    FROM dual
    CONNECT BY LEVEL <=9;
    
-- #112 SQL로 알고리즘 문제풀기(2)
-- 구구단 1단 ~ 9단 출력
-- WITH절과 계층형 질의문을 사용
-- 계층형 질의문을 이용하여 숫자 1번 부터 9번까지 출력한 결과를 WITH절을 이용하여 LOOP_TABLE로 저장
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= 9),
-- 계층형 질의문을 이용하여 숫자 2번부터 9번까지 출력한 결과를 WITH절을 이용하여 GUGU_TABLE로 저장
     GUGU_TABLE as (SELECT LEVEL + 1 as GUGU
                        FROM dual
                        CONNECT BY LEVEL <= 8)
-- LOOP_TABLE과 GUGU_TABLE에서 숫자를 각각 불러와 구구단 전체를 출력하는 문장을 연결 연산자로 만듬
    SELECT TO_CHAR(A.NUM) || ' x ' || TO_CHAR(B.GUGU) || ' = ' ||
           TO_CHAR(B.GUGU * A.NUM) as 구구단
        FROM LOOP_TABLE A, GUGU_TABLE B;
        
-- #113 SQL로 알고리즘 문제풀기
-- 직각삼각형 출력
-- 계층형 질의문과 LPAD를 이용
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= 8)
    SELECT LPAD('★', NUM, '★') as STAR
        FROM LOOP_TABLE;
        
-- ★ 10개 출력
SELECT LPAD('★' ,10, '★') as STAR
    FROM dual;
    
-- #114 SQL로 알고리즘 문제풀기(4)
-- 삼각형 출력
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= 8)
    SELECT LPAD(' ',10-num, ' ') || LPAD('★', num, '★') as "TRIANGLE"
        FROM LOOP_TABLE;
        
-- 원하는 크기의 삼각형 출력
undefine 숫자1
undefine 숫자2

WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= &숫자1)
                        
    SELECT LPAD(' ', &숫자2-NUM, ' ') || LPAD('★', NUM, '★') as "TRIANGLE"
        FROM LOOP_TABLE;
        
-- #115 SQL로 알고리즘 문제풀기(5)
-- 마름모 출력
-- p_num : 호스트 변수, 외부 변수 undefine 명령어로 변수에 담겨있는 내용 삭제
-- accept : 값을 받아 p_num변수에 담는 명령어
-- UNION ALL : 집합 연산자, 위의 쿼리와 아래의 쿼리를 합침
undefine p_num
ACCEPT p_num prompt '숫자 입력 : '

SELECT LPAD(' ', &p_num-LEVEL, ' ') || RPAD('★', LEVEL, '★') as STAR
        FROM dual
        CONNECT BY LEVEL <&p_num+1
UNION ALL
SELECT LPAD(' ', LEVEL, ' ') || RPAD('★', (&p_num) - LEVEL, '★') as STAR
        FROM dual
        CONNECT BY LEVEL < &p_num;
        
-- #116 SQL로 알고리즘 문제 풀기(6)
-- 사각형 출력
undefine p_n1
undefine p_n2
ACCEPT p_n1 prompt '가로 숫자를 입력하세요~';
ACCEPT p_n2 prompt '세로 숫자를 입력하세요~';

-- &p_n2 변수 안의 값만큼 세로로 출력되는 행수가 반복
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= &p_n2)
-- &p_n1 변수 안의 값 만큼 가로로 출력되는 별이 반복
SELECT LPAD('★', &p_n1, '★') as STAR
    FROM LOOP_TABLE;
    
-- #117 SQL로 알고리즘 문제 풀기(7)
-- 1부터 10까지의 숫자 합
undefine p_n
ACCEPT p_n prompt '숫자에 대한 값 입력 : ';

-- LEVEL이 출력하고 있는 1부터 10까지의 합계를 집계
SELECT SUM(LEVEL) as 합계
    FROM dual
    CONNECT BY LEVEL <= &p_n;
    
-- #118 SQL로 알고리즘 문제 풀기(8)
-- 1부터 10까지 숫자의 곱
undefine p_n
ACCEPT p_n prompt '숫자에 대한 값 입력 : ';

SELECT ROUND(EXP(SUM(LN(LEVEL)))) 곱
    FROM dual
    CONNECT BY LEVEL <= &p_n;
    
-- #119 SQL로 알고리즘 문제 풀기(9)
-- 1부터 10까지 짝수만 출력
undefine p_n
ACCEPT p_n prompt '숫자에 대한 값 입력 : ';

SELECT LISTAGG(LEVEL, ', ') as 짝수
    FROM dual
    -- 레벨을 2로 나눠서 0이되는 값만 검색
    WHERE MOD(LEVEL, 2) = 0
    CONNECT BY LEVEL <= &p_n;
    
-- #120 SQL로 알고리즘 문제풀기(10)
-- 1부터 10까지 소수만 출력
undefine p_n
ACCEPT p_n prompt '숫자에 대한 값 입력 : ';

WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= &p_n)
SELECT L1.NUM as 소수
    FROM LOOP_TABLE L1, LOOP_TABLE L2
    WHERE MOD(L1.NUM, L2.NUM) = 0
    GROUP BY L1.NUM
    HAVING COUNT(L1.NUM) = 2;
    
-- #121 SQL로 알고리즘 문제풀기(11)
-- 최대 공약수
ACCEPT p_n1 prompt '첫번째 숫자에 대한 값 입력 : ';
ACCEPT p_n2 prompt '두번째 숫자에 대한 값 입력 : ';

WITH NUM_D as (SELECT &p_n1 as NUM1, &p_n2 as NUM2
                    FROM dual)
SELECT MAX(LEVEL) as "최대 공약수"
    FROM NUM_D
    WHERE MOD(NUM1, LEVEL) = 0
      AND MOD(NUM2, LEVEL) = 0
    CONNECT BY LEVEL <= NUM2;
    
-- #122 SQL로 알고리즘 문제 풀기(12)
-- 최소 공배수
ACCEPT p_n1 prompt '첫번째 숫자에 대한 값 입력 : ';
ACCEPT p_n2 prompt '두번째 숫자에 대한 값 입력 : ';

WITH NUM_D as (SELECT &p_n1 as NUM1, &p_n2 as NUM2
                    FROM dual)
SELECT NUM1, NUM2,
        (NUM1/MAX(LEVEL)) * (NUM2/MAX(LEVEL)) * MAX(LEVEL) AS "최소 공배수"
    FROM NUM_D
    WHERE MOD(NUM1, LEVEL) = 0
      AND MOD(NUM2, LEVEL) = 0
    CONNECT BY LEVEL <= NUM2;
    
-- #123 SQL로 알고리즘 문제 풀기(13)
-- 피타고라스의 정리
ACCEPT NUM1 prompt '밑변의 길이에 대한 값 입력 : ';
ACCEPT NUM2 prompt '높이의 대한 값 입력 : ';
ACCEPT NUM3 prompt '빗변의 길이에 대한 값 입력 : ';

SELECT CASE WHEN
        ( POWER(&NUM1, 2) + POWER(&NUM2,2)) = POWER(&NUM3,2)
            THEN '직각 삼각형이 맞습니다'
            ELSE '직각 삼각형이 아닙니다' END AS "피타고라스의 정리"
    FROM dual;
    
-- #124 SQL로 알고리즘 문제 풀기(14)
-- 몬테카를로 알고리즘
-- 몬테카를로 알고리즘을 이용하여 원주율 출력
SELECT SUM(CASE WHEN (POWER(NUM1, 2) + POWER(NUM2,2)) <= 1 THEN 1
            ELSE 0 END) / 1000000 * 4 as "원주율"
    FROM(
            SELECT DBMS_RANDOM.VALUE(0,1) as NUM1,
                   DBMS_RANDOM.VALUE(0,1) as NUM2
                FROM dual
            CONNECT BY LEVEL < 1000000
        );
        
-- #125 SQL로 알고리즘 문제풀기(15)
-- 오일러 상수 자연상수 구하기
-- 몬테카를로 알고리즘을 이용하여 자연상수 e값을 출력
-- 계층형 질의문으로 1000000까지의 숫자를 만들어 LOOP_TABLE이라는 WITH절용 임시 테이블에 저장
WITH LOOP_TABLE AS (SELECT LEVEL AS NUM FROM dual
                        CONNECT BY LEVEL <= 1000000
                    )
-- 자연상수를 도출하는 식을 POWER함수로 작성, 숫자가 커질수록 점점 자연상수 값에 근사해짐
SELECT RESULT
    FROM (
            SELECT NUM, POWER((1+1/NUM) ,NUM) AS RESULT
                FROM LOOP_TABLE
            )
    WHERE NUM = 1000000;