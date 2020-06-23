-- #093 일반 테이블 생성하기
-- 사원 번호, 이름, 월급, 입사일을 저장할 수 있는 테이블을 생성
-- 테이블 명과 컬럼명 지정 규칙
-- 반드시 문자로 시작, 이름의 길이는 30자 이하, 대문자 알파벳과 소문자 알파벳과 숫자를 포함 가능
-- 특수문자는 $,_,#만 포함가능
-- 괄호뒤에 숫자는, 길이. 길이 뒤에 숫자는 허용되는 소수점
CREATE TABLE emp01
(empno      NUMBER(10),
ename       VARCHAR2(10),
sal         NUMBER(10,2),
hiredate    DATE);

-- #094 임시테이블 생성하기
-- 사원번호 이름, 월급을 저장할 수 있는 테이블을 생성
-- commit 할떄까지만 데이터를 저장
-- ON COMMIT DELETE ROWS : 임시 테이블에 데이터를 입력하고 COMMIT 할때까지만 데이터를 보관
-- ON COMMIT PRESERVE ROWS : 임시 테이블에 데이터를 입력하고 세션이 종료될때까지 데이터를 보관
CREATE GLOBAL TEMPORARY TABLE EMP37
( empno         NUMBER(10),
   ename        VARCHAR2(10),
   sal          NUMBER(10))
   ON COMMIT DELETE ROWS;
   
-- ON COMMIT DELETE ROWS를 옵션으로 주고 만든 임시 테이블은 COMMIT 하면 데이터가 사라짐
INSERT INTO emp37 VALUES(1111, 'SCOTT', 3000);
INSERT INTO emp37 VALUES(2222, 'SMITH', 4000);

-- COMMIT 전이라 데이터가 보임
SELECT * FROM emp37;

-- 커밋
commit;

-- 커밋 후 다시 확인, 데이터가 없음
SELECT * FROM emp37;

--ON COMMIT PRESERVE ROWS 옵션을 주고 만든 임시 테이블은 접속한 세션을 로그아웃하면 데이터가 사라짐
CREATE GLOBAL TEMPORARY TABLE EMP38
( empno         NUMBER(10),
   ename        VARCHAR2(10),
   sal          NUMBER(10))
   ON COMMIT PRESERVE ROWS;
   
INSERT INTO emp38 VALUES(1111, 'SCOTT', 3000);
INSERT INTO emp38 VALUES(2222, 'SMITH', 4000);

SELECT * FROM emp38;

commit;

SELECT * FROM emp38;

-- #095 복잡한 쿼리를 단순하게 하기(1)
-- 직업이 SALESMAN인 사원들의 사원 번호, 이름, 월급, 직업, 부서 번호를 출력하는 VIEW 생성
-- CREATE VIEW AS 다음 VIEW를 통해 보여줄 쿼리를 작성
CREATE VIEW EMP_VIEW
AS
SELECT empno, ename, sal, job, deptno
    FROM emp
    WHERE job = 'SALESMAN';
    
-- VIEW 보기
SELECT *
    FROM emp_view;
    
-- VIEW 변경시 실제 테이블도 변경됨
UPDATE emp_view
SET sal = 0
WHERE ename = 'MARTIN';

-- 확인
SELECT * 
    FROM emp
    WHERE job = 'SALESMAN';

-- 되돌리기
ROLLBACK; 

-- #096 복잡한 쿼리를 단순하게 하기(2)
-- 부서번호와 부서 번호별 평균 월급을 출력하는 VIEW를 생성
-- 복합 뷰 : view에 함수나 그룹 함수가 포함되어있는것
CREATE VIEW emp_view2
AS
SELECT deptno, round(avg(sal)) "평균 월급"
    FROM emp
    GROUP BY deptno;

-- view 확인
SELECT *
    FROM emp_view2;
    
-- 복합 뷰는 데이터가 수정되지 않을수 있음
-- 평균수치는 여러데이터가 모여서 생긴 데이터이므로, 평균을 고치면 여러개의 데이터를 어떻게 고쳐야할지 몰라서
UPDATE emp_view2
    SET "평균 월급" = 3000
    WHERE deptno = 30;
    
-- view를 사용하여 쿼리를 작성하면 조금더 간결해짐
-- view를 사용하지 않았을때의 쿼리
SELECT e.ename, e.sal, e.deptno, v."평균 월급"
    FROM emp e, (SELECT deptno, round(avg(sal)) "평균 월급"
                    FROM emp
                    GROUP BY deptno) v
    WHERE e.deptno = v.deptno AND e.sal > v."평균 월급";
    
-- view를 사용할때의 쿼리 많이 짧아짐
SELECT e.ename, e.sal, e.deptno, v."평균 월급"
    FROM emp e, emp_view2 v
    WHERE e.deptno = v.deptno AND e.sal > v."평균 월급";
    
-- #097 데이터 검색 속도 높이기
-- 월급을 조회할떄 검색 속도를 높이기 위해 월급에 인덱스를 생성
-- index : 테이블에서 데이터를 검색할때 검색 속도를 높이기 위해 사용하는 데이터 베이스 객체
CREATE INDEX emp_sal
    ON emp(sal);
    
-- index없이 데이터 검색
-- emp에서  sal을 처음부터 스캔(1), 1600을 찾음 (2), 다시 끝까지 검색 (3)
-- 결국 데이터를 끝까지 FULL 스캔
SELECT ename, sal
    FROM emp
    WHERE sal = '1600';
    
-- index는 rowid를 가지고 있어서 데이터를 끝까지 full스캔 하지 않음
-- index가 sal을 내림차순으로 정렬하고 있으므로, 바로 sal 1600을 찾음
-- index의 rowid로 테이블의 해당 rowid를 찾아 name과 sal을 조회

-- #098 절대로 중복되지 않는 번호만들기
-- 숫자 1번부터 100번까지 출력하는 시퀀스 생성
-- 시퀀스 생성
CREATE SEQUENCE SEQ1
-- 첫시작 숫자를 1로 지정
START WITH 1
-- 숫자의 증가치를 1로 지정
INCREMENT BY 1
-- 최대치를 100으로 지정
MAXVALUE 100
-- 최대치 이후에 다시 1번부터 생성할지의 여부(안함)
NOCYCLE;

-- 지금 등록된 사원번호 조회
SELECT MAX(empno)
    FROM emp;
    
-- 조회된 7934보다 더 큰 번호로 데이터를 입력
INSERT INTO emp(empno, ename, sal, job, deptno)
    VALUES(7935, 'JACK', 3400, 'ANALYST', 20);
    
-- 하지만 시퀀스를 사용하면 해당 작업을 하지 않아도됨
-- 생성한 시퀀스를 사용하여 사원 테이블에 데이터 입력하기
-- 일단 테이블 생성
CREATE TABLE emp02
(empno NUMBER(10),
    ename VARCHAR2(10),
    sal NUMBER(10));
    
-- 시퀀스를 사용하여 데이터 입력
-- 시퀀스이름.NEXTVAL : 시퀀스의 다음 번호를 출력 또는 확인할때는 사용
INSERT INTO emp02 VALUES(SEQ1.NEXTVAL, 'JACK', 3500);
INSERT INTO emp02 VALUES(SEQ1.NEXTVAL, 'JAMES', 4500);

-- 데이터 확인
SELECT *
    FROM emp02;
    
-- #099 실수로 지운 데이터 복구하기(1)
-- 사원 테이블의 5분 전 KING 데이터를 검색
-- AS OF TIMESTAMP : 과거 시점 작성
-- SYSTIMESTAMP : 현재 시간
-- SYSTIMESTAMP - INTERVAL '5' MINUTE : 현재 시간에서 5분 뺸 것
SELECT *
    FROM emp
    AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE)
    WHERE ename = 'KING';
    
-- 현재 시간 확인
SELECT SYSTIMESTAMP
    FROM dual;

-- 현재 시간에서 5분뺸 시간 확인
SELECT SYSTIMESTAMP - INTERVAL '5' MINUTE
    FROM dual;
    
-- KING의 데이터를 변경하고 과거 시점의 데이터를 확인
-- KING의 월급 조회
SELECT ename, sal
    FROM emp
    WHERE ename = 'KING';

-- 월급을 0으로 바꿈
UPDATE emp
    SET sal = 0
    WHERE ename = 'KING';
    
commit;

-- 5분전의 KING 데이터 확인
SELECT *
    FROM emp
    AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE)
    WHERE ename = 'KING';
    
-- 테이블을 플레쉬백 확인
SELECT *
    FROM v$parameter
    WHERE name = 'undo_retention';
    
-- #100 실수로 지운 데이터 복구하기(2)
-- 플래쉬백 가능한 상태로 변경
ALTER TABLE emp ENABLE ROW MOVEMENT;

-- 플래쉬백 가능한 상태 확인
SELECT row_movement
    FROM user_tables
    WHERE table_name = 'emp';

-- 사원테이블을 10분전으로 변경
FLASHBACK TABLE emp TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE)

-- 특정 시간으로 변경도 가능
FLASHBACK TABLE emp TO TIMESTAMP
TO TIMESTAMP('20/06/23 19:25:00','RR/MM/DD HH24:MI:SS');

-- #101 실수로 지운 데이터 복구하기(3)
-- DROP된 사원 테이블을 휴지통에서 복구
-- 테이블 drop
DROP TABLE emp;

-- 휴지통에 있는지 확인
SELECT original_name, droptime
  FROM user_recyclebin;

-- 복구
FLASHBACK TABLE emp TO BEFORE DROP;

-- table 이름을 바꾸고 싶으면
FLASHBACK TABLE emp TO BEFORE DROP RENAME TO emp2;

-- #102 실수로 지운 데이터 복구하기(4)
-- 사원테이블의 데이터가 과거 특정 시점부터 지금까지 어떻게 변경되어 왔는지 이력 정보를 출력
SELECT ename, sal, versions_starttime, versions_endtime, versions_operation
    FROM emp
    VERSIONS BETWEEN TIMESTAMP
            TO_TIMESTAMP('2020-06-23 19:37:00', 'RRRR-MM-DD HH24:MI:SS')
            AND MAXVALUE
    WHERE ename = 'KING'
    ORDER BY versions_starttime;
    
-- 현재 시간 확인
SELECT SYSTIMESTAMP FROM dual;

-- KING 의 데이터 확인
SELECT *
    FROM emp
    WHERE ename = 'KING';
    
-- KING의 월급을 8000으로 변경하고 commit
UPDATE emp
    SET sal = 8000
    WHERE ename = 'KING';
    
commit;

-- KING의 부서번호를 20번으로 변경
UPDATE emp
    SET deptno = 20
    WHERE ename = 'KING';

commit;

-- KING의 데이터 변경 이력 정보를 확인
SELECT ename, sal, deptno, versions_starttime, versions_endtime, versions_operation
    FROM emp
    VERSIONS BETWEEN TIMESTAMP
            TO_TIMESTAMP('2020-06-23 19:37:00', 'RRRR-MM-DD HH24:MI:SS')
            AND MAXVALUE
        WHERE ename = 'KING'
    ORDER BY versions_starttime;
    
-- emp 테이블을 10분전으로 되돌리고 commit
FLASHBACK TABLE emp TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE);

commit;

-- #103 실수로 지운 데이터 복구하기(5)
-- 사원 테이블의 데이터를 5분 전으로 되돌리기 위한 DML문을 출력
-- 아카이브 모드 : 장애가 발생했을떄 DB를 복구할수 있는 로그정보를 자동으로 저장하게 하는 모드
SELECT undo_sql
    FROM flashback_transaction_query
    WHERE table_owner = 'SCOTT' AND table_name = 'emp'
    AND commit_scn between 9457390 AND 9457397
    ORDER BY start_timestamp DESC;
    
-- 도스창에서 sys유저로 접속
-- DB 정상 종료
-- 데이터 베이스를 마운트 상태로 올림
-- 아카이브 모드로 데이터 베이스를 변경
-- DML 문이 redo log file에 저장될수 있도록 설정
-- SCOTT 유저로 접속
-- king의 데이터 확인
-- king의 데이터 변경
-- king 데이터 변경 이력 정보 확인

-- #104 데이터의 품질 높이기
-- DEPTNO컬럼에 PRIMARY KEY 제약을 걸면서 테이블을 생성
-- PRIMARY KEY : null값과 중복된 데이터를 입력 불가능 ex(사원번호, 주민번호 등)
CREATE TABLE DEPT2
( DEPTNO  NUMBER(10) CONSTRAINT DPET2_DEPNO_PK  PRIMARY KEY,
  DNAME   VARCHAR2(14),
  LOC   VARCHAR2(10) );    

-- 테이블에 생성된 제약을 확인하는 방법
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
   FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
   WHERE a.TABLE_NAME = 'DEPT2'
   AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

DROP TABLE dept2;

-- 테이블 생성 후 제약을 생성
CREATE TABLE dept2
 (DEPTNO NUMBER(10),
  DNAME  VARCHAR2(13),
  LOC    VARCHAR2(10));
  
ALTER TABLE DEPT2
    ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY(DEPTNO);
    
-- #105 데이터의 품질 높이기
-- UNIQUE : 중복데이터 입력 안되게 제약, NULL은 입력 가능
CREATE TABLE dept3
 (deptno  NUMBER(10),
  dname   VARCHAR2(14) CONSTRAINT DEPT3_DNAME_UN UNIQUE,
  loc     VARCHAR2(10));
  
-- 테이블에 생성된 제약을 확인하는 방법
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
   FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
   WHERE a.TABLE_NAME = 'DEPT3'
   AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

-- 생성 후 제약 주기
CREATE TABLE dept4
 (deptno  NUMBER(10),
  dname   VARCHAR2(13),
  loc     VARCHAR2(10));
  
ALTER TABLE dept4
    ADD CONSTRAINT DEPT4_DNAME_UN UNIQUE(dname);
    
-- 테이블에 생성된 제약을 확인하는 방법
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
   FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
   WHERE a.TABLE_NAME = 'DEPT4'
   AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;
   
-- #106 데이터의 품질 높이기(3)
-- NOT NULL : 테이블의 특정 컬럼에 NULL값 입력을 허용하지 않게
CREATE TABLE DEPT5
( DEPTNO  NUMBER(10), 
  DNAME   VARCHAR2(14), 
  LOC   VARCHAR2(10) CONSTRAINT DEPT5_LOC_NN NOT NULL );
  
-- 데이터 생성 제약 걸기
-- 단, null이 없어야 함
CREATE TABLE DEPT6
( DEPTNO  NUMBER(10), 
  DNAME   VARCHAR2(14), 
  LOC   VARCHAR2(10));
  
ALTER TABLE dept6
    MODIFY LOC CONSTRAINT DEPT6_LOC_NN NOT NULL;
    
-- #107 데이터의 품질 높이기(4)
-- 사원테이블을 생성, 월급이 0에서 6000 사이의 데이터만 입력되거나 수정될수 있도록 제약
-- CHECK : 특정 컬럼에 특정 조건의 데이터만 입력되거나 수정되도록 제한을 거는것
CREATE TABLE emp6
 ( empno NUMBER(10),
   ename VARCHAR2(20),
   sal   NUMBER(10) CONSTRAINT EMP6_SAL_CK
   CHECK ( SAL BETWEEN 0  AND 6000) );
   
-- 제약을 벗어나는것을 넣으면? : 안됨
INSERT INTO emp6 VALUES (7566, 'ADAMS', 9000);

-- 제약 삭제
ALTER TABLE emp6
    DROP CONSTRAINT emp6_sal_ck;
    
-- 삽입됨
INSERT INTO emp6 VALUES (7566, 'ADAMS', 9000);


-- #108 데이터의 품질 높이기(5)
-- 사원 테이블의 부서 번호에 데이터를 입력할떄 부서 테이블에 존재하는 부서 번호만 입력될수 있도록 제약생성
-- FORREIGN KEY : 특정 컬럼에 데이터를 입력할떄 다른 테이블의 데이터를 참조해서 해당하는 데이터만 허용하는 것
-- emp7의 deptno가 foreing key, dept7의 deptno가 primary key
CREATE TABLE DEPT7
 (DEPTNO NUMBER(10) CONSTRAINT DEPT7_DEPTNO_PK PRIMARY KEY,
  DNAME  VARCHAR2(14),
  LOC    VARCHAR2(10));
  
CREATE TABLE EMP7
 (empno   NUMBER(10),
  ename   VARCHAR2(20),
  SAL     NUMBER(10),
  DEPTNO  NUMBER(10)
  CONSTRAINT EMP7_DEPTNO_FK REFERENCES DEPT7(DEPTNO));
  
-- 서로 제약이 걸린 상태에선 삭제가 안됨
ALTER TABLE DEPT7
    DROP CONSTRAINT DEPT7_DEPTNO_PK;

-- 삭제를 하려면 cascade 옵션을 붙여야 함
-- emp7 테이블의 foreign key 제약도 같이 삭제됨
ALTER TABLE dept7
    DROP CONSTRAINT DEPT7_DEPTNO_PK cascade;
    
-- #109 WITH절 사용하기(1)
-- WITH절을 이용하여 직업과 직업별 토탈 월급을 출력
-- 직업별 토탈월급들의 평균값보다 더 큰 값들만 출력
-- WITH : 검색 시간이 오래 걸리는 SQL이 하나의 SQL내에서 반복되어 사용될떄 성능을 높이기 위한 방법으로 사용
WITH JOB_SUMSAL as (SELECT job, SUM(sal) as 토탈
                            FROM emp
                            GROUP BY job)
    SELECT job, 토탈
        FROM JOB_SUMSAL
        WHERE 토탈 > (SELECT AVG(토탈)
                        FROM JOB_SUMSAL );
                        
-- with절 대신 서브쿼리를 사용
-- 아래 쿼리에선 단, 서브쿼리가 with절보다 2배 더 시간이 걸림
SELECT job, SUM(sal) as 토탈
    FROM emp
    GROUP BY job
    HAVING SUM(sal) > (SELECT AVG(SUM(sal))
                        FROM emp
                        GROUP BY job);
                        
-- #110 with절 사용하기(2)
-- with절 사용하면 특정 서브 쿼리문의 컬럼을 다른 서브 쿼리문에서 참조하는것이 가능함
-- 직업별 토탈평균값에 3000을 더한 값보다 더 큰 부서 번호별 토탈 월급들을 출력
-- job_sumsal이라는 임시저장 영역을 만들어, 해당 임시 저장영역을 참조하게 함.
WITH job_sumsal as (SELECT job, SUM(sal) 토탈
                        FROM emp
                        GROUP BY job) ,
    DEPTNO_SUMSAL as (SELECT deptno, SUM(sal) 토탈
                        FROM emp
                        GROUP BY deptno
                        HAVING SUM(sal) > (SELECT AVG(토탈) + 2000
                                                FROM job_sumsal)
                    )
    SELECT deptno, 토탈
        FROM deptno_sumsal;