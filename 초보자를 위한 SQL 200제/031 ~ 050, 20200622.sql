-- #031 ��¥������ ������ ���� ��ȯ�ϱ�
-- 81�� 11�� 17�Ͽ� �Ի��� ����� �̸��� �Ի����� ���
-- TO_DATE : ����, ��, ���� ����
SELECT ename, hiredate
    FROM emp
    WHERE hiredate =To_DATE('81/11/17', 'RRRR-MM-DD');
    
-- ��¥ �����͸� �˻��Ҷ��� ������ ������ ��¥������ Ȯ���ؾ� �������� �˻�����
-- ���� ������ ������ ��¥ ������ Ȯ���ϴ� ����
SELECT *
    FROM nls_session_parameters
    WHERE parameter = 'NLS_DATE_FORMAT';
    
-- ����� RR/MM/DD �϶� ��¥�� �˻��ϴ¹�
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- ��¥������ DD/MM/RR �϶�
-- 17�� ������ �ƴ϶� ����(DD)
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '17/11/81';

-- ���� ������ ������ ��¥ ������ DD/MM/RR�� �����ϰ� �˻�
-- ���� : ���� ����Ŭ�� ������ â�� �ǹ�
-- ���� ���� ������ ������ ��¥ ������ DD/MM/RR �������� ����, 
-- ���� ������ ���ǿ����� ��ȿ, �α׾ƿ� �� �ٽ� ���� �� ������ �Ķ���� ���� �����
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RR';

SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '17/11/81';
    
-- �ϰ��ǰ� ��¥�� �˻��ϴ� ��
-- TO_DATE�� �̿��Ͽ� RR/MM/DD �� ������ִ°�
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = TO_DATE('81/11/17', 'RR/MM/DD');
    
-- �ٽ� ��¥ ������ RR/MM/DD�� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- # 032 �Ͻ��� �� ��ȯ �����ϱ�
-- ����Ŭ�� �˾Ƽ� �Ͻ������� �� ��ȯ�� ��
-- �Ʒ��� ������ = ������ ���̳�, �Ͻ��� �� ��ȯ���� ������ = ���������� �˾Ƽ� ����Ǵ� ����
SELECT ename, sal
    FROM emp
    WHERE sal = '3000';
    
-- SAL�� ���������� ����� �����ϴ� ��ũ��Ʈ(EMP32)
CREATE TABLE EMP32
( ENAME  VARCHAR2(10),
 SAL      VARCHAR2(10) );
 
INSERT INTO EMP32 VALUES('SCOTT' ,'3000');
INSERT INTO EMP32 VALUES('SMITH' ,'1200');
COMMIT;

-- WHERE ������ sal = '3000'���� ������ �ۼ��ϰ� ����
-- ������ = ������
SELECT ename, sal
    FROM emp32
    WHERE sal = '3000';
    
-- ������ = ������
SELECT ename, sal
    FROM emp32
    WHERE sal = 3000;
    
-- �� ������ ����
SELECT ename, sal
    FROM emp32
    WHERE TO_NUMBER(sal) = 3000;
    
-- SET AUTOT ON : SQL�� �����Ҷ� ��µǴ� ����� SQL�� �����ϴ� ���� ��ȹ�� �ѹ��� ���� ��ɾ�

SET AUTOT ON

SELECT ename, sal
    FROM emp32
    WHERE sal = 3000;
    
-- # 033 NULL�� ��� �ٸ� ������ ����ϱ�
-- �̸��� Ŀ�̼��� ���, Ŀ�̼��� NULL�� ������� 0����
SELECT ename, comm, NVL(comm, 0)
    FROM emp;
    
-- �̸�, ����, Ŀ�̼�, ���� + Ŀ�̼��� ����ϴ� ����
-- NULL ���� �־, ���� + Ŀ�̼ǵ� NULL�� ����̵�
SELECT ename, sal, comm, sal+comm
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
-- Ŀ�̼��� NULL�� 0���� ġȯ�Ͽ� ���� + Ŀ�̼��� ���
-- Ŀ�̼��� NULL�� 0���� ġȯ��
SELECT ename, sal, comm, NVL(comm,0), sal+NVL(comm,0)
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
-- NVL2 �Լ��� �̿��Ͽ� Ŀ�̼��� NULL�� �ƴ� ������� sal + comm�� ����ϰ�, NULL�� ������� sal�� ���
SELECT ename, sal, comm, NVL2(comm, sal+comm, sal)
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');
    
-- #034 IF���� SQL�� �����ϱ�(1)
-- deptno(�μ��ѹ�)�� 10�̸� 300, 20�̸� 400, �Ѵ� �ƴϸ� 0���� ���
-- DECODE�� ��ȣ�� ����
SELECT ename, deptno, DECODE(deptno, 10, 300, 20, 400, 0) as ���ʽ�
    FROM emp;
    
-- �����ȣ�� ¦������ Ȧ������ ����ϴ� ����
SELECT empno, mod(empno,2), DECODE(mod(empno,2),0, '¦��', 1, 'Ȧ��') as ���ʽ�
    FROM emp;

-- SALESMAN�� ���ʽ� 5000, �������� 2000�� ���
SELECT ename, job, DECODE(job, 'SALESMAN', 5000, 2000) as ���ʽ�
    FROM emp;
    
-- #035 IF���� SQL�� �����ϱ�(2)
-- ������ 300�̻��̸� 500, 2000�̻��̸� 300, 1000 �̻��̸� 200�� �������� 0���� ���ʽ��� ���
-- CASE�� >= �ε�ȣ�� ����
SELECT ename, job, sal, CASE WHEN sal >= 3000 THEN 500
                             WHEN sal >= 2000 THEN 300
                             WHEN sal >= 1000 THEN 200
                             ELSE 0 END AS BONUS
                             
    FROM emp
    WHERE job IN ('SALESMAN', 'ANALYST');

-- �̸�, ����, Ŀ�̼�, ���ʽ��� ��� 
-- ���ʽ��� Ŀ�̼��� NULL�̸� 500�� ���, NULL�� �ƴϸ� 0�� ���
SELECT ename, job, comm, CASE WHEN comm is null THEN 500
                              ELSE 0 END BONUS
    FROM emp
    WHERE job IN('SALESMAN', 'ANALYST');
    
-- ���ʽ��� ����ҋ� ������ SALESMAN, ANALYST�� 500�� ����ϰ� CLERK, MANAGER�̸� 400�� �������� 0�� ���
SELECT ename, job, CASE WHEN job in ('SALESMAN', 'ANALYST') THEN 500
                        WHEN job in ('CLERK', 'MANAGER') THEN 400
                    ELSE 0 END AS BONUS
    FROM emp;
    
-- #036 �ִ밪 ����ϱ�
-- ��� ���̺��� �ִ� ������ ���
SELECT MAX(sal)
    FROM emp;
    
-- SALESMAN�� �ִ� ���� ���
SELECT MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN';
    
-- SALESMAN �߿� ���� �ִ� �ΰ�?
-- ���� �׷��� �Լ��� �ƴ϶�� ���� ��
-- job �÷��� ���� �������� ���� ��µǴµ� MAX(sal)�� �� �ϳ��� ��µǱ� ������ ������ �ߴ°���
SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALSEMAN';
    
-- ���� ������ �ذ��ϱ� ���� groupby�� job�� �׷���
SELECT job, MAX(sal)
    FROM emp
    WHERE job = 'SALESMAN'
    GROUP BY job;
    
-- �μ���ȣ�� �μ� ��ȣ�� �ִ� ������ ���
SELECT deptno, MAX(sal)
    FROM emp
    GROUP BY deptno;
    
-- #037 �ּҰ� ����ϱ�
-- ������ SALESMAN�� ����� �� �ּ� ������ ���
SELECT MIN(sal)
    FROM emp
    WHERE job = 'SALESMAN';
    
-- ������ ������ �ּ� ������ ��� ORDER BY���� ����Ͽ� �ּ� ������ ���� �ͺ��� ���
-- ORDER BY �� �׻� �� �������� ����
SELECT job, MIN(sal) �ּҰ�
    FROM emp
    GROUP BY job
    ORDER By �ּҰ� DESC;
    
-- �׷� �Լ��� Ư¡�� WHERE���� ������ �����̾ ����� �׻� �����
-- WHERE 1 = 2�� ���������� �����
SELECT MIN(sal)
    FROM emp
    WHERE 1 = 2;
    
-- ����� NULL�� ���, ������ ���� NVL �Լ��� Ȯ��
SELECT NVL(MIN(sal),0)
    FROM emp
    WHERE 1 = 2;
    
-- ����, ������ �ּ� ������ ���
-- �������� SALESMAN�� �����ϰ� ���
-- ������ �ּ� ������ �����ͺ��� ���
SELECT job, MIN(sal)
    FROM emp
    WHERE job != 'SALESMAN'
    GROUP BY job
    ORDER BY MIN(sal) DESC;
    
-- #038 ��հ� ����ϱ�
-- ��� ���̺��� ��� Ŀ�̼��� ���
SELECT AVG(comm)
    FROM emp;
    
-- �׷� �Լ��� NULL���� ����, ���� NULL�� 0���� ġȯ �� ��հ��� ����ϸ� �޶���
SELECT ROUND(AVG(NVL(comm,0)))
    FROM emp;
    
-- #039 ��Ż�� ����ϱ�
-- �μ��� ���� ��� ���ϱ�
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno;

-- ������ ������ ��Ż ������ ���, ������ ��Ż ������ �����ͺ��� ���
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    ORDER BY SUM(sal) DESC;
    
-- ������ ������ ��Ż������ ���
-- ������ ��Ż ������ 4000 �̻��� �͸� ���
-- �׷� �Լ��� �㰡���� �ʽ��ϴ� ��� ������ ���
-- �׷� �Լ��� ������ �ً��� WHERE�� ��� HAVING���� ����ؾ� ��
SELECT job, SUM(sal)
    FROM emp
    WHERE SUM(sal) >= 4000
    GROUP BY job;
    
-- �׷� �Լ��� ������ �ً��� WHERE�� ��� HAVING���� ����ؾ� ��
SELECT job, SUM(sal)
    FROM emp
    GROUP BY job
    HAVING SUM(sal) >= 4000;
    
-- ������ ������ ��Ż ������ ����ϴµ�, ������ SALESMAN�� ����
-- ������ ��Ż ������ 4000�̻��� ����鸸 ���
SELECT job, SUM(sal)
    FROM emp
    WHERE job != 'SALESMAN'
    GROUP BY job
    HAVING SUM(sal) >= 4000;
    
-- ORDER BY�� ���� �������� �����
-- FROM���� ���� ���� ����, �״��� WHERE, �׸��� GROUP BY���� ����
-- emp ���̺��� �÷� ��Ī�� ������ ã���� ��������, ���� ��
SELECT job as ����, SUM(sal)
    FROM emp
    WHERE job != 'SALESMAN'
    GROUP BY ����
    HAVING SUM(sal) >= 4000;
    
-- #040 �Ǽ� ����ϱ�
-- ��� ���̺� ��ü ������� ���
-- COUNT : �Ǽ��� ���� �Լ�
SELECT COUNT(empno)
    FROM emp;

-- NULL���� ������
SELECT COUNT(comm)
    FROM emp;
    
-- #041 ������ �м� �Լ��� ���� ����ϱ�(1)
-- ������ ANALYST, MANAGER�� ������� �̸�, ����, ����, ������ ������ ���
-- RANK() : ������ ����ϴ� ������ �м� �Լ�
-- RANK()�ڿ� OVER ������ ������ ��ȣ �ȿ� ����ϰ� ���� �����͸� �����ϴ� SQL������ ������ �� �ö����� ���� �������� ������ ���
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) ����
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER');
    
-- �������� ������ ���� ������� ������ �ο��ؼ� ���� ���
SELECT ename, sal, job, RANK() over (PARTITION BY job  ORDER BY sal DESC) as ����
    FROM emp;
    
-- # 042 ������ �м� �Լ��� ���� ����ϱ�(2)
-- RANK : 1���� 2���־, �ٷ� 3���� ���
-- DENSE_RANK : 1���� 2���־ �� �ڿ��� 2���� ���
SELECT ename, job, sal, RANK() over (ORDER BY sal DESC) as RANK,
                        DENSE_RANK() over (ORDER BY sal DESC) as DENCE_RANK
    FROM emp
    WHERE job IN ('ANALYST', 'MANAGER');
    
-- 81�⵵�� �Ի��� ������� ����, �̸�, ����, ������ ���
-- �������� ������ ���� ������� ���
SELECT job, ename, sal, DENSE_RANK() over (PARTITION BY job
                                           ORDER BY sal DESC) as ����
    FROM emp
    WHERE hiredate BETWEEN TO_DATE('1981/01/01', 'RRRR/MM/DD')
                       AND TO_DATE('1981/12/31', 'RRRR/MM/DD');
                       
-- DENSE_RANK �ٷ� ������ ������ ��ȣ���� ������ ���� �����͸� �ְ� Ȱ��
-- ������ 2975�� ����� ��� ���̺��� ������ ������ ���
-- WITHIN : ~ �̳�
-- WITHIN GROUP : ��� �׷�
SELECT DENSE_RANK(2975) WITHIN GROUP (ORDER BY sal DESC) ����
    FROM emp;

-- �Ի��� 81�� 11�� 17���� ��� ���̺� ��ü ����� �� ���°�� �Ի��Ͽ��°�
SELECT DENSE_RANK('81/11/17') WITHIN GROUP (ORDER BY hiredate ASC) ����
    FROM emp;
    
-- #043 ������ �м� �Լ��� ��� ����ϱ�
-- �̸��� ����, ����, ������ ����� ���
-- ������ ����� 4������� 1~4��޾� �� 25%�� ��
-- NTILE() : ��ȣ�ȿ� ���ڸ� �ִ°����� ����� ����
-- NULLS LAST : ������ �����ͺ��� ��µǵ��� �����ϴµ�, NULL�� �� �Ʒ��� ���
SELECT ename, job, sal,
    NTILE(4) over (ORDER BY sal DESC NULLS LAST) ���
    FROM emp
    WHERE job in ('ANALYST', 'MANAGER', 'CLERK');
    
-- #044 ������ �м� �Լ��� ������ ���� ����ϱ�
-- �̸��� ����, ������ ����, ����� ���� ������ ���
SELECT ename, sal, RANK() over(ORDER BY sal DESC) as RANK ,
                   DENSE_RANK() over (ORDER BY sal DESC) as DENSE_RANK,
                   CUME_DIST() over (ORDER BY sal DESC) as CUM_DIST
    FROM emp;
    
-- PARTITION BY JOB�� ����Ͽ� �������� CUME_DIST�� ���
SELECT job, ename, sal, RANK() over (PARTITION BY JOB
                                     ORDER BY sal DESC) as RANK,
                        CUME_DIST() over (PARTITION BY JOB
                                          ORDER BY sal DESC) as CUM_DIST
    FROM emp;
    
-- #045 ������ �м� �Լ��� �����͸� ���η� ���
-- �μ� ��ȣ�� ����ϰ�, �μ� ��ȣ ���� �ش� �μ��� ���ϴ� ������� �̸��� ���η� ���
-- LISTAGG : �����͸� ���η� ���
-- WITHIN GROUP : GROUP ������ ������ ��ȣ�� ���� �׷��� �����͸� ���
-- GROUP BY : LISTAGG �Լ��� ����Ϸ��� �ʼ��� ���
SELECT deptno, LISTAGG(ename, ',') WITHIN GROUP (ORDER BY ename) as EMPLOYEE
    FROM emp
    GROUP BY deptno;
    
-- ������ �� ������ ���� ������� �̸��� ���η� ���
SELECT job, LISTAGG(ename, ',') WITHIN GROUP (ORDER BY ename ASC) as EMPLOYEE
    FROM emp
    GROUP BY job;
    
-- �̸� ���� ���޵� ���� ����ϱ����� ���Ῥ���� ���
SELECT job,
    LISTAGG(ename||'('||sal||')', ',') WITHIN GROUP (ORDER BY ename ASC) as EMPLOYEE
    FROM emp
    GROUP BY job;
    
-- #043 ������ �м� �Լ��� �ٷ� �� ��� ������ ����ϱ�
-- �����ȣ, �̸�, ������ ���, �� ���� �ٷ� �� ���� ������ ���, �� ���� �ٷ� ���� ���� ������ ���
SELECT empno, ename, sal,
        LAG(sal,1) over (ORDER BY sal ASC) "�� ��",
        LEAD(sal, 1) over (ORDER BY sal ASC) "���� ��"
    FROM emp
    WHERE job IN ('ANALYST', 'MANAGER');
    
-- �μ���ȣ, �����ȣ, �̸�, �Ի���, �ٷ� ���� �Ի��� ����� �Ի����� ���
-- �ٷ� ������ �Ի��� ����� �Ի����� ���, �μ� ��ȣ���� �����ؼ�
SELECT deptno, empno, ename, hiredate,
        LAG(hiredate,1) over (PARTITION BY deptno
                              ORDER BY hiredate  ASC) "�� ��",
        LEAD(hiredate,1) over (PARTITION BY deptno
                               ORDER BY hiredate ASC) "���� ��"
    FROM emp;
    
-- #047 COLUMN�� ROW�� ����ϱ�(1)
-- �μ���ȣ, �μ� ��ȣ�� ��Ż ������ ���. ��, ���η� ���
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
       SUM(DECODE(deptno, 20, sal)) as "20",
       SUM(DECODE(deptno, 30, sal)) as "30"
    FROM emp;
    
-- �μ� ��ȣ�� 10���̸� ������ ���, �ƴϸ� NULL�� ���
SELECT deptno,  DECODE(deptno, 10, sal) as "10"
    FROM emp;
    
-- DEPTNO �÷��� �����ϰ� DECODE(deptno, 10, sal)�� ����� ���� ��µ� ����� �� ����
SELECT SUM(DECODE(deptno, 10, sal)) as "10"
    FROM emp;
    
-- �����ϰ� 20, 30�� �߰�
SELECT SUM(DECODE(deptno, 10, sal)) as "10",
       SUM(DECODE(deptno, 20, sal)) as "20",
       SUM(DECODE(deptno, 30, sal)) as "30"
    FROM emp;
    
-- ����, ������ ��Ż ������ ���η� ���
SELECT SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp;
    
-- ���� �������� SELECT���� deptno�� �߰�
-- deptno�� �߰��ϸ� �μ� ��ȣ���� ���� ������ ��Ż ������ ������ ���� ����
-- deptno�� �׷��Լ��� ���� �־����Ƿ�, GROUP BY deptno�� �߰�

SELECT deptno, SUM(DECODE(job, 'ANALYST', sal)) as "ANALYST",
       SUM(DECODE(job, 'CLERK', sal)) as "CLERK",
       SUM(DECODE(job, 'MANAGER', sal)) as "MANAGER",
       SUM(DECODE(job, 'SALESMAN', sal)) as "SALESMAN"
    FROM emp
    GROUP BY deptno;
    
-- #048 COLUMN�� ROW�� ����ϱ�(2)
-- �μ���ȣ, �μ���ȣ�� ��Ż ������ Pivot���� ����Ͽ� ���η� ���
SELECT *
    FROM (select deptno, sal from emp)
    PIVOT (sum(sal) for deptno in (10,20,30));
    
-- PIVOT ���� �̿��Ͽ� ������ ������ ��Ż ������ ���η� ���
SELECT *
    FROM(select job, sal from emp)
    PIVOT(sum(sal) for job in ('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN'));
    
-- ��Ŭ �����̼� ��ũ ���� �ϱ�
SELECT *
    FROM(select job, sal from emp)
    PIVOT (sum(sal) for job in ('ANALYST' as "ANALYST", 'CLERK' as "CLERK", 
                                'MANAGER' as "MANAGER", 'SALESMAN' as "SALESMAN"));
                                
-- #049 ROW�� COLUMN���� ����ϱ�
create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );

commit;

-- UNPIVOT���� ����Ͽ� �÷��� �ο�� ���
-- UNPIVOT : ���� ������ ���
SELECT *
    FROM order2
    UNPIVOT (�Ǽ� for ������ in (BICYCLE, CAMERA, NOTEBOOK));
    
SELECT *
    FROM order2
    UNPIVOT(�Ǽ� for ������ in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
    
-- order2 ���̺��� �����Ϳ� NULL�� ���ԵǾ� �ִٸ� UNPIVOT ������� ��µ��� ����
-- SMITH�� NOTEBOOK�� NULL�� ����
UPDATE ORDER2 SET NOTEBOOK=NULL WHERE ENAME='SMITH';

-- SMITH�� NOTEBOOK�� NULL�� �Ǿ������Ƿ� UNPIVOT�� ����ϸ� ����� �ȵ�
-- NULL�� ������ UNPIVOT INCLUDE NULLS�� ����Ͽ�����
SELECT *
    FROM order2
    UNPIVOT INCLUDE NULLS(�Ǽ� for ������ in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
    
-- #050 ������ �м� �Լ��� ���� ������ ����ϱ�
-- ������ ANALYST, MANAGER�� ������� �����ȣ, �̸�, ����, ������ ����ġ�� ���
-- OVER�� ��ȣ�ȿ��� ���� ������ �����츦 �����Ҽ� ����
-- UNBOUNDED PRECEDING�� ���� ù��° ���� ����Ŵ
SELECT empno, ename, sal, SUM(sal) over (ORDER BY empno ROWS
                                         BETWEEN UNBOUNDED PRECEDING
                                         AND CURRENT ROW) ����ġ
    FROM emp
    WHERE job IN ('ANALYST', 'MANAGER');