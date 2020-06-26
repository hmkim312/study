-- #139 PL/SQL ���� �����ϱ�(1)
-- �� ���� ���� ����� �ϰ� �Է¹޾� �μ��� ���� ����� ��µǰ� �ϴ� PL/SQL�� �ۼ�
set serveroutput on
accept p_num1 prompt 'ù ��° ���ڸ� �Է��ϼ��� : '
accept p_num2 prompt '�� ��° ���ڸ� �Է��ϼ��� : '

declare
        v_sum number(10);
 begin
        v_sum := &p_num1 + &p_num2 ;
        
        
        dbms_output.put_line('�� ����:' || v_sum);
end;
/

-- #140 PL/SQL ���� �����ϱ�(2)
-- ��� ��ȣ�� ����� �ϰ� �����ȣ�� �Է��ϸ� �ش� ����� ������ ��µǰ� �ϴ� PL/SQL
set serveroutput on
accept p_empno prompt '��� ��ȣ�� �Է��ϼ��� :'
    declare
        v_sal number(10);
    begin
        select sal into v_sal
            from emp
            where empno = &p_empno;
            
    DBMS_OUTPUT.PUT_LINE('�ش� ����� ������ ' || v_sal);

end;
/

-- #141 PL/SQL IF �����ϱ�(1)
-- ���ڸ� ����� �ϰ� ���ڸ� �Է��ϸ� �ش� ���ڰ� ¦������ Ȧ������ ��µǰ��ϴ� PL/SQL
set serveroutput on
set verify off
accept p_num prompt '���ڸ� �Է��ϼ��� : '
begin
    if mod(&p_num, 2) = 0 then
        dbms_output.put_line('¦���Դϴ�.');
    else
        dbms_output.put_line('Ȧ���Դϴ�.');
    end if;
end;
/

-- #142 PL/SQL IF �����ϱ�(2)
-- �̸��� �Է¹޾� �ش� ����� ������ 3000�̻��̸� ��ҵ���, 2000�̻��̰� 3000���� ������ �߰��ҵ���
-- 2000���� ���� ����� ���ҵ��� ��� �޼����� ����ϴ� PL/SQL
set serveroutput on
set verify off
accept p_ename prompt '����� �̸��� �Է��ϼ��� :'
declare
    v_ename emp.ename%type := upper('&p_ename');
    v_sal   emp.sal%type;
    
 begin
    select sal into v_sal
        from emp
        where ename = v_ename;
    if  v_sal >= 3000 then
        dbms_output.put_line('��ҵ��� �Դϴ�.');
    elsif   v_sal >= 2000 then
        dbms_output.put_line('�߰� �ҵ��� �Դϴ�.');
    else
        dbms_output.put_line('���ҵ��� �Դϴ�.');
    end if;
end;
/

-- #143 PL/SQL Basic Loop �����ϱ�
-- PL/SQL�� Basic loop ������ ������ 2���� ���
declare
    v_count  number(10) := 0;
begin
    loop
        v_count := v_count+1;
        dbms_output.put_line('2 x '|| v_count || ' = ' || 2* v_count);
        exit when v_count = 9;
    end loop;
end;
/

-- #144 PL/SQL While Loop �����ϱ�
-- PL/SQL�� While loop������ ������ 2���� ���
declare
    v_count number(10) :=0;
begin
    while v_count < 9 loop
        v_count := v_count +1;
        dbms_output.put_line('2 x '|| v_count || ' = ' || 2* v_count);
    end loop;
end;
/

-- #145 PL/SQL for loop �����ϱ�
-- PL/SQL�� for loop������ ������ 2�� ���
begin
    for i in 1 .. 9 loop
        dbms_output.put_line('2 x ' || i || ' = ' || 2 * i);
    end loop;
end;
/

-- #146 PL/SQL ���� loop�� �����ϱ�
-- PL/SQL�� ���� for loop ���� �̿��ؼ� ������ 2�ܺ���9�ܱ��� ���
prompt '������ ��ü�� ����մϴ�.'
begin
    for i in 2 .. 9 loop
        for j in 1 .. 9 loop
            dbms_output.put_line( i || ' x ' || j || ' = ' || i * j);
        end loop;
    end loop;
end;
/

-- #147 PL/SQL Cursor�� �����ϱ�
-- PL/SQL�� Cursor���� Basic �������� Ȱ���ؼ� �μ���ȣ�� ������ϰ�, �μ���ȣ�� �Է��ϸ�
-- �ش� �λ� ��� �̸�, ����, �μ� ��ȣ�� ���
-- cursor : PL/SQL ���α׷����� ó���� �����͸� ������ �޸𸮿���
set serveroutput on
set verify off
accept p_deptno prompt '�μ���ȣ �Է�'
declare
    v_ename  emp.ename%type;
    v_sal    emp.sal%type;
    v_deptno emp.deptno%type;
    
    cursor emp_cursor is
        select ename, sal, deptno
            from emp
            where deptno = &p_deptno;
begin
    open emp_cursor ;
     loop
        fetch emp_cursor into v_ename, v_sal, v_deptno;
        exit when emp_cursor%notfound;
        dbms_output.put_line(v_ename||' '||v_sal||' '||v_deptno);
     end loop;
    close emp_cursor;
end;
/

-- #148 PL/SQL Cursor�� �����ϱ�
-- PL/SQL�� Ŀ������ FOR �������� Ȱ���ؼ� �μ� ��ȣ�� ����� �ϰ�
-- �μ� ��ȣ�� �Է��ϸ� �ش� ��� �̸�, ���� �μ���ȣ�� ���
accept p_deptno prompt  '�μ���ȣ�� �Է��ϼ���' 
declare
     cursor emp_cursor is           
       select ename, sal, deptno     
         from emp                    
         where deptno = &p_deptno;     
begin
     for emp_record in emp_cursor   loop 
      dbms_output.put_line(emp_record.ename ||' '||emp_record.sal 
                                   ||' '||emp_record.deptno);
     end loop;
end;
/

-- #149 PL/SQL cursor for loop�� �����ϱ�
-- ���������� ����� cursor for loop���� ����Ͽ� ���� 148���� ���� �����ϰ� �ۼ�
accept p_deptno prompt '�μ� ��ȣ�� �Է��ϼ���'
begin
    for emp_record in (select ename, sal, deptno
                        from emp
                        where deptno = &p_deptno) loop
        dbms_output.put_line(emp_record.ename ||' '||
                             emp_record.sal  ||' '||
                             emp_record.deptno);
    end loop;
end;
/

-- #150 ���ν��� �����ϱ�
-- �̸��� �Է¹޾� �ش� ����� ������ ��µǰ� �ϴ� ���ν����� ����
create or replace procedure pro_ename_sal
 (p_ename in emp.ename%type)
is
    v_sal emp.sal%type;
begin
            select sal into v_sal
                from emp
                where ename = p_ename;
    dbms_output.put_line(v_sal ||'�Դϴ�');
end;
/