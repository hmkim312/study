-- #093 �Ϲ� ���̺� �����ϱ�
-- ��� ��ȣ, �̸�, ����, �Ի����� ������ �� �ִ� ���̺��� ����
-- ���̺� ��� �÷��� ���� ��Ģ
-- �ݵ�� ���ڷ� ����, �̸��� ���̴� 30�� ����, �빮�� ���ĺ��� �ҹ��� ���ĺ��� ���ڸ� ���� ����
-- Ư�����ڴ� $,_,#�� ���԰���
-- ��ȣ�ڿ� ���ڴ�, ����. ���� �ڿ� ���ڴ� ���Ǵ� �Ҽ���
CREATE TABLE emp01
(empno      NUMBER(10),
ename       VARCHAR2(10),
sal         NUMBER(10,2),
hiredate    DATE);

-- #094 �ӽ����̺� �����ϱ�
-- �����ȣ �̸�, ������ ������ �� �ִ� ���̺��� ����
-- commit �ҋ������� �����͸� ����
-- ON COMMIT DELETE ROWS : �ӽ� ���̺� �����͸� �Է��ϰ� COMMIT �Ҷ������� �����͸� ����
-- ON COMMIT PRESERVE ROWS : �ӽ� ���̺� �����͸� �Է��ϰ� ������ ����ɶ����� �����͸� ����
CREATE GLOBAL TEMPORARY TABLE EMP37
( empno         NUMBER(10),
   ename        VARCHAR2(10),
   sal          NUMBER(10))
   ON COMMIT DELETE ROWS;
   
-- ON COMMIT DELETE ROWS�� �ɼ����� �ְ� ���� �ӽ� ���̺��� COMMIT �ϸ� �����Ͱ� �����
INSERT INTO emp37 VALUES(1111, 'SCOTT', 3000);
INSERT INTO emp37 VALUES(2222, 'SMITH', 4000);

-- COMMIT ���̶� �����Ͱ� ����
SELECT * FROM emp37;

-- Ŀ��
commit;

-- Ŀ�� �� �ٽ� Ȯ��, �����Ͱ� ����
SELECT * FROM emp37;

--ON COMMIT PRESERVE ROWS �ɼ��� �ְ� ���� �ӽ� ���̺��� ������ ������ �α׾ƿ��ϸ� �����Ͱ� �����
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

-- #095 ������ ������ �ܼ��ϰ� �ϱ�(1)
-- ������ SALESMAN�� ������� ��� ��ȣ, �̸�, ����, ����, �μ� ��ȣ�� ����ϴ� VIEW ����
-- CREATE VIEW AS ���� VIEW�� ���� ������ ������ �ۼ�
CREATE VIEW EMP_VIEW
AS
SELECT empno, ename, sal, job, deptno
    FROM emp
    WHERE job = 'SALESMAN';
    
-- VIEW ����
SELECT *
    FROM emp_view;
    
-- VIEW ����� ���� ���̺� �����
UPDATE emp_view
SET sal = 0
WHERE ename = 'MARTIN';

-- Ȯ��
SELECT * 
    FROM emp
    WHERE job = 'SALESMAN';

-- �ǵ�����
ROLLBACK; 

-- #096 ������ ������ �ܼ��ϰ� �ϱ�(2)
-- �μ���ȣ�� �μ� ��ȣ�� ��� ������ ����ϴ� VIEW�� ����
-- ���� �� : view�� �Լ��� �׷� �Լ��� ���ԵǾ��ִ°�
CREATE VIEW emp_view2
AS
SELECT deptno, round(avg(sal)) "��� ����"
    FROM emp
    GROUP BY deptno;

-- view Ȯ��
SELECT *
    FROM emp_view2;
    
-- ���� ��� �����Ͱ� �������� ������ ����
-- ��ռ�ġ�� ���������Ͱ� �𿩼� ���� �������̹Ƿ�, ����� ��ġ�� �������� �����͸� ��� ���ľ����� ����
UPDATE emp_view2
    SET "��� ����" = 3000
    WHERE deptno = 30;
    
-- view�� ����Ͽ� ������ �ۼ��ϸ� ���ݴ� ��������
-- view�� ������� �ʾ������� ����
SELECT e.ename, e.sal, e.deptno, v."��� ����"
    FROM emp e, (SELECT deptno, round(avg(sal)) "��� ����"
                    FROM emp
                    GROUP BY deptno) v
    WHERE e.deptno = v.deptno AND e.sal > v."��� ����";
    
-- view�� ����Ҷ��� ���� ���� ª����
SELECT e.ename, e.sal, e.deptno, v."��� ����"
    FROM emp e, emp_view2 v
    WHERE e.deptno = v.deptno AND e.sal > v."��� ����";
    
-- #097 ������ �˻� �ӵ� ���̱�
-- ������ ��ȸ�ҋ� �˻� �ӵ��� ���̱� ���� ���޿� �ε����� ����
-- index : ���̺��� �����͸� �˻��Ҷ� �˻� �ӵ��� ���̱� ���� ����ϴ� ������ ���̽� ��ü
CREATE INDEX emp_sal
    ON emp(sal);
    
-- index���� ������ �˻�
-- emp����  sal�� ó������ ��ĵ(1), 1600�� ã�� (2), �ٽ� ������ �˻� (3)
-- �ᱹ �����͸� ������ FULL ��ĵ
SELECT ename, sal
    FROM emp
    WHERE sal = '1600';
    
-- index�� rowid�� ������ �־ �����͸� ������ full��ĵ ���� ����
-- index�� sal�� ������������ �����ϰ� �����Ƿ�, �ٷ� sal 1600�� ã��
-- index�� rowid�� ���̺��� �ش� rowid�� ã�� name�� sal�� ��ȸ

-- #098 ����� �ߺ����� �ʴ� ��ȣ�����
-- ���� 1������ 100������ ����ϴ� ������ ����
-- ������ ����
CREATE SEQUENCE SEQ1
-- ù���� ���ڸ� 1�� ����
START WITH 1
-- ������ ����ġ�� 1�� ����
INCREMENT BY 1
-- �ִ�ġ�� 100���� ����
MAXVALUE 100
-- �ִ�ġ ���Ŀ� �ٽ� 1������ ���������� ����(����)
NOCYCLE;

-- ���� ��ϵ� �����ȣ ��ȸ
SELECT MAX(empno)
    FROM emp;
    
-- ��ȸ�� 7934���� �� ū ��ȣ�� �����͸� �Է�
INSERT INTO emp(empno, ename, sal, job, deptno)
    VALUES(7935, 'JACK', 3400, 'ANALYST', 20);
    
-- ������ �������� ����ϸ� �ش� �۾��� ���� �ʾƵ���
-- ������ �������� ����Ͽ� ��� ���̺� ������ �Է��ϱ�
-- �ϴ� ���̺� ����
CREATE TABLE emp02
(empno NUMBER(10),
    ename VARCHAR2(10),
    sal NUMBER(10));
    
-- �������� ����Ͽ� ������ �Է�
-- �������̸�.NEXTVAL : �������� ���� ��ȣ�� ��� �Ǵ� Ȯ���Ҷ��� ���
INSERT INTO emp02 VALUES(SEQ1.NEXTVAL, 'JACK', 3500);
INSERT INTO emp02 VALUES(SEQ1.NEXTVAL, 'JAMES', 4500);

-- ������ Ȯ��
SELECT *
    FROM emp02;
    
-- #099 �Ǽ��� ���� ������ �����ϱ�(1)
-- ��� ���̺��� 5�� �� KING �����͸� �˻�
-- AS OF TIMESTAMP : ���� ���� �ۼ�
-- SYSTIMESTAMP : ���� �ð�
-- SYSTIMESTAMP - INTERVAL '5' MINUTE : ���� �ð����� 5�� �A ��
SELECT *
    FROM emp
    AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE)
    WHERE ename = 'KING';
    
-- ���� �ð� Ȯ��
SELECT SYSTIMESTAMP
    FROM dual;

-- ���� �ð����� 5�ЖA �ð� Ȯ��
SELECT SYSTIMESTAMP - INTERVAL '5' MINUTE
    FROM dual;
    
-- KING�� �����͸� �����ϰ� ���� ������ �����͸� Ȯ��
-- KING�� ���� ��ȸ
SELECT ename, sal
    FROM emp
    WHERE ename = 'KING';

-- ������ 0���� �ٲ�
UPDATE emp
    SET sal = 0
    WHERE ename = 'KING';
    
commit;

-- 5������ KING ������ Ȯ��
SELECT *
    FROM emp
    AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE)
    WHERE ename = 'KING';
    
-- ���̺��� �÷����� Ȯ��
SELECT *
    FROM v$parameter
    WHERE name = 'undo_retention';
    
-- #100 �Ǽ��� ���� ������ �����ϱ�(2)
-- �÷����� ������ ���·� ����
ALTER TABLE emp ENABLE ROW MOVEMENT;

-- �÷����� ������ ���� Ȯ��
SELECT row_movement
    FROM user_tables
    WHERE table_name = 'emp';

-- ������̺��� 10�������� ����
FLASHBACK TABLE emp TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE)

-- Ư�� �ð����� ���浵 ����
FLASHBACK TABLE emp TO TIMESTAMP
TO TIMESTAMP('20/06/23 19:25:00','RR/MM/DD HH24:MI:SS');

-- #101 �Ǽ��� ���� ������ �����ϱ�(3)
-- DROP�� ��� ���̺��� �����뿡�� ����
-- ���̺� drop
DROP TABLE emp;

-- �����뿡 �ִ��� Ȯ��
SELECT original_name, droptime
  FROM user_recyclebin;

-- ����
FLASHBACK TABLE emp TO BEFORE DROP;

-- table �̸��� �ٲٰ� ������
FLASHBACK TABLE emp TO BEFORE DROP RENAME TO emp2;

-- #102 �Ǽ��� ���� ������ �����ϱ�(4)
-- ������̺��� �����Ͱ� ���� Ư�� �������� ���ݱ��� ��� ����Ǿ� �Դ��� �̷� ������ ���
SELECT ename, sal, versions_starttime, versions_endtime, versions_operation
    FROM emp
    VERSIONS BETWEEN TIMESTAMP
            TO_TIMESTAMP('2020-06-23 19:37:00', 'RRRR-MM-DD HH24:MI:SS')
            AND MAXVALUE
    WHERE ename = 'KING'
    ORDER BY versions_starttime;
    
-- ���� �ð� Ȯ��
SELECT SYSTIMESTAMP FROM dual;

-- KING �� ������ Ȯ��
SELECT *
    FROM emp
    WHERE ename = 'KING';
    
-- KING�� ������ 8000���� �����ϰ� commit
UPDATE emp
    SET sal = 8000
    WHERE ename = 'KING';
    
commit;

-- KING�� �μ���ȣ�� 20������ ����
UPDATE emp
    SET deptno = 20
    WHERE ename = 'KING';

commit;

-- KING�� ������ ���� �̷� ������ Ȯ��
SELECT ename, sal, deptno, versions_starttime, versions_endtime, versions_operation
    FROM emp
    VERSIONS BETWEEN TIMESTAMP
            TO_TIMESTAMP('2020-06-23 19:37:00', 'RRRR-MM-DD HH24:MI:SS')
            AND MAXVALUE
        WHERE ename = 'KING'
    ORDER BY versions_starttime;
    
-- emp ���̺��� 10�������� �ǵ����� commit
FLASHBACK TABLE emp TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE);

commit;

-- #103 �Ǽ��� ���� ������ �����ϱ�(5)
-- ��� ���̺��� �����͸� 5�� ������ �ǵ����� ���� DML���� ���
-- ��ī�̺� ��� : ��ְ� �߻������� DB�� �����Ҽ� �ִ� �α������� �ڵ����� �����ϰ� �ϴ� ���
SELECT undo_sql
    FROM flashback_transaction_query
    WHERE table_owner = 'SCOTT' AND table_name = 'emp'
    AND commit_scn between 9457390 AND 9457397
    ORDER BY start_timestamp DESC;
    
-- ����â���� sys������ ����
-- DB ���� ����
-- ������ ���̽��� ����Ʈ ���·� �ø�
-- ��ī�̺� ���� ������ ���̽��� ����
-- DML ���� redo log file�� ����ɼ� �ֵ��� ����
-- SCOTT ������ ����
-- king�� ������ Ȯ��
-- king�� ������ ����
-- king ������ ���� �̷� ���� Ȯ��

-- #104 �������� ǰ�� ���̱�
-- DEPTNO�÷��� PRIMARY KEY ������ �ɸ鼭 ���̺��� ����
-- PRIMARY KEY : null���� �ߺ��� �����͸� �Է� �Ұ��� ex(�����ȣ, �ֹι�ȣ ��)
CREATE TABLE DEPT2
( DEPTNO  NUMBER(10) CONSTRAINT DPET2_DEPNO_PK  PRIMARY KEY,
  DNAME   VARCHAR2(14),
  LOC   VARCHAR2(10) );    

-- ���̺� ������ ������ Ȯ���ϴ� ���
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
   FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
   WHERE a.TABLE_NAME = 'DEPT2'
   AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

DROP TABLE dept2;

-- ���̺� ���� �� ������ ����
CREATE TABLE dept2
 (DEPTNO NUMBER(10),
  DNAME  VARCHAR2(13),
  LOC    VARCHAR2(10));
  
ALTER TABLE DEPT2
    ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY(DEPTNO);
    
-- #105 �������� ǰ�� ���̱�
-- UNIQUE : �ߺ������� �Է� �ȵǰ� ����, NULL�� �Է� ����
CREATE TABLE dept3
 (deptno  NUMBER(10),
  dname   VARCHAR2(14) CONSTRAINT DEPT3_DNAME_UN UNIQUE,
  loc     VARCHAR2(10));
  
-- ���̺� ������ ������ Ȯ���ϴ� ���
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
   FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
   WHERE a.TABLE_NAME = 'DEPT3'
   AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;

-- ���� �� ���� �ֱ�
CREATE TABLE dept4
 (deptno  NUMBER(10),
  dname   VARCHAR2(13),
  loc     VARCHAR2(10));
  
ALTER TABLE dept4
    ADD CONSTRAINT DEPT4_DNAME_UN UNIQUE(dname);
    
-- ���̺� ������ ������ Ȯ���ϴ� ���
SELECT a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, b.COLUMN_NAME
   FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b
   WHERE a.TABLE_NAME = 'DEPT4'
   AND a.CONSTRAINT_NAME = b.CONSTRAINT_NAME;
   
-- #106 �������� ǰ�� ���̱�(3)
-- NOT NULL : ���̺��� Ư�� �÷��� NULL�� �Է��� ������� �ʰ�
CREATE TABLE DEPT5
( DEPTNO  NUMBER(10), 
  DNAME   VARCHAR2(14), 
  LOC   VARCHAR2(10) CONSTRAINT DEPT5_LOC_NN NOT NULL );
  
-- ������ ���� ���� �ɱ�
-- ��, null�� ����� ��
CREATE TABLE DEPT6
( DEPTNO  NUMBER(10), 
  DNAME   VARCHAR2(14), 
  LOC   VARCHAR2(10));
  
ALTER TABLE dept6
    MODIFY LOC CONSTRAINT DEPT6_LOC_NN NOT NULL;
    
-- #107 �������� ǰ�� ���̱�(4)
-- ������̺��� ����, ������ 0���� 6000 ������ �����͸� �Էµǰų� �����ɼ� �ֵ��� ����
-- CHECK : Ư�� �÷��� Ư�� ������ �����͸� �Էµǰų� �����ǵ��� ������ �Ŵ°�
CREATE TABLE emp6
 ( empno NUMBER(10),
   ename VARCHAR2(20),
   sal   NUMBER(10) CONSTRAINT EMP6_SAL_CK
   CHECK ( SAL BETWEEN 0  AND 6000) );
   
-- ������ ����°��� ������? : �ȵ�
INSERT INTO emp6 VALUES (7566, 'ADAMS', 9000);

-- ���� ����
ALTER TABLE emp6
    DROP CONSTRAINT emp6_sal_ck;
    
-- ���Ե�
INSERT INTO emp6 VALUES (7566, 'ADAMS', 9000);


-- #108 �������� ǰ�� ���̱�(5)
-- ��� ���̺��� �μ� ��ȣ�� �����͸� �Է��ҋ� �μ� ���̺� �����ϴ� �μ� ��ȣ�� �Էµɼ� �ֵ��� �������
-- FORREIGN KEY : Ư�� �÷��� �����͸� �Է��ҋ� �ٸ� ���̺��� �����͸� �����ؼ� �ش��ϴ� �����͸� ����ϴ� ��
-- emp7�� deptno�� foreing key, dept7�� deptno�� primary key
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
  
-- ���� ������ �ɸ� ���¿��� ������ �ȵ�
ALTER TABLE DEPT7
    DROP CONSTRAINT DEPT7_DEPTNO_PK;

-- ������ �Ϸ��� cascade �ɼ��� �ٿ��� ��
-- emp7 ���̺��� foreign key ���൵ ���� ������
ALTER TABLE dept7
    DROP CONSTRAINT DEPT7_DEPTNO_PK cascade;
    
-- #109 WITH�� ����ϱ�(1)
-- WITH���� �̿��Ͽ� ������ ������ ��Ż ������ ���
-- ������ ��Ż���޵��� ��հ����� �� ū ���鸸 ���
-- WITH : �˻� �ð��� ���� �ɸ��� SQL�� �ϳ��� SQL������ �ݺ��Ǿ� ���ɋ� ������ ���̱� ���� ������� ���
WITH JOB_SUMSAL as (SELECT job, SUM(sal) as ��Ż
                            FROM emp
                            GROUP BY job)
    SELECT job, ��Ż
        FROM JOB_SUMSAL
        WHERE ��Ż > (SELECT AVG(��Ż)
                        FROM JOB_SUMSAL );
                        
-- with�� ��� ���������� ���
-- �Ʒ� �������� ��, ���������� with������ 2�� �� �ð��� �ɸ�
SELECT job, SUM(sal) as ��Ż
    FROM emp
    GROUP BY job
    HAVING SUM(sal) > (SELECT AVG(SUM(sal))
                        FROM emp
                        GROUP BY job);
                        
-- #110 with�� ����ϱ�(2)
-- with�� ����ϸ� Ư�� ���� �������� �÷��� �ٸ� ���� ���������� �����ϴ°��� ������
-- ������ ��Ż��հ��� 3000�� ���� ������ �� ū �μ� ��ȣ�� ��Ż ���޵��� ���
-- job_sumsal�̶�� �ӽ����� ������ �����, �ش� �ӽ� ���念���� �����ϰ� ��.
WITH job_sumsal as (SELECT job, SUM(sal) ��Ż
                        FROM emp
                        GROUP BY job) ,
    DEPTNO_SUMSAL as (SELECT deptno, SUM(sal) ��Ż
                        FROM emp
                        GROUP BY deptno
                        HAVING SUM(sal) > (SELECT AVG(��Ż) + 2000
                                                FROM job_sumsal)
                    )
    SELECT deptno, ��Ż
        FROM deptno_sumsal;