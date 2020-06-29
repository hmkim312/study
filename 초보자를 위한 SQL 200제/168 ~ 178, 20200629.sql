-- #168 PL/SQL�� �˰��� ����Ǯ��(1) : �ﰢ�� ���
-- PL/SQL������ �ﰢ���� ���
set serveroutput on

accept p_num prompt '���ڸ� �Է��ϼ���.'
declare
    v_cnt   number(1) := 0;
begin
    while v_cnt < &p_num loop
        v_cnt := v_cnt + 1;
        dbms_output.put_line(lpad('��', v_cnt, '��'));
    end loop;
end;
/

-- #169 PL/SQL�� �˰��� ����Ǯ��(2) : �簢�� ���
-- ������ ���̿� ������ ���̸� ���� �Է¹޾� �簢���� ����ϴ� PL/SQL���� �ۼ�
set serveroutput on

accept p_a prompt '������ ���ڸ� �Է��ϼ���.'
accept p_b prompt '������ ���ڸ� �Է��ϼ���.'

begin
    for i in 1 .. &p_b loop
        dbms_output.put_line(lpad('��', &p_a, '��'));
    end loop;
end;
/

-- #170 PL/SQL�� �˰��� ����Ǯ��(3) : ��Ÿ����� ����
-- ������ ���̿� ������ ����, ������ ���̸� ���� �Է¹ް�, ���� �ﰢ������ ���θ� ����ϴ� PL/SQL���� �ۼ�
set serveroutput on
set verify off
accept p_num1 prompt '�غ��� ���̸� �Է��ϼ���'
accept p_num2 prompt '���̸� �Է��ϼ���'
accept p_num3 prompt '������ ���̸� �Է��ϼ���'

declare
    v_num1 number(10) :=&p_num1;
    v_num2 number(10) :=&p_num2;
    v_num3 number(10) :=&p_num3;
    
begin
if (v_num1) ** 2 + (v_num2) ** 2 = (v_num3) ** 2 then
    dbms_output.put_line('�����ﰢ���� �½��ϴ�.');
else
    dbms_output.put_line('�����ﰢ���� �ƴմϴ�.');
end if;
end;
/

-- #171 PL/SQL�� �˰��� ���� Ǯ��(4) : ���丮��
-- ���н� ���丮���� PL/SQL������ ����
set serveroutput on
set verify off
accept p_num prompt '���ڸ� �Է��ϼ���'
declare
    v_num1 number(10) := &p_num;
    v_num2 number(10) := &p_num;
begin
    loop
        v_num1 := v_num1 - 1;
        v_num2 := v_num2 * v_num1;
        exit when v_num1=1;
    end loop;
        dbms_output.put_line(v_num2);
end;
/

-- #172 PL/SQL�� �˰��� ����Ǯ��(5) : �ִ�����
-- �μ��ڸ� �Է¹޾� �� ������ �ִ� ������� ����ϴ� PL/SQL���� �ۼ�
set verify off
accept p_num1 prompt '���ڸ� �Է��ϼ���'
accept p_num2 prompt '���ڸ� �Է��ϼ���'
declare
    v_cnt   number(10);
    v_mod   number(10);
begin
    for i in reverse 1 .. &p_num1 loop
        v_mod := mod(&p_num1, i) + mod(&p_num2, i);
        v_cnt := i;
        exit when v_mod = 0;
    end loop;
        dbms_output.put_line(v_cnt);
end;
/

-- #173 PL/SQL�� �˰��� ���� Ǯ��(6) : �ּ� �����
-- �� ���ڸ� �Է¹޾� �� ������ �ּ� ������� PL/SQL�� ���
set serveroutput on
set verify off
accept p_num1 prompt '���ڸ� �Է��ϼ���'
accept p_num2 prompt '���ڸ� �Է��ϼ���'
declare
    v_num1  number(10) := &p_num1;
    v_num2  number(10) := &p_num2;
    v_cnt   number(10);
    v_mod   number(10);
    v_result    number(10);
begin
    for i in reverse 1 .. v_num1 loop
        v_mod := mod(v_num1, i) + mod(v_num2, i);
        v_cnt := i;
        exit when v_mod = 0;
    end loop;
        v_result := (v_num1 / v_cnt) *  (v_num2 / v_cnt) * v_cnt;
        dbms_output.put_line(v_result);
end;
/

-- #174 PL/SQL�� �˰��� ����Ǯ��(7) : ���� ����
-- 5���� ���ڵ��� �Է¹޾� ���� ���� �˰������� �����ϴ� ����� PL/SQL�� ����
set serveroutput on
set verify off
accept p_num prompt '������ 5���� ���ڸ� �Է��ϼ���'

declare
    type array_t is varray(10) of number(10);
    array array_t := array_t();
    tmp number := 0;
    v_num varchar2(50) := '&p_num';
    v_cnt number := regexp_count(v_num, ' ') +1;

begin
    array.extend(v_cnt);
    dbms_output.put('���� �� ���� : ');
    
    for i in 1 .. array.count loop
        array(i) := regexp_substr('&p_num','[^ ]+',1,i);
      dbms_output.put(array(i)||' ');
    end loop;
    
    dbms_output.new_line;
    
    for i in 1 .. array.count -1 loop
        for j in i + 1 .. array.count loop
            if array(i) > array(j) then
                tmp := array(i);
                array(i) := array(j);
                array(j) := tmp;
            end if;
        end loop;
    end loop;
     dbms_output.put('���� �� ���� : ');
    
    for i in 1 .. array.count loop
        dbms_output.put(array(i)||' ');
    end loop;
        dbms_output.new_line;
end;
/

-- #175 PL/SQL�� �˰��� ����Ǯ��(8) : ���� ����
-- 5�� ���ڵ��� �Է¹޾� ���� ���� �˰������� �����ϴ� ����� PL/SQL�� ����
set serveroutput on
set verify off

accept p_num prompt '������ 5���� ���ڸ� �Է��ϼ���.'

declare
    type array_t is  varray(100) of number(10);
    varray array_t := array_t();
    v_temp number(10);
begin

  varray.extend(regexp_count('&p_num',' ') + 1);
    for i in 1 .. varray.count loop
        varray(i) := to_number(regexp_substr('&p_num','[^ ]+', 1,i));
    end loop;
    
  for j in 2 .. varray.count loop
    for k in 1 .. j -1 loop
    
        if varray(k) > varray(j) then
            v_temp := varray(j);
            
        for z in reverse k .. j -1 loop
            varray(z + 1) := varray(z);
        end loop;
                
            varray(k) := v_temp;
        end if;
    end loop;
  end loop;
  
  for i in 1 .. varray.count loop
    dbms_output.put(varray(i) || ' ');
  end loop;
  
  dbms_output.new_line;
end;
/

-- #176 PL/SQL�� �˰��� ����Ǯ��(9) : ����Ž��
-- �������� ������ ���ڵ��� �迭�� ����ǰ� �ϰ� Ư�� ���ڰ� �迭���� �˻��Ǵ����� ���� Ž������ ����
set serveroutput on
set verify off
accept p_num prompt '�������� ������ ���ڵ��� ������ �Է�'
accept p_a prompt '�˻��� ���ڸ� �Է�'

declare
    type array_t is varray(1000) of number(30);
    array_s array_t := array_t();
    v_cnt   number(10) := &p_num;
    v_a     number(10) := &p_a;
    v_chk   number(10) := 0;
    
begin

array_s.extend(v_cnt);

for i in 1 .. v_cnt loop
    array_s(i) := round(dbms_random.value(1, v_cnt));
    dbms_output.put(array_s(i) ||',');
end loop;
    dbms_output.new_line;
for i in array_s.first..array_s.last loop
  if v_a = array_s(i) then
      v_chk := 1;
    dbms_output.put(i||'��°���� ����' ||v_a||'�� �߰��߽��ϴ�.');
  end if;
end loop;

    dbms_output.new_line;
    
if v_chk = 0 then
    dbms_output.put_line('���ڸ� �߰����� ���߽��ϴ�.');
end if;

end;
/

-- #177 PL/SQL�� �˰��� ����Ǯ��(10) : ����ī���� �˰���
-- ����ī���� �˰����� �̿��Ͽ� �������� ���
set serveroutput on

declare
    v_cnt   number(10, 2) := 0;
    v_a number(10,2);
    v_b number(10,2);
    v_pi number(10,2);
    
begin
    for i in 1 .. 1000000 loop
        v_a := dbms_random.value(0,1);
        v_b := dbms_random.value(0,1);
        
        if power(v_a,2) +power(v_b,2) <= 1 then
            v_cnt := v_cnt + 1;
        end if;
    end loop;
    
        v_pi := (v_cnt/1000000) * 4;
        dbms_output.put_line(v_pi);
end;
/

-- #178 PL/SQL�� �˰��� ����Ǯ��(11) : Ž�� �˰���
-- Ž��˰��� : �� �������� �ּ��� ������ �ϴ°�
-- �ܵ� ��ü �ݾװ� �ܵ��� ������ ���� ����� �ϰ� Ž�� �˰����� �̿��Ͽ� �Է��� �ݾ׿� ���߾� �ܵ��� �Ž����ִ� PL/SQL
set serveroutput on
set verify off
accept p_money prompt '�ܵ� ��ü �ݾ��� �Է�'
accept p_coin prompt '�ܵ� ������ �Է�'

declare
    v_money     number(10) := &p_money;
    type array_t is varray(3) of number(10);
    v_array  array_t := array_t(&p_coin);
    v_num   array_t := array_t(0,0,0);
begin
    for i in 1 .. v_array.count loop
        if v_money >= v_array(i) then
            v_num(i) := trunc(v_money/v_array(i));
            v_money := mod(v_money, v_array(i));
        end if;
        dbms_output.put(v_array(i) ||'���� ���� : ' || v_num(i)||'��, ');
    end loop;
    dbms_output.new_line;
end;
/