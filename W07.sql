create schema W07 default character set utf8mb4;
use W07;
set SQL_SAFE_UPDATES = 0;


drop table if exists 수강;
drop table if exists 학생;
drop table if exists 과목;

# =============== 학생 table ===============
create table 학생 (
   학번 char(4) not null,
   학생명 varchar(12),
   학년 int,
   primary key(학번)
);

insert into 학생 values('1111', '홍길동', 1);
insert into 학생 values('2222', '김윤식', 3);
insert into 학생 values('3333', '이정진', 2);
insert into 학생 values('4444', '홍진아', 1);

select * from 학생;

# =============== 과목 table ===============
create table 과목 (
   과목번호 char(5),
   과목명 varchar(30),
   primary key(과목번호)
);

insert into 과목 values('CS100', '데이터베이스');
insert into 과목 values('CS101', '운영체제');
insert into 과목 values('CS102', '자료구조');

select * from 과목;

# =============== 수강 table ===============
create table 수강 (
   학번 char(4) not null,
   과목번호 char(5),
   성적 int,
   primary key(학번, 과목번호),
   foreign key(학번)
      references 학생(학번),
   foreign key(과목번호)
      references 과목(과목번호)
);

insert into 수강 values('1111', 'CS100', 98);
insert into 수강 values('1111', 'CS102', 88);
insert into 수강 values('2222', 'CS102', 90);
insert into 수강 values('3333', 'CS100', 92);

select * from 수강;

# =============== 학과 table ===============
create table 학과 (
   학과코드 char(2) not null,
   학과명 varchar(30),
   primary key(학과코드)
);

# =============== 학생2 table ===============
create table 학생2 (
   학번 char(4) not null,
   학생명 varchar(12),
   학년 int,
   학과코드 char(2),
   primary key(학번),
   foreign key(학과코드)
      references 학과(학과코드)
);

# =============== 사원 table ===============
create table 사원 (
   사원번호 char(4),
   사원명 varchar(20),
   연락처 char(13),
   생일 varchar(15),
   primary key(사원번호)
);

-- 데이터 입력(널 값)
-- 방법1
insert into 사원 values('D001', '정지영', '', NULL);
insert into 사원 values('D002', '김선주', '010-1111-1111', NULL);
insert into 사원 values('D003', '정선호', NULL, '10월04일');

-- 방법2
insert into 사원(사원번호, 사원명, 연락처) values('D001', '정지영', '');
insert into 사원(사원번호, 사원명, 연락처) values('D002', '김선주', '010-1111-1111');
insert into 사원(사원번호, 사원명, 생일) values('D003', '정선호', '10월04일');

select * from 사원;

-- null 값 검색
select * 
from 사원
where 생일 is null;

update 사원
set 연락처 = '010-1111-1111', 생일 = '10월11일'
where 사원명 = '정지영';

delete
from 사원
where 사원명 = '정선호';