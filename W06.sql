create schema W06 default character set utf8mb4;
use W06;


drop table if exists dept;
drop table if exists dmember;

# =============== 직원 table ===============
create table 직원 (
   이름 varchar(20) not null,
   주소 varchar(100),
   전화번호 char(13) not null,
   연봉 int default 0,
   primary key(이름)
);

insert into 직원 values('우태하', '서울시 서초구', '010-1111-1111', 1000);
insert into 직원 values('김선우', '서울시 구로구', '010-2222-2222', 2000);
insert into 직원 values('이영지', '서울시 마포구', '010-3333-3333', 3000);
insert into 직원 values('유희정', '서울시 마포구', '010-4444-4444', 4000);
insert into 직원 values('오형준', '부산구 연산구', '010-5555-5555', 5000);
insert into 직원 values('고진수', '서울시 구로구', '010-6666-6666', 6000);

select * from 직원;   #기본키 기준으로 가나다순 정렬

# =============== 직원_뷰 view ===============
#뷰 삭제
drop view 직원_뷰;

#직원_뷰(이름, 전화번호)
create view 직원_뷰
as
   select 이름, 전화번호 from 직원;
   
#뷰 조회
select * from 직원_뷰;

#뷰 데이터 입력
insert into 직원_뷰 values('한재승', '010-9999-9999');  #직원 테이블에서 빈 곳은 Null 값으로 들어감

# =============== dept table ===============
create table dept (
   dept_id char(3) not null,
   name varchar(20),
   primary key(dept_id)
);

insert into dept values('100', '컴퓨터공학과');
insert into dept values('101', '산업공학과');

select * from dept;

# =============== dmember table ===============
create table dmember (
   name varchar(10) not null,
   dept_id char(3),
   primary key(name),
   constraint fk_dmember_dept
      foreign key(dept_id)
         references dept(dept_id)
);

insert into dmember values('김광식', '100');
insert into dmember values('김현정', '101');
insert into dmember values('조영수', '101');
insert into dmember values('유승민', '100');

select * from dmember;