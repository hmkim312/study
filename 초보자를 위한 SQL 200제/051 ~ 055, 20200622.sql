-- #051 �����ͺм� �Լ��� ���� ����ϱ�
-- �μ� ��ȣ�� 20���� ������� �����ȣ, �̸�, ������ ���
-- 20�� �μ� ��ȣ������ �ڽ��� ���� ������ ��� �Ǵ��� ���
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over () as ����
    FROM emp
    WHERE deptno = 20;
    
-- 20�� �μ���ȣ�� ������� ������ 20�� �μ� ��ȣ�� ������� ��ü�������� ������ ���
SELECT empno, ename, sal, RATIO_TO_REPORT(sal) over() as ����,
                          sal/SUM(sal) over() as "�� ����"
    FROM emp
    WHERE deptno = 20;
    
-- #052 �����ͺм� �Լ��� ���� ��� ����ϱ�(1)
-- ������ ������ ��Ż ������ ���
-- �� ������ �࿡ ��Ż ������ ���
-- ROLLUP : ������ ������ ��Ż ������ ����ϴ� ������, ROLLUP�� �ٿ��ָ� ��ü ��Ż ������ �߰���
SELECT job, SUM(sal)
    FROM emp
    GROUP BY ROLLUP(job);
    
-- ROLLUP�� ����Ͽ� �� �Ʒ��� ��Ż ������ ���
-- GROUP BY�� ����Ͽ� �μ��� ��Ż ���޵� ���
-- job �÷��� �����͵� ������������ ���
SELECT deptno, job, SUM(sal)
    FROM emp
    GROUP BY ROLLUP(deptno, job);
    
-- #053 ������ �м� �Լ��� ������ ����ϱ�(2)
-- ����, ������ ��Ż ������ ���
-- ù��° �࿡ ��Ż ������ ���
-- CUBE : �� ���ʿ� ��Ż�� �߰���
SELECT job, SUM(sal)
    FROM emp
    GROUP BY CUBE(job);
    
-- CUBE�� �÷� 2���� ���
-- ��Ż������ ��µǰ�, �μ��� ��Ż������ ��µ�
SELECT deptno, job, SUM(sal)
    FROM emp
    GROUP BY CUBE(deptno, job); 
    
-- #054 ������ �м� �Լ��� ���� ��� ����ϱ�(3)
-- �μ���ȣ�� ����, �μ� ��ȣ�� ��Ż ���ް� ������ ��Ż ����, ��ü ��Ż������ ���
-- GROUPING SETS : ��ȣ�ȿ� �����ϰ� ���� �÷����� ���
SELECT deptno, job, SUM(sal)
    FROM emp
    GROUP BY GROUPING SETS((deptno), (job), ());

-- #055 ������ �м� �Լ��� ��°�� �ѹ��� �ϱ�
-- ROW_NUMBER : ��µǴ� �� �࿡ ������ ���ڰ��� �ο��ϴ� �Լ�
SELECT empno, ename, sal, RANK() over (ORDER BY sal DESC) RANK,
                          DENSE_RANK() over (ORDER BY sal DESC) DENSE_RANK,
                          ROW_NUMBER() over (ORDER BY sal DESC) ��ȣ
    FROM emp
    WHERE deptno = 20;
    
-- ROW_NUMBER�� over ���� ��ȣ �ȿ� �ݵ�� ORDER BY���� ����ؾ� ��
-- �Ʒ��� ORDER BY�� ��� ������
SELECT empno, ename, sal, ROW_NUMBER() over () ��ȣ
    FROM emp
    WHERE deptno = 20;
    
-- �μ� ��ȣ���� ���޿� ���� ������ ���
-- PARTITION BY�� ���
SELECT deptno, ename, sal, ROW_NUMBER() over (PARTITION BY deptno
                                              ORDER BY sal DESC) ��ȣ
    FROM emp
    WHERE deptno in (10, 20);