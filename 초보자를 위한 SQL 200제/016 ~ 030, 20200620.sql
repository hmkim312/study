-- #016 ��ҹ��� ��ȯ �Լ� ����
-- ������̺��� �̸��� ���, ù���� �÷��� �̸��� �빮�ڷ�, �ι�° �÷� �̸��� �ҹ��ڷ�, ������ �÷��� �տ��� �빮��
-- ���� �� �Լ� : �ϳ��� ���� �Է¹޾� �ϳ��� ���� ��ȯ�ϴ� �Լ�(����, ����, ��¥ ��ȯ, �Ϲ� �Լ�)
-- ���� �� �Լ� : ���� ���� ���� �Է¹޾� �ϳ��� ���� ��ȯ�ϴ� �Լ�(�׷� �Լ�)
SELECT UPPER(ename) ,LOWER(ename), INITCAP(ename)
    FROM emp;

-- �̸��� scott�� ����� �̸��� ������ ��ȸ
SELECT ENAME, SAL
    FROM emp
    WHERE LOWER(ename) ='scott';

-- �̸��� �ҹ������� �빮�� ���� �𸦶�
SELECT ename, sal
    FROM emp
    WHERE LOWER(ename) = 'scott' or UPPER(ename) ='SCOTT';
    
-- #017 ���ڿ��� Ư�� ö�� �����ϱ�
-- SMITH���� SMI�� �߶� ���
-- SUBSTR('SMITH',1,3) : SMITH���� 1�������� 3��°������ ��� 
SELECT SUBSTR('SMITH',1,3)
    FROM DUAL;

-- MI�� ���
SELECT SUBSTR('SMITH',2,2)
    FROM DUAL;
    
-- TH�� ��� ���� 2��°���� 2���� ���
SELECT SUBSTR('SMITH',-2,2)
    FROM DUAL;
    
-- 2��°���� ��� ���
SELECT SUBSTR('SMITH',2)
    FROM DUAL;
    
-- #018 ���ڿ��� ���̸� ����ϱ�
-- �̸��� ����ѵ� �� ���� �̸��� ö�� ������ ���
SELECT ename, LENGTH(ename)
    FROM emp;
    
-- �ѱ۵� ���������� ���ڿ��� ���̰� ��µ�
SELECT LENGTH('�����ٶ󸶹ٻ�')
    FROM DUAL;

-- ����Ʈ�� ���̸� ���
SELECT LENGTHB('�����ٶ󸶹ٻ�')
    FROM DUAL;
    
-- #019 ���ڿ��� Ư�� ö���� ��ġ ����ϱ�
-- SMITH���� ���ĺ� ö�� M�� ��ġ�� �ڸ� ã��
-- INSTR : ���ڿ��� Ư�� ö���� ��ġ�� ����ϴ� �Լ�
SELECT INSTR('SMITH', 'M')
    FROM DUAL;
    
-- �̸��Ͽ��� naver.com�� �����ϱ�
-- @�� ��ġ ã��
SELECT INSTR('abcdefg@naver.com','@')
    FROM DUAL;

-- ã�� ��ġ���� +1 ���� SUBSTR�� �̿��Ͽ� ��� ��� �ϸ� naver.com�� ����    
SELECT SUBSTR('abcdefg@naver.com',INSTR('abcdefg@naver.com','@') + 1)
    FROM DUAL;
    
-- �����ʿ� com�� ���ְ� ���
SELECT RTRIM(SUBSTR('abcdefg@naver.com',INSTR('abcdefg@naver.com','@') + 1),'.com')
    FROM DUAL;
    
-- #020 Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϱ�
-- �̸��� ������ ���, ������ 0�� *ǥ�� ���
-- replace : Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϴ� ���� �Լ�
SELECT ename, REPLACE(sal, 0, '*')
    FROM emp;
    
-- ������ ���� 0~3������ *�� ���
-- REGEXP_REPLACE : ����ǥ���� �Լ�
SELECT ename, REGEXP_REPLACE(sal, '[0-3]', '*') as SALARY
    FROM emp;
    
-- ���̺� ����
CREATE TABLE TEST_ENAME
(ENAME   VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('����ȣ');
INSERT INTO TEST_ENAME VALUES('�Ȼ��');
INSERT INTO TEST_ENAME VALUES('�ֿ���');
COMMIT;

-- �̸��� �ι�° �ڸ��� �ѱ��� *�� ���
SELECT REPLACE(ENAME, SUBSTR(ENAME, 2,1), '*') as "������_�̸�"
    FROM test_ename;

-- #021 Ư�� ö�ڸ� N�� ��ŭ ä���
-- �̸��� ������ ���, ���� �÷��� �ڸ����� 10�ڸ��� �ϰ� ������ ����ϰ� ���� ������ �ڸ��� ��ǥ*�� ���
-- LPAD : �������� ä�� ����
-- RPAD : ���������� ä�� ����
SELECT ename, LPAD(sal, 10, '*') as salary1, RPAD(sal,10,'*') as salary2
    FROM emp;

-- �ٸ��͵� �ǳ�?
SELECT ename, LPAD(sal, 10, 'a') as salary1, RPAD(sal,10,'a') as salary2
    FROM emp;
    
-- �̸��� ������ ����ϰ� ���� 100�� �׸� �ϳ��� �����(100�� �� 1��) 
SELECT ename, sal, LPAD('��', round(sal/100) , '��') as bar_chart
    FROM emp;
    
-- #022 Ư�� ö�� �߶󳻱�
-- ù��° �÷��� smith ö�ڸ� ���, �ι�° �÷��� s��, ����° �÷��� h��, �׹��� �÷��� smiths�� �糡 s�� �߶� ���
-- LTRIM : ���� ö�ڸ� �߶� ���
-- RTRIM : ������ ö�ڸ� �߶� ���
-- TRIM : ������ ö�ڸ� �߶� ���
SELECT 'smith', LTRIM('smith' ,'s'), RTRIM('smith', 'h'), TRIM('s' from 'smiths')
    FROM dual;
    
-- insert �������� ��� ���̺� ��� �����͸� �Է�, jack ��� �����͸� �Է��Ҷ� jack �����ʿ� ������ �ϳ� �־ �Է�
insert into emp(empno, ename, sal, job, deptno) values(8291, 'jack ', 3000, 'SALESMAN', 30);
commit

-- �̸��� jack�� ����� �̸��� ������ ��ȸ
-- �ȳ���, jack�� �̸����� ' '������ �־
SELECT ename, sal
    FROM emp
    WHERE ename = 'jack';
    
-- RTRIM���� ������ �����ϰ� ã��    
SELECT ename, sal
    FROM emp
    WHERE RTRIM(ename) = 'jack';

-- �Է��� ������ ����
DELETE FROM emp WHERE TRIM(ename) ='jack';
commit;

-- #023 �ݿø��ؼ� ����ϱ�
-- 876.567 ���ڸ� ������ �ι�° �ڸ��� 6���� �ݿø��ؼ� ���
-- ROUND(876.567 ,1) �� �Ҽ��� ���� �ι�° �ڸ����� �ݿø�
-- ROUND(876.567 ,2) �� �Ҽ��� ���� ����° �ڸ����� �ݿø�
-- ROUND(876.567 ,-1) �� �Ҽ��� ���� ���� �ڸ����� �ݿø�
-- ROUND(876.567 ,-2) �� �Ҽ��� ���� ���� �ڸ����� �ݿø�
-- ROUND(876.567 ,0) �� �Ҽ����ڸ��� �����̶� �Ȱ��� ���ڰ� ��µ�
SELECT '876.567' as ����, ROUND(876.567 ,1)
    FROM dual;
    
-- #024 ���ڸ� ������ ����ϱ�
-- 876,567�� �Ҽ��� �ι�° �ڸ��� 6���� ��� ������ ���
-- ������ �ڸ��� ROUND�� �Ȱ���
SELECT '876.567' as ����, TRUNC(876.567 ,1)
    FROM dual;
    
-- #025 ���� ������ �� ����ϱ�
-- MOD : �տ� ���ڸ� �ڿ� ���ڷ� ���� ������ �� ���
-- FLOOR : �տ� ���ڸ� �ڿ� ���ڷ� ���� �� ���
-- ���� 10�� 3���� ���� ������ ���� ���
SELECT MOD(10, 3)
    FROM DUAL;

-- �����ȣ�� ��� ��ȣ�� Ȧ���̸� 1, ¦���� 0�� ���
SELECT empno, MOD(empno,2)
    FROM emp;
    
-- �����ȣ�� ¦���� ������� ��� ��ȣ�� �̸��� ���
SELECT empno, ename
    FROM emp
    WHERE MOD(empno,2) =0;
    
-- 10�� 3���� ���� ���� ���
SELECT FLOOR(10/3)
    FROM dual;
    
-- #026 ��¥ �� ������ ����ϱ�
-- sysdate : ���� ��¥�� Ȯ���ϴ� �Լ�
-- months_between(�ֽų�¥, ������¥) : ��¥ ���� �Է¹޾� ���� ���� ���
-- �̸��� ����ϰ� �Ի��� ��¥���� ���ñ��� �� ��� �ٹ��ߴ��� ���
SELECT ename, MONTHS_BETWEEN(sysdate, hiredate)
    FROM emp;

-- 2018�� 10�� 1�Ͽ��� 2019�� 6�� 1�� ������ �� �ϼ��� ���
-- to_date : ��¥�� ���ϴ� �Լ�
SELECT TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')
    FROM dual;

-- 2018�� 10�� 1�Ϻ��� 2019�� 6�� 1�� ������ �� �ּ� ���ϱ�
SELECT ROUND((TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')) / 7)  as "�� �ּ�"
    FROM dual;

-- #027 ���� �� ���� ��¥ ����ϱ�
-- 2019�� 5�� 1�Ϻ��� 100�� ���� ��¥��?
SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'),100)
    FROM dual;

-- 2019�� 5�� 1�Ϻ��� 100�� �Ŀ� ���ƿ��� ��¥
-- 100���̸� �Ѵ��� 30��? 31��? �ָ���
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + 100
    FROM dual;
    
-- 100���̸� �Ѵ��� 30��? 31��? �ָ��� �׷��� month �ɼ��� ��
-- interval �Լ��� ��¥ �Ѽ� ������ ����
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '100' month
    FROM dual;
    
-- interval �Լ��� ���, 2019�� 5�� 1�Ϻ��� 1�� 3���� ���� ��¥�� ���
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '1-3' year(1) to month
    FROM dual;
    
-- ������ 1�ڸ� : YEAR, ������ 3�ڸ� : YEAR(3)
-- 2019�� 5�� 1�Ͽ��� 3�� ���� ��¥�� ��ȯ
SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + interval '3' year
    FROM dual;
    
-- TO_YMINTERVAL�� ����Ͽ� 2019�� 5�� 1�Ϻ��� 3�� 5���� ���� ��¥�� ���

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') as ��¥
    FROM dual;
    
-- #028 Ư�� ��¥ �ڿ� ���� ���� ��¥ ����ϱ�
-- 2019�� 5�� 22�Ϻ��� �ٷ� ���ƿ� �������� ��¥��?
SELECT '2019/05/22' as ��¥,  NEXT_DAY('2019/05/22', '������')
    FROM dual;
    
-- ���� ��¥�� ���
SELECT SYSDATE as "���� ��¥"
    FROM dual;

-- ���ú��� ������ ���ƿ� ȭ������ ��¥�� ���
SELECT NEXT_DAY(SYSDATE, 'ȭ����') as "���� ��¥"
    FROM dual;
    
-- ���ú��� 100�� �ڿ� ���ƿ��� �������� ��¥�� ���
SELECT NEXT_DAY(ADD_MONTHS(sysdate, 100), '������') as "���� ��¥"
    FROM  dual;
    
-- #029 Ư�� ��¥�� �ִ� ���� ������ ��¥ ����ϱ�
-- 2019�� 5�� 22�� �ش� ���� ������ ��¥�� ��� �Ǵ��� ���
SELECT '2019/05/22' as "��¥", LAST_DAY('2019/05/22')  as "������ ��¥"
    FROM dual;
    
-- ���ú��� �̹��� ���ϱ��� �� ��ĥ ���Ҵ��� ���
SELECT LAST_DAY(sysdate) - SYSDATE as "���� ��¥"
    FROM dual;
    
-- KING�� ����� �̸�, �Ի���, �Ի��� ���� ������ ��¥�� ���
SELECT ename, hiredate, LAST_DAY(hiredate)
    FROM emp
    WHERE ename = 'KING';
    
-- #030 ���������� ������ ���� ��ȯ�ϱ�
-- �̸��� SCOTT�� ����� �̸��� �Ի��� ������ ����ϰ�, SCOTT�� ���޿� õ������ �����Ҽ� �ִ� ,�� ����
-- TO_CHAR(sal, 999,999)�� ������ ����Ҷ� õ������ ǥ���Ͽ� ���
-- TO_CHAR : ������ ������ ������ ���������� ��ȯ�ϰų� ��¥�� ������ ������ ���������� ��ȯ�ҋ� ���
SELECT ename, TO_CHAR(hiredate, 'DAY') as ����, TO_CHAR(sal, '999,999') as ����
    FROM emp
    WHERE ename ='SCOTT';
    
-- ��¥�� ���ڷ� ��ȯ�ؼ� ����ϸ� ��¥���� ��, ��, ��, ���� ���� �����ؼ� ���
SELECT hiredate, TO_CHAR(hiredate, 'RRRR') as ����, TO_CHAR(hiredate, 'MM') as ��,
                 TO_CHAR(hiredate, 'DD') as ��, TO_CHAR(hiredate, 'DAY') as ����
    FROM emp
    WHERE ename = 'KING';
    
-- 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ���
SELECT ename, hiredate
    FROM emp
    WHERE TO_CHAR(hiredate, 'RRRR') = '1981';

-- ��¥�÷����� ����/��/��/�ð�/��/�ʸ� �����ϱ� ���� EXTRACT �Լ��� ���
SELECT ename as �̸�, EXTRACT(year from hiredate) as ����,
                     EXTRACT(MONTH from hiredate) as ��,
                     EXTRACT(day from hiredate) as ����
    FROM emp;
    
-- �̸��� ������ ����ϴµ�, ������ ����Ҷ� õ������ ǥ���ؼ� ���
SELECT ename as �̸�, TO_CHAR(sal, '999,999') as ����
 FROM emp;
 
-- õ ������ �鸸 ������ ǥ���ϴ� ����
SELECT ename as �̸�, TO_CHAR(sal * 200, '999,999,999') as ����
    FROM emp;
    
-- ���ĺ� L�� ����Ͽ� ȭ������� �ٿ��� ���
SELECT ename as �̸�, TO_CHAR(sal*200, 'L999,999,999') as ����
    FROM emp;