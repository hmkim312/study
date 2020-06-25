drop  table crime_cause;

create table crime_cause
(
범죄유형  varchar2(30),
생계형  number(10),
유흥 number(10),
도박 number(10),
허영심 number(10),
복수  number(10),
해고  number(10),
징벌 number(10),
가정불화  number(10),
호기심 number(10),
유혹  number(10),
사고   number(10),
불만   number(10),
부주의   number(10),
기타   number(10)  );

 insert into crime_cause values( '살인',1,6,0,2,5,0,0,51,0,0,147,15,2,118);
 insert into crime_cause values( '살인미수',0,0,0,0,2,0,0,44,0,1,255,38,3,183);
 insert into crime_cause values( '강도',631,439,24,9,7,53,1,15,16,37,642,27,16,805);
 insert into crime_cause values( '강간강제추행',62,19,4,1,33,22,4,30,1026,974,5868,74,260,4614);
 insert into crime_cause values( '방화',6,0,0,0,1,2,1,97,62,0,547,124,40,339);
 insert into crime_cause values( '상해',26,6,2,4,6,42,18,1666,27,17,50503,1407,1035,22212);
 insert into crime_cause values( '폭행',43,15,1,4,5,51,117,1724,45,24,55814,1840,1383,24953);
 insert into crime_cause values( '체포감금',7,1,0,0,1,2,0,17,1,3,283,17,10,265);
 insert into crime_cause values( '협박',14,3,0,0,0,10,11,115,16,16,1255,123,35,1047);
 insert into crime_cause values( '약취유인',22,7,0,0,0,0,0,3,8,15,30,6,0,84);
 insert into crime_cause values( '폭력행위등',711,1125,12,65,75,266,42,937,275,181,52784,1879,1319,29067);
 insert into crime_cause values( '공갈',317,456,12,51,17,116,1,1,51,51,969,76,53,1769);
 insert into crime_cause values( '손괴',20,4,0,1,3,17,8,346,61,11,15196,873,817,8068);
 insert into crime_cause values( '직무유기',0,1,0,0,0,0,0,0,0,0,0,0,18,165);
 insert into crime_cause values( '직권남용',1,0,0,0,0,0,0,0,0,0,1,0,12,68);
 insert into crime_cause values( '증수뢰',25,1,1,2,5,1,0,0,0,10,4,0,21,422);
 insert into crime_cause values( '통화',15,11,0,1,1,0,0,0,6,2,5,0,2,44);
 insert into crime_cause values( '문서인장',454,33,8,10,37,165,0,16,684,159,489,28,728,6732);
 insert into crime_cause values( '유가증권인지',23,1,0,0,2,3,0,0,0,0,3,0,11,153);
 insert into crime_cause values( '사기',12518,2307,418,225,689,2520,17,47,292,664,3195,193,4075,60689);
 insert into crime_cause values( '횡령',1370,174,58,34,86,341,3,10,358,264,1273,23,668,8697);
 insert into crime_cause values( '배임',112,4,4,0,30,29,0,0,2,16,27,1,145,1969);
 insert into crime_cause values( '성풍속범죄',754,29,1,6,12,100,2,114,1898,312,1051,60,1266,6712);
 insert into crime_cause values( '도박범죄',1005,367,404,32,111,12969,4,8,590,391,2116,9,737,11167);
 insert into crime_cause values( '특별경제범죄',5313,91,17,28,293,507,31,75,720,194,9002,1206,6816,33508);
 insert into crime_cause values( '마약범죄',57,5,0,1,2,19,3,6,399,758,223,39,336,2195);
 insert into crime_cause values( '보건범죄',2723,10,6,4,63,140,1,6,5,56,225,6,2160,10661);
 insert into crime_cause values( '환경범죄',122,1,0,2,1,2,0,0,15,3,40,3,756,1574);
 insert into crime_cause values( '교통범죄',258,12,3,4,2,76,3,174,1535,1767,33334,139,182010,165428);
 insert into crime_cause values( '노동범죄',513,11,0,0,23,30,0,2,5,10,19,3,140,1251);
 insert into crime_cause values( '안보범죄',6,0,0,0,0,0,1,0,4,0,4,23,0,56);
 insert into crime_cause values( '선거범죄',27,0,0,3,1,0,2,1,7,15,70,43,128,948);
 insert into crime_cause values( '병역범죄',214,0,0,0,2,7,3,35,2,6,205,50,3666,11959);
 insert into crime_cause values( '기타',13872,512,35,55,552,2677,51,455,2537,1661,18745,1969,20957,87483);

commit;