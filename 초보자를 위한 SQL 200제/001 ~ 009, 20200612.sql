-- #001_ 테이블에서 특정열(column) 선택하기
-- EMPNO, ENAME, SAL을 EMP테이블로부터 선택해서 출력해라
SELECT empno, ename, sal
    FROM emp;
    
-- 대소문자 상관 없음
SELECT EMPNO, ENAME, SAL
FROM EMP;

SELECT empno, ename, sal
FROM emp;

-- 가독성을 위해 SQL은 대문자로, 컬럼명, 테이블명은 소문자로 작성을 권장
SELECT empno, ename, sal
FROM emp;

-- 한줄로 작성
SELECT empno, ename, sal FROM emp;

-- 여러줄로 작성
SELECT empno, ename, sal 
FROM emp;

-- 들여쓰기 안했을때
SELECT empno, ename, sal 
FROM emp;

-- 들여쓰기
SELECT empno, ename, sal 
    FROM emp;
    
-- SELECT, FROM은 항상 순서를 맞춰줘야함

-- #002 테이블에서 모든 열(COLUMN) 출력하기
-- emp 테이블의 모든 column을 가져오는 명령어(*)
SELECT *
    FROM emp;

-- *대신 가져오고 싶은 column을 일일이 나열해줘도 됨
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
    FROM emp;

-- emp 테이블의 모든 컬럼을 출력하고 맨끝에 다시 한번 특정 컬럼을 한번더 출력
SELECT dept.*, deptno
    FROM dept;

-- #003 컬럼 별칭을 사용하여 출력되는 컬럼명 변경하기
-- as 뒤에는 띄어쓰기가 안되나보다. 에러뜸
-- "" 더블쿼테이션 마크를 감싸줘야 할때
    -- 대소문자를 구분하여 출력 할때
    -- 공백문자를 출력할때
    -- 특수문자를 출력할때
SELECT empno as 사원번호, ename as 사원이름, sal as "Salary"
    FROM emp;
    
-- 쿼리에 수식을 사용하여 결과를 출력할때 as가 유용함
SELECT ename, sal * (12 + 3000)
    FROM emp;

SELECT ename, sal * (12 + 3000) as 연봉
    FROM emp;
    
-- ORDER BY에 유용함
SELECT ename, sal * (12 + 3000) as 연봉
    FROM emp
    ORDER BY 연봉 desc;
    
-- #004 연결 연산자 사용하기(||)
-- 이름과 월급을 붙여서 출력
SELECT ename || sal
    FROM emp;

-- 문자열과 같이 연결해서 출력하기
SELECT ename || '의 월급은 ' || sal || '입니다' as 월급정보
    FROM emp;

-- 문자열과 같이 연결해서 출력하기
SELECT ename || '의 직업은 ' || job || '입니다' as 직업정보
    FROM emp;
    
-- #005 중복된 데이터를 제거해서 출력하기(DISTINCT)
-- 사원 테이블의 직업중 중복된 데이터 제거하고 출력
SELECT DISTINCT job
    FROM emp;

-- DISTINCT와 동일한 UNIQUE도 있음
SELECT UNIQUE job
    FROM emp;

-- #006 데이터를 정렬해서 출력하기 (ORDER BY)
-- acs : 오름차순, desc : 내림차순
-- 이름과 월급을 출력하는데 월급이 낮은 사원부터 출력하기(오름차순)
-- ORDER BY는 맨 마지막에 작성함, 실행도 제일 마지막에 됨
SELECT ename, sal
    FROM emp
    ORDER BY sal asc;
    
-- 별칭을 ORDER BY에 사용 가능
SELECT ename, sal as 월급
    FROM emp
    ORDER BY 월급 asc;
    
-- 여러개 컬럼을 작성
-- 부서번호를 먼저  오름차순으로 정렬 뒤 월급을 내림차순으로 정렬함
SELECT ename, deptno, sal
    FROM emp
    ORDER BY deptno asc, sal DESC;
    
-- #007 WHERE절 배우기1(숫자 데이터 검색)
-- WHERE절은 FROM절 다음에 작성
-- 월급이 3000인 사원들의 이름, 월급, 직업을 출력
SELECT ename, sal, job
    FROM emp
    WHERE sal = 3000;

-- 월급이 3000이상인 사원들의 이름과 월급을 출력
SELECT ename as 이름, sal as 월급
    FROM emp
    WHERE sal >= 3000;

-- 별칭을 WHRER절에 사용하면?
-- 오류가 뜸 why? FREM -> WHERE -> SELECT 순으로 실행되기 때문에 WHERE가 실행될떈 월급이 없음
SELECT ename as 이름, sal as 월급
    FROM emp
    WHERE 월급 >= 3000;
    
-- #008 WHERE절 배우기2(문자와 날짜 검색)
-- 이름이 scott인 사원의 이름, 월급, 직업, 입사일, 부서번호 출력
SELECT ename, sal, job, hiredate, deptno
    FROM emp
    WHERE ename = 'SCOTT';

-- 입사일이 81년 11월 17일인 사원의 이름과 입사일 출력
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- 접속한 session의 날짜형식 확인
SELECT *
    FROM NLS_SESSION_PARAMETERS
    WHERE PARAMETER ='NLS_DATE_FORMAT';
    
-- 날짜 session 타입 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';

-- 다시 조회해보기(안나옴)
-- YY일때는 81년을 2081년으로 인식해서 나오지 않음
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- 날짜 session 타입 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- 다시 조회해보기(안나옴)
-- RR일때는 81년을 81년으로 인식해서 나오게됨
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- 세션이란 데이터 베이스 유저로 로그인해서 로그아웃할때까지의 한 단위

-- #009 산술 연산자 배우기(*, /, +, -)
-- 연봉 36000 이상인 사원들의 이름과 연봉을 출력
SELECT ename, sal * 12 as 연봉
    FROM emp
    WHERE sal * 12 >= 36000;

-- 부서 번호가 10번인 사원들의 이름, 월급, 커미션, 월급 + 커미션을 출력, sal + comm이 null이나옴
SELECT ename, sal, comm, sal + comm
    FROM emp
    WHERE deptno = 10;

-- null을 처리하는 함수 NVL NVL(comm,0)은 comm이 null이면 0으로 취급하게 함
SELECT ename, sal, comm, sal + NVL(comm, 0)
    FROM emp
    WHERE deptno = 10;