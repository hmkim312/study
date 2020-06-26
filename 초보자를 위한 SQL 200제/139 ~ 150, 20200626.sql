-- #139 PL/SQL 변수 이해하기(1)
-- 두 수를 각각 물어보게 하고 입력받아 두수의 합이 결과로 출력되게 하는 PL/SQL을 작성
set serveroutput on
accept p_num1 prompt '첫 번째 숫자를 입력하세요 : '
accept p_num2 prompt '두 번째 숫자를 입력하세요 : '

declare
        v_sum number(10);
 begin
        v_sum := &p_num1 + &p_num2 ;
        
        
        dbms_output.put_line('총 합은:' || v_sum);
end;
/

-- #140 PL/SQL 변수 이해하기(2)
-- 사원 번호를 물어보게 하고 사원번호를 입력하면 해당 사원의 월급이 출력되게 하는 PL/SQL
set serveroutput on
accept p_empno prompt '사원 번호를 입력하세요 :'
    declare
        v_sal number(10);
    begin
        select sal into v_sal
            from emp
            where empno = &p_empno;
            
    DBMS_OUTPUT.PUT_LINE('해당 사원의 월급은 ' || v_sal);

end;
/

-- #141 PL/SQL IF 이해하기(1)
-- 숫자를 물어보게 하고 숫자를 입력하면 해당 숫자가 짝수인지 홀수인지 출력되게하는 PL/SQL
set serveroutput on
set verify off
accept p_num prompt '숫자를 입력하세요 : '
begin
    if mod(&p_num, 2) = 0 then
        dbms_output.put_line('짝수입니다.');
    else
        dbms_output.put_line('홀수입니다.');
    end if;
end;
/

-- #142 PL/SQL IF 이해하기(2)
-- 이름을 입력받아 해당 사원의 월급이 3000이상이면 고소득자, 2000이상이고 3000보다 적으면 중간소득자
-- 2000보다 적은 사원은 저소득자 라는 메세지를 출력하는 PL/SQL
set serveroutput on
set verify off
accept p_ename prompt '사원의 이름을 입력하세요 :'
declare
    v_ename emp.ename%type := upper('&p_ename');
    v_sal   emp.sal%type;
    
 begin
    select sal into v_sal
        from emp
        where ename = v_ename;
    if  v_sal >= 3000 then
        dbms_output.put_line('고소득자 입니다.');
    elsif   v_sal >= 2000 then
        dbms_output.put_line('중간 소득자 입니다.');
    else
        dbms_output.put_line('저소득자 입니다.');
    end if;
end;
/

-- #143 PL/SQL Basic Loop 이해하기
-- PL/SQL의 Basic loop 문으로 구구단 2단을 출력
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

-- #144 PL/SQL While Loop 이해하기
-- PL/SQL의 While loop문으로 구구단 2단을 출력
declare
    v_count number(10) :=0;
begin
    while v_count < 9 loop
        v_count := v_count +1;
        dbms_output.put_line('2 x '|| v_count || ' = ' || 2* v_count);
    end loop;
end;
/

-- #145 PL/SQL for loop 이해하기
-- PL/SQL의 for loop문으로 구구단 2단 출력
begin
    for i in 1 .. 9 loop
        dbms_output.put_line('2 x ' || i || ' = ' || 2 * i);
    end loop;
end;
/

-- #146 PL/SQL 이중 loop문 이해하기
-- PL/SQL의 이중 for loop 문을 이용해서 구구단 2단부터9단까지 출력
prompt '구구단 전체를 출력합니다.'
begin
    for i in 2 .. 9 loop
        for j in 1 .. 9 loop
            dbms_output.put_line( i || ' x ' || j || ' = ' || i * j);
        end loop;
    end loop;
end;
/

-- #147 PL/SQL Cursor문 이해하기
-- PL/SQL의 Cursor문과 Basic 루프문을 활용해서 부서번호를 물어보게하고, 부서번호를 입력하면
-- 해당 부사 사원 이름, 월급, 부서 번호가 출력
-- cursor : PL/SQL 프로그램에서 처리할 데이터를 저장할 메모리영역
set serveroutput on
set verify off
accept p_deptno prompt '부서번호 입력'
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

-- #148 PL/SQL Cursor문 이해하기
-- PL/SQL의 커서문과 FOR 루프문을 활용해서 부서 번호를 물어보게 하고
-- 부서 번호를 입력하면 해당 사원 이름, 월급 부서번호가 출력
accept p_deptno prompt  '부서번호를 입력하세요' 
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

-- #149 PL/SQL cursor for loop문 이해하기
-- 서브쿼리를 사용한 cursor for loop문을 사용하여 예제 148번을 좀더 간단하게 작성
accept p_deptno prompt '부서 번호를 입력하세요'
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

-- #150 프로시저 구현하기
-- 이름을 입력받아 해당 사원의 월급이 출력되게 하는 프로시저를 생성
create or replace procedure pro_ename_sal
 (p_ename in emp.ename%type)
is
    v_sal emp.sal%type;
begin
            select sal into v_sal
                from emp
                where ename = p_ename;
    dbms_output.put_line(v_sal ||'입니다');
end;
/