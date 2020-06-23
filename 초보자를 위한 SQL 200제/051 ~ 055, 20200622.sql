-- #051 데이터분석 함수로 비율 출력하기
-- 부서 번호가 20번인 사원들의 사원번호, 이름, 월급을 출력
-- 20번 부서 번호내에서 자신의 월급 비율이 어떻게 되는지 출력
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over () as 비율
    FROM emp
    WHERE deptno = 20;
    
-- 20번 부서번호의 사원들의 월급을 20번 부서 번호인 사원들의 전체월급으로 나누어 출력
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over() as 비율,
                          sal/SUM(sal) over() as "비교 비율"
    FROM emp
    WHERE deptno = 20;
    
-- #052 데이터분석 함수로 집계 결과 출력하기(1)
-- 직업과 직업별 토탈 월급을 출력
-- 맨 마지막 행에 토탈 월급을 출력
-- ROLLUP : 직업과 직업별 토탈 월급을 출력하는 쿼리에, ROLLUP을 붙여주면 전체 토탈 월급이 추가됨
SELECT job, SUM(sal)
    FROM emp
    GROUP BY ROLLUP(job);
    
-- ROLLUP을 사용하여 맨 아래에 토탈 월급을 출력
-- GROUP BY를 사용하여 부서별 토탈 월급도 출력
-- job 컬럼의 데이터도 오름차순으로 출력
SELECT deptno, job, SUM(sal)
    FROM emp
    GROUP BY ROLLUP(deptno, job);
    
-- #053 데이터 분석 함수로 집계결과 출력하기(2)
-- 직업, 직업별 토탈 월급을 출력
-- 첫번째 행에 토탈 월급을 출력
-- CUBE : 맨 위쪽에 토탈이 추가됨
SELECT job, SUM(sal)
    FROM emp
    GROUP BY CUBE(job);
    
-- CUBE에 컬럼 2개를 사용
-- 토탈월급이 출력되고, 부서별 토탈월급이 출력됨
SELECT deptno, job, SUM(sal)
    FROM emp
    GROUP BY CUBE(deptno, job); 
    
-- #054 데이터 분석 함수로 집계 결과 출력하기(3)
-- 부서번호와 직업, 부서 번호별 토탈 월급과 직업별 토탈 월급, 전체 토탈월급을 출력
-- GROUPING SETS : 괄호안에 집계하고 싶은 컬럼명을 기술
SELECT deptno, job, SUM(sal)
    FROM emp
    GROUP BY GROUPING SETS((deptno), (job), ());

-- #055 데이터 분석 함수로 출력결과 넘버링 하기
-- ROW_NUMBER : 출력되는 각 행에 고유한 숫자값을 부여하는 함수
SELECT empno, ename, sal, RANK() over (ORDER BY sal DESC) RANK,
                          DENSE_RANK() over (ORDER BY sal DESC) DENSE_RANK,
                          ROW_NUMBER() over (ORDER BY sal DESC) 번호
    FROM emp
    WHERE deptno = 20;
    
-- ROW_NUMBER는 over 다음 괄호 안에 반드시 ORDER BY절을 기술해야 함
-- 아래는 ORDER BY가 없어서 오류남
SELECT empno, ename, sal, ROW_NUMBER() over () 번호
    FROM emp
    WHERE deptno = 20;
    
-- 부서 번호별로 월급에 대한 순위를 출력
-- PARTITION BY를 사용
SELECT deptno, ename, sal, ROW_NUMBER() over (PARTITION BY deptno
                                              ORDER BY sal DESC) 번호
    FROM emp
    WHERE deptno in (10, 20);