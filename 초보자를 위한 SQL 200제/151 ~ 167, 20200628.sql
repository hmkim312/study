-- #151 �Լ� �����ϱ�
-- �μ���ȣ�� �Է¹޾� �ش� �μ� ������� �μ� ��ġ�� ��µǴ� �Լ��� ����
create or replace function get_loc
(p_deptno in dept.deptno%type)
return dept.loc%type
is
    v_loc dept.loc%type;
begin
    select loc into v_loc
        from dept
        where deptno = p_deptno;
    return v_loc;
end;
/

-- �Լ� ����
select ename, get_loc(deptno) as loc
    from emp
    where job ='SALESMAN';
    
-- #152 ���н� �����ϱ�(1) - ���밪
-- ���ڸ� ����� �ϰ� �ش� ������ ���밪�� ��µǴ� PL/SQL�� �ۼ�
set serveroutput on
accept p_num prompt '���ڸ� �Է��ϼ���'

declare
    v_num number(10) :=&p_num;

begin
    if v_num >= 0 then
        dbms_output.put_line(v_num);
    else
        dbms_output.put_line(-1 * v_num);
    end if;
end;
/

-- #153 ���н� �����ϱ�(2) - �����ﰢ��
-- �غ��� ���̿� ������ ���� ����� �ϰ� �����ﰢ���� �´��� ��µǰ��ϴ� PL/SQL�� �ۼ�
set serveroutput on
set verify off
accept p_num1 prompt '�غ��� �Է��ϼ���'
accept p_num2 prompt '���̸� �Է��ϼ���'
accept p_num3 prompt '������ �Է��ϼ���'

begin
    if power(&p_num1,2) + power(&p_num2,2) = power(&p_num3,2)
    then
        dbms_output.put_line('�����ﰢ���Դϴ�.');
        
    else
        dbms_output.put_line('�����ﰢ���� �ƴմϴ�.');
        
    end if;
end;
/

-- #154 ���н� �����ϱ�(3) - �����Լ�
-- �ؼ��� ������ ���� ������ϰ� ���� ���� �Լ��� ����� ��µǰ��ϴ� PL/SQL�� �ۼ�
set serveroutput on
set verify off
accept p_num1 prompt '�ؼ��� �Է��ϼ���'
accept p_num2 prompt '������ �Է��ϼ���'

declare
    v_result    number(10) := 1;
    v_num2      number(10) := &p_num1;
    v_count     number(10) := 0;
    
begin
    loop
        v_count := v_count + 1;
        v_result := v_result * v_num2;
        exit when v_count = &p_num2;
    end loop;
        dbms_output.put_line(v_result);
end;
/

-- #155 ���н� �����ϱ�(4) - �α� �Լ�
-- �ؼ��� ������ ���� ������ϰ� ���� �α� �Լ��� ����� ��µǰ� �ϴ� PL/SQL�� �ۼ�
set serveroutput on
set verify off
accept p_num1 prompt '�ؼ��� �Է��ϼ���'
accept p_num2 prompt '������ �Է��ϼ���'

declare
        v_num1      number(10) :=&p_num1;
        v_num2      number(10) :=&p_num2;
        v_count     number(10) := 0;
        v_result    number(10) := 1;
        
begin
    loop
        v_count := v_count + 1;
        v_result := v_result * v_num1;
        exit when v_result = v_num2;
    end loop;
        dbms_output.put_line(v_count);
end;
/

-- #156 ���н� �����ϱ�(5) - ����
-- ������ ���ϱ� ���� ���̺� ����
create table sample
( num  number(10),
 fruit   varchar2(10) );

insert into sample values (1, '���');
insert into sample values (2, '�ٳ���');
insert into sample values (3, '������');
commit;

select * from sample;

-- ���н� ������ PL/SQL�� ����
set serveroutput on
set verify off
declare
     v_name1   sample.fruit%type;
     v_name2   sample.fruit%type; 
begin
    for i in 1 .. 3 loop
        for j in 1 .. 3 loop
          select  fruit  into v_name1  from sample where num = i;
          select  fruit  into v_name2  from sample where num = j;
            if i != j then
                dbms_output.put_line(v_name1 || ', ' || v_name2);
            end if;
        end loop;
    end loop;
end;
/

-- #157 ���н� �����ϱ�(6) : ����
-- ���н� ������ PL/SQL�� ����
set serveroutput on
declare
     v_name1   sample.fruit%type;
     v_name2   sample.fruit%type; 
begin
    for i in 1 .. 3 loop
        for j in 1 .. 3 loop
            select fruit into v_name1 from sample where num = i;
            select fruit into v_name2 from sample where num = j;
            dbms_output.put_line(v_name1 ||', '|| v_name2);
        end loop;
    end loop;
end;
/

-- #158 ���� ��� �����ϱ�(1) : ��հ�
-- �������� ���ڵ��� �Է¹��� �� �Է¹��� ���ڵ��� ��հ��� ����ϴ� PL/SQL�� �ۼ�
set serveroutput on
set verify off
accept p_arr prompt '���ڸ� �Է��ϼ���';

declare
    type arr_type is varray(5) of number(10);
    v_num_arr   arr_type := arr_type(&p_arr);
    v_sum   number(10) := 0;
    v_cnt   number(10) := 0;
begin
    for i in 1 .. v_num_arr.count loop
        v_sum := v_sum + v_num_arr(i);
        v_cnt := v_cnt + 1;
    end loop;
dbms_output.put_line(v_sum/v_cnt);

end;

/

-- #159 ���� ��� �����ϱ�(2) : �߾Ӱ�
-- �������� ���ڵ��� �Է¹��� �� �Է¹��� ���ڵ� �߿��� �߾Ӱ��� ����ϴ� PL/SQL���� �ۼ�
accept p_arr prompt '���ڸ� �Է��ϼ���';
declare
type arr_type is varray(10) of number(10);
    v_num_arr   arr_type := arr_type(&p_arr);
    v_n     number(10);
    v_medi  number(10, 2);
begin
    v_n := v_num_arr.count;
    if mod(v_n,2) = 1 then
        v_medi := v_num_arr((v_n+1)/2);
    else
        v_medi := (v_num_arr(v_n/2) + v_num_arr((v_n/2)+1))/2;
    end if;
    dbms_output.put_line(v_medi);
end;
/

-- #160 ������� �����ϱ�(3) : �ֺ�
-- �������� ���ڸ� �Է¹��� �� �Է¹��� ���ڵ� �߿��� �ֺ��� ����ϴ� PL/SQL���� �ۼ�
accept p_num1 prompt '���ڸ� �Է��ϼ���'
declare
    type array_t is varray(10) of varchar2(10);
    v_array array_t := array_t(&p_num1);
    v_cnt number(10);
    v_tmp number(10);
    v_max number(10) := 0;
    v_tmp2 number(10);
    
begin
    for i in 1 .. v_array.count loop
        v_cnt := 1;
        for j in i + 1 .. v_array.count loop
            if v_array(i) = v_array(j) then
                v_tmp := v_array(i);
                v_cnt := v_cnt + 1;
            end if;
        end loop;
        
        if v_max <= v_cnt then
            v_max := v_cnt;
            v_tmp2 := v_tmp;
        end if;
    end loop;
dbms_output.put_line('�ֺ��� '|| v_tmp2 || '�̰� ' || v_max || '�� �Դϴ�.');
end;
/

-- #161 ������� �����ϱ�(4) : �л�� ǥ������
-- �������� ���ڵ��� �Է¹��� �� �� ���ڵ��� �л�� ǥ�������� ����ϴ� PL/SQL���� �ۼ�
set serveroutput on
set verify off
accept p_arr prompt '���ڸ� �Է��ϼ���';

declare
    type arr_type is varray(10) of number(10);
    v_num_arr   arr_type := arr_type(&p_arr);
    v_sum   number(10, 2) := 0;
    v_cnt   number(10, 2) := 0;
    v_avg   number(10, 2) := 0;
    v_var   number(10, 2) := 0;
    
begin
    for i in 1 .. v_num_arr.count loop
        v_sum := v_sum + v_num_arr(i);
        v_cnt := v_cnt + 1;
    end loop;
    
    v_avg := v_sum / v_cnt;
    
    for i in 1 .. v_num_arr.count loop
        v_var := v_var + power(v_num_arr(i) - v_avg, 2);
    end loop;
    
    v_var := v_var / v_cnt;
    
    dbms_output.put_line('�л� ����:' || v_var);
    dbms_output.put_line('ǥ�� ��������:' || round(sqrt(v_var)));
    
end;
/

-- #162 ���� ��� �����ϱ�(5) : ���л�
-- 5���� Ű�� ü�� �����͸� ���� �Է¹��� �� ���л� ���� ����ϴ� PL/SQL���� �ۼ�
accept p_arr1 prompt 'Ű�� �Է��ϼ���'
accept p_arr2 prompt 'ü���� �Է��ϼ���'

declare
    type arr_type is varray(10) of number(10,2);
    v_num_arr1      arr_type := arr_type(&p_arr1);
    v_sum1  number(10, 2) :=0;
    v_avg1  number(10, 2) :=0;
    
    v_num_arr2      arr_type := arr_type(&p_arr2);
    v_sum2  number(10, 2) :=0;
    v_avg2  number(10, 2) :=0;
    
    v_cnt   number(10, 2);
    v_var   number(10, 2) :=0;
    
begin
    
    v_cnt := v_num_arr1.count;
    for i in 1 .. v_num_arr1.count loop
        v_sum1 := v_sum1 + v_num_arr1(i);
    end loop;
    
    for i in 1 .. v_num_arr2.count loop
        v_sum2 := v_sum2 + v_num_arr2(i);
    end loop;
    
    v_avg2 := v_sum2 / v_cnt;
    
    for i in 1 .. v_cnt loop
        v_var := v_var + (v_num_arr1(i) - v_avg1) * (v_num_arr2(i) - v_avg2) / v_cnt;
    end loop;
    
    dbms_output.put_line('���л� ����: ' ||v_var);
end;
/

-- #163 ������� �����ϱ�(6) : ������
-- Ű�� ü�� �����͸� �Է� ���� �� Ű�� ü�߰��� ������谡 �ִ��� PL/SQL������ ����
accept p_arr1 prompt 'Ű�� �Է��ϼ���'
accept p_arr2 prompt 'ü���� �Է��ϼ���'

declare
    type arr_type is varray(10) of number(10, 2);
    v_num_arr1      arr_type := arr_type(&p_arr1);
    v_sum1  number(10, 2) :=0;
    v_avg1  number(10, 2) :=0;
    
    v_num_arr2      arr_type := arr_type(&p_arr2);
    v_sum2  number(10, 2) :=0;
    v_avg2  number(10, 2) :=0;
    
    v_cnt   number(10, 2);
    cov_var number(10, 2) := 0;
    
    v_num_arr1_var  number(10, 2) := 0;
    v_num_arr2_var  number(10, 2) := 0;
    v_corr  number(10, 2);
    
begin

    v_cnt := v_num_arr1.count;
    
    for i in 1 .. v_num_arr1.count loop
        v_sum1 := v_sum1 + v_num_arr1(i);
    end loop;
    
    v_avg1 := v_sum1/ v_cnt;
    
    for i in 1 .. v_num_arr2.count loop
        v_sum2 := v_sum2 + v_num_arr2(i);
    end loop;
    
    v_avg2 :=   v_sum2 / v_cnt;
    
    for i in 1 .. v_cnt loop
        cov_var := cov_var + (v_num_arr1(i) - v_avg1) * (v_num_arr2(i) - v_avg2) / v_cnt;
        v_num_arr1_var := v_num_arr1_var + power(v_num_arr1(i) - v_avg1,2);
        v_num_arr2_var := v_num_arr2_var + power(v_num_arr2(i) - v_avg2,2);
    end loop;
    
        v_corr := cov_var / sqrt(v_num_arr1_var * v_num_arr2_var);
        dbms_output.put_line('�������� :' || v_corr);
end;
/

-- #164 ���� ��� �����ϱ�(7) : Ȯ��
-- �ϳ��� ������ ������ �������� �ո�� �޸��� ���� Ȯ���� ���� 50%���� PL/SQL�� Ȯ��
declare
    v_loop number(10) := 10000;
    v_coin number(10);
    v_0 number(10) := 0;
    v_1 number(10) := 0;
    
begin
    for i in 1.. v_loop loop
        select round(dbms_random.value(1,2)) into v_coin
            from dual;
            
        if v_coin = 1 then
            v_0 := v_0 + 1;
        else
            v_1 := v_1+1;
        end if;
        
    end loop;
    
    dbms_output.put_line('������ �ո��� ���� Ȯ�� : ' || round((v_0 / v_loop),2));
    dbms_output.put_line('������ �޸��� ���� Ȯ�� : ' || round((v_1 / v_loop),2));
end;
/

-- #165 ������� �����ϱ�(8) : Ȯ��
-- ������ �ΰ��� ���ÿ� ���� �Ѵ� �ո��� ���� Ȯ���� �Ѵ� �޸��� ����Ȯ��, �ϳ��� �ո�, �ϳ��� �޸��� ����Ȯ�� ���
declare
    v_loop number(10) := 10000;
    v_coin1 number(10);
    v_coin2 number(10);
    v_0 number(10) :=0;
    v_1 number(10) :=0;
    v_2 number(10) :=0;
    
begin
    for i in 1 .. v_loop loop
        
        select round(dbms_random.value(0,1)), round(dbms_random.value(0,1))
                            into v_coin1, v_coin2
            from dual;
            
        if v_coin1 = 0 and v_coin2 = 0 then
            v_0 := v_0 + 1;
            
        elsif v_coin1 = 1 and v_coin2 = 1 then
            v_1 := v_1 + 1;
            
        else
            v_2 := v_2+1;
        end if;
    end loop;
    dbms_output.put_line('���� �Ѵ� �ո��� ���� Ȯ�� : '|| round((v_0/v_loop),2));
    dbms_output.put_line('���� �Ѵ� �޸��� ���� Ȯ�� : '|| round((v_1/v_loop),2));
    dbms_output.put_line('���� �յڷ� ���� Ȯ�� : '|| round((v_2/v_loop),2));
end;
/

-- #166 ���� ��� �����ϱ�(9) : ���׺���
-- ������������ ���� Ȯ�� ������ PL/SQL������ ����
create or replace function mybin
(p_h in number)
return number
is
    v_h number(10) := p_h;
    v_sim number(10) := 100000;
    v_cnt number(10) := 0;
    v_cnt2 number(10) := 0;
    v_res number(10,2); 

begin
     for n in 1..v_sim loop
     v_cnt := 0;
          for i in 1..10 loop
               if dbms_random.value<0.5 then
                      v_cnt := v_cnt+1;
              end if;
          end loop;
          if v_cnt=v_h then
                v_cnt2 := v_cnt2+1;
 end if;
    end loop;

    v_res := v_cnt2/v_sim;

 return v_res;
end;
/

-- ���� ���� Ȯ��
SELECT level-1 grade, mybin(level-1) Ȯ��, lpad('��', mybin(level-1)*100, '��') "����׷���"
  FROM dual
  CONNECT BY level < 12;

-- #167 ���� ��� �����ϱ�(10) : ���Ժ���
-- �ʵ��л� �ʸ� ���� Ű ���� �����͸� �������� ����
-- �ʸ����� Ű �����Ͱ� ���Ժ����� �̷���� PL/SQL�� ����
set serveroutput on

create or replace procedure probn
 ( p_mu in number,
   p_sig in number,
   p_bin in number)
is

   type arr_type is varray(9) of number(30);

  v_sim number(10) := 10000;
  v_rv number(20,7);
  v_mu number(10) := p_mu;
  v_sig number(10) := p_sig;
  v_nm arr_type := arr_type('',0,0,0,0,0,0,0,'');
  v_cnt arr_type := arr_type(0,0,0,0,0,0,0,0);
  v_rg arr_type := arr_type(-power(2,31),-3,-2,-1,0,1,2,3,power(2,32));

begin
   for i in v_nm.first+1..v_nm.last-1 loop
       v_nm(i) := v_mu-3*p_bin+(i-2)*p_bin;
   end loop;

  for i in 1..v_sim loop
      v_rv := dbms_random.normal*v_sig+v_mu;

        for i in 2..v_rg.count loop
             if v_rv >= v_mu+v_rg(i-1)*p_bin and v_rv < v_mu+v_rg(i)*p_bin then
                    v_cnt(i-1) := v_cnt(i-1)+1;
             end if;
        end loop;
  end loop;

  for i in 1..v_cnt.count loop
dbms_output.put_line(rpad(v_nm(i)||'~'||v_nm(i+1), 10, ' ')||lpad('��',trunc((v_cnt(i)/v_sim)*100),'��'));
  end loop;
end;
/

-- ���Ժ��� Ȯ��
exec probn(160,5,5);