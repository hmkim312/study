-- #111 SQL�� �˰��� ����Ǯ��(1)
-- ������ 2�� ���
-- ������ ���ǹ��� �̿�
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                            FROM dual
                            CONNECT BY LEVEL <=9)
    SELECT '2' || 'x' || NUM || ' = ' || 2 * NUM as "2��"
        FROM LOOP_TABLE;
        
-- ���� 1������ 9������ ����� ����� WITH���� �̿��Ͽ� LOOP_TABLE�� ����
SELECT LEVEL as NUM
    FROM dual
    CONNECT BY LEVEL <=9;
    
-- #112 SQL�� �˰��� ����Ǯ��(2)
-- ������ 1�� ~ 9�� ���
-- WITH���� ������ ���ǹ��� ���
-- ������ ���ǹ��� �̿��Ͽ� ���� 1�� ���� 9������ ����� ����� WITH���� �̿��Ͽ� LOOP_TABLE�� ����
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= 9),
-- ������ ���ǹ��� �̿��Ͽ� ���� 2������ 9������ ����� ����� WITH���� �̿��Ͽ� GUGU_TABLE�� ����
     GUGU_TABLE as (SELECT LEVEL + 1 as GUGU
                        FROM dual
                        CONNECT BY LEVEL <= 8)
-- LOOP_TABLE�� GUGU_TABLE���� ���ڸ� ���� �ҷ��� ������ ��ü�� ����ϴ� ������ ���� �����ڷ� ����
    SELECT TO_CHAR(A.NUM) || ' x ' || TO_CHAR(B.GUGU) || ' = ' ||
           TO_CHAR(B.GUGU * A.NUM) as ������
        FROM LOOP_TABLE A, GUGU_TABLE B;
        
-- #113 SQL�� �˰��� ����Ǯ��
-- �����ﰢ�� ���
-- ������ ���ǹ��� LPAD�� �̿�
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= 8)
    SELECT LPAD('��', NUM, '��') as STAR
        FROM LOOP_TABLE;
        
-- �� 10�� ���
SELECT LPAD('��' ,10, '��') as STAR
    FROM dual;
    
-- #114 SQL�� �˰��� ����Ǯ��(4)
-- �ﰢ�� ���
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= 8)
    SELECT LPAD(' ',10-num, ' ') || LPAD('��', num, '��') as "TRIANGLE"
        FROM LOOP_TABLE;
        
-- ���ϴ� ũ���� �ﰢ�� ���
undefine ����1
undefine ����2

WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= &����1)
                        
    SELECT LPAD(' ', &����2-NUM, ' ') || LPAD('��', NUM, '��') as "TRIANGLE"
        FROM LOOP_TABLE;
        
-- #115 SQL�� �˰��� ����Ǯ��(5)
-- ������ ���
-- p_num : ȣ��Ʈ ����, �ܺ� ���� undefine ��ɾ�� ������ ����ִ� ���� ����
-- accept : ���� �޾� p_num������ ��� ��ɾ�
-- UNION ALL : ���� ������, ���� ������ �Ʒ��� ������ ��ħ
undefine p_num
ACCEPT p_num prompt '���� �Է� : '

SELECT LPAD(' ', &p_num-LEVEL, ' ') || RPAD('��', LEVEL, '��') as STAR
        FROM dual
        CONNECT BY LEVEL <&p_num+1
UNION ALL
SELECT LPAD(' ', LEVEL, ' ') || RPAD('��', (&p_num) - LEVEL, '��') as STAR
        FROM dual
        CONNECT BY LEVEL < &p_num;
        
-- #116 SQL�� �˰��� ���� Ǯ��(6)
-- �簢�� ���
undefine p_n1
undefine p_n2
ACCEPT p_n1 prompt '���� ���ڸ� �Է��ϼ���~';
ACCEPT p_n2 prompt '���� ���ڸ� �Է��ϼ���~';

-- &p_n2 ���� ���� ����ŭ ���η� ��µǴ� ����� �ݺ�
WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= &p_n2)
-- &p_n1 ���� ���� �� ��ŭ ���η� ��µǴ� ���� �ݺ�
SELECT LPAD('��', &p_n1, '��') as STAR
    FROM LOOP_TABLE;
    
-- #117 SQL�� �˰��� ���� Ǯ��(7)
-- 1���� 10������ ���� ��
undefine p_n
ACCEPT p_n prompt '���ڿ� ���� �� �Է� : ';

-- LEVEL�� ����ϰ� �ִ� 1���� 10������ �հ踦 ����
SELECT SUM(LEVEL) as �հ�
    FROM dual
    CONNECT BY LEVEL <= &p_n;
    
-- #118 SQL�� �˰��� ���� Ǯ��(8)
-- 1���� 10���� ������ ��
undefine p_n
ACCEPT p_n prompt '���ڿ� ���� �� �Է� : ';

SELECT ROUND(EXP(SUM(LN(LEVEL)))) ��
    FROM dual
    CONNECT BY LEVEL <= &p_n;
    
-- #119 SQL�� �˰��� ���� Ǯ��(9)
-- 1���� 10���� ¦���� ���
undefine p_n
ACCEPT p_n prompt '���ڿ� ���� �� �Է� : ';

SELECT LISTAGG(LEVEL, ', ') as ¦��
    FROM dual
    -- ������ 2�� ������ 0�̵Ǵ� ���� �˻�
    WHERE MOD(LEVEL, 2) = 0
    CONNECT BY LEVEL <= &p_n;
    
-- #120 SQL�� �˰��� ����Ǯ��(10)
-- 1���� 10���� �Ҽ��� ���
undefine p_n
ACCEPT p_n prompt '���ڿ� ���� �� �Է� : ';

WITH LOOP_TABLE as (SELECT LEVEL as NUM
                        FROM dual
                        CONNECT BY LEVEL <= &p_n)
SELECT L1.NUM as �Ҽ�
    FROM LOOP_TABLE L1, LOOP_TABLE L2
    WHERE MOD(L1.NUM, L2.NUM) = 0
    GROUP BY L1.NUM
    HAVING COUNT(L1.NUM) = 2;
    
-- #121 SQL�� �˰��� ����Ǯ��(11)
-- �ִ� �����
ACCEPT p_n1 prompt 'ù��° ���ڿ� ���� �� �Է� : ';
ACCEPT p_n2 prompt '�ι�° ���ڿ� ���� �� �Է� : ';

WITH NUM_D as (SELECT &p_n1 as NUM1, &p_n2 as NUM2
                    FROM dual)
SELECT MAX(LEVEL) as "�ִ� �����"
    FROM NUM_D
    WHERE MOD(NUM1, LEVEL) = 0
      AND MOD(NUM2, LEVEL) = 0
    CONNECT BY LEVEL <= NUM2;
    
-- #122 SQL�� �˰��� ���� Ǯ��(12)
-- �ּ� �����
ACCEPT p_n1 prompt 'ù��° ���ڿ� ���� �� �Է� : ';
ACCEPT p_n2 prompt '�ι�° ���ڿ� ���� �� �Է� : ';

WITH NUM_D as (SELECT &p_n1 as NUM1, &p_n2 as NUM2
                    FROM dual)
SELECT NUM1, NUM2,
        (NUM1/MAX(LEVEL)) * (NUM2/MAX(LEVEL)) * MAX(LEVEL) AS "�ּ� �����"
    FROM NUM_D
    WHERE MOD(NUM1, LEVEL) = 0
      AND MOD(NUM2, LEVEL) = 0
    CONNECT BY LEVEL <= NUM2;
    
-- #123 SQL�� �˰��� ���� Ǯ��(13)
-- ��Ÿ����� ����
ACCEPT NUM1 prompt '�غ��� ���̿� ���� �� �Է� : ';
ACCEPT NUM2 prompt '������ ���� �� �Է� : ';
ACCEPT NUM3 prompt '������ ���̿� ���� �� �Է� : ';

SELECT CASE WHEN
        ( POWER(&NUM1, 2) + POWER(&NUM2,2)) = POWER(&NUM3,2)
            THEN '���� �ﰢ���� �½��ϴ�'
            ELSE '���� �ﰢ���� �ƴմϴ�' END AS "��Ÿ����� ����"
    FROM dual;
    
-- #124 SQL�� �˰��� ���� Ǯ��(14)
-- ����ī���� �˰���
-- ����ī���� �˰����� �̿��Ͽ� ������ ���
SELECT SUM(CASE WHEN (POWER(NUM1, 2) + POWER(NUM2,2)) <= 1 THEN 1
            ELSE 0 END) / 1000000 * 4 as "������"
    FROM(
            SELECT DBMS_RANDOM.VALUE(0,1) as NUM1,
                   DBMS_RANDOM.VALUE(0,1) as NUM2
                FROM dual
            CONNECT BY LEVEL < 1000000
        );
        
-- #125 SQL�� �˰��� ����Ǯ��(15)
-- ���Ϸ� ��� �ڿ���� ���ϱ�
-- ����ī���� �˰����� �̿��Ͽ� �ڿ���� e���� ���
-- ������ ���ǹ����� 1000000������ ���ڸ� ����� LOOP_TABLE�̶�� WITH���� �ӽ� ���̺� ����
WITH LOOP_TABLE AS (SELECT LEVEL AS NUM FROM dual
                        CONNECT BY LEVEL <= 1000000
                    )
-- �ڿ������ �����ϴ� ���� POWER�Լ��� �ۼ�, ���ڰ� Ŀ������ ���� �ڿ���� ���� �ٻ�����
SELECT RESULT
    FROM (
            SELECT NUM, POWER((1+1/NUM) ,NUM) AS RESULT
                FROM LOOP_TABLE
            )
    WHERE NUM = 1000000;