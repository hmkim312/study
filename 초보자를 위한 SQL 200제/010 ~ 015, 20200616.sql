-- #010 �� �����ڹ���1
-- ������ 1200������ ������� �̸��� ���� ���� �μ���ȣ�� ���
SELECT ename, sal, job, deptno
    FROM emp
    WHERE sal <= 1200;
    
-- #011 �� ������ ����2
-- ������ 1000���� 3000 ������ ������� �̸��� ������ ���
-- BETWEEN�� ���Ѱ� AND ���Ѱ����� �Է�
SELECT ename, sal
    FROM emp
    WHERE sal BETWEEN 1000 AND 3000;
    
SELECT ename, sal
    FROM emp
    WHERE (sal >= 1000 AND sal <= 3000);

-- ������ 1000���� 3000 ���̰� �ƴ� ������� �̸��� ������ ��ȸ
SELECT ename, sal
    FROM emp
    WHERE sal NOT BETWEEN 1000 and 3000;

SELECT ename, sal
    FROM emp
    WHERE (sal < 1000 OR sal > 3000);
    
-- 1982�⵵�� �Ի��� ������� �̸��� �Ի����� ��ȸ
SELECT ename, hiredate
    FROM emp
    WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';
    
-- #012 �� ������ ����3(like)
-- �̸��� ù���ڰ� S�� �����ϴ� ������� �̸��� ������ ���
-- % : ���ϵ�ī���� �ϸ� % �ڸ����� ��� ö�ڰ� ���� ��� �͵� ��� ���ٴ� ��
SELECT ename, sal
    FROM emp
    WHERE ename LIKE 'S%';

-- �̸��� �ι��� ö�ڰ� M�� ���
-- _ : ����ٴ� ��� ö�ڰ� �͵� ��������� �ڸ����� ���ڸ� �ΰ�
SELECT ename
    FROM emp
    WHERE ename LIKE '_M%';
    
-- �̸��� �����ڰ� T�� ������ ����� �̸�
SELECT ename
    FROM emp
    WHERE ename LIKE '%T';
    
-- �̸��� A�� ���� ���
SELECT ename
    FROM emp
    WHERE ename LIKE '%A%';
    
-- #013 �񱳿����� ����4
-- Ŀ�̼��� NULL�� ������� �̸��� Ŀ�̼��� ���
-- NULL�� =�� ���Ҽ� ������, is null �� ã�ƾ���
SELECT ename, comm
    FROM emp
    WHERE comm is null;
    
-- %014 �񱳿����� ����5
-- ������ SALESMAN, ANALYST, MANAGER�� ������� �̸�, ����, ������ ���
SELECT ename, sal, job
    FROM emp
    WHERE job in ('SALESMAN', 'ANALYST', 'MANAGER');
    
SELECT ename, sal, job
    FROM emp
    WHERE (job = 'SALESMAN' or job = 'ANALYST' or job ='MANAGER');
    
-- ������ SALESMAN, ANALYST, MANAGER�� �ƴ� ������� �̸�, ����, ������ ���
SELECT ename, sal, job
    FROM emp
    WHERE job not in ('SALESMAN', 'ANALYST', 'MANAGER');

SELECT ename, sal, job
    FROM emp
    WHERE (job != 'SALESMAN' and job != 'ANALYST' and job !='MANAGER');
    
-- #015 �������� ����
-- ������ SALESMAN�̰� ������ 1200�̻��� ������� �̸�, ����, ������ ���
-- TRUE AND TRUE = TRUE, TRUE AND FALSE = FALSE
-- TRUE OR TRUE = TRUE, TRUE OR FALSE = TRUE
-- TRUE AND NULL = NULL, TRUE OR NULL = TRUE
SELECT ename, sal, job
    FROM emp
    WHERE job = 'SALESMAN' AND sal >= 1200;
    
-- WHERE�� ������ ��� TRUE�� ���Ǹ� ����, ���߿� �ϳ��� FALSE�� ������ ����
SELECT ename, sal, job
    FROM emp
    WHERE job = 'ABCS' AND sal >= 1200;