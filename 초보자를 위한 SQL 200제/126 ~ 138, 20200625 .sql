-- #126 ���� �����͸� DB�� �ε��ϴ� ���
-- csv ������ ������ ���̺��� ����
CREATE TABLE CANCER
(����     VARCHAR2(50),
 �����ڵ�  VARCHAR(20),
 ȯ�ڼ�   NUMBER(10),
 ����    VARCHAR2(20),
 �������� NUMBER(10,2),
 ������  NUMBER(10,2));
 
-- ���̺��� ������import -> ������ ���� -> �÷� ��Ī

-- #127 ��Ƽ�� �⽺ ���������� ���� ���� ������ �ܾ�� �����ΰ�?
-- ���̺� ����
CREATE TABLE SPEECH
 ( SPEECH_TEXT VARCHAR(1000) );
 
-- jobs.txt ���̺� �ҷ���
-- ������ �Է� �� �Ǽ��� Ȯ��
SELECT count(*) FROM speech;

-- REGEXP_SUBSTR �Լ��� ������ ���������� ����
-- REGEXP_SUBSTR : ���� ǥ���� �Լ�
SELECT REGEXP_SUBSTR('I naver graduated from college', '[^ ]+', 1, 2) word
    FROM dual;
    
-- ���� Ȯ��
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
    FROM speech, ( SELECT LEVEL a
                        FROM dual
                        CONNECT BY LEVEL <= 52);
                        
-- ������ ���� �ܾ���� ī��Ʈ�Ͽ� ���� ���� ������ �ܾ������ ����
SELECT word, count(*)
    FROM ( SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
            FROM speech, ( SELECT LEVEL a
                                FROM dual
                                CONNECT BY LEVEL <= 52)         
        )
WHERE word is not null
GROUP BY word
ORDER BY count(*) DESC;

-- #128 ��Ƽ�� �⽺ ���������� ���� �ܾ ������, ���� �ܾ ������
-- �����ܾ�� �����ܾ �����ϱ� ���� ���̺��� ����
CREATE TABLE POSITIVE ( P_TEXT VARCHAR2(2000) );
CREATE TABLE NEGATIVE ( N_TEXT VARCHAR2(2000) );

-- positive�� negative �ܾ ���̺� ����Ʈ

-- 127�� ����� view�� ����
CREATE VIEW SPEECH_VIEW
as
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
    FROM speech, ( SELECT level a
                    FROM dual
                    CONNECT BY LEVEL <=52);
                    
-- �����ܾ��� �Ǽ� ��ȸ
SELECT count(word) as "���� �ܾ�"
    FROM speech_view
    WHERE lower(word) IN ( SELECT lower(p_text)
                            FROM positive );
                            
-- �����ܾ��� �Ǽ� ��ȸ
SELECT count(word) as "���� �ܾ�"
    FROM speech_view
    WHERE lower(word) IN ( SELECT lower(n_text)
                            FROM negative );
                            
-- #129 ������ ���� �߻��ϴ� ������ �����ΰ�?
-- ���� �߻� ���� �����͸� ��� ���� ���̺� ����
DROP TABLE CRIME_DAY;

CREATE TABLE CRIME_DAY
( CRIME_TYPE  VARCHAR2(50),
  SUN_CNT    NUMBER(10),
  MON_CNT   NUMBER(10),
  TUE_CNT    NUMBER(10),
  WED_CNT   NUMBER(10),
  THU_CNT    NUMBER(10),
  FRI_CNT     NUMBER(10),
  SAT_CNT    NUMBER(10),
  UNKNOWN_CNT  NUMBER(10) );

-- unpivot���� �̿��Ͽ� ���� �÷��� �ο�� �˻��� �����͸� crime_day_unpivot ���̺� ����
CREATE TABLE CRIME_DAY_UNPIVOT
 AS
 SELECT *
   FROM CRIME_DAY
   UNPIVOT ( CNT FOR  DAY_CNT  IN ( SUN_CNT, MON_CNT, TUE_CNT, WED_CNT,
   THU_CNT, FRI_CNT, SAT_CNT) );
   
-- crime_type�� ���� ���˷θ� ���� �����ϰ� rank �Լ��� �̿��ؼ� �Ǽ��� ���� ������ ������ �ο�
-- 1���� ���
SELECT *
    FROM (
        SELECT DAY_CNT, CNT, RANK() over (ORDER BY cnt DESC) RNK
            FROM crime_day_unpivot
            WHERE TRIM(crime_type) = '����'
        )
    WHERE RNK = 1;
    
-- #130 �츮���󿡼� ���� ��ϱ��� ���� ���� �б��� ���?
-- TABLE ����
CREATE TABLE UNIVERSITY_FEE
( DIVISION      VARCHAR2(20),
  TYPE          VARCHAR2(20),
  UNIVERSITY    VARCHAR2(60),
  LOC           VARCHAR2(40),
  ADMISSION_CNT NUMBER(20),
  ADMISIION_FEE NUMBER(20),
  TUITION_FEE   NUMBER(20));
  
-- UNIVERSITY_FEE ���̺��� ��ϱ��� ���� ���� �б� ������ ���� �ο�
SELECT *
    FROM ( 
        SELECT UNIVERSITY, TUITION_FEE,
                RANK() over (ORDER BY tuition_fee DESC NULLS last) ����
            FROM university_fee
        )
    WHERE ���� = 1;
    
-- #131 ����� ���� �� ���� ��� ǰ��� ������ �����ΰ�?
-- TABLE ����
drop table price;

create  table price 
(  
P_SEQ	number(10),
M_SEQ	number(10),
M_NAME  varchar2(80),
A_SEQ	number(10),
A_NAME	varchar2(60),
A_UNIT	varchar2(40),
A_PRICE	number(10),
P_YEAR_MONTH	varchar2(30),
ADD_COL	     varchar2(180),
M_TYPE_CODE	varchar2(20),
M_TYPE_NAME	varchar2(20),
M_GU_CODE	varchar2(10),
M_GU_NAME	varchar2(30) );


  
-- ������ �Է�(131_data_insert.sql ����) 
-- price�� ���̺��� �ִ� ������ ����ϰ� ������������ �� ���� �ش��ϴ� ǰ��� �̸� ������ ���
SELECT a_name as "��ǰ", a_price as "����", m_name as "�����"
    FROM price
    WHERE a_price = (SELECT MAX(a_price)
                        FROM price);
                        
-- price�� ���̺��� �ּ� ������ ����ϰ� ������������ �� ���� �ش��ϴ� ǰ��� �̸� ������ ���
SELECT a_name as "��ǰ", a_price as "����", m_name as "�����"
    FROM price
    WHERE a_price = (SELECT MIN(a_price)
                        FROM price);

--# 132 ������ ���� ���� �߻��ϴ� ��Ҵ� ����ΰ�?
-- ���̺� ����
CREATE TABLE CRIME_LOC
 ( CRIME_TYPE   VARCHAR2(100),
   CRIME_LOC    VARCHAR2(100),
   CRIME_CNT    NUMBER(10));
   
-- 132_data_insert.sql ���Ϸ� ������ ����
-- ���������� ������ ��ҿ� �� ������ ���
SELECT *
    FROM (
        SELECT c_loc, cnt, RANK() over (ORDER BY cnt DESC) rnk
            FROM crime_loc
            WHERE crime_type ='����'
        )
WHERE rnk = 1;

-- #133 ������ȭ�� ����� ���� ū ���� ������?
-- TABLE ����
create table crime_cause
(
��������  varchar2(30),
������  number(10),
���� number(10),
���� number(10),
�㿵�� number(10),
����  number(10),
�ذ�  number(10),
¡�� number(10),
������ȭ  number(10),
ȣ��� number(10),
��Ȥ  number(10),
���   number(10),
�Ҹ�   number(10),
������   number(10),
��Ÿ   number(10)  );

-- 133_data_insert.sql�� ������ ����
-- ���� ���Ⱑ ��µǱ� �����ϵ��� unpivot���� �̿��Ͽ� ���� ���� �÷��� �ο�� �˻��� �����͸�
-- crime_cause2 ���̺�� ����
CREATE TABLE CRIME_CAUSE2
as
SELECT *
    FROM crime_cause
    unpivot (cnt FOR term IN (������, ����, ����, �㿵��, ����, �ذ�, ¡��, ������ȭ,
                              ȣ���, ��Ȥ, ���, �Ҹ�, ������, ��Ÿ));
                              
-- ������������ ������ȭ�� ���� ������ �Ǽ��߿��� ���� ū �Ǽ��� ���
-- �� �Ǽ��� �����鼭 ������ ���� ��ȭ�� ���� ������ ������������ ��ȸ
SELECT ��������
    FROM crime_cause2
    WHERE cnt = ( SELECT MAX(cnt)
                    FROM crime_cause2
                    WHERE TERM = '������ȭ')
    AND TERM = '������ȭ';

-- #134 ��ȭ����� ���� ū ������ �����ΰ�?
-- ��ȭ����� ���� ū ������ ��ȸ
SELECT TERM as ����
    FROM crime_cause2
    WHERE cnt = ( SELECT MAX(CNT)
                    FROM crime_cause2
                    WHERE �������� = '��ȭ')
    AND �������� = '��ȭ';
    
-- #135 �������� ������ ���� ���� �߻��ϴ� ������?
-- ���̺� ����
CREATE TABLE ACC_LOC_DATA
(ACC_LOC_NO    NUMBER(10),
 ACC_YEAR       NUMBER(10),
 ACC_TYPE       VARCHAR2(20),
 ACC_LOC_CODE   NUMBER(10),
 CITY_NAME      VARCHAR2(50),
 ACC_LOC_NAME  VARCHAR2(200),
 ACC_CNT        NUMBER(10),
 AL_CNT          NUMBER(10),
 DEAD_CNT       NUMBER(10),
 M_INJURY_CNT   NUMBER(10),
 L_INJURY_CNT    NUMBER(10),
 H_INJURY_CNT   NUMBER(10),
 LAT              NUMBER(15,8),
 LOT              NUMBER(15,8),
 DATA_UPDATE_DATE   DATE );
 
-- csv. ������ �Է�
-- FROM���� ������������ ������ �Ǽ��� ���� ������ ������ �ο��Ͽ� ����� ���
-- ������������ ���������� ��� �� ���� 5�������� ������ �ɾ� ���
SELECT *
    FROM ( SELECT acc_loc_name as "��� ���", acc_cnt as "��� �Ǽ�",
                DENSE_RANK() over (ORDER BY acc_cnt DESC NULLS LAST) as ����
            FROM acc_loc_data
            WHERE acc_year = 2017
        )
    WHERE ���� <= 5;
    
-- #136 ġŲ�� ����� ���� ���Ҵ� ������ �����ΰ�?
-- ���̺� ����
CREATE TABLE CLOSING
( ����        NUMBER(10),
  �̿��       NUMBER(10),
  �����       NUMBER(10),
  �Ͻ���       NUMBER(10),
  ġŲ��       NUMBER(10),
  Ŀ������      NUMBER(10),
  �ѽ�������     NUMBER(10),
  ȣ����������    NUMBER(10));
  
-- ����Ǽ�csv�� �Է�
-- ġŲ�� ����Ǽ��� ���� ������ ������ ���
SELECT ����  "ġŲ�� ��� ����", ġŲ�� "�Ǽ�"
    FROM (SELECT ����, ġŲ��,
                RANK() over (ORDER BY ġŲ�� DESC) as ����
        FROM closing)
    WHERE ���� = 1;
    
-- #���迡�� �ٹ� �ð��� ���� �� ����� ����ΰ�?
-- ���̺� ����
CREATE  TABLE  WORKING_TIME
( COUNTRY      VARCHAR2(30),
  Y_2014       NUMBER(10),
  Y_2015       NUMBER(10),
  Y_2016       NUMBER(10),
  Y_2017       NUMBER(10),
  Y_2018       NUMBER(10) );

-- �ٷ��ڴ�_�����_����_�ٷνð�_OECD.xlsx �Է�
-- unpivot���� �̿��Ͽ� �����÷��� ����� ������ ������ ����� view�� ���
CREATE VIEW C_WORK_TIME
AS
SELECT *
    FROM WORKING_TIME
    UNPIVOT (cnt FOR y_year IN (Y_2014, Y_2015, Y_2016, Y_2017, Y_2018));
    
-- RANK�Լ��� �̿� ���� �ٷνð��� ���� ���� ������ ������ �ο��Ͽ� ������ ���� ���
SELECT country, cnt, RANK() over (ORDER BY cnt DESC) ����
    FROM C_WORK_TIME
    WHERE Y_YEAR = 'Y_2018';

-- #138 ���ڿ� ���ڰ� ���� ���� �ɸ��� ����?
-- ���̺� ����
CREATE  TABLE  CANCER2
( ����       VARCHAR2(50),   
  �����ڵ�   VARCHAR2(20),
  ȯ�ڼ�     NUMBER(10),
  ����       VARCHAR2(20),
  ��������   NUMBER(10,2),     
  ������    NUMBER(10,2) );

-- �����ϼ���_24�������Ϲ߻���_2018��12��csv�����͸� ����Ʈ
-- ������ ������ �����Ϳ��� ȯ�ڼ��� ���� ���� ���� �������� ��ȸ
-- UNION ALL���� �����ڸ� ����Ͽ� �� �Ʒ� ���� ����� ���� ��µǰ� ��
-- ���� �������� ���� ȯ�ڼ��� ���� ���ǿ� �����ϴ� ������ ������ ȯ�ڼ��� ���
-- ������ ������ ȯ�ڼ��� �ִ밪�� ����Ͽ� ������������ ����
SELECT DISTINCT(����), ����, ȯ�ڼ�
    FROM cancer2
    WHERE ȯ�ڼ� = (SELECT MAX(ȯ�ڼ�)
                    FROM cancer2
                    WHERE ���� = '����' and ���� != '����')
UNION ALL
SELECT DISTINCT(����), ����, ȯ�ڼ�
    FROM cancer2
    WHERE ȯ�ڼ� = (SELECT MAX(ȯ�ڼ�)
                    FROM cancer2
                    WHERE ���� = '����');