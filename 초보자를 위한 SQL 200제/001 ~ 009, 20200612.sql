-- #001_ ���̺��� Ư����(column) �����ϱ�
-- EMPNO, ENAME, SAL�� EMP���̺�κ��� �����ؼ� ����ض�
SELECT empno, ename, sal
    FROM emp;
    
-- ��ҹ��� ��� ����
SELECT EMPNO, ENAME, SAL
FROM EMP;

SELECT empno, ename, sal
FROM emp;

-- �������� ���� SQL�� �빮�ڷ�, �÷���, ���̺���� �ҹ��ڷ� �ۼ��� ����
SELECT empno, ename, sal
FROM emp;

-- ���ٷ� �ۼ�
SELECT empno, ename, sal FROM emp;

-- �����ٷ� �ۼ�
SELECT empno, ename, sal 
FROM emp;

-- �鿩���� ��������
SELECT empno, ename, sal 
FROM emp;

-- �鿩����
SELECT empno, ename, sal 
    FROM emp;
    
-- SELECT, FROM�� �׻� ������ ���������

-- #002 ���̺��� ��� ��(COLUMN) ����ϱ�
-- emp ���̺��� ��� column�� �������� ��ɾ�(*)
SELECT *
    FROM emp;

-- *��� �������� ���� column�� ������ �������൵ ��
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
    FROM emp;

-- emp ���̺��� ��� �÷��� ����ϰ� �ǳ��� �ٽ� �ѹ� Ư�� �÷��� �ѹ��� ���
SELECT dept.*, deptno
    FROM dept;

-- #003 �÷� ��Ī�� ����Ͽ� ��µǴ� �÷��� �����ϱ�
-- as �ڿ��� ���Ⱑ �ȵǳ�����. ������
-- "" ���������̼� ��ũ�� ������� �Ҷ�
    -- ��ҹ��ڸ� �����Ͽ� ��� �Ҷ�
    -- ���鹮�ڸ� ����Ҷ�
    -- Ư�����ڸ� ����Ҷ�
SELECT empno as �����ȣ, ename as ����̸�, sal as "Salary"
    FROM emp;
    
-- ������ ������ ����Ͽ� ����� ����Ҷ� as�� ������
SELECT ename, sal * (12 + 3000)
    FROM emp;

SELECT ename, sal * (12 + 3000) as ����
    FROM emp;
    
-- ORDER BY�� ������
SELECT ename, sal * (12 + 3000) as ����
    FROM emp
    ORDER BY ���� desc;
    
-- #004 ���� ������ ����ϱ�(||)
-- �̸��� ������ �ٿ��� ���
SELECT ename || sal
    FROM emp;

-- ���ڿ��� ���� �����ؼ� ����ϱ�
SELECT ename || '�� ������ ' || sal || '�Դϴ�' as ��������
    FROM emp;

-- ���ڿ��� ���� �����ؼ� ����ϱ�
SELECT ename || '�� ������ ' || job || '�Դϴ�' as ��������
    FROM emp;
    
-- #005 �ߺ��� �����͸� �����ؼ� ����ϱ�(DISTINCT)
-- ��� ���̺��� ������ �ߺ��� ������ �����ϰ� ���
SELECT DISTINCT job
    FROM emp;

-- DISTINCT�� ������ UNIQUE�� ����
SELECT UNIQUE job
    FROM emp;

-- #006 �����͸� �����ؼ� ����ϱ� (ORDER BY)
-- acs : ��������, desc : ��������
-- �̸��� ������ ����ϴµ� ������ ���� ������� ����ϱ�(��������)
-- ORDER BY�� �� �������� �ۼ���, ���൵ ���� �������� ��
SELECT ename, sal
    FROM emp
    ORDER BY sal asc;
    
-- ��Ī�� ORDER BY�� ��� ����
SELECT ename, sal as ����
    FROM emp
    ORDER BY ���� asc;
    
-- ������ �÷��� �ۼ�
-- �μ���ȣ�� ����  ������������ ���� �� ������ ������������ ������
SELECT ename, deptno, sal
    FROM emp
    ORDER BY deptno asc, sal DESC;
    
-- #007 WHERE�� ����1(���� ������ �˻�)
-- WHERE���� FROM�� ������ �ۼ�
-- ������ 3000�� ������� �̸�, ����, ������ ���
SELECT ename, sal, job
    FROM emp
    WHERE sal = 3000;

-- ������ 3000�̻��� ������� �̸��� ������ ���
SELECT ename as �̸�, sal as ����
    FROM emp
    WHERE sal >= 3000;

-- ��Ī�� WHRER���� ����ϸ�?
-- ������ �� why? FREM -> WHERE -> SELECT ������ ����Ǳ� ������ WHERE�� ����ɋ� ������ ����
SELECT ename as �̸�, sal as ����
    FROM emp
    WHERE ���� >= 3000;
    
-- #008 WHERE�� ����2(���ڿ� ��¥ �˻�)
-- �̸��� scott�� ����� �̸�, ����, ����, �Ի���, �μ���ȣ ���
SELECT ename, sal, job, hiredate, deptno
    FROM emp
    WHERE ename = 'SCOTT';

-- �Ի����� 81�� 11�� 17���� ����� �̸��� �Ի��� ���
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- ������ session�� ��¥���� Ȯ��
SELECT *
    FROM NLS_SESSION_PARAMETERS
    WHERE PARAMETER ='NLS_DATE_FORMAT';
    
-- ��¥ session Ÿ�� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';

-- �ٽ� ��ȸ�غ���(�ȳ���)
-- YY�϶��� 81���� 2081������ �ν��ؼ� ������ ����
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- ��¥ session Ÿ�� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- �ٽ� ��ȸ�غ���(�ȳ���)
-- RR�϶��� 81���� 81������ �ν��ؼ� �����Ե�
SELECT ename, hiredate
    FROM emp
    WHERE hiredate = '81/11/17';
    
-- �����̶� ������ ���̽� ������ �α����ؼ� �α׾ƿ��Ҷ������� �� ����

-- #009 ��� ������ ����(*, /, +, -)
-- ���� 36000 �̻��� ������� �̸��� ������ ���
SELECT ename, sal * 12 as ����
    FROM emp
    WHERE sal * 12 >= 36000;

-- �μ� ��ȣ�� 10���� ������� �̸�, ����, Ŀ�̼�, ���� + Ŀ�̼��� ���, sal + comm�� null�̳���
SELECT ename, sal, comm, sal + comm
    FROM emp
    WHERE deptno = 10;

-- null�� ó���ϴ� �Լ� NVL NVL(comm,0)�� comm�� null�̸� 0���� ����ϰ� ��
SELECT ename, sal, comm, sal + NVL(comm, 0)
    FROM emp
    WHERE deptno = 10;