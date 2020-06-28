-- #151 함수 구현하기
-- 부서번호를 입력받아 해당 부서 사원들의 부서 위치가 출력되는 함수를 생성
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

-- 함수 실행
select ename, get_loc(deptno) as loc
    from emp
    where job ='SALESMAN';
    
-- #152 수학식 구현하기(1) - 절대값
-- 숫자를 물어보게 하고 해당 숫자의 절대값이 출력되는 PL/SQL을 작성
set serveroutput on
accept p_num prompt '숫자를 입력하세요'

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

-- #153 수학식 구현하기(2) - 직각삼각형
-- 밑변과 높이와 빗변을 각각 물어보게 하고 직각삼각형이 맞는지 출력되게하는 PL/SQL을 작성
set serveroutput on
set verify off
accept p_num1 prompt '밑변을 입력하세요'
accept p_num2 prompt '높이를 입력하세요'
accept p_num3 prompt '빗변을 입력하세요'

begin
    if power(&p_num1,2) + power(&p_num2,2) = power(&p_num3,2)
    then
        dbms_output.put_line('직각삼각형입니다.');
        
    else
        dbms_output.put_line('직각삼각형이 아닙니다.');
        
    end if;
end;
/

-- #154 수학식 구현하기(3) - 지수함수
-- 밑수와 지수를 각각 물어보게하고 계산된 지수 함수의 결과가 출력되게하는 PL/SQL을 작성
set serveroutput on
set verify off
accept p_num1 prompt '밑수를 입력하세요'
accept p_num2 prompt '지수를 입력하세요'

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

-- #155 수학식 구현하기(4) - 로그 함수
-- 밑수와 진수를 각각 물어보게하고 계산된 로그 함수의 결과가 출력되게 하는 PL/SQL을 작성
set serveroutput on
set verify off
accept p_num1 prompt '밑수를 입력하세요'
accept p_num2 prompt '진수를 입력하세요'

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

-- #156 수학식 구현하기(5) - 순열
-- 순열을 구하기 위해 테이블 생성
create table sample
( num  number(10),
 fruit   varchar2(10) );

insert into sample values (1, '사과');
insert into sample values (2, '바나나');
insert into sample values (3, '오렌지');
commit;

select * from sample;

-- 수학식 순열을 PL/SQL로 구현
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

-- #157 수학식 구현하기(6) : 조합
-- 수학식 조합을 PL/SQL로 구현
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

-- #158 기초 통계 구현하기(1) : 평균값
-- 여러개의 숫자들을 입력받은 후 입력받은 숫자들의 평균값을 출력하는 PL/SQL을 작성
set serveroutput on
set verify off
accept p_arr prompt '숫자를 입력하세요';

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

-- #159 기초 통게 구현하기(2) : 중앙값
-- 여러개의 숫자들을 입력받은 후 입력받은 숫자들 중에서 중앙값을 출력하는 PL/SQL문을 작성
accept p_arr prompt '숫자를 입력하세요';
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

-- #160 기초통계 구현하기(3) : 최빈값
-- 여러개의 숫자를 입력받은 후 입력받은 숫자들 중에서 최빈값을 출력하는 PL/SQL문을 작성
accept p_num1 prompt '숫자를 입력하세요'
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
dbms_output.put_line('최빈값은 '|| v_tmp2 || '이고 ' || v_max || '개 입니다.');
end;
/

-- #161 기초통계 구현하기(4) : 분산과 표준편차
-- 여러개의 숫자들을 입력받은 후 그 숫자들의 분산과 표준편차를 출력하는 PL/SQL문을 작성
set serveroutput on
set verify off
accept p_arr prompt '숫자를 입력하세요';

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
    
    dbms_output.put_line('분산 값은:' || v_var);
    dbms_output.put_line('표준 편차값은:' || round(sqrt(v_var)));
    
end;
/

-- #162 기초 통계 구현하기(5) : 공분산
-- 5명의 키와 체중 데이터를 각각 입력받은 후 공분산 값을 출력하는 PL/SQL문을 작성
accept p_arr1 prompt '키를 입력하세요'
accept p_arr2 prompt '체중을 입력하세요'

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
    
    dbms_output.put_line('공분산 값은: ' ||v_var);
end;
/

-- #163 기초통계 구현하기(6) : 상관계수
-- 키와 체중 데이터를 입력 받은 후 키와 체중간의 상관관계가 있는지 PL/SQL문으로 구현
accept p_arr1 prompt '키를 입력하세요'
accept p_arr2 prompt '체중을 입력하세요'

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
        dbms_output.put_line('상관관계는 :' || v_corr);
end;
/

-- #164 기초 통계 구현하기(7) : 확률
-- 하나의 동전을 여러번 던졌을때 앞면과 뒷면이 나올 확률이 각각 50%임을 PL/SQL로 확인
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
    
    dbms_output.put_line('동전의 앞면이 나올 확률 : ' || round((v_0 / v_loop),2));
    dbms_output.put_line('동전의 뒷면이 나올 확률 : ' || round((v_1 / v_loop),2));
end;
/

-- #165 기초통계 구현하기(8) : 확률
-- 동전을 두개를 동시에 던저 둘다 앞면이 나올 확률과 둘다 뒷면이 나올확률, 하나는 앞면, 하나는 뒷면이 나올확률 출력
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
    dbms_output.put_line('동전 둘다 앞면이 나올 확률 : '|| round((v_0/v_loop),2));
    dbms_output.put_line('동전 둘다 뒷면이 나올 확률 : '|| round((v_1/v_loop),2));
    dbms_output.put_line('동전 앞뒤로 나올 확률 : '|| round((v_2/v_loop),2));
end;
/

-- #166 기초 통계 구현하기(9) : 이항분포
-- 동전던지기의 이항 확률 분포를 PL/SQL문으로 구현
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

-- 이항 분포 확인
SELECT level-1 grade, mybin(level-1) 확률, lpad('■', mybin(level-1)*100, '■') "막대그래프"
  FROM dual
  CONNECT BY level < 12;

-- #167 기초 통계 구현하기(10) : 정규분포
-- 초등학생 십만 명의 키 숫자 데이터를 랜덤으로 생성
-- 십만명의 키 데이터가 정규분포를 이루는지 PL/SQL로 구현
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
dbms_output.put_line(rpad(v_nm(i)||'~'||v_nm(i+1), 10, ' ')||lpad('■',trunc((v_cnt(i)/v_sim)*100),'■'));
  end loop;
end;
/

-- 정규분포 확인
exec probn(160,5,5);