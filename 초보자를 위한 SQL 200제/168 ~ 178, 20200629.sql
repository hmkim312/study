-- #168 PL/SQL로 알고리즘 문제풀기(1) : 삼각형 출력
-- PL/SQL문으로 삼각형을 출력
set serveroutput on

accept p_num prompt '숫자를 입력하세요.'
declare
    v_cnt   number(1) := 0;
begin
    while v_cnt < &p_num loop
        v_cnt := v_cnt + 1;
        dbms_output.put_line(lpad('★', v_cnt, '★'));
    end loop;
end;
/

-- #169 PL/SQL로 알고리즘 문제풀기(2) : 사각형 출력
-- 가로의 길이와 세로의 길이를 각각 입력받아 사각형을 출력하는 PL/SQL문을 작성
set serveroutput on

accept p_a prompt '가로의 숫자를 입력하세요.'
accept p_b prompt '세로의 숫자를 입력하세요.'

begin
    for i in 1 .. &p_b loop
        dbms_output.put_line(lpad('★', &p_a, '★'));
    end loop;
end;
/

-- #170 PL/SQL로 알고리즘 문제풀기(3) : 피타고라스의 정리
-- 가로의 길이와 세로의 길이, 빗변의 길이를 각각 입력받고, 직각 삼각형인지 여부를 출력하는 PL/SQL문을 작성
set serveroutput on
set verify off
accept p_num1 prompt '밑변의 길이를 입력하세요'
accept p_num2 prompt '높이를 입력하세요'
accept p_num3 prompt '빗변의 길이를 입력하세요'

declare
    v_num1 number(10) :=&p_num1;
    v_num2 number(10) :=&p_num2;
    v_num3 number(10) :=&p_num3;
    
begin
if (v_num1) ** 2 + (v_num2) ** 2 = (v_num3) ** 2 then
    dbms_output.put_line('직각삼각형이 맞습니다.');
else
    dbms_output.put_line('직각삼각형이 아닙니다.');
end if;
end;
/

-- #171 PL/SQL로 알고리즘 문제 풀기(4) : 팩토리얼
-- 수학식 팩토리얼을 PL/SQL문으로 구현
set serveroutput on
set verify off
accept p_num prompt '숫자를 입력하세요'
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

-- #172 PL/SQL로 알고리즘 문제풀기(5) : 최대공약수
-- 두숫자를 입력받아 두 숫자의 최대 공약수를 출력하는 PL/SQL문을 작성
set verify off
accept p_num1 prompt '숫자를 입력하세요'
accept p_num2 prompt '숫자를 입력하세요'
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

-- #173 PL/SQL로 알고리즘 문제 풀기(6) : 최소 공배수
-- 두 숫자를 입력받아 두 숫자의 최소 공배수를 PL/SQL로 출력
set serveroutput on
set verify off
accept p_num1 prompt '숫자를 입력하세요'
accept p_num2 prompt '숫자를 입력하세요'
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

-- #174 PL/SQL로 알고리즘 문제풀기(7) : 버블 정렬
-- 5개의 숫자들을 입력받아 버블 정렬 알고리즘으로 정렬하는 방법을 PL/SQL로 구현
set serveroutput on
set verify off
accept p_num prompt '정렬할 5개의 숫자를 입력하세요'

declare
    type array_t is varray(10) of number(10);
    array array_t := array_t();
    tmp number := 0;
    v_num varchar2(50) := '&p_num';
    v_cnt number := regexp_count(v_num, ' ') +1;

begin
    array.extend(v_cnt);
    dbms_output.put('정렬 전 숫자 : ');
    
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
     dbms_output.put('정렬 후 숫자 : ');
    
    for i in 1 .. array.count loop
        dbms_output.put(array(i)||' ');
    end loop;
        dbms_output.new_line;
end;
/

-- #175 PL/SQL로 알고리즘 문제풀기(8) : 삽입 정렬
-- 5개 숫자들을 입력받아 삽입 정렬 알고리즘으로 정렬하는 방법을 PL/SQL로 구현
set serveroutput on
set verify off

accept p_num prompt '정렬할 5개의 숫자를 입력하세요.'

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

-- #176 PL/SQL로 알고리즘 문제풀기(9) : 순차탐색
-- 랜덤으로 생성된 숫자들이 배열에 저장되게 하고 특정 숫자가 배열에서 검색되는지를 순차 탐색으로 구현
set serveroutput on
set verify off
accept p_num prompt '랜덤으로 생성할 숫자들의 개수를 입력'
accept p_a prompt '검색할 숫자를 입력'

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
    dbms_output.put(i||'번째에서 숫자' ||v_a||'를 발견했습니다.');
  end if;
end loop;

    dbms_output.new_line;
    
if v_chk = 0 then
    dbms_output.put_line('숫자를 발견하지 못했습니다.');
end if;

end;
/

-- #177 PL/SQL로 알고리즘 문제풀기(10) : 몬테카를로 알고리즘
-- 몬테카를로 알고리즘을 이용하여 원주율을 출력
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

-- #178 PL/SQL로 알고리즘 문제풀기(11) : 탐욕 알고리즘
-- 탐욕알고리즘 : 매 순간마다 최선의 선택을 하는것
-- 잔돈 전체 금액과 잔돈의 단위를 각각 물어보게 하고 탐욕 알고리즘을 이용하여 입력한 금액에 맞추어 잔돈을 거슬러주는 PL/SQL
set serveroutput on
set verify off
accept p_money prompt '잔돈 전체 금액을 입력'
accept p_coin prompt '잔돈 단위를 입력'

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
        dbms_output.put(v_array(i) ||'원의 개수 : ' || v_num(i)||'개, ');
    end loop;
    dbms_output.new_line;
end;
/