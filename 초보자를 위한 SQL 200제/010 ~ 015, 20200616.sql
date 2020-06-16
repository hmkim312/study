-- #010 비교 연산자배우기1
-- 월급이 1200이하인 사원들의 이름과 월급 직업 부서번호를 출력
SELECT ename, sal, job, deptno
    FROM emp
    WHERE sal <= 1200;
    
-- #011 비교 연산자 배우기2
-- 월급이 1000에서 3000 사이인 사원들의 이름과 월급을 출력
-- BETWEEN은 하한값 AND 상한값으로 입력
SELECT ename, sal
    FROM emp
    WHERE sal BETWEEN 1000 AND 3000;
    
SELECT ename, sal
    FROM emp
    WHERE (sal >= 1000 AND sal <= 3000);

-- 월급이 1000에서 3000 사이가 아닌 사원들의 이름과 월급을 조회
SELECT ename, sal
    FROM emp
    WHERE sal NOT BETWEEN 1000 and 3000;

SELECT ename, sal
    FROM emp
    WHERE (sal < 1000 OR sal > 3000);
    
-- 1982년도에 입사한 사원들의 이름과 입사일을 조회
SELECT ename, hiredate
    FROM emp
    WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';
    
-- #012 비교 연산자 배우기3(like)
-- 이름의 첫글자가 S로 시작하는 사원들의 이름과 월급을 출력
-- % : 와일드카드라고 하며 % 자리에는 어떠한 철자가 오고 몇개가 와도 상관 없다는 뜻
SELECT ename, sal
    FROM emp
    WHERE ename LIKE 'S%';

-- 이름의 두번쨰 철자가 M인 사원
-- _ : 언더바는 어떠한 철자가 와도 상관없으나 자리수는 한자리 인것
SELECT ename
    FROM emp
    WHERE ename LIKE '_M%';
    
-- 이름의 끝글자가 T로 끝나는 사원의 이름
SELECT ename
    FROM emp
    WHERE ename LIKE '%T';
    
-- 이름에 A가 들어가는 사원
SELECT ename
    FROM emp
    WHERE ename LIKE '%A%';
    
-- #013 비교연산자 배우기4
-- 커미션이 NULL인 사원들의 이름과 커미션을 출력
-- NULL은 =로 비교할수 없으며, is null 로 찾아야함
SELECT ename, comm
    FROM emp
    WHERE comm is null;
    
-- %014 비교연산자 배우기5
-- 직업이 SALESMAN, ANALYST, MANAGER인 사원들의 이름, 월급, 직업을 출력
SELECT ename, sal, job
    FROM emp
    WHERE job in ('SALESMAN', 'ANALYST', 'MANAGER');
    
SELECT ename, sal, job
    FROM emp
    WHERE (job = 'SALESMAN' or job = 'ANALYST' or job ='MANAGER');
    
-- 직업이 SALESMAN, ANALYST, MANAGER가 아닌 사원들의 이름, 월급, 직업을 출력
SELECT ename, sal, job
    FROM emp
    WHERE job not in ('SALESMAN', 'ANALYST', 'MANAGER');

SELECT ename, sal, job
    FROM emp
    WHERE (job != 'SALESMAN' and job != 'ANALYST' and job !='MANAGER');
    
-- #015 논리연산자 배우기
-- 직업이 SALESMAN이고 월급이 1200이상인 사원들의 이름, 월급, 직업을 출력
-- TRUE AND TRUE = TRUE, TRUE AND FALSE = FALSE
-- TRUE OR TRUE = TRUE, TRUE OR FALSE = TRUE
-- TRUE AND NULL = NULL, TRUE OR NULL = TRUE
SELECT ename, sal, job
    FROM emp
    WHERE job = 'SALESMAN' AND sal >= 1200;
    
-- WHERE의 조건이 모두 TRUE인 조건만 나옴, 둘중에 하나라도 FALSE면 나오지 않음
SELECT ename, sal, job
    FROM emp
    WHERE job = 'ABCS' AND sal >= 1200;