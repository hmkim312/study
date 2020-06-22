-- #031 날짜형으로 데이터 유형 변환하기
-- 81년 11월 17일에 입사한 사원의 이름과 입사일을 출력
-- TO_DATE : 연도, 달, 일을 지정
SELECT ename, hiredate
    FROM emp
    WHERE hiredate =To_DATE('81/11/17', 'RRRR-MM-DD');
    
-- 날짜 데이터를 검색할때는 접속한 세션의 날짜형식을 확인해야 에러없이 검색가능
-- 현재 접속한 세션의 날짜 형식을 확인하는 쿼리
SELECT *
    FROM nls_session_parameters
    WHERE parameter = 'NLS_DATE_FORMAT';
    
-- 결과가 RR/MM/DD 일때 날짜를 검색하는법
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- 날짜형식이 DD/MM/RR 일때
-- 17은 연도가 아니라 일임(DD)
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '17/11/81';

-- 내가 접속한 세션의 날짜 형식을 DD/MM/RR로 변경하고 검색
-- 세션 : 지금 오라클에 접속한 창을 의미
-- 현재 내가 접속한 세션의 날짜 포멧을 DD/MM/RR 형식으로 변경, 
-- 지금 접속한 세션에서만 유효, 로그아웃 후 다시 접속 시 설정한 파라미터 값은 사라짐
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RR';

SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '17/11/81';
    
-- 일관되게 날짜를 검색하는 법
-- TO_DATE를 이용하여 RR/MM/DD 를 명시해주는것
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = TO_DATE('81/11/17', 'RR/MM/DD');
    
-- 다시 날짜 포멧을 RR/MM/DD로 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- # 032 암시적 형 변환 이해하기
-- 오라클은 알아서 암시적으로 형 변환을 함
-- 아래는 숫자형 = 문자형 비교이나, 암시적 형 변환으로 숫자형 = 숫자형으로 알아서 변경되는 쿼리
SELECT ename, sal
    FROM emp
    WHERE sal = '3000';
    
-- SAL을 문자형으로 만들어 생성하는 스크립트(EMP32)
CREATE TABLE EMP32
( ENAME  VARCHAR2(10),
 SAL      VARCHAR2(10) );
 
INSERT INTO EMP32 VALUES('SCOTT' ,'3000');
INSERT INTO EMP32 VALUES('SMITH' ,'1200');
COMMIT;

-- WHERE 절에서 sal = '3000'으로 쿼리를 작성하고 실행
-- 문자형 = 문자형
SELECT ename, sal
    FROM emp32
    WHERE sal = '3000';
    
-- 문자형 = 숫자형
SELECT ename, sal
    FROM emp32
    WHERE sal = 3000;
    
-- 이 쿼리와 같음
SELECT ename, sal
    FROM emp32
    WHERE TO_NUMBER(sal) = 3000;
    
-- SET AUTOT ON : SQL을 실행할때 출력되는 결과의 SQL을 실행하는 실행 계획을 한번에 보는 명령어

SET AUTOT ON

SELECT ename, sal
    FROM emp32
    WHERE sal = 3000;
    
-- # 033 NULL값 대신 다른 데이터 출력하기
-- 이름과 커미션을 출력, 커미션이 NULL인 사원들은 0으로
SELECT ename, comm, NVL(comm, 0)
    FROM emp;
    
-- 이름, 월급, 커미션, 월급 + 커미션을 출력하는 쿼리
-- NULL 값이 있어서, 월급 + 커미션도 NULL로 출력이됨
SELECT ename, sal, comm, sal+comm
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
-- 커미션의 NULL을 0으로 치환하여 월급 + 커미션을 출력
-- 커미션의 NULL이 0으로 치환됨
SELECT ename, sal, comm, NVL(comm,0), sal+NVL(comm,0)
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
-- NVL2 함수를 이용하여 커미션이 NULL이 아닌 사원들은 sal + comm을 출력하고, NULL인 사원들은 sal을 출력
SELECT ename, sal, comm, NVL2(comm, sal+comm, sal)
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
-- #034 IF문을 SQL로 구현하기(1)
-- deptno(부서넘버)가 10이면 300, 20이면 400, 둘다 아니면 0으로 출력
-- DECODE는 등호만 가능
SELECT ename, deptno, DECODE(deptno, 10, 300, 20, 400, 0) as 보너스
    FROM emp;
    
-- 사원번호가 짝수인지 홀수인지 출력하는 쿼리
SELECT empno, mod(empno,2), DECODE(mod(empno,2),0, '짝수', 1, '홀수') as 보너스
    FROM emp;

-- SALESMAN은 보너스 5000, 나머지는 2000을 출력
SELECT ename, job, DECODE(job, 'SALESMAN', 5000, 2000) as 보너스
    FROM emp;
    
-- #035 IF문을 SQL로 구현하기(2)
-- 월급이 300이상이면 500, 2000이상이면 300, 1000 이상이면 200을 나머지는 0으로 보너스를 출력
-- CASE는 >= 부등호도 가능
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
                             
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');

-- 이름, 직업, 커미션, 보너스를 출력 
-- 보너스는 커미션이 NULL이면 500을 출력, NULL이 아니면 0을 출력
SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                              ELSE 0 END BONUS
    FROM emp
    WHERE job IN('SALESMAN', 'ANALYST');
    
-- 보너스를 출력할떄 직업이 SALESMAN, ANALYST면 500을 출력하고 CLERK, MANAGER이면 400을 나머지는 0을 출력
SELECT ename, job, CASE WHEN job in ('SALESMAN', 'ANALYST') THEN 500
                        WHEN job in ('CLERK', 'MANAGER') THEN 400
                    ELSE 0 END AS BONUS
    FROM emp;
    
-- #036 최대값 출력하기
-- 사원 테이블에서 최대 월급을 출력
SELECT MAX(sal)
    FROM emp;
    
-- SALESMAN의 최대 월급 출력
SELECT MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN';
    
-- SALESMAN 중에 누가 최대 인가?
-- 단일 그룹의 함수가 아니라는 오류 뜸
-- job 컬럼의 값은 여러개의 행이 출력되는데 MAX(sal)은 값 하나가 출력되기 때문에 오류가 뜨는것임
SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALSEMAN';
    
-- 위의 오류를 해결하기 위해 groupby로 job을 그룹핑
SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN'
    GROUP BY job;
    
-- 부서번호와 부서 번호별 최대 월급을 출력
SELECT deptno, MAX(sal)
    FROM emp
    GROUP BY deptno;
    
-- #037 최소값 출력하기
-- 직업이 SALESMAN인 사원들 중 최소 월급을 출력
SELECT MIN(sal)
    FROM emp
    WHERE job = 'SALESMAN';
    
-- 직업과 직업별 최소 월급을 출력 ORDER BY절을 사용하여 최소 월급이 높은 것부터 출력
-- ORDER BY 는 항상 맨 마지막에 실행
SELECT job, MIN(sal) 최소값
    FROM emp
    GROUP BY job
    ORDER By 최소값 DESC;
    
-- 그룹 함수의 특징은 WHERE절의 조건이 거짓이어도 결과를 항상 출력함
-- WHERE 1 = 2는 거짓이지만 실행됨
SELECT MIN(sal)
    FROM emp
    WHERE 1 = 2;
    
-- 결과는 NULL로 출력, 다음과 같이 NVL 함수를 확인
SELECT NVL(MIN(sal),0)
    FROM emp
    WHERE 1 = 2;
    
-- 직업, 직업별 최소 월급을 출력
-- 직업에서 SALESMAN은 제외하고 출력
-- 직업별 최소 월급이 높은것부터 출력
SELECT job, MIN(sal)
    FROM emp
    WHERE job != 'SALESMAN'
    GROUP BY job
    ORDER BY MIN(sal) DESC;
    
-- #038 평균값 출력하기
-- 사원 테이블의 평균 커미션을 출력
SELECT AVG(comm)
    FROM emp;
    
-- 그룹 함수는 NULL값을 무시, 따라서 NULL을 0으로 치환 후 평균값을 출력하면 달라짐
SELECT ROUND(AVG(NVL(comm,0)))
    FROM emp;
    
-- #039 토탈값 출력하기
-- 부서별 연봉 모두 더하기
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno;

-- 직업과 직업별 토탈 월급을 출력, 직업별 토탈 월급이 높은것부터 출력
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    ORDER BY SUM(sal) DESC;
    
-- 직업과 직업별 토탈월급을 출력
-- 직업별 토탈 월급이 4000 이상인 것만 출력
-- 그룹 함수는 허가되지 않습니다 라는 오류가 출력
-- 그룹 함수로 조건을 줄떄는 WHERE절 대신 HAVING절을 사용해야 함
SELECT job, SUM(sal)
    FROM emp
    WHERE SUM(sal) >= 4000
    GROUP BY job;
    
-- 그룹 함수로 조건을 줄떄는 WHERE절 대신 HAVING절을 사용해야 함
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    HAVING SUM(sal) >= 4000;
    
-- 직업과 직업별 토탈 월급을 출력하는데, 직업을 SALESMAN은 제외
-- 직업별 토탈 월급이 4000이상인 사원들만 출력
SELECT job, SUM(sal)
    FROM emp
    WHERE job != 'SALESMAN'
    GROUP BY job
    HAVING SUM(sal) >= 4000;
    
-- ORDER BY가 제일 마지막에 실행됨
-- FROM절을 제일 먼저 실행, 그다음 WHERE, 그리고 GROUP BY절을 실행
-- emp 테이블에서 컬럼 별칭인 직업을 찾을수 없음으로, 오류 뜸
SELECT job as 직업, SUM(sal)
    FROM emp
    WHERE job != 'SALESMAN'
    GROUP BY 직업
    HAVING SUM(sal) >= 4000;
    
-- #040 건수 출력하기
-- 사원 테이블 전체 사원수를 출력
-- COUNT : 건수를 세는 함수
SELECT COUNT(empno)
    FROM emp;

-- NULL값은 무시함
SELECT COUNT(comm)
    FROM emp;
    
-- #041 데이터 분석 함수로 순위 출력하기(1)
-- 직업이 ANALYST, MANAGER인 사원들의 이름, 직업, 월급, 월급의 순위를 출력
-- RANK() : 순위를 출력하는 데이터 분석 함수
-- RANK()뒤에 OVER 다음에 나오는 괄호 안에 출력하고 싶은 데이터를 정렬하는 SQL문장을 넣으면 그 컬람값에 대한 데이터의 순위가 출력
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) 순위
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER');
    
-- 직업별로 월급이 높은 순서대로 순위를 부여해서 각각 출력
SELECT ename, sal, job, RANK() over (PARTITION BY job  ORDER BY sal DESC) as 순위
    FROM emp;
    
-- # 042 데이터 분석 함수로 순위 출력하기(2)
-- RANK : 1등이 2명있어서, 바로 3등이 출력
-- DENSE_RANK : 1등이 2명있어도 그 뒤에는 2등이 출력
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) as RANK,
                        DENSE_RANK() over (ORDER BY sal DESC) as DENCE_RANK
    FROM emp
    WHERE job IN ('ANALYST', 'MANAGER');
    
-- 81년도에 입사한 사원들의 직업, 이름, 월급, 순위를 출력
-- 직업별로 월급이 높은 순서대로 출력
SELECT job, ename, sal, DENSE_RANK() over (PARTITION BY job
                                           ORDER BY sal DESC) as 순위
    FROM emp
    WHERE hiredate BETWEEN TO_DATE('1981/01/01', 'RRRR/MM/DD')
                       AND TO_DATE('1981/12/31', 'RRRR/MM/DD');
                       
-- DENSE_RANK 바로 다음에 나오는 괄호에도 다음과 같이 데이터를 넣고 활용
-- 월급이 2975인 사원은 사원 테이블에서 월급의 순위를 출력
-- WITHIN : ~ 이내
-- WITHIN GROUP : 어느 그룹
SELECT DENSE_RANK(2975) WITHIN GROUP (ORDER BY sal DESC) 순위
    FROM emp;

-- 입사일 81년 11월 17일인 사원 테이블 전체 사원들 중 몇번째로 입사하였는가
SELECT DENSE_RANK('81/11/17') WITHIN GROUP (ORDER BY hiredate ASC) 순위
    FROM emp;
    
-- #043 데이터 분석 함수로 등급 출력하기
-- 이름과 월급, 직업, 월급의 등급을 출력
-- 월급의 등급은 4등급으로 1~4등급씩 각 25%로 함
-- NTILE() : 괄호안에 숫자를 넣는것으로 등급을 나눔
-- NULLS LAST : 월급을 높은것부터 출력되도록 정렬하는데, NULL을 맨 아래에 출력
SELECT ename, job, sal,
    NTILE(4) over (ORDER BY sal DESC NULLS LAST) 등급
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER', 'CLERK');
    
-- #044 데이터 분석 함수로 순위의 비율 출력하기
-- 이름과 월급, 월급의 순위, 얼급의 순위 비율을 출력
SELECT ename, sal, RANK() over(ORDER BY sal DESC) as RANK ,
                   DENSE_RANK() over (ORDER BY sal DESC) as DENSE_RANK,
                   CUME_DIST() over (ORDER BY sal DESC) as CUM_DIST
    FROM emp;
    
-- PARTITION BY JOB을 사용하여 직업별로 CUME_DIST를 출력
SELECT job, ename, sal, RANK() over (PARTITION BY JOB
                                     ORDER BY sal DESC) as RANK,
                        CUME_DIST() over (PARTITION BY JOB
                                          ORDER BY sal DESC) as CUM_DIST
    FROM emp;
    
-- #045 데이터 분석 함수로 데이터를 가로로 출력
-- 부서 번호를 출력하고, 부서 번호 옆에 해당 부서에 속하는 사원들의 이름을 가로로 출력
-- LISTAGG : 데이터를 가로로 출력
-- WITHIN GROUP : GROUP 다음에 나오는 괄호에 속한 그룹의 데이터를 출력
-- GROUP BY : LISTAGG 함수를 사용하려면 필수로 사용
SELECT deptno, LISTAGG(ename, ',') WITHIN GROUP (ORDER BY ename) as EMPLOYEE
    FROM emp
    GROUP BY deptno;
    
-- 직업과 그 직업에 속한 사원들의 이름을 가로로 출력
SELECT job, LISTAGG(ename, ',') WITHIN GROUP (ORDER BY ename ASC) as EMPLOYEE
    FROM emp
    GROUP BY job;
    
-- 이름 옆에 월급도 같이 출력하기위한 연결연산자 사용
SELECT job,
    LISTAGG(ename||'('||sal||')', ',') WITHIN GROUP (ORDER BY ename ASC) as EMPLOYEE
    FROM emp
    GROUP BY job;
    
-- #043 데이터 분석 함수로 바로 전 행과 다음행 출력하기
-- 사원번호, 이름, 월급을 출력, 그 옆에 바로 전 행의 월급을 출력, 또 옆에 바로 다음 행의 월급을 출력
SELECT empno, ename, sal,
        LAG(sal,1) over (ORDER BY sal ASC) "전 행",
        LEAD(sal, 1) over (ORDER BY sal ASC) "다음 행"
    FROM emp
    WHERE job IN ('ANALYST', 'MANAGER');
    
-- 부서번호, 사원번호, 이름, 입사일, 바로 전에 입사한 사원의 입사일을 출력
-- 바로 다음에 입사한 사원의 입사일을 출력, 부서 번호별로 구분해서
SELECT deptno, empno, ename, hiredate,
        LAG(hiredate,1) over (PARTITION BY deptno
                              ORDER BY hiredate  ASC) "전 행",
        LEAD(hiredate,1) over (PARTITION BY deptno
                               ORDER BY hiredate ASC) "다음 행"
    FROM emp;
    
-- #047 COLUMN을 ROW로 출력하기(1)
-- 부서번호, 부서 번호별 토탈 월급을 출력. 단, 가로로 출력
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
       SUM(DECODE(deptno, 20, sal)) as "20",
       SUM(DECODE(deptno, 30, sal)) as "30"
    FROM emp;
    
-- 부서 번호가 10번이면 월급이 출력, 아니면 NULL이 출력
SELECT deptno,  DECODE(deptno, 10, sal) as "10"
    FROM emp;
    
-- DEPTNO 컬럼을 제외하고 DECODE(deptno, 10, sal)만 출력한 다음 출력된 결과를 다 더함
SELECT SUM(DECODE(deptno, 10, sal)) as "10"
    FROM emp;
    
-- 동일하게 20, 30을 추가
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
       SUM(DECODE(deptno, 20, sal)) as "20",
       SUM(DECODE(deptno, 30, sal)) as "30"
    FROM emp;
    
-- 직업, 직업별 토탈 월급을 가로로 출력
SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp;
    
-- 위의 쿼리에서 SELECT절에 deptno를 추가
-- deptno를 추가하면 부서 번호별로 각각 직업의 토탈 월급의 분포를 보기 위함
-- deptno를 그룹함수와 같이 넣었으므로, GROUP BY deptno를 추가

SELECT deptno, SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp
    GROUP BY deptno;
    
-- #048 COLUMN을 ROW로 출력하기(2)
-- 부서번호, 부서번호별 토탈 월급을 Pivot문을 사용하여 가로로 출력
SELECT *
    FROM (select deptno, sal from emp)
    PIVOT (sum(sal) for deptno in (10,20,30));
    
-- PIVOT 문을 이용하여 직업과 직업별 토탈 월급을 가로로 출력
SELECT *
    FROM(select job, sal from emp)
    PIVOT(sum(sal) for job in ('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN'));
    
-- 싱클 쿼테이션 마크 없이 하기
SELECT *
    FROM(select job, sal from emp)
    PIVOT (sum(sal) for job in ('ANALYST' as "ANALYST", 'CLERK' as "CLERK", 
                                'MANAGER' as "MANAGER", 'SALESMAN' as "SALESMAN"));
                                
-- #049 ROW를 COLUMN으로 출력하기
create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );

commit;

-- UNPIVOT문을 사용하여 컬럼을 로우로 출력
-- UNPIVOT : 열을 행으로 출력
SELECT *
    FROM order2
    UNPIVOT (건수 for 아이템 in (BICYCLE, CAMERA, NOTEBOOK));
    
SELECT *
    FROM order2
    UNPIVOT(건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
    
-- order2 테이블의 데이터에 NULL이 포함되어 있다면 UNPIVOT 결과에서 출력되지 않음
-- SMITH의 NOTEBOOK을 NULL로 변경
UPDATE ORDER2 SET NOTEBOOK=NULL WHERE ENAME='SMITH';

-- SMITH의 NOTEBOOK이 NULL로 되어있으므로 UNPIVOT을 사용하면 출력이 안됨
-- NULL을 보려면 UNPIVOT INCLUDE NULLS를 사용하여야함
SELECT *
    FROM order2
    UNPIVOT INCLUDE NULLS(건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
    
-- #050 데이터 분석 함수로 누적 데이터 출력하기
-- 직업이 ANALYST, MANAGER인 사원들의 사원번호, 이름, 월급, 월급의 누적치를 출력
-- OVER의 괄호안에는 값을 누적할 윈도우를 지정할수 있음
-- UNBOUNDED PRECEDING는 제일 첫번째 행을 가리킴
SELECT empno, ename, sal, SUM(sal) over (ORDER BY empno ROWS
                                         BETWEEN UNBOUNDED PRECEDING
                                         AND CURRENT ROW) 누적치
    FROM emp
    WHERE job IN ('ANALYST', 'MANAGER');