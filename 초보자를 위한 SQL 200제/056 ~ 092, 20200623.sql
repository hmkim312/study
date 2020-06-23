-- #056 출력되는 행 제한하기(1)
-- 사원테이블의 사원 번호, 이름, 직업, 월급을 상단 5개의 행만 출력
-- ROWNUM : 가상의 ROWNUM을 생성하여 그것을 5개 이하만 보게되면 상위 5개 행만 보여짐
-- 대용량 데이터 파일 볼때 유용함
SELECT ROWNUM, empno, ename, job, sal
    FROM emp
    WHERE ROWNUM <=5 ;
    
-- # 057 출력되는 행 제한하기(2)
-- 월급이 높은 사원순으로 사원번호, 이름, 직업, 월급을 4개의 행으로 제한해서 출력
-- FETCH FIRST N ROWS ONLY : N개의 결과를 봄 
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;
    
-- 월급이 높은 사원들중 20%에 해당하는 사원들만 출력
SELECT empno, ename, job, sal
    FROM emp
    FETCH FIRST 20 PERCENT ROWS ONLY;
    
-- WITH TIES : 여러행이 N번째 행과 동일하다면 같이 출력
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;
    
-- OFFSET : 출력이 시작되는 행의 위치를 지정 가능
-- 10번쨰 행부터 끝까지 결과를 출력
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS;
    
-- OFFSET과 FETCH를 조합해서 사용
-- OFFSET 9로 출력된 5개의 행 중에서 2개만 보여줌
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS
    FETCH FIRST 2 ROWS ONLY;
    
-- #058 여러 테이블의 데이터를 조인해서 출력하기(1)
-- 사원 테이블과 부서 테이블을 조인하여 이름과 부서 위치를 출력
-- emp.deptno = dept.deptno의 조건을 줌
SELECT ename, loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;

-- 만일 조건을 주지 않고 조인을 하면 전부다 조인이 됨
SELECT ename, loc
    FROM emp, dept;
    
-- 직업이 ANALYST인 사원들만 출력
-- emp.deptno = dept.deptno : 조인 조건, 두 테이블을 조인하기 위해 필요한 조건
-- emp.job = 'ANALYST'는 : 검색 조건, 전체 데이터 중에 특정 데이터만 제한하여 보기위한 조건
SELECT ename, loc, job
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
-- deptno도 추가
-- emp, dept 테이블에 모두 있는 deptno는 어디것을 가져와야 할지 몰라서 오류가 남
SELECT ename, loc, job, deptno
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';

-- 따라서 열 이름 앞에 테이블명을 접두어로 붙여줘야함
SELECT ename, loc, job, emp.deptno
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
-- 검색속도 향상을 위해 모든 컬럼앞에 테이블명을 붙이는 것이 좋음
SELECT emp.ename, dept.loc, emp.job
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
-- FROM 절에 테이블을 별칭으로 변경후 사용도 가능
SELECT e.ename, d.loc, e.job
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job = 'ANALYST';
    
-- 단, 별칭을 지정한 후에는 emp.은 사용이 불가능
SELECT emp.ename, d.loc, e.job
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job = 'ANALYST';
    
-- #059 여러테이블의 데이터를 조인해서 출력하기(2)
-- 사원 테이블과 급여 등급 테이블을 조인하여 이름, 월급, 급여 등급을 출력
SELECT e.ename, e.sal, s.grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal and s.hisal;
    
-- salgrade는 급여 등급 테이블, 5등급일수록 높음
SELECT * FROM salgrade;

-- NON equal join : equal을 사용해서 조인을 할수 없을때는
-- emp의 sal은 salgrade의 losal, hisal 사이에 있는것을 이용하여 조인
SELECT e.ename, e.sal, s.grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal and s.hisal;
    
-- #060 여러 테이블의 데이터를 조인해서 출력하기(3)
-- 사원 테이블과 부서 테이블을조인하여 이름과 부서위치를 출력
-- 단, boston도 같이 출력
-- (+) : OUTER join의 사인, equal join은 둘다 있는 데이터만 출력, OUTER는 데이터가 없는 테이블도 출력 
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno (+) = d.deptno;
    
-- #061 여러 테이블의 데이터를 조인해서 출력하기(4)
-- 사원테이블 자기 자신의 테이블과 조인하여 이름, 직업, 해당 사원의 관리자 이름과 관리자의 직업을 출력
SELECT e.ename as 사원, e.job as 직업, m.ename as 관리자, m.job as 직업
    FROM emp e, emp m
    WHERE e.mgr = m.empno and e.job ='SALESMAN';
    
-- #062 여러 테이블의 데이터를 조인해서 출력하기(5)
-- ON절을 사용하여 이름과 직업 월급 부서 위치를 출력
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as 부서위치
    FROM emp e JOIN dept d
    ON (e.deptno = d.deptno)
    WHERE e.job = 'SALESMAN';
    
-- 오라클 EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    
-- ON절을 사용한 조인
SELECT e.ename, d.loc
    FROM emp e JOIN dept d
    ON (e.deptno = d.deptno);
    
-- 여러개의 테이블을 조인할때의 작성법
-- 오라클 EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno
    AND e.sal BETWEEN s.losal and s.hisal;

-- ON절을 사용한 조인
-- 조인 조건의 개수 = 테이블개수 -1
SELECT e.ename, d.loc, s.grade
    FROM emp e
    JOIN dept d ON(e.deptno = d.deptno)
    JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal);
    
-- #063 여러테이블의 데이터를 조인해서 출력하기(5)
-- USING 절을 사용한 조인 방법으로 이름, 직업, 월급, 부서 위치를 출력
-- USING절에는 조인 조건 대신 두 테이블을 연결할때 사용할 컬럼을 작성
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e JOIN dept d
    USING (deptno)
    WHERE e.job = 'SALESMAN';
    
-- 오라클 EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    
-- USING절을 사용한 조인
SELECT e.ename, d.loc
    FROM emp e JOIN dept d
    USING (deptno);
    
-- 어러개의 테이블을 조인하기
-- 오라클 EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal;

-- USING절을 사용한 JOIN
-- emp와 조인하는 테이블명 다음에 USING절을 사용하면 됨
SELECT e.ename, d.loc, s.grade
    FROM emp e
    JOIN dept d USING(deptno)
    JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal);

-- #064 여러테이블의 데이터를 조인해서 출력하기(6)
-- NATURAL 조인방법으로 이름, 직업, 월급과 부서 위치를 출력
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e NATURAL JOIN dept d
    WHERE e.job = 'SALESMAN';
    
-- JOIN의 연결고리가 되는 컬럼인 deptno는 테이블명을 별칭없이 사용해야함.
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e NATURAL JOIN dept d
    WHERE e.job = 'SALESMAN' and deptno = 30;
    
-- #065 여러 테이블의 데이터를 조인해서 출력하기
-- RIGHT OUTER JOIN 방법으로 이름, 직업, 월급, 부서 위치를 출력
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e RIGHT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- 오라클 RIGHT OUTER JOIN
-- (+)를 데이터가 '덜' 출력되는 쪽에 붙여줌
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno (+) = d.deptno;
    
-- RIGHT OUTER JOIN
SELECT e.ename, d.loc
    FROM emp e RIGHT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- 부서번호 50번을 생성 뒤 LEFT OUTER JOIN 해보기
INSERT INTO emp(empno, ename, sal, job, deptno)
        VALUES(8282, 'JACK', 3000, 'ANALYST', 50);
    
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e LEFT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- 오라클의 LETF OUTER JOIN 
-- (+)를 데이터가 '덜' 출력되는 쪽에 붙여줌
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno (+);
    
-- LETF OUTER JOIN
SELECT e.ename, d.loc
    FROM emp e LEFT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- #066 여러 테이블의 데이터를 조인해서 출력하기(8)
-- FULL OUTER 조인방법으로 이름, 직업, 월급, 부서 위치 출력
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    FROM emp e FULL OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- 오라클의 OUTER JOIN 방법을 사용하면 에러남
-- 오라클의 OUTER JOIN은 1개만 지정가능 
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno (+) = d.deptno(+);
    
-- FULL OUTER JOIN을 사용하지 않고 동일한 결과를 출력하는 법
-- UNION을 쓰면됨
SELECT e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc "부서 위치"
    FROM emp e LEFT OUTER JOIN dept d
    ON (e.deptno = d.deptno)
UNION
SELECT e.ename, e.job, e.sal, d.loc
    FROM emp e RIGHT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- #067 집합 연산자로 데이터를 위아래로 연결하기(1)
-- 부서 번호와 부서 번호별 토탈 월급을 출력하는데, 맨 아래쪽 행에 토탈월급을 같이 출력
-- UNION ALL : 위 아래 쿼리 결과를 하나의 결과로 출력하는 집합 연산자
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno
UNION ALL
SELECT TO_NUMBER(null) as deptno, SUM(sal)
    FROM emp;
    
-- UNION ALL은 중복을 제거하지않는다.

CREATE TABLE A (COL1 NUMBER(10) );
INSERT INTO A VALUES(1);
INSERT INTO A VALUES(2);
INSERT INTO A VALUES(3);
INSERT INTO A VALUES(4);
INSERT INTO A VALUES(5);
commit;

CREATE TABLE B (COL1 NUMBER(10) );
INSERT INTO A VALUES(3);
INSERT INTO A VALUES(4);
INSERT INTO A VALUES(5);
INSERT INTO A VALUES(6);
INSERT INTO A VALUES(7);
commit;

-- 위에서 만든 1,2,3,4,5의 데이터와 3,4,5,6,7의 데이터를 합치면 중복되는 3,4,5는 사라지지않고 그대로 출력
SELECT COL1 FROM A
UNION ALL
SELECT COL1 FROM B;

-- #068 집합 연산자로 데이터를 위아래로 연결하기(2)
-- 부서번호와 부서 번호별 토탈 월급을 출력하는데, 맨 아래 행에 토탈월급을 출력
-- UNION 과 UNION ALL과 다른점 1 : 중복된 데이터를 하나의 고유한 값으로 출력(중복제거됨)
-- UNION 과 UNION ALL과 다른점 2 : 첫번째 칼럼의 데이터를 기준으로 내림차순으로 정렬하여 출력
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno
UNION
SELECT null as deptno, SUM(sal)
    FROM emp;
    
-- 테이블 C와 D를 생성 후 중복된 데이터 출력이 어떻게 되는지 확인
CREATE TABLE C (COL1 NUMBER(10) );
INSERT INTO C VALUES(1);
INSERT INTO C VALUES(2);
INSERT INTO C VALUES(3);
INSERT INTO C VALUES(4);
INSERT INTO C VALUES(5);
COMMIT;

CREATE TABLE D (COL1 NUMBER(10) );
INSERT INTO D VALUES(3);
INSERT INTO D VALUES(4);
INSERT INTO D VALUES(5);
INSERT INTO D VALUES(6);
INSERT INTO D VALUES(7);
COMMIT;

-- UNION은 중복된 데이터가 제거되고 출력됨
SELECT COL1 FROM C
UNION
SELECT COL1 FROM D;

-- #069 집합 연산자로 데이터의 교집합을 출력하기
-- 부서 번호 10번, 20번인 사원들을 출력하는 쿼리의 결과
-- 부서 번호 20번, 30번을 출력하는 쿼리 결과의 교집합을 출력
-- INTERSECT의 위의 쿼리와 아래 쿼리의 교집합을 출력
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN (10, 20)
INTERSECT
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN (20, 30);
    
-- 교집합을 가진 테이블 만듬
CREATE TABLE E (COL1 NUMBER(10) );
INSERT INTO E VALUES(1);
INSERT INTO E VALUES(2);
INSERT INTO E VALUES(3);
INSERT INTO E VALUES(4);
INSERT INTO E VALUES(5);
COMMIT;

CREATE TABLE F (COL1 NUMBER(10) );
INSERT INTO F VALUES(3);
INSERT INTO F VALUES(4);
INSERT INTO F VALUES(5);
INSERT INTO F VALUES(6);
INSERT INTO F VALUES(7);
COMMIT;

-- INTERSECT의 교집합 확인 (3,4,5 만 출력됨)
SELECT col1 FROM e
INTERSECT
SELECT col1 FROM f;

-- #070 집합 연산자로 데이터의 차이를 출력하기
-- 부서 번호 10번, 20번을 출력하는 쿼리의 결과에서 부서 번호 20번, 30번을 출력하는 쿼리
-- MINUS : 위쪽 쿼리의 결과 데이터에서 아래쪽 쿼리의 결과 데이터의 차이를 출력
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN(10, 20)
MINUS
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN(20,30);
    
-- 두 쿼리의 차이를 보기 위해 테이블 생성
CREATE TABLE G (COL1 NUMBER(10) );
INSERT INTO G VALUES(1);
INSERT INTO G VALUES(2);
INSERT INTO G VALUES(3);
INSERT INTO G VALUES(4);
INSERT INTO G VALUES(5);
COMMIT;

CREATE TABLE H (COL1 NUMBER(10) );
INSERT INTO H VALUES(3);
INSERT INTO H VALUES(4);
INSERT INTO H VALUES(5);
INSERT INTO H VALUES(6);
INSERT INTO H VALUES(7);
COMMIT;

-- 테이블G와 테이블H의 차이를 출력, 내림차순으로 정렬함
SELECT col1 FROM g
MINUS
SELECT col1 FROM h;

-- #071 서브쿼리 사용하기(1)
-- JONES보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력
SELECT ename, sal
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- 일단 JONES의 월급 찾는 쿼리 (서브 쿼리)
SELECT sal
    FROM emp
    WHERE ename = 'JONES';
    
-- JONES의 월급은 2975, 이보다 높은 사원들의 이름과 월급을 출력 (메인 쿼리)
SELECT ename, sal
    FROM emp
    WHERE sal > 2975;
    
-- 서브쿼리와 메인쿼리를 합침
SELECT ename, sal
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- SCOTT과 같은 월급을 받는 사원들의 이름과 월급을 출력
SELECT ename, sal
    FROM emp
    WHERE sal = (SELECT sal
                    FROM emp
                    WHERE ename = 'SCOTT');

-- SCOTT을 제외하려면 한줄 더 추가
-- 메인쿼리의 AND ename != 'SCOTT'
SELECT ename, sal
    FROM emp
    WHERE sal = (SELECT sal
                    FROM emp
                    WHERE ename = 'SCOTT')
    AND ename != 'SCOTT';
    
-- #072 서브 쿼리 사용하기(2)
-- 직업이 SALESMAN인 사원들과 같은 월급을 받는 사원들의 이름과 월급을 출력
-- 직업이 SALESMAN인 사원들이 한명이 아니라 여려명이기 때문에 in을 사용, equal을 사용하면 오류
-- in - 단일 행 서브 쿼리 : 서브 쿼리에서 메인 쿼리로 하나의 값이 반환
-- in - 다중 행 서브 쿼리 : 서브 쿼리에서 메인 쿼리로 여러 개의 값이 반환
-- in - 다중컬럼 서브 쿼리 : 서브 쿼리에서 메인 쿼리로 여러개의 컬럼 값이 반환 
SELECT ename, sal
    FROM emp
    WHERE sal in (SELECT sal 
                    FROM emp
                    WHERE job = 'SALESMAN');
                    
-- #073 서브쿼리 사용하기(3)
-- 관리자가 아닌 사원들의 이름과 직업을 출력
SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr
                            FROM emp
                            WHERE mgr is not null);
                            
-- 메인 쿼리
SELECT ename, sal, job
    FROM emp
    WHERE empno not in (7839, 7698, 7902, 7566, 7788, 7782);
    
-- 메인쿼리 + 서브쿼리 (null)
-- NULL 때문에 아무값도 안나옴
-- not in을 사용하면 서브쿼리에서 메인쿼리로 NULL값이 하나라도 리턴되면 결과가 출력되지 않음.
SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr
                            FROM emp);
                            
-- #074 서브 쿼리 사용하기(4)
-- 부서 테이블에 있는 부서 번호 중에서 사원 테이블에도 존재하는 부서 번호의 부서번호, 부서명, 부서위치 출력
-- EXISTS : 테이블 A에 존재하는 데이터가 테이블B에 존재하는지 여부를 확인할때 EXISTS또는 NOT EXISTS를 사용
SELECT *
    FROM dept d
    WHERE EXISTS(SELECT *
                    FROM emp e
                    WHERE e.deptno = d.deptno);

-- NOT EXISTS : dept에는 존재하나 emp에는 존재하지 않는 데이터를 검색할때 사용
SELECT *
    FROM dept d
    WHERE NOT EXISTS(SELECT *
                        FROM emp e
                        WHERE e.deptno = d.deptno);
                        
-- #075 서브 쿼리 사용하기(5)
-- 직업과 직업별 토탈 월급을 출력
-- 직업이 SALESMAN인 사원들의 토탈월급보다 더큰 값만 출력
-- HAVING : 그룹함수를 사용할떄 WHERE가 아닌 HAVING을 사용
-- GROUP BY는 서브쿼리에서 사용불가능
SELECT job,  SUM(sal)
    FROM emp
    GROUP BY job
    HAVING SUM(sal) > (SELECT SUM(sal)
                        FROM emp
                        WHERE job = 'SALESMAN');
                        
-- #076 서브쿼리 사용하기(6)
-- 이름과 월급과 순위를 출력
-- 순위가 1위인 사원만 출력
-- in line view : FROM절의 서브쿼리
SELECT v.ename, v.sal, v.순위
    FROM(SELECT ename, sal, RANK() over(ORDER BY sal DESC) 순위
            FROM emp) v
    WHERE v.순위 = 1;
    
-- #077 서브 쿼리 사용하기(7)
-- 직업이 SALESMAN인 사원들의 이름과 월급을 출력하는데, 직업이 SALESMAN인 사원들의 최대월급과 최소월급도 같이 출력
-- scalar 서브쿼리 : SELECT절의 서브 쿼리, 출력되는 행 수 만큼 반복되어 실행됨
-- 여기서는 SALESMAN이 4명이라, scalar 서브쿼리도 4번 수행됨
SELECT ename, sal, (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN') as "최대 월급",
                   (SELECT MIN(sal) FROM emp WHERE job = 'SALESMAN') as "최소 월급"
    FROM emp
    WHERE job = 'SALESMAN';
    
-- #078 데이터 입력하기
-- 사원 테이블에 데이터를 입력
-- 사원 번호 2812, 사원 이름 JACK, 월급 3500, 입사일 2019년 6월 5일, 직업은 ANALYST
INSERT INTO emp (empno, ename, sal, hiredate, job)
    VALUES(2812, 'JACK', 3500, TO_DATE('2019/06/05', 'RRRR/MM/DD'), 'ANALYST');
    
-- insert : 데이터 입력
-- update : 데이터 수정
-- delete : 데이터 삭제
-- merge : 데이터 입력, 수정, 삭제를 한 번에 수행

-- #079 데이터 수정하기
-- SCOTT의 월급을 3200으로 수정
UPDATE emp
    SET sal = 3200
    WHERE ename ='SCOTT';
    
-- 하나의 UPDATE문으로 여러개의 열 값 수정 가능
-- SCOTT의 월급과 커미션을 동시에 변경, SET절에 변경할 컬럼을 ,로 구분
-- UPDATE, SET, WHERE문은 모든 절에서 서브쿼리 작성 가능
UPDATE emp
    SET sal = 5000, comm = 200
    WHERE ename = 'SCOTT';
    
-- #080 데이터 삭제하기
-- 사원 테이블에서 SCOTT의 행 데이터를 삭제
-- 삭제 명령어 : DELETE, TRUNCATE, DROP
-- CREATE : 생성
-- ALTER : 수정
-- DROP : 삭제
-- TRUNCATE : 삭제
-- RENAME : 객체 이름 변경
DELETE FROM emp
WHERE ename = 'SCOTT';

-- #081 데이터저장 및 취소하기
-- 사원 테이블에 입력한 데이터가 데이터 베이스에 저장되도록
INSERT INTO emp(empno, ename, sal, deptno)
    VALUES(1122, 'JACK1', 3000, 20);
    
-- COMMIT : COMMIT 이전에 수행했던 DML 작업들을 데이터베이스에 영구히 반영하는 TCL
COMMIT;

UPDATE emp
    SET sal = 4000
    WHERE ename = 'SCOTT';
    
-- ROLLBACK : 마지막 COMMIT 명령어를 수행 후 DML문을 취소하는 TCL
--여기서는 SCOTT의 월급을 4000으로 변경하는 UPDATE문이 취소됨
ROLLBACK;

-- COMMIT : 모든 변경 사항을 데이터 베이스에 반영
-- ROLLBACK : 모든 변경 사항을 취소
-- SAVEPOINT : 특정 지점까지의 변경을 취소

-- #082 데이터 입력, 수정, 삭제 한번에 하기
-- emp 테이블에 loc 컬럼 추가
ALTER TABLE emp
    ADD loc varchar2(10);

-- 사원 테이블에 부서 위치 컬럼 추가, 부서 테이블을 이용하여 해당 사원의 부서위치로 갱신
-- 만약 부서 테이블에는 존재하는 부서이나, 사원 테이블에 없는 부서라면 새롭게 사원 테이블에 입력
-- merge into 다음에 merge 대상이 되는 target 테이블명 작성
MERGE INTO emp e
-- using절 다음에는 SOURCE 테이블명 작성, dept로부터 데이터를 읽어와 dept테이블의 데이터로 emp 테이블을 merge
USING dept d
-- target테이블과 source 테이블을 조인, 조인에 성공하면 merge update를 실행, 실해하면 merge insert절을 실행
ON (e.deptno = d.deptno)
-- merge update절 join에 성공하면 수행되는 절, 사원 테이블의 부서 위치 컬럼을 부서 테이블의 부서위치로 갱신
WHEN MATCHED THEN
-- ㅡmerge insert절 join에 실패되면 수행되는절, 부서 테이블의 데이터를 사원 테이블에 입력
UPDATE SET e.loc = d.loc
WHEN NOT MATCHED THEN
INSERT (e.empno, e.deptno, e.loc) VALUES (1111, d.deptno, d.loc);

-- #083 LOCK 이해하기
-- 같은 데이터를 동시에 갱신할 수 없도록 하는 락
-- SCOTT으로 접속한 터미널창 1에서 update 후 commit을 하지 않는다면
-- 같은 세션인 SCOTT으로 접속한 터미널창 2에서 다른 update를 한다면 변경되지 않고 멈춤
-- 터미널창1에 접속한 SCOTT세션이 update후 commit이나, rollback을 하지 않았기 때문에
-- update 문을 실행하면 update 대상이 되는 행을 잠궈 버림(이것이 lock)
-- lock가 걸리는 이유는 데이터의 일관성을 유지 하기 위해서

-- #084 SELECT FOR UPDATE절 이해하기
-- SELECT FOR UPDATE문은 검색하는 행에 락을 거는 SQL문
-- 터미널창 1에서 SELECT FOR UPDATE문으로 데이터를 검색하면 자동으로 락이 걸림
-- 터미널창 2에서 행을 변경하려고하면 변경이 안됨.
-- 터미널창 1에서 commit을 하면 lock이 해재되면서 터미널창 2에서 실행한 쿼리가 수행됨

-- #085 서브 쿼리를 사용하여 데이터 입력하기
-- emp2 table 생성
CREATE TABLE emp2
    as
        SELECT *
            FROM emp
            WHERE 1 = 2;

-- emp 테이블의 구조를 그대로 복제한 emp2 테이블에 부서번호가 10번인 사원들의 사원번호, 이름, 월급, 부서번호를 한번에 입력
-- VALUES절에 대신 SELECT로 서브쿼리를 작성
INSERT INTO emp2(empno, ename, sal, deptno)
    SELECT empno, ename, sal, deptno
        FROM emp
        WHERE deptno = 10;
    
-- #086 서브 쿼리를 사용하여 데이터 수정하기
-- 직업이 SALESMAN인 사원들의 월급을 ALLEN의 월급으로 변경
UPDATE emp
    SET sal = (SELECT sal
                FROM emp
                WHERE ename = 'ALLEN')
WHERE job = 'SALESMAN';

-- #087 서브 쿼리를 사용하여 데이터 삭제하기
-- SCOTT보다 더 많은 월급을 받는 사원들을 삭제
DELETE FROM emp
WHERE sal > (SELECT sal
                FROM emp
                WHERE ename = 'SCOTT');
                
-- 월급이 해당 사원이 속한 부서 번호의 평균 월급보다 크면 삭제
DELETE FROM emp m
WHERE sal > (SELECT avg(sal)
                FROM emp s
                WHERE s.deptno = m.deptno);
                
-- #088 서브쿼리를 사용하여 데이터 합치기
-- dept 테이블에 sumsal 컬럼을 추가
ALTER TABLE dept
    ADD sumsal number(10);

-- 부서 테이블에 숫자형으로 SUMSAL 컬럼을 추가
-- 사원 테이블을 이용하여 SUMSAL 컬럼의 데이터를 부서 테이블의 부서 번호별 토탈월급으로 갱신
MERGE INTO dept d
USING (SELECT deptno, SUM(sal) sumsal
        FROM emp
        GROUP BY deptno) v
ON (d.deptno = v.deptno)
WHEN MATCHED THEN
UPDATE SET d.sumsal = v.sumsal;

-- #089 계층형 질의문으로 서열을 주고 데이터 출력하기(1)
-- 계층형 질의문을 이용하여 사원 이름, 월급, 직업을 출력
-- 사원들 간의 서열을 같이 출력
-- connect by와 start with절을 사용하여 pseudo column인 level을 출력, 
-- level : 계층 트리 구조에서 계층
-- ex : KING은 트리 구조의 최상위에 있는 노드여서 계층 1레벨이되며, 순차적으로 그 하위에 있는 레벨2와 3이 이 부여되어 출력
-- rpad로 이름 앞에 공백을 level수의 3배가 되도록 추가하여 서열을 시각화함
-- start with : 해당 절에서 루트노드의 데이터를 지정, 루트노드는 최상위 노드, KING이 사장이므로 루트노드로 지정
-- connect by : 부모 노드와 자식노드들간의 관계를 지정하는 절 prior를 가운데로 두고, 왼쪽이 부모노드, 오른쪽이 자식노드
-- 노드 : 표시된 항목
-- 레벨 : 트리 구조에서 각각의 계층
-- 루트 : 트리 구조에서 최상위에 있는 노드
-- 부모 : 트리 구조에서 상위에 있는 노드
-- 자식 : 트리 구조에서 하위에 있는 노드
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr;
    
-- #090 계층형 질의문으로 서열을 주고 데이터 출력하기(2)
-- 위의 예제에서 BLAKE와 그 직속부하는 출력되지 않게 
-- WHERE 절에 ename != BLAKE조건을 추가
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr AND ename != 'BLAKE';
    
-- #091 계층형 질의문으로 서열을 주고 데이터 출력하기(3)
-- 계층형 질의문을 이용하여, 사원 이름, 월급, 직업을 서열과 같이 출력
-- 서열 순서를 유지하면서 월급이 높은 사원부터 출력
-- SIBILNGS : ORDER와 BY 사이에 사용하여 정렬하면 계층형 질의문의 서열 순서를 꺠트리지 않으면서 출력 가능
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr
    ORDER SIBLINGS BY sal DESC;
    
-- 만일 SIBLINGS를 사용하지 않는경우 월급이 높은 순서로대로 출력되어 계층 순서가 깨짐
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr
    ORDER BY sal DESC;
    
-- #092 계층형 질의문으로 서열을 주고 데이터 출력하기(4)
-- 계층형 질의문과 SYS_CONNECT_BY 함수를 이용하여 서열순서를 가로로 출력
SELECT ename, SYS_CONNECT_BY_PATH(ename, '/') as path
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr;
    
--LTRIM을 사용하여 가로로 출력되는 이름 앞에 '/'를 제거하고 출력
SELECT ename, LTRIM(SYS_CONNECT_BY_PATH(ename, '/'), '/') as path
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr;