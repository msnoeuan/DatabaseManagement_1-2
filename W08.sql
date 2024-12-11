create schema W08 default character set utf8mb4;
use W08;
set sql_safe_updates = 0;


drop table if exists 주소록;

# =============== 주소록 table ===============
create table 주소록 (
   이름 char(4) not null,
   전화번호 char(13),
   주소 varchar(10),
   생일 varchar(11),
   primary key(이름)
);

insert into 주소록 values('홍길동', '010-1234-5678', '서울', '3월 15일');
insert into 주소록 values('이몽룡', '010-3354-5643', '부산', '12월 14일');
insert into 주소록 values('최용만', '321-2345', '대전', '5월 8일 ');
insert into 주소록 values('이건우', '010-2132-2345', null, null);
-- insert into 주소록(이름, 전화번호) values('이건우', '010-2132-2345');

select * from 주소록;

update 주소록 set 전화번호 = '010-3245-4368' where 이름 = '홍길동';
update 주소록 set 주소 = '서울', 생일 = '8월 23일' where 이름 = '이건우';
delete from 주소록 where 이름 = '최용만';
select * from 주소록 where 이름 = '이몽룡';

# =============== 주소록2 table ===============
create table 주소록2 (
   번호 int auto_increment,
   이름 char(10) not null,
   전화번호 char(13),
   주소 varchar(10),
   생일 varchar(11),
   primary key(번호)
);

insert into 주소록2(이름, 전화번호, 주소, 생일) values('홍길동', '010-1234-5678', '서울', '1990-03-15');
insert into 주소록2(이름, 전화번호, 주소, 생일) values('이몽룡', '010-3354-5643', '부산', '12월 14일');
insert into 주소록2(이름, 전화번호, 주소, 생일) values('최용만', '321-2345', '대전', '5월 8일');
insert into 주소록2(이름, 전화번호, 주소, 생일) values('이건우', '010-2132-2345', null, null);

select * from 주소록2;

-- 데이터 구조 확인 
describe 주소록2;  #desc 주소록; 도 가능