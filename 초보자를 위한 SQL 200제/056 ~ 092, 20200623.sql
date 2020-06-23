-- #056 ��µǴ� �� �����ϱ�(1)
-- ������̺��� ��� ��ȣ, �̸�, ����, ������ ��� 5���� �ุ ���
-- ROWNUM : ������ ROWNUM�� �����Ͽ� �װ��� 5�� ���ϸ� ���ԵǸ� ���� 5�� �ุ ������
-- ��뷮 ������ ���� ���� ������
SELECT ROWNUM, empno, ename, job, sal
    FROM emp
    WHERE ROWNUM <=5 ;
    
-- # 057 ��µǴ� �� �����ϱ�(2)
-- ������ ���� ��������� �����ȣ, �̸�, ����, ������ 4���� ������ �����ؼ� ���
-- FETCH FIRST N ROWS ONLY : N���� ����� �� 
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 4 ROWS ONLY;
    
-- ������ ���� ������� 20%�� �ش��ϴ� ����鸸 ���
SELECT empno, ename, job, sal
    FROM emp
    FETCH FIRST 20 PERCENT ROWS ONLY;
    
-- WITH TIES : �������� N��° ��� �����ϴٸ� ���� ���
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC FETCH FIRST 2 ROWS WITH TIES;
    
-- OFFSET : ����� ���۵Ǵ� ���� ��ġ�� ���� ����
-- 10���� ����� ������ ����� ���
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS;
    
-- OFFSET�� FETCH�� �����ؼ� ���
-- OFFSET 9�� ��µ� 5���� �� �߿��� 2���� ������
SELECT empno, ename, job, sal
    FROM emp
    ORDER BY sal DESC OFFSET 9 ROWS
    FETCH FIRST 2 ROWS ONLY;
    
-- #058 ���� ���̺��� �����͸� �����ؼ� ����ϱ�(1)
-- ��� ���̺�� �μ� ���̺��� �����Ͽ� �̸��� �μ� ��ġ�� ���
-- emp.deptno = dept.deptno�� ������ ��
SELECT ename, loc
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;

-- ���� ������ ���� �ʰ� ������ �ϸ� ���δ� ������ ��
SELECT ename, loc
    FROM emp, dept;
    
-- ������ ANALYST�� ����鸸 ���
-- emp.deptno = dept.deptno : ���� ����, �� ���̺��� �����ϱ� ���� �ʿ��� ����
-- emp.job = 'ANALYST'�� : �˻� ����, ��ü ������ �߿� Ư�� �����͸� �����Ͽ� �������� ����
SELECT ename, loc, job
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
-- deptno�� �߰�
-- emp, dept ���̺� ��� �ִ� deptno�� ������ �����;� ���� ���� ������ ��
SELECT ename, loc, job, deptno
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';

-- ���� �� �̸� �տ� ���̺���� ���ξ�� �ٿ������
SELECT ename, loc, job, emp.deptno
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
-- �˻��ӵ� ����� ���� ��� �÷��տ� ���̺���� ���̴� ���� ����
SELECT emp.ename, dept.loc, emp.job
    FROM emp, dept
    WHERE emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
-- FROM ���� ���̺��� ��Ī���� ������ ��뵵 ����
SELECT e.ename, d.loc, e.job
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job = 'ANALYST';
    
-- ��, ��Ī�� ������ �Ŀ��� emp.�� ����� �Ұ���
SELECT emp.ename, d.loc, e.job
    FROM emp e, dept d
    WHERE e.deptno = d.deptno and e.job = 'ANALYST';
    
-- #059 �������̺��� �����͸� �����ؼ� ����ϱ�(2)
-- ��� ���̺�� �޿� ��� ���̺��� �����Ͽ� �̸�, ����, �޿� ����� ���
SELECT e.ename, e.sal, s.grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal and s.hisal;
    
-- salgrade�� �޿� ��� ���̺�, 5����ϼ��� ����
SELECT * FROM salgrade;

-- NON equal join : equal�� ����ؼ� ������ �Ҽ� ��������
-- emp�� sal�� salgrade�� losal, hisal ���̿� �ִ°��� �̿��Ͽ� ����
SELECT e.ename, e.sal, s.grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal and s.hisal;
    
-- #060 ���� ���̺��� �����͸� �����ؼ� ����ϱ�(3)
-- ��� ���̺�� �μ� ���̺��������Ͽ� �̸��� �μ���ġ�� ���
-- ��, boston�� ���� ���
-- (+) : OUTER join�� ����, equal join�� �Ѵ� �ִ� �����͸� ���, OUTER�� �����Ͱ� ���� ���̺� ��� 
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno (+) = d.deptno;
    
-- #061 ���� ���̺��� �����͸� �����ؼ� ����ϱ�(4)
-- ������̺� �ڱ� �ڽ��� ���̺�� �����Ͽ� �̸�, ����, �ش� ����� ������ �̸��� �������� ������ ���
SELECT e.ename as ���, e.job as ����, m.ename as ������, m.job as ����
    FROM emp e, emp m
    WHERE e.mgr = m.empno and e.job ='SALESMAN';
    
-- #062 ���� ���̺��� �����͸� �����ؼ� ����ϱ�(5)
-- ON���� ����Ͽ� �̸��� ���� ���� �μ� ��ġ�� ���
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as �μ���ġ
    FROM emp e JOIN dept d
    ON (e.deptno = d.deptno)
    WHERE e.job = 'SALESMAN';
    
-- ����Ŭ EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    
-- ON���� ����� ����
SELECT e.ename, d.loc
    FROM emp e JOIN dept d
    ON (e.deptno = d.deptno);
    
-- �������� ���̺��� �����Ҷ��� �ۼ���
-- ����Ŭ EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno
    AND e.sal BETWEEN s.losal and s.hisal;

-- ON���� ����� ����
-- ���� ������ ���� = ���̺��� -1
SELECT e.ename, d.loc, s.grade
    FROM emp e
    JOIN dept d ON(e.deptno = d.deptno)
    JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal);
    
-- #063 �������̺��� �����͸� �����ؼ� ����ϱ�(5)
-- USING ���� ����� ���� ������� �̸�, ����, ����, �μ� ��ġ�� ���
-- USING������ ���� ���� ��� �� ���̺��� �����Ҷ� ����� �÷��� �ۼ�
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e JOIN dept d
    USING (deptno)
    WHERE e.job = 'SALESMAN';
    
-- ����Ŭ EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    
-- USING���� ����� ����
SELECT e.ename, d.loc
    FROM emp e JOIN dept d
    USING (deptno);
    
-- ����� ���̺��� �����ϱ�
-- ����Ŭ EQUI JOIN
SELECT e.ename, d.loc
    FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal;

-- USING���� ����� JOIN
-- emp�� �����ϴ� ���̺�� ������ USING���� ����ϸ� ��
SELECT e.ename, d.loc, s.grade
    FROM emp e
    JOIN dept d USING(deptno)
    JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal);

-- #064 �������̺��� �����͸� �����ؼ� ����ϱ�(6)
-- NATURAL ���ι������ �̸�, ����, ���ް� �μ� ��ġ�� ���
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e NATURAL JOIN dept d
    WHERE e.job = 'SALESMAN';
    
-- JOIN�� ������� �Ǵ� �÷��� deptno�� ���̺���� ��Ī���� ����ؾ���.
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e NATURAL JOIN dept d
    WHERE e.job = 'SALESMAN' and deptno = 30;
    
-- #065 ���� ���̺��� �����͸� �����ؼ� ����ϱ�
-- RIGHT OUTER JOIN ������� �̸�, ����, ����, �μ� ��ġ�� ���
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e RIGHT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- ����Ŭ RIGHT OUTER JOIN
-- (+)�� �����Ͱ� '��' ��µǴ� �ʿ� �ٿ���
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno (+) = d.deptno;
    
-- RIGHT OUTER JOIN
SELECT e.ename, d.loc
    FROM emp e RIGHT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- �μ���ȣ 50���� ���� �� LEFT OUTER JOIN �غ���
INSERT INTO emp(empno, ename, sal, job, deptno)
        VALUES(8282, 'JACK', 3000, 'ANALYST', 50);
    
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e LEFT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- ����Ŭ�� LETF OUTER JOIN 
-- (+)�� �����Ͱ� '��' ��µǴ� �ʿ� �ٿ���
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno (+);
    
-- LETF OUTER JOIN
SELECT e.ename, d.loc
    FROM emp e LEFT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- #066 ���� ���̺��� �����͸� �����ؼ� ����ϱ�(8)
-- FULL OUTER ���ι������ �̸�, ����, ����, �μ� ��ġ ���
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    FROM emp e FULL OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- ����Ŭ�� OUTER JOIN ����� ����ϸ� ������
-- ����Ŭ�� OUTER JOIN�� 1���� �������� 
SELECT e.ename, d.loc
    FROM emp e, dept d
    WHERE e.deptno (+) = d.deptno(+);
    
-- FULL OUTER JOIN�� ������� �ʰ� ������ ����� ����ϴ� ��
-- UNION�� �����
SELECT e.ename as �̸�, e.job as ����, e.sal as ����, d.loc "�μ� ��ġ"
    FROM emp e LEFT OUTER JOIN dept d
    ON (e.deptno = d.deptno)
UNION
SELECT e.ename, e.job, e.sal, d.loc
    FROM emp e RIGHT OUTER JOIN dept d
    ON (e.deptno = d.deptno);
    
-- #067 ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ�(1)
-- �μ� ��ȣ�� �μ� ��ȣ�� ��Ż ������ ����ϴµ�, �� �Ʒ��� �࿡ ��Ż������ ���� ���
-- UNION ALL : �� �Ʒ� ���� ����� �ϳ��� ����� ����ϴ� ���� ������
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno
UNION ALL
SELECT TO_NUMBER(null) as deptno, SUM(sal)
    FROM emp;
    
-- UNION ALL�� �ߺ��� ���������ʴ´�.

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

-- ������ ���� 1,2,3,4,5�� �����Ϳ� 3,4,5,6,7�� �����͸� ��ġ�� �ߺ��Ǵ� 3,4,5�� ��������ʰ� �״�� ���
SELECT COL1 FROM A
UNION ALL
SELECT COL1 FROM B;

-- #068 ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ�(2)
-- �μ���ȣ�� �μ� ��ȣ�� ��Ż ������ ����ϴµ�, �� �Ʒ� �࿡ ��Ż������ ���
-- UNION �� UNION ALL�� �ٸ��� 1 : �ߺ��� �����͸� �ϳ��� ������ ������ ���(�ߺ����ŵ�)
-- UNION �� UNION ALL�� �ٸ��� 2 : ù��° Į���� �����͸� �������� ������������ �����Ͽ� ���
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno
UNION
SELECT null as deptno, SUM(sal)
    FROM emp;
    
-- ���̺� C�� D�� ���� �� �ߺ��� ������ ����� ��� �Ǵ��� Ȯ��
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

-- UNION�� �ߺ��� �����Ͱ� ���ŵǰ� ��µ�
SELECT COL1 FROM C
UNION
SELECT COL1 FROM D;

-- #069 ���� �����ڷ� �������� �������� ����ϱ�
-- �μ� ��ȣ 10��, 20���� ������� ����ϴ� ������ ���
-- �μ� ��ȣ 20��, 30���� ����ϴ� ���� ����� �������� ���
-- INTERSECT�� ���� ������ �Ʒ� ������ �������� ���
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN (10, 20)
INTERSECT
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN (20, 30);
    
-- �������� ���� ���̺� ����
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

-- INTERSECT�� ������ Ȯ�� (3,4,5 �� ��µ�)
SELECT col1 FROM e
INTERSECT
SELECT col1 FROM f;

-- #070 ���� �����ڷ� �������� ���̸� ����ϱ�
-- �μ� ��ȣ 10��, 20���� ����ϴ� ������ ������� �μ� ��ȣ 20��, 30���� ����ϴ� ����
-- MINUS : ���� ������ ��� �����Ϳ��� �Ʒ��� ������ ��� �������� ���̸� ���
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN(10, 20)
MINUS
SELECT ename, sal, job, deptno
    FROM emp
    WHERE deptno IN(20,30);
    
-- �� ������ ���̸� ���� ���� ���̺� ����
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

-- ���̺�G�� ���̺�H�� ���̸� ���, ������������ ������
SELECT col1 FROM g
MINUS
SELECT col1 FROM h;

-- #071 �������� ����ϱ�(1)
-- JONES���� �� ���� ������ �޴� ������� �̸��� ������ ���
SELECT ename, sal
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- �ϴ� JONES�� ���� ã�� ���� (���� ����)
SELECT sal
    FROM emp
    WHERE ename = 'JONES';
    
-- JONES�� ������ 2975, �̺��� ���� ������� �̸��� ������ ��� (���� ����)
SELECT ename, sal
    FROM emp
    WHERE sal > 2975;
    
-- ���������� ���������� ��ħ
SELECT ename, sal
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- SCOTT�� ���� ������ �޴� ������� �̸��� ������ ���
SELECT ename, sal
    FROM emp
    WHERE sal = (SELECT sal
                    FROM emp
                    WHERE ename = 'SCOTT');

-- SCOTT�� �����Ϸ��� ���� �� �߰�
-- ���������� AND ename != 'SCOTT'
SELECT ename, sal
    FROM emp
    WHERE sal = (SELECT sal
                    FROM emp
                    WHERE ename = 'SCOTT')
    AND ename != 'SCOTT';
    
-- #072 ���� ���� ����ϱ�(2)
-- ������ SALESMAN�� ������ ���� ������ �޴� ������� �̸��� ������ ���
-- ������ SALESMAN�� ������� �Ѹ��� �ƴ϶� �������̱� ������ in�� ���, equal�� ����ϸ� ����
-- in - ���� �� ���� ���� : ���� �������� ���� ������ �ϳ��� ���� ��ȯ
-- in - ���� �� ���� ���� : ���� �������� ���� ������ ���� ���� ���� ��ȯ
-- in - �����÷� ���� ���� : ���� �������� ���� ������ �������� �÷� ���� ��ȯ 
SELECT ename, sal
    FROM emp
    WHERE sal in (SELECT sal 
                    FROM emp
                    WHERE job = 'SALESMAN');
                    
-- #073 �������� ����ϱ�(3)
-- �����ڰ� �ƴ� ������� �̸��� ������ ���
SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr
                            FROM emp
                            WHERE mgr is not null);
                            
-- ���� ����
SELECT ename, sal, job
    FROM emp
    WHERE empno not in (7839, 7698, 7902, 7566, 7788, 7782);
    
-- �������� + �������� (null)
-- NULL ������ �ƹ����� �ȳ���
-- not in�� ����ϸ� ������������ ���������� NULL���� �ϳ��� ���ϵǸ� ����� ��µ��� ����.
SELECT ename, sal, job
    FROM emp
    WHERE empno not in (SELECT mgr
                            FROM emp);
                            
-- #074 ���� ���� ����ϱ�(4)
-- �μ� ���̺� �ִ� �μ� ��ȣ �߿��� ��� ���̺��� �����ϴ� �μ� ��ȣ�� �μ���ȣ, �μ���, �μ���ġ ���
-- EXISTS : ���̺� A�� �����ϴ� �����Ͱ� ���̺�B�� �����ϴ��� ���θ� Ȯ���Ҷ� EXISTS�Ǵ� NOT EXISTS�� ���
SELECT *
    FROM dept d
    WHERE EXISTS(SELECT *
                    FROM emp e
                    WHERE e.deptno = d.deptno);

-- NOT EXISTS : dept���� �����ϳ� emp���� �������� �ʴ� �����͸� �˻��Ҷ� ���
SELECT *
    FROM dept d
    WHERE NOT EXISTS(SELECT *
                        FROM emp e
                        WHERE e.deptno = d.deptno);
                        
-- #075 ���� ���� ����ϱ�(5)
-- ������ ������ ��Ż ������ ���
-- ������ SALESMAN�� ������� ��Ż���޺��� ��ū ���� ���
-- HAVING : �׷��Լ��� ����ҋ� WHERE�� �ƴ� HAVING�� ���
-- GROUP BY�� ������������ ���Ұ���
SELECT job,  SUM(sal)
    FROM emp
    GROUP BY job
    HAVING SUM(sal) > (SELECT SUM(sal)
                        FROM emp
                        WHERE job = 'SALESMAN');
                        
-- #076 �������� ����ϱ�(6)
-- �̸��� ���ް� ������ ���
-- ������ 1���� ����� ���
-- in line view : FROM���� ��������
SELECT v.ename, v.sal, v.����
    FROM(SELECT ename, sal, RANK() over(ORDER BY sal DESC) ����
            FROM emp) v
    WHERE v.���� = 1;
    
-- #077 ���� ���� ����ϱ�(7)
-- ������ SALESMAN�� ������� �̸��� ������ ����ϴµ�, ������ SALESMAN�� ������� �ִ���ް� �ּҿ��޵� ���� ���
-- scalar �������� : SELECT���� ���� ����, ��µǴ� �� �� ��ŭ �ݺ��Ǿ� �����
-- ���⼭�� SALESMAN�� 4���̶�, scalar ���������� 4�� �����
SELECT ename, sal, (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN') as "�ִ� ����",
                   (SELECT MIN(sal) FROM emp WHERE job = 'SALESMAN') as "�ּ� ����"
    FROM emp
    WHERE job = 'SALESMAN';
    
-- #078 ������ �Է��ϱ�
-- ��� ���̺� �����͸� �Է�
-- ��� ��ȣ 2812, ��� �̸� JACK, ���� 3500, �Ի��� 2019�� 6�� 5��, ������ ANALYST
INSERT INTO emp (empno, ename, sal, hiredate, job)
    VALUES(2812, 'JACK', 3500, TO_DATE('2019/06/05', 'RRRR/MM/DD'), 'ANALYST');
    
-- insert : ������ �Է�
-- update : ������ ����
-- delete : ������ ����
-- merge : ������ �Է�, ����, ������ �� ���� ����

-- #079 ������ �����ϱ�
-- SCOTT�� ������ 3200���� ����
UPDATE emp
    SET sal = 3200
    WHERE ename ='SCOTT';
    
-- �ϳ��� UPDATE������ �������� �� �� ���� ����
-- SCOTT�� ���ް� Ŀ�̼��� ���ÿ� ����, SET���� ������ �÷��� ,�� ����
-- UPDATE, SET, WHERE���� ��� ������ �������� �ۼ� ����
UPDATE emp
    SET sal = 5000, comm = 200
    WHERE ename = 'SCOTT';
    
-- #080 ������ �����ϱ�
-- ��� ���̺��� SCOTT�� �� �����͸� ����
-- ���� ��ɾ� : DELETE, TRUNCATE, DROP
-- CREATE : ����
-- ALTER : ����
-- DROP : ����
-- TRUNCATE : ����
-- RENAME : ��ü �̸� ����
DELETE FROM emp
WHERE ename = 'SCOTT';

-- #081 ���������� �� ����ϱ�
-- ��� ���̺� �Է��� �����Ͱ� ������ ���̽��� ����ǵ���
INSERT INTO emp(empno, ename, sal, deptno)
    VALUES(1122, 'JACK1', 3000, 20);
    
-- COMMIT : COMMIT ������ �����ߴ� DML �۾����� �����ͺ��̽��� ������ �ݿ��ϴ� TCL
COMMIT;

UPDATE emp
    SET sal = 4000
    WHERE ename = 'SCOTT';
    
-- ROLLBACK : ������ COMMIT ��ɾ ���� �� DML���� ����ϴ� TCL
--���⼭�� SCOTT�� ������ 4000���� �����ϴ� UPDATE���� ��ҵ�
ROLLBACK;

-- COMMIT : ��� ���� ������ ������ ���̽��� �ݿ�
-- ROLLBACK : ��� ���� ������ ���
-- SAVEPOINT : Ư�� ���������� ������ ���

-- #082 ������ �Է�, ����, ���� �ѹ��� �ϱ�
-- emp ���̺� loc �÷� �߰�
ALTER TABLE emp
    ADD loc varchar2(10);

-- ��� ���̺� �μ� ��ġ �÷� �߰�, �μ� ���̺��� �̿��Ͽ� �ش� ����� �μ���ġ�� ����
-- ���� �μ� ���̺��� �����ϴ� �μ��̳�, ��� ���̺� ���� �μ���� ���Ӱ� ��� ���̺� �Է�
-- merge into ������ merge ����� �Ǵ� target ���̺�� �ۼ�
MERGE INTO emp e
-- using�� �������� SOURCE ���̺�� �ۼ�, dept�κ��� �����͸� �о�� dept���̺��� �����ͷ� emp ���̺��� merge
USING dept d
-- target���̺�� source ���̺��� ����, ���ο� �����ϸ� merge update�� ����, �����ϸ� merge insert���� ����
ON (e.deptno = d.deptno)
-- merge update�� join�� �����ϸ� ����Ǵ� ��, ��� ���̺��� �μ� ��ġ �÷��� �μ� ���̺��� �μ���ġ�� ����
WHEN MATCHED THEN
-- ��merge insert�� join�� ���еǸ� ����Ǵ���, �μ� ���̺��� �����͸� ��� ���̺� �Է�
UPDATE SET e.loc = d.loc
WHEN NOT MATCHED THEN
INSERT (e.empno, e.deptno, e.loc) VALUES (1111, d.deptno, d.loc);

-- #083 LOCK �����ϱ�
-- ���� �����͸� ���ÿ� ������ �� ������ �ϴ� ��
-- SCOTT���� ������ �͹̳�â 1���� update �� commit�� ���� �ʴ´ٸ�
-- ���� ������ SCOTT���� ������ �͹̳�â 2���� �ٸ� update�� �Ѵٸ� ������� �ʰ� ����
-- �͹̳�â1�� ������ SCOTT������ update�� commit�̳�, rollback�� ���� �ʾұ� ������
-- update ���� �����ϸ� update ����� �Ǵ� ���� ��� ����(�̰��� lock)
-- lock�� �ɸ��� ������ �������� �ϰ����� ���� �ϱ� ���ؼ�

-- #084 SELECT FOR UPDATE�� �����ϱ�
-- SELECT FOR UPDATE���� �˻��ϴ� �࿡ ���� �Ŵ� SQL��
-- �͹̳�â 1���� SELECT FOR UPDATE������ �����͸� �˻��ϸ� �ڵ����� ���� �ɸ�
-- �͹̳�â 2���� ���� �����Ϸ����ϸ� ������ �ȵ�.
-- �͹̳�â 1���� commit�� �ϸ� lock�� ����Ǹ鼭 �͹̳�â 2���� ������ ������ �����

-- #085 ���� ������ ����Ͽ� ������ �Է��ϱ�
-- emp2 table ����
CREATE TABLE emp2
    as
        SELECT *
            FROM emp
            WHERE 1 = 2;

-- emp ���̺��� ������ �״�� ������ emp2 ���̺� �μ���ȣ�� 10���� ������� �����ȣ, �̸�, ����, �μ���ȣ�� �ѹ��� �Է�
-- VALUES���� ��� SELECT�� ���������� �ۼ�
INSERT INTO emp2(empno, ename, sal, deptno)
    SELECT empno, ename, sal, deptno
        FROM emp
        WHERE deptno = 10;
    
-- #086 ���� ������ ����Ͽ� ������ �����ϱ�
-- ������ SALESMAN�� ������� ������ ALLEN�� �������� ����
UPDATE emp
    SET sal = (SELECT sal
                FROM emp
                WHERE ename = 'ALLEN')
WHERE job = 'SALESMAN';

-- #087 ���� ������ ����Ͽ� ������ �����ϱ�
-- SCOTT���� �� ���� ������ �޴� ������� ����
DELETE FROM emp
WHERE sal > (SELECT sal
                FROM emp
                WHERE ename = 'SCOTT');
                
-- ������ �ش� ����� ���� �μ� ��ȣ�� ��� ���޺��� ũ�� ����
DELETE FROM emp m
WHERE sal > (SELECT avg(sal)
                FROM emp s
                WHERE s.deptno = m.deptno);
                
-- #088 ���������� ����Ͽ� ������ ��ġ��
-- dept ���̺� sumsal �÷��� �߰�
ALTER TABLE dept
    ADD sumsal number(10);

-- �μ� ���̺� ���������� SUMSAL �÷��� �߰�
-- ��� ���̺��� �̿��Ͽ� SUMSAL �÷��� �����͸� �μ� ���̺��� �μ� ��ȣ�� ��Ż�������� ����
MERGE INTO dept d
USING (SELECT deptno, SUM(sal) sumsal
        FROM emp
        GROUP BY deptno) v
ON (d.deptno = v.deptno)
WHEN MATCHED THEN
UPDATE SET d.sumsal = v.sumsal;

-- #089 ������ ���ǹ����� ������ �ְ� ������ ����ϱ�(1)
-- ������ ���ǹ��� �̿��Ͽ� ��� �̸�, ����, ������ ���
-- ����� ���� ������ ���� ���
-- connect by�� start with���� ����Ͽ� pseudo column�� level�� ���, 
-- level : ���� Ʈ�� �������� ����
-- ex : KING�� Ʈ�� ������ �ֻ����� �ִ� ��忩�� ���� 1�����̵Ǹ�, ���������� �� ������ �ִ� ����2�� 3�� �� �ο��Ǿ� ���
-- rpad�� �̸� �տ� ������ level���� 3�谡 �ǵ��� �߰��Ͽ� ������ �ð�ȭ��
-- start with : �ش� ������ ��Ʈ����� �����͸� ����, ��Ʈ���� �ֻ��� ���, KING�� �����̹Ƿ� ��Ʈ���� ����
-- connect by : �θ� ���� �ڽĳ��鰣�� ���踦 �����ϴ� �� prior�� ����� �ΰ�, ������ �θ���, �������� �ڽĳ��
-- ��� : ǥ�õ� �׸�
-- ���� : Ʈ�� �������� ������ ����
-- ��Ʈ : Ʈ�� �������� �ֻ����� �ִ� ���
-- �θ� : Ʈ�� �������� ������ �ִ� ���
-- �ڽ� : Ʈ�� �������� ������ �ִ� ���
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr;
    
-- #090 ������ ���ǹ����� ������ �ְ� ������ ����ϱ�(2)
-- ���� �������� BLAKE�� �� ���Ӻ��ϴ� ��µ��� �ʰ� 
-- WHERE ���� ename != BLAKE������ �߰�
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr AND ename != 'BLAKE';
    
-- #091 ������ ���ǹ����� ������ �ְ� ������ ����ϱ�(3)
-- ������ ���ǹ��� �̿��Ͽ�, ��� �̸�, ����, ������ ������ ���� ���
-- ���� ������ �����ϸ鼭 ������ ���� ������� ���
-- SIBILNGS : ORDER�� BY ���̿� ����Ͽ� �����ϸ� ������ ���ǹ��� ���� ������ ��Ʈ���� �����鼭 ��� ����
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr
    ORDER SIBLINGS BY sal DESC;
    
-- ���� SIBLINGS�� ������� �ʴ°�� ������ ���� �����δ�� ��µǾ� ���� ������ ����
SELECT rpad(' ', level * 3) || ename as employee, level, sal, job
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr
    ORDER BY sal DESC;
    
-- #092 ������ ���ǹ����� ������ �ְ� ������ ����ϱ�(4)
-- ������ ���ǹ��� SYS_CONNECT_BY �Լ��� �̿��Ͽ� ���������� ���η� ���
SELECT ename, SYS_CONNECT_BY_PATH(ename, '/') as path
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr;
    
--LTRIM�� ����Ͽ� ���η� ��µǴ� �̸� �տ� '/'�� �����ϰ� ���
SELECT ename, LTRIM(SYS_CONNECT_BY_PATH(ename, '/'), '/') as path
    FROM emp
    START WITH ename = 'KING'
    CONNECT BY prior empno = mgr;