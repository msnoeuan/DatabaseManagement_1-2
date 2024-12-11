-- 1. 데이터베이스 생성
-- use database;
-- 2. 테이블 생성
-- 3. 데이터 입력
-- 4. 데이터 조회

create schema W05 default character set utf8mb4;
use W05;

drop table if exists 학과;
drop table if exists 학생;
drop table if exists member_tbl;

# =============== 학과 table ===============
create table 학과 (
   학과번호 int not null,
   학과명 varchar(50),
   primary key(학과번호)
);  #괄호 뒤 세미콜론 주의

insert into 학과 values(1, '컴퓨터소프트웨어공학과');
insert into 학과 values(2, '컴퓨터정보공학과');
insert into 학과 values(3, '인공지능소프트웨어공학과');

select * from 학과;

# =============== 학생 table ===============
create table 학생 (
   번호 int not null,
   이름 varchar(12),
   학년 int,
   분반 char(2),
   학과번호 int,
   primary key(번호),
   foreign key(학과번호)
      references 학과(학과번호)
);

insert into 학생 values(1, '한지혜', 1, 'YB', 1);
insert into 학생 values(2, '이정우', 1, 'YA', 1);
insert into 학생 values(3, '오지영', 2, 'J1', 2);
insert into 학생 values(4, '강재미', 1, 'YB', 1);
insert into 학생 values(5, '박철호', 2, 'Y1', 2);

select * from 학생;

# =============== member_tbl table ===============
create table member_tbl (
   C_NO char(5) not null,
   C_NAME varchar(15),
   PHONE varchar(11),
   ADDRESS varchar(50),
   GRADE varchar(6),
   primary key(C_NO)
);

insert into member_tbl values('10001', '홍길동', '01011112222', '서울시 강남구', '일반');
insert into member_tbl values('10002', '장발장', '01022223333', '성남시 분당구', '일반');
insert into member_tbl values('10003', '임꺽정', '01033334444', '대전시 유성구', '일반');
insert into member_tbl values('20001', '성춘향', '01044445555', '부산시 서구', 'VIP');
insert into member_tbl values('20002', '이몽룡', '01055556666', '대구시 북구', 'VIP');

select * from member_tbl;
